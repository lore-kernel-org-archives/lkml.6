Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D59C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C300B2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvlDAaKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C300B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJHNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:02:49 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35068 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:02:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id y76-v6so7619114ywd.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSaAchdbHEkfhLJjlVf6xrMIGvwFgt4/+JLlRf1eVEs=;
        b=NvlDAaKLVIeTKXdt340zr897j8fOV6A7y8dtJf5bdRuFe7t/6eiRE6f+v0/l+sn1xB
         77Al0580hp62PyF/hODF7aIfR3+GX1jW1uTXn7lC8KDEQQFpvmnwUND4csyO4krJPyO+
         RJ8wN6gZBVmSHJL8sh/I3NREop2wZl8Xp8Gc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSaAchdbHEkfhLJjlVf6xrMIGvwFgt4/+JLlRf1eVEs=;
        b=U9jVzuPR9gXCx7e15upi/7VEag9cW6AeiYUwwXFHoaSroRlcfk6oKRQRgb1iSQtKnX
         6vFKmjJ0XjnWHXhz3yaAq+RsMgRCDxumJ7TKxYL59PjlOcNiLfdY/Oizibl0xxjwLvpd
         62V3Tavn8LjS8Abq+sAU+1AqkuPbOk/ltP5mer7iZbrOeWC+ZcQyq+hruJT5eI709KOf
         ZFzGp1a/58VN/4Zzd0cveMLM7z2WvZBLEi1z1Dgegyya/5AvLcmSqSgpIPPikfd8v53l
         0YXs5X5/lTQd1Yyz7GR77iSCPrQfIpP9m5qmbZ1dSOsTNPa9+bUhd/6WVxC0miOu/uQ9
         qAZg==
X-Gm-Message-State: ABuFfoh+fulz5neacOvp2JQBHFAncsmWXqGoV/XMlft4KwYii2Dol+eh
        8scm9vZkxU78j2VjO2SnjD/L6fnaSFxJiPm3LGdqrg==
X-Google-Smtp-Source: ACcGV60zJg1XVKsQbSNsIq35wMsVuWtwJL+uO7l7V4xnf6768V7R0i86nCOHfwuq37vA1B9TmUwzZJPeL2UYNT2MI90=
X-Received: by 2002:a81:25c4:: with SMTP id l187-v6mr12455457ywl.236.1538977969320;
 Sun, 07 Oct 2018 22:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
In-Reply-To: <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 8 Oct 2018 11:22:38 +0530
Message-ID: <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
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

On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
>
> On 08.10.2018 07:16, Firoz Khan wrote:
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > index 4e85293..4334bb7 100644
> > --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > @@ -349,4 +349,5 @@
> >  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> >  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> >  349     common  statx                           sys_statx
> > -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > \ No newline at end of file
> > +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > +351  common  rseq                            sys_rseq                        compat_sys_rseq
>
> You can't add the rseq syscall for parisc yet.
> It needs additional code in the kernel for parisc which hasn't been tested yet.
> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/

Thanks for your update!

When I compiled the kernel I got below warnings.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
<stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]

I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
syscall is gone. But we definitely have to keep rseq entry on parisc
architecture.

I can ignore this patch currently as your patch not yet tested.

FYI, I have merged the system call table files based on our previous
discussions.
Please comment on that.

I would appreciate if you can perform a boot test without this patch
on the actual
platform.

Firoz

>
> Helge
