Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7526ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8122086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI0Ru8OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8122086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeKHTVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:21:15 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34329 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeKHTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:21:14 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so6959602uam.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rb60YH5Tm4k60RM6h1+bFv61r+M4fgHXpdQCVlPF7iE=;
        b=bI0Ru8OZi3Zjn8xGFujJosxtTH61MuEBGp3Ix55UEKNJBqC1RTa6FwvNveB9cYoIMF
         VzXX/hwNalgr/DTLXLStMx7AVl0YSgXFnv+C1ustH2clEq51nT3l9Ij1PCbPad+dGIZt
         wkvmVeQafK8reusWHTViq72ag6+wIvCKa2FeGfJuPV3RBgPPR8V79m+ts82i0PEIKVKg
         Mfv3QyyOp5PxPDkK44eBz73eGUvsVSOArssbwPHBS6FVPcmL7COxxLlk+dwX79vl46Uj
         pViEpx3m40CE+sZ88gcVivmEk4OF4bclLcPWn4d9xlZHy3ADkeDuRIk9MlW0w2CWuxUi
         tkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rb60YH5Tm4k60RM6h1+bFv61r+M4fgHXpdQCVlPF7iE=;
        b=rKaiQXdmfR8uo03KFSgGX4UPb7QnmUG4uuIYKLNHjEncdrtuLddFKhKfEFiH97nJQK
         mkOVdqtUIjNRr3lBDq9pvCAlsOjLxc9AgGUt/CWVH5rorLanFs0KfNs0pSAN89F1aGUP
         lMyTxYMTTME64jvRkUDczRU3dcq6xlwztLTsPzV83bFQJvLipEQfvFndt4cgqGeFlIL5
         cTvOENt0c+aiI6TnAJOPCz9HX0hhGLwuK2mRTB6WPPjX24qtTfaQMkJudJPXFtf8faGN
         75scPZqXUv9PSUp//pnVV791qSomhxTJ/5ZFY4iSY9UJFDA46cEFKP7oJj1XpM/VE1cb
         Gm5A==
X-Gm-Message-State: AGRZ1gIjMyEGNE/404xjIVmy/zCTtbD4hhXFyJofnklVnhqWpysxEMCv
        o06GSxfJkbLmkubtIQlAmUMFe/DEE/Tvg3xRDtg6UQ==
X-Google-Smtp-Source: AJdET5eVIkKhJxk+LOHa22dYRRf4yoKuSp02cJx6AxxvlO33+bWWqJqHKUbIxKKXzL/fvH+q0gG5QeiwaWc6tFOfsv0=
X-Received: by 2002:ab0:42e6:: with SMTP id j93mr1784911uaj.107.1541670393644;
 Thu, 08 Nov 2018 01:46:33 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
 <40880.1541434328@turing-police.cc.vt.edu>
In-Reply-To: <40880.1541434328@turing-police.cc.vt.edu>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 8 Nov 2018 15:16:22 +0530
Message-ID: <CAOuPNLiHowVGDdLi=FwAVZRRsO=NnLk4=PnTqYAXF97G1QrkRQ@mail.gmail.com>
Subject: Re: Creating compressed backing_store as swapfile
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:42 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 05 Nov 2018 20:31:46 +0530, Pintu Agarwal said:
> > I wanted to have a swapfile (64MB to 256MB) on my system.
> > But I wanted the data to be compressed and stored on the disk in my swapfile.
> > [Similar to zram, but compressed data should be moved to disk, instead of RAM].
>
> What platform are you on that you're both storage constrained enough to need
> swap, and also so short on disk space that compressing it makes sense?
> Understanding the hardware constraints here would help in advising you.
>

Currently, I am using the minimal platform such as busybox for arm
(kind of a ubuntu based debian platform).
Also I am trying to do this on an arm based embedded board with 8 GB
MMC card and 1 GB RAM.
And I am using the ext4 filesystem with Linux Kernel version 4.9.x.
So, with 8 GB SD card I have 2 GB left on the storage space. Out of
which 64MB - 128MB would be used for swapfile.
However, note that this is not the final end product requirement.
I am just trying to demonstrate a prototype and use cases.
Performance requirement is not that strict right now, as I don't know
the end product. However, the system requirement is as minimal as
this.

The main requirement is, creating a RAM snapshot image, then
compressing some of its data and moving to swapfile, so that snapshot
image size can be reduced.
I guess, ZRAM is not useful here, so I thought to explore some other
option such as zswap, etc. ?
BTRFS is not an option, though, as we use ext4 and vfat filesystem (only).

> > Note: I wanted to optimize RAM space, so performance is not important
> > right now for our requirement.
> >
> > So, what are the options available, to perform this in 4.x kernel version.
> > My Kernel: 4.9.x
>
> Given that this is a greenfield development, why are you picking a kernel
> that's 2 years out of date?  You *do* realize that 4.9.135 does *not* contain
> all the bugfixes since then, only that relatively small subset that qualify for
> 'stable' (see Documentation/process/stable-kernel-rules.rst for the gory
> details).
>
Yes, we want to stick to 4.9 right now, as the end product might be
based on this version.
However, if higher kernel version have some fixes or good features, we
can back port it.

> One possible total hack would be to simply use a file-based swap area,
> but put the file on a filesystem that supports automatic inline compression.
>
I know, squashfs is a compressed filesystem, but it is read-only. So
its ruled out.

> Note that this will probably *totally* suck on performance, because there's
> no good way to find where 4K block 11,493 starts inside the compressed
> file, so it would have to read/decompress from the file beginning.  Also,
> if you write data to a previously unused location (or even a previously used
> spot that compressed the 4K page to a different length), you have a bad time
> inserting it.  (Note that zram can avoid most of this because it can (a) keep
> a table of pointers to where each page starts and (b) it isn't constrained to
> writing to 4K blocks on disk, so if the current compression takes a 4K page down
> to 1,283 bytes, it doesn't have to care *too* much if it stores that someplace
> that crosses a page boundary.
>
> Another thing that you will need to worry about is what happens in low-memory
> situations - the time you *most* need to do a swap operation, you may not have
> enough memory to do the I/O.  zram basically makes sure it *has* the memory
> needed beforehand, and swap directly to pre-allocated disk doesn't need much
> additional memory.
Swap storage requirement would be mostly between 64MB to 256MB (pre-configured).
Yes it can be something similar on ZRAM line, may be zram + zswap ?
Not sure if this right combination ?
