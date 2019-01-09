Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B41C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322FC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtt781g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfAIRk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:40:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45745 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAIRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:40:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so7957269edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PS7Wx36ATFnTYeL3eDoBgyVEISixJ4fMKJQ2OWuzmwA=;
        b=gtt781g2Nsje/ww9WwNK8CJe4iXMwkKHYefkwnHBlmCXgy/0eCBQvtQUYwdFQfe1dt
         eRKA102wDhTycqogqOcc3EUalQ33ahSHvrAWM9F/OWuCvlOP6+d2nDmXUQWZT3DGyLDz
         xUiAMIU3oSl8/5VIcKgvmcz9BX6gHJa+sGBlzpb8yOOZ38tGuFWmCNZUoVADZAc/NZWT
         0+KpnB820L5g93acYPeQHNdyXZQq1thG6fBsEMvIcpLtdHcUoqWepBt4wBSl1P/b+VBc
         RhvSAf8ZhOh6gl12kzhAwDozZlX3MxUqih/YBt3R63xoDUIDFcydGY52w71LvqwpqWYz
         raIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PS7Wx36ATFnTYeL3eDoBgyVEISixJ4fMKJQ2OWuzmwA=;
        b=C9/8Hm0pdAx41T0tbDVpc+2s899NvrjgeMO8Cb0izs5ffxMhCErq1LwynIZY6kfmk0
         m1S0OX4Hw9r/CE4tK9Hlk+ZiLUT3lrOCn4bXCqNx/Ur+KS2MkLclXM7zqI8KFF7+yHWd
         wiMByg+R7rX1QbbmwG/Ih06at+UF7LuiDOvCv2CkogF66ndBybb3hbrF+VkLoP650FOw
         jRjq2jK5TvIr0/vR/PjUQ8MAe6KGzu1jVL62LjvlDOepGYBu8Te0M6SQqFz+EHESmFhX
         SbUT9Ao1b7TaKbsXZQ3WZLoTOqS5WkyoDrVtmO8GLBvjfkp4iFE7L/RXQxQcxNvuLKWt
         DdNg==
X-Gm-Message-State: AJcUukeHfMtnmC45G5/u0phCI4185Wbxp6ZyM69wfNwC/4Pc8Hmp8Tuh
        gvqvb/mXNajbTEnJRkCGKql6wR3w18tbodFpAde/vgYPhec=
X-Google-Smtp-Source: ALg8bN5xgLrm4diDnBnFD9UfCaUxJPmDAF6K5O6W3C4zGenPjRr1oteb4yje/xdvfhaBmWJMpVHdnkd3FYcIK58Rp9k=
X-Received: by 2002:a50:87a7:: with SMTP id a36mr6921468eda.96.1547055626888;
 Wed, 09 Jan 2019 09:40:26 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de> <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
In-Reply-To: <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 9 Jan 2019 13:40:14 -0400
Message-ID: <CAB9dFdvRAzqnRAUEr3Y6H+h6viwdEMDpWP2Gf=tj3-0ojH58Xg@mail.gmail.com>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:09 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-01-09 17:52:35 [+0100], Greg Kroah-Hartman wrote:
> > If there are no in-kernel users, the symbols should not be exported
> > anymore.  That's nothing new, we have always done this.
>
> The thing is that we had
>   EXPORT_SYMBOL(__kernel_fpu_begin)
>   EXPORT_SYMBOL_GPL(kernel_fpu_begin)
>
> and now __kernel_fpu_begin() is no longer exported and static only.
> All in kernel user (including the kvm module) use kernel_fpu_begin()
> which is not available to proprietary modules. Hence Marc's mail.
>
> > > On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
> > > helps in any way yet please correct me if I am wrong.
> >
> > Yes, it helps, please leave it as-is.
>
> As you say. I only notice that certain things used to work and then no
> longer do because due to $rework it somehow become EXPORT_SYMBOL_GPL
> only and people complain and we tend to switch the export back to
> EXPORT_SYMBOL. I'm not aware of a case where it actually helped in
> anyway.
>
> > thanks,
> >
> > greg k-h
>
> Sebastian

I would point out that there are several precedents for restoring
exports after functionality has been unintentionally made GPL only;
from a quick lookup these are some examples:

  8af190958059 ("x86/paravirt: Remove GPL from pv_ops export")
  31c5bda3a656 ("mm: fix exports that inadvertently make put_page()
EXPORT_SYMBOL_GPL")
  1e5476815fd7 ("x86/tlb: Drop the _GPL from the cpu_tlbstate export")
  b562c171cf01 ("locking/refcounts: Do not force refcount_t usage as
GPL-only export")

Marc
