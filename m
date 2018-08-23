Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A832150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY3QuD02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A832150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeHXAWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:22:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44650 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHXAWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:22:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so6077984oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HxrmlZTrAAPr/ySJeq6MJnm6Bsvg97pVrcpICdQ7y8g=;
        b=PY3QuD02UWkYdu1yNwF5f52R4UOm8EpiTIN41V3Mmq9JBAa0WJIzHRdCrZk6dK2qV4
         iODUmuK59oNZuVfOd7Ml1Z9wvjxqMdmrbPAQbeT4qG5OcT4Uz8sPEjsdukB5KHKTbZCH
         j/anECtwX7/WCzQgL6d+MMJEX8pEL3BGtgIKG8CPGY5rT2H1d3e5yjZhbthUfjYj4VHa
         TK7UKU10mucQZmIQpWS85MNj9IFiFuek0sDnJPIXrcuzzlIG3Do+bmmaqa3tkm3aiCSP
         BfaLPTeld5pkNIdRYzO3TzBEDisVZhDx5v8WwFj9bd5folMPGHW82TFPJQ8v5HjvJIDo
         Lfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HxrmlZTrAAPr/ySJeq6MJnm6Bsvg97pVrcpICdQ7y8g=;
        b=TaKh9YYibaNkrdtkt9rQexNgXTdEuCA1JcPZeGyxPmyS6iq/ALtkTMfz4TOXs3KOJt
         nvQBeSknHGwybiAHwdQ5Ptknk7Ch/o1k3rY/NyiI8Kt2FqyFXwpbNn7plSSYeU/swlXk
         JNkjFjY8xtZIwG9SfWnNDJQisAcq1rU7vSQJhRacq6mwG/Q2A4X9P/oXBP8iZA9nB0zh
         gGat5dycqTTvGv+g5jfPZhMkQogj9G1YLt2uE1eecw2yEVopio2jMw/WFVP+/sbwo6ti
         WmjZ36wRjEYuu7gfJ9kQhO4Ld5EJPmwUCZwyuQe7qDs96FKPCNxCs6AsBvTw8v7T92Ec
         boYQ==
X-Gm-Message-State: APzg51Bq2cp0kIHg4Yf6WYSqyl0Kcy2hreDGyZXP3hS3TJ48x/w3UyoU
        6w/R4CqlGE0xtVfLBT9TruEv5zF7aRW4Bbw2yCaA+A==
X-Google-Smtp-Source: ANB0VdZO8OEz1IXFJRSNAi8hG14v/KLuSffK8w+XXk9AWkDexPXB5j02r4GX0yai7SzzoxnhlQQ78wjpfuGkHEPAGmE=
X-Received: by 2002:aca:4a49:: with SMTP id x70-v6mr10522185oia.11.1535057452971;
 Thu, 23 Aug 2018 13:50:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:342a:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 13:50:52
 -0700 (PDT)
In-Reply-To: <cb54216e-ee75-a816-8316-b385a2cdd576@redhat.com>
References: <20180823162424.13282-1-vkuznets@redhat.com> <cb54216e-ee75-a816-8316-b385a2cdd576@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 23 Aug 2018 13:50:52 -0700
Message-ID: <CALMp9eSnDRHEsDLzOGLDEqw1Jg3C-goO3yX6i08RorN91NoX+w@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/nVMX: avoid redundant double assignment of nested_run_pending
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 9:26 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/08/2018 18:24, Vitaly Kuznetsov wrote:
>> nested_run_pending is set 20 lines above and check_vmentry_prereqs()/
>> check_vmentry_postreqs() don't seem to be resetting it (the later, however,
>> checks it).
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
