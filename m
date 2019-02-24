Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3C4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92708206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG3V+47j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfBXNZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:25:31 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53305 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfBXNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:25:31 -0500
Received: by mail-it1-f194.google.com with SMTP id v2so3450062ith.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raoGjtVydweLfy9alzAvY9fR1DdrLhL84ZW1qOvnacs=;
        b=FG3V+47jExM1M8gF/1NFIFkl/lZOe4gPD6vqtzPTgIQ1LNaHnhMnxSz6V6SRaaUI2g
         niny6GwwYhMuTzuF3p/Oix76KRhXGgWZpxXXYWRWQacg2b3aqUE4UBBek9e6hPz1RYu2
         pMc+DsEIQc++3Hh+jT4idlghxf3Wl8qC4IFw/xUvyWH3hhuizH08mDB6s+eVh+P8fjc0
         9Aih6OFwBjuLgTFSLoyEOJZqBamf7NSsnkEafnXbuaaavt7KtNm2z0zv3wwHChJc8DZ2
         1e/LS5OoOYWb8L23zLOEwzNBggDYm1CP2WNTaQKp9YMegWavroPBfKRyCLdFPV9L/5ry
         vd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raoGjtVydweLfy9alzAvY9fR1DdrLhL84ZW1qOvnacs=;
        b=lc0aH8AHew8uocDoR2mLfET/fx040y3gw8yuXp0QNqxieZdpJAwDcecatdjShrTgdT
         E1yb/zS2NKMXQt9KwpRg7oHQ8qGe566DiH64RLuGWZgTVgShEs8xieVMSJGYHZSyfy4p
         dvyC5ycHsvcgq02VsUY92Ho7z/6GlQ0qeAp7xc0rDe2KgyPhnLyiQ0st0BsmPCyrYNzh
         TsLvIx/S65rzRAt2ufgIg9BorzptvknTM9FvckYSOWBb1K9+hskfZkqEzzxGfeSm729x
         hNfcrlZABoTBaLxZKPdku9BQtmequf0+hHpWTVZBLHOKEfcPRcJYiAzbCwWeA0hoQLAm
         NRZw==
X-Gm-Message-State: AHQUAubhWBO0lmTZucyfKhECJ/C29rfeP3hxHn7GpeutAVTRazBIeInc
        YK7AMG9f8rNKfi2A+PYQ/MiIs5ANvx0xza8DLHRUOy+5mg==
X-Google-Smtp-Source: AHgI3IZuoX/lE0NFX9DDg9VkAQx37l6nJoIDuimLgaoLdRx3+vg+YEQwviPHMATY1Oe093VhxQ/VyUvqYqxAeSuKIwI=
X-Received: by 2002:a24:4650:: with SMTP id j77mr7142052itb.6.1551014730072;
 Sun, 24 Feb 2019 05:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20190205081552.GG21801@zn.tnic> <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com> <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com> <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com> <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com> <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
In-Reply-To: <20190222130026.GA30766@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 24 Feb 2019 21:25:18 +0800
Message-ID: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 9:00 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > The current default of 256MB was found by experiments on a bigger
> > number of machines, to create a reasonable default that is at least
> > likely to be sufficient of an average machine.
>
> Exactly, and this is what makes sense.
>
> The code should try the requested reservation and if it fails, it should
> try high allocation with default swiotlb size because we need to reserve
> *some* range.
>
> If that reservation succeeds, we should say something along the lines of
>
> "... requested range failed, reserved <X> range instead."
>
Maybe I misunderstood you, but does "requested range failed" mean that
user specify the range? If yes, then it should be the duty of user as
you said later, not the duty of kernel"

> And then in Documentation/admin-guide/kernel-parameters.txt above the
> crashkernel= explanations, the allocation strategy of best effort should
> be explained in short. That the kernel will try to allocate high if the
> requested allocation didn't succeed and that the user can tweak the
> allocation with the below options.
>
Yes, it should be improved.

> Bottom line is: the kernel should assist the user and try harder to
> allocate *some* range for a crash kernel when there's no detailed
> specification what that range should be.
>
> *If* the user adds ,low, high, then the kernel should try only that
> specified range because the assumption is that the user knows what she's
> doing.
>
> But if the user simply wants a range for a crash kernel without stating
> where that range should be in particular and it's placement is a don't
> care - as long as there is a range - then the kernel should simply try
> high, etc.
>
We do not know the memory layout of a system, maybe a system with
memory less than 4GB. So it is better to try all the range of system
memory

Thanks,
Pingfan

> Makes sense?
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
