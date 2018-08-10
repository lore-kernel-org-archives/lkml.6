Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC42DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C8223AA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=apporbit-com.20150623.gappssmtp.com header.i=@apporbit-com.20150623.gappssmtp.com header.b="aIeSZzpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6C8223AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apporbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeHJC7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:59:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38482 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHJC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:59:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so13017181oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 17:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apporbit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wjwS5PrVwSCqQKbMLZ1h+6Sfj8742HGyWMlZ6vsyhJA=;
        b=aIeSZzpjjr12b+/FlgPxUdrLr/c6ZKrtzWUh0WONeFrheMfw81oKt4nHROQMybpuzA
         65pHkP3fTKcnEaq1Q1r21CJZlhXc6mGdziPN8L2RKi0CN/MdcfnIc68q7UaEMS3gsWUb
         gboejdz8Xy4ViT9OYEMVaKrtNzuF80piE1Z1YzV98SWTh224sfLYdJdTVARwV9Czlmdp
         qGz8YZSsox6p6D/N4bm2Zl5RFm1+8kbxMxD1MJ9rCXOkGZQdqftJk+oprgqu/4R5V9H3
         yohHnBna61G9Nslk47JDjDmy3nWvlwZmEtIgPHHIjxTO+a+RJBo12kUi9ohnbOnwqkiP
         c9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wjwS5PrVwSCqQKbMLZ1h+6Sfj8742HGyWMlZ6vsyhJA=;
        b=U53JHH6VGGNR7iRrHJdsbodwYdRniDEtswWi2QjjYkLTvw//gpIgzPRNIbGLJV7J9x
         kWzjfpJZXtaPIgby9vfbigdddAZeCvabF0fUKbIWDFc5zA2FFs1fEfPP+e7gT9KwIbRw
         OB8WHLXXjEqZObpnjR7Tcxxlf/PTWEk2INeiHgwyVfUXdJNBjtnCgMawHQHNzJXpG2na
         kqQxDKKOxTNbYMbmNfmVBJCnlY52xjuq5z9Srj137d4GdnqHfVcIWCHL5wZhiE3+GqQD
         Pm1RHso5WuisoGXGmx1QiBPLr5Ooa/TCXfziUdXxhpsUcQ7rQUXR0+6sGTEus62iR+KL
         Qs1g==
X-Gm-Message-State: AOUpUlHsQ33PLHCbi1cBuHK7efpwzykQEmWwi8yD40I9IiYuQZWE47EM
        kuGXCy9wl7aGn6PSX+aeeoSzSdESafU=
X-Google-Smtp-Source: AA+uWPzYxfSthy+hTzkiEUF0AXAGNJy3/ovEulu9wGDcSeKzMWRZTqJXsa92dKIjk0L3Bfrl8u+AAQ==
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr4132520oia.242.1533861131312;
        Thu, 09 Aug 2018 17:32:11 -0700 (PDT)
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id y85-v6sm11096227oie.25.2018.08.09.17.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 17:32:10 -0700 (PDT)
Received: by mail-oi0-f54.google.com with SMTP id m11-v6so13064756oic.2;
        Thu, 09 Aug 2018 17:32:10 -0700 (PDT)
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr4072895oig.287.1533861130017;
 Thu, 09 Aug 2018 17:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180807024442.GA12274@cisco.lan>
In-Reply-To: <20180807024442.GA12274@cisco.lan>
From:   Dinesh Subhraveti <subhraveti@apporbit.com>
Date:   Thu, 9 Aug 2018 17:31:57 -0700
X-Gmail-Original-Message-ID: <CAP4sa4+PTxniTjFWGJJjYFJXczgmUnsG2pQU7KuUdeERxxDnnQ@mail.gmail.com>
Message-ID: <CAP4sa4+PTxniTjFWGJJjYFJXczgmUnsG2pQU7KuUdeERxxDnnQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:44 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> Hi all,
>
> Dinesh Subhraveti has claimed that some part of this series might be
> patented. While he has not furnished me with anything to confirm this
> claim, I'll put this series on hold.

For the sake of everyone's clarity, there is no patent or intellectual
property issue here and we'd like to see this feature in the kernel.
I did indicate that there is a patent related to the mechanism
underlying this patch set but that is completely incidental to the
issue here.  We have filed that patent only for the purpose of defense
and have no interest or resources to go after infringements.  As such,
I spoke about the approach, it's value for networking and a few
possible ways of implementing it in the kernel at Linux Plumbers
Conference 2017.

As a contractor and a member of our team at AppSwitch (FKA Fermat),
Tycho Andersen helped implement a fully user space version of system
call trap mechanism based on seccomp / fd-passing and participated in
our team discussions about upstreaming a kernel version of the
feature.  Given that context, we were taken aback that he posted the
v1 patch set without letting us know and without any mention of
AppSwitch in the post even though he was still under contract at that
time.

In any case, please note that we will communicate with Tycho directly
regarding this matter going forward.

--
Dinesh Subhraveti
