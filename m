Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0846320645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1twMSqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeLQEV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:21:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43584 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeLQEV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:21:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so9551220eds.10;
        Sun, 16 Dec 2018 20:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHq7ZoUXv9frQVTofQUPWIqflBtCt4iCGnfRpTr4IIY=;
        b=m1twMSqeqJFVDPdu2YYSTHCdIZ9ZwpnrJrva7btn8A/j7nZwjbS5eOw1w0Hxkzcety
         rlNhLPwcAQItU1as+HKu4GzNljk2nAx08njrCNdU+8yuyxTwtCbgVgkUNiv+jkabuoKw
         PxEbzoqdABEfh+3F/K3mk6QZaVwdQ/buX3h9XHMTYAxu2BRkroVfVEE8pK3WFBAumK+t
         0qDkl1GQEHE+zqLf8hz3EZrfG46U3Tsf5jmpPwYjfS5iojyfdHzu4+ApJJWyen6bNx7h
         z+Mr+OOsVDUgw+j5yARZL41i6v/ySG01f/K8VLwVxVlYpTHuxIiiv2R7MZJQZQeDkrCw
         UFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHq7ZoUXv9frQVTofQUPWIqflBtCt4iCGnfRpTr4IIY=;
        b=ECOAZzT5heB4PtP1Euj3t1JpUqNt8qdoGeUinxPfLpjR50K0Sxnj33n22ZaPTxTt33
         E8KTIw10lkeJH0dKPDbO8DR5d4RFe1vKEgzcW157Og1oKG80J7w3peCm9pXx7adfL9q7
         SEh3tv9bJ2TCI5/2Xq2olaW0marHC6GFFyz/sCMgv19kXI3knJwrETwskUv1BgIQ7PY+
         znBmey5v85u6o8qKuijz/72BK2/5NrwcXoteRInuu7i6Xy1HXNcJLWryhPJsdGxC/T90
         ZbPl3TJKwv2d6k8KtPQ5PwKSobeAhlYGXriwvCy1VGWL3GsY3laqbSb4dv1BuLf57fBk
         c+vw==
X-Gm-Message-State: AA+aEWY4HtcWKqoxXWjCEDqY6DbaP6fWnfzzjyNQj3LgfbtGVAu+Mesg
        +h1WqIgPflTRZKCCvtyDx4tL+wuxPXbJzQQXofY=
X-Google-Smtp-Source: AFSGD/XOEdVKh7mCMVy94p8O2QyP5zNaq6YhyCyhoasXxaSzcjTAurHnLHlBOxCDC7YvlIxqUPnM1MCherbYYBZm1ao=
X-Received: by 2002:a17:906:e1d0:: with SMTP id gp16-v6mr5244396ejb.221.1545020514767;
 Sun, 16 Dec 2018 20:21:54 -0800 (PST)
MIME-Version: 1.0
References: <18d54cd3edbf4fd3a7c01962f41ead58@cnbox5.mioffice.cn>
 <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com> <20181214154436.GA16772@avx2>
In-Reply-To: <20181214154436.GA16772@avx2>
From:   =?UTF-8?B?56iL5rSL?= <d17103513@gmail.com>
Date:   Mon, 17 Dec 2018 12:21:40 +0800
Message-ID: <CADd0cq21TfsncsoViQD+1Q=GKyjG5fKuWEnZr8JxevLh3mSeag@mail.gmail.com>
Subject: Re: > [PATCH] Security: Handle hidepid option correctly
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I'm pretty sure kernel calls proc_mount()
Here is the call stack
[    0.003450] [<ffffff8bef2a0190>] proc_mount+0x2c/0x98
[    0.003459] [<ffffff8bef22e560>] mount_fs+0x164/0x190
[    0.003465] [<ffffff8bef24c138>] vfs_kern_mount+0x74/0x168
[    0.003469] [<ffffff8bef24c244>] kern_mount_data+0x18/0x30
[    0.003474] [<ffffff8bef2a0258>] pid_ns_prepare_proc+0x24/0x40
[    0.003484] [<ffffff8bef0cd5ec>] alloc_pid+0x498/0x4b4
[    0.003492] [<ffffff8bef0a9b94>] copy_process.isra.73.part.74+0xed0/0x17=
08
[    0.003496] [<ffffff8bef0aa560>] _do_fork+0xdc/0x3f8
[    0.003501] [<ffffff8bef0aa8c8>] kernel_thread+0x34/0x3c
[    0.003511] [<ffffff8bf00cd498>] rest_init+0x20/0x80
[    0.003522] [<ffffff8bf0c00c7c>] start_kernel+0x3e4/0x43c
[    0.003527] [<ffffff8bf0c001e8>] __primary_switched+0x64/0x90
Alexey Dobriyan <adobriyan@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:44=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Wed, Dec 05, 2018 at 03:26:04PM +0800, =E7=A8=8B=E6=B4=8B wrote:
> > Anyone who can review my patch?
> >
> > =E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> =E4=BA=8E2018=E5=B9=B411=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=
=93=EF=BC=9A
> > >
> > > Here is an article illustrates the details.
> > > https://medium.com/@topjohnwu/from-anime-game-to-android-system-secur=
ity-vulnerability-9b955a182f20
> > >
> > > And There is a similar fix on kernel-4.4:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D99663be772c827b8f5f594fe87eb4807be1994e5
> > >
> > > Q: Other filesystems parse the options from fill_super().  Is proc sp=
ecial in some fashion?
> > > A: According to my research, start_kernel will call proc_mount first,=
 and initialize sb->s_root before any userspace process runs. If others wan=
t to mount it, all options will be ignored.
> > >      AOSP change here: https://android-review.googlesource.com/c/plat=
form/system/core/+/181345/4/init/init.cpp
> > >      At first I though we should mount it with MS_REMOUNT flag. But k=
ernel will crash if we did this.
>
> This is not true: /proc is mounted by userspace (and it is easy to see
> from the fact that proc_mount() is not called from kernel anywhere).
>
> hidepid=3D in its current form is misdesigned, so might as well not bothe=
r
> changing anything. IIRC there were(?) patches to make it per-mount.
