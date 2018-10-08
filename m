Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB5C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60A2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOFxCorE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJHN7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:59:02 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37662 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJHN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:59:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id y14-v6so7644443ywa.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eeDBFYTvmzE5kSPQxuACQNuY4qKPrp8/x8wf9lSsBo=;
        b=KOFxCorEVyDaSSpK4yd0JQvncpbRZLzWMW34N1xJhM69rx2JgX8HBuyLEYpHd6Qb9Z
         ZR5F30WwASVAxQR26mHZkhpx4KJBu9y3cbKnb3eE6hJWI0F2sAAkEqjAPHn8R0BfWPe3
         0S1CMnuKiD0MsdwV5s9BYb+8My4aPTF+bmqsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eeDBFYTvmzE5kSPQxuACQNuY4qKPrp8/x8wf9lSsBo=;
        b=OoQ25npTMFu1O1wHz7LdGFBY8dNV3Sr4yKzkcGlKaFQ7SsgwV7PVpms9+NMiMnG7mr
         3hvlyYzsndyI/TZMcK6VGKFDLFnE99Sp323jW/rghNrVY/PgDiPzhwoPqa4YIb3OP3Kw
         311YKUOt5liQ2lS58nSdck2E8+DYOhRR7RSv2Meh0G7uRMk6ZchluZ/KMRz4kJUAXXLn
         zdEe4GPzp7/sYl69+EuSk44vP5kyMRDH+qTVK3NmHjpm32mRRgrncmC0msPurP8D6g0s
         d50eZTWuTWyJWhzVU1KYH6HjL9f4d+DCq3KgSDxmf+SBDyHo3f8+7iC52ng5sbzqpe44
         WKsg==
X-Gm-Message-State: ABuFfoj5T4st8ipXOE/DJPNT2c4/0TFbYvRoYNMSSqoMgnuJIeo3pfzB
        fU7zUMWHXvm6iYZoVwJLdaogcJgKmetsOGmGJws5yA==
X-Google-Smtp-Source: ACcGV63uMrTUXBfJLllNAIXYdlTITYXpg9USJ3E9gAZRvh84sASmjlqte3tMFAcFzuxWgBKsG3OksXS0+E4WtyII4Eg=
X-Received: by 2002:a81:3bc4:: with SMTP id i187-v6mr11322786ywa.82.1538981330562;
 Sun, 07 Oct 2018 23:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com> <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de>
In-Reply-To: <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 8 Oct 2018 12:18:39 +0530
Message-ID: <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
>
> On 08.10.2018 07:52, Firoz Khan wrote:
> > Hi Helge,
> >
> > On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
> >>
> >> On 08.10.2018 07:16, Firoz Khan wrote:
> >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >>> ---
> >>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> >>> index 4e85293..4334bb7 100644
> >>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> >>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> >>> @@ -349,4 +349,5 @@
> >>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> >>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> >>>  349     common  statx                           sys_statx
> >>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> >>> \ No newline at end of file
> >>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> >>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
> >>
> >> You can't add the rseq syscall for parisc yet.
> >> It needs additional code in the kernel for parisc which hasn't been tested yet.
> >> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> >
> > Thanks for your update!
> >
> > When I compiled the kernel I got below warnings.
> >
> > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> >
> > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > syscall is gone. But we definitely have to keep rseq entry on parisc
> > architecture.
>
> I prefer to keep the warning for rseq for now.

I'm fine with this.

> It reminds me that we still may want the rseq syscall.
> If the warning is a problem, you may simply add the __IGNORE_rseq define.

But I still feel to keep an IGNORE entry, so once you test your patch; we can
remove IGNORE entry and update the syscall.tbl.

I would like you to take the call here :)

Thanks
Firoz

>
> > I can ignore this patch currently as your patch not yet tested.
> >
> > FYI, I have merged the system call table files based on our previous
> > discussions.
> > Please comment on that.
>
> I'll do after testing.
>
> Thanks!
> Helge
>
> > I would appreciate if you can perform a boot test without this patch
> > on the actual
> > platform.
> >
> > Firoz
> >
> >>
> >> Helge
>
