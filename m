Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073FDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D98208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wvLnvBbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D98208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeFRNsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:48:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44612 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeFRNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:48:34 -0400
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5IDmUUX012646
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:48:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5IDmUUX012646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529329711;
        bh=yB9Iu+fOxayt0OXnxQ1OUR+Eaq48J2IAuj9sTw6timE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wvLnvBbso0s4ESBaniMhkeHQqA6k0KT0hoZ+TtqRbcyujasD29ZgKJllfrNPTsrRf
         C8T6EFL3+W6Z7bu7IWGTUBrR/ercJUucCKDyPU5Zlj4zAVuZpiEaFj0Jjpdyku5/JT
         20xRHlTbXPZN4LXoFjA4rQMWD6jHR2L+dwqrp4ug7XyUMH+SD9n+v2xqfu/H88M8l9
         HVrmqkUWidIgDMEGwFS635XlGq5Omvrn2k7bAehrEv9mul8GidNe5kzQnCisWJDl0Q
         sTqBibYNbsqfVdR5XdyXoDEDoJfWdhzjgGxcU8TYLb6kjpjomRmixlg0VPjB/rFZds
         BQNWNxzWl+MlA==
X-Nifty-SrcIP: [209.85.217.177]
Received: by mail-ua0-f177.google.com with SMTP id n4-v6so10706052uad.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 06:48:31 -0700 (PDT)
X-Gm-Message-State: APt69E06YjQXOifl4tib/SBSQ4JxxCOAX75Jvd9vsnUSLJPcEjVxl2TG
        9Ltho9bWGs2mowGkthz14wKK03NYsmZl/qAyrPs=
X-Google-Smtp-Source: ADUXVKJVZB50Ctkfav2FCtUimL7WqNhE3+f3ZIFxdLFddMBAQm938EIXhopbDOfDFHjgBgZI8UIHgrWstzkXLuKtuXM=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr7698006uae.140.1529329710271;
 Mon, 18 Jun 2018 06:48:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 06:47:49
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1806150705540.2565@hadrien>
References: <1504258820-2122-1-git-send-email-elena.reshetova@intel.com>
 <CAGXu5jK-6fNvaEiX1Wvp98BKv+uF17KdFyPQKi5hgE-Jz3-+Tg@mail.gmail.com> <alpine.DEB.2.20.1806150705540.2565@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Jun 2018 22:47:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
Message-ID: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
Subject: Re: [PATCH] Coccinelle: add atomic_as_refcounter script
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <mmarek@suse.com>,
        Hans Liljestrand <ishkamiel@gmail.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-15 14:06 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Thu, 14 Jun 2018, Kees Cook wrote:
>
>> On Fri, Sep 1, 2017 at 2:40 AM, Elena Reshetova
>> <elena.reshetova@intel.com> wrote:
>> > atomic_as_refcounter.cocci script allows detecting
>> > cases when refcount_t type and API should be used
>> > instead of atomic_t.
>> >
>> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Oops, I think this got lost. Who can take this patch? I thought Julia
>> ran the scripts/coccinelle/ tree, but looking at git log, it looks
>> more like it's Masahiro? Either way, let's get this in the tree. Who
>> can take it?
>
> Masahiro takes patches.
>
> julia


Somehow I missed this one.
Now, applied to linux-kbuild.  Thanks for the reminder.

(If Julia hosted a git repository, that would be better, though.)


-- 
Best Regards
Masahiro Yamada
