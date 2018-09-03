Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QfdRpSqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeICF4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:56:11 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38025 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICF4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:56:11 -0400
Received: by mail-it0-f49.google.com with SMTP id p129-v6so13628488ite.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USPU6gEGfH9PNisBCiuQsmUdk5dTgpnWlTQYvFRTYXs=;
        b=QfdRpSqmTcq2ShfvWrudo3euGxDErTAKHGc/tDAJwQcIynnd7x/XewvCflsasWCRaI
         oADO+0N/u9Ooe6jfG9ZTXYb4p5Fk7GN0LhB81tr1wXemoJCYf1wu2tnsXEBs1MLhOF9s
         IbPtDEE3AkCgSf76+o1TvCANUzpabRK1jdS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USPU6gEGfH9PNisBCiuQsmUdk5dTgpnWlTQYvFRTYXs=;
        b=ZPWJjpW5d6Mn0Pw3NDWs2PG35afpqaewJcVZU1laTEdVgClMaQBRjaSGzIesl0WezJ
         JiPC//kUkej0328eikZ9mXxhLuxfXHdmyz71gm6HWk4Usk9PE89CcIdm4s7XIeiWjsmD
         zsrPwzlVl9vlfKp8PqIn76irABH0ubdcG09kcVHBzV7UaoqtDRiZmkJObujnujZqkuZo
         Am6etdSyPBsHjAJ3aGsIF1JyyRUgq6qdPPbOhIrn98i0cFLZWolvhDL1TUG6wrfTFokI
         aMdyFRzex0BasvDpxiZ83rUYmr1IWJLGg9gL4E/IGWZVe8qQG8DTCz1ylZ4kn28zpoS7
         ee6A==
X-Gm-Message-State: APzg51A1xmXYoMYbDQGWmDdBStss2Kn4/c8NfSfzN/WR3w08wZq4xRay
        aew4poui5qQaoREy7ukhgcJms+BVBrjtRiZ/5Q0=
X-Google-Smtp-Source: ANB0VdY6+BD+/f5YNDn6AgJDIMj72TP/YdcOy2ZF4Ovn29T2x3GHRqg0ABJuoAXQ3OXV6Ee+IejxVu+v+WPGM7sYvyo=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr4015127itq.9.1535938701797;
 Sun, 02 Sep 2018 18:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org> <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
In-Reply-To: <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 18:38:10 -0700
Message-ID: <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 6:32 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Also, if we cross page boundaries with those guys then we have a bigger
> problem no ? we could fall off a vmalloc page into the nether or into
> an ioremap mapping no ?

It's not used for vmalloc stuff. It's just regular kmalloc().

So it can cross pages, and it can fall off the end of memory, but it
can't do random stuff.

               Linus
