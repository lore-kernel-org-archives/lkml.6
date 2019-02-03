Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E7C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51DD2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2kTpPVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfBCPu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:50:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfBCPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:50:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5619641pfb.4;
        Sun, 03 Feb 2019 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRHjBbjhgo8lbVo3Vu8QLmAuxWwcebCrUtdOqttVhGk=;
        b=U2kTpPVTgQ4tOJ128aA2PneicxnhNarQHINqrGaAgkVfUyCqAoVN3bLbd6VpeD8lnT
         xuuBj36hHNXa1aesX1IH9qrd8bm4pmHe2MxVtLFVX6APCM2qXTp/WmyRjNRsj1cmvEjd
         YiFRXQ3/U5AaTD1WL+Cl1MB6IBBhf1QQzUxNRMCYJbFkkpFzr8n1rDS0QOUdLadB3rgb
         675Fa300rgFQ9SeqVCwR2ZW223esd+/wMAl5mqswmLXXm2XNOLWBDrq44k3Gtx4ZF1QZ
         iTGlYdoVyJH80Tdtpc985Gx8AlvsefRNlLJoeib1lPuJIQFJndVA3g8xo/AigY20jtib
         cUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRHjBbjhgo8lbVo3Vu8QLmAuxWwcebCrUtdOqttVhGk=;
        b=pLQ48ePUDIpxEH90GJ1HaE1J2Ad+DAwJ4BGJBC3hcoHfDWWyxkE5D6p5DAskm8eXZq
         HJ+i/9DclxscKRWrsTLLFUKiLHoeH2Lut72UhMFhrDhcOJOJRHzEhD7UDD9u848Nxt3h
         /JPiYH0aq8GLdekWs5QXi7h9UUsO9ZJDuhmb58yBXBoaft19uWBO2xi2s/tIDSy5n+GH
         kcBFfNJt2WEqvC7wArZXZX9sjqhNIj/XRWHb279Casnhs3psNwN2Ua3A93uPSdZXJFow
         gRuNyoDXtjifFSAlquBBDkflIHQX6eDZqJHMUb3qJxL7v+AWo/s99dkQXtvsyPo5sR9y
         rFbQ==
X-Gm-Message-State: AJcUukfb/tIU9qIAnv9492QEbvDrTCLRC5Gv2wt5t2xF8UdeUy8NaH1S
        c3wMAxMqLXENx0cI2ed4fj6SyGQquTxifTdN9UE=
X-Google-Smtp-Source: AHgI3IYwakpGhTNqah3jpwVMI2jtk7tjp2rP4k+2Rw1vYQPNJgf/U4LcUOdIokjaBUFlhiPqi4uax2+AsJ9fVaa9D6Y=
X-Received: by 2002:a62:9305:: with SMTP id b5mr26609769pfe.10.1549209056947;
 Sun, 03 Feb 2019 07:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1548676048-19626-1-git-send-email-yotta.liu@ucloud.cn>
In-Reply-To: <1548676048-19626-1-git-send-email-yotta.liu@ucloud.cn>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 3 Feb 2019 09:50:45 -0600
Message-ID: <CAH2r5mt05d3fPVk+PowKK-ktMT8=GiU+81qLeU=g9D6CCzBmKg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix NULL pointer dereference of devname
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, Jan 28, 2019 at 5:56 AM Yao Liu <yotta.liu@ucloud.cn> wrote:
>
> There is a NULL pointer dereference of devname in strspn()
>
> The oops looks something like:
>
>   CIFS: Attempting to mount (null)
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>   ...
>   RIP: 0010:strspn+0x0/0x50
>   ...
>   Call Trace:
>    ? cifs_parse_mount_options+0x222/0x1710 [cifs]
>    ? cifs_get_volume_info+0x2f/0x80 [cifs]
>    cifs_setup_volume_info+0x20/0x190 [cifs]
>    cifs_get_volume_info+0x50/0x80 [cifs]
>    cifs_smb3_do_mount+0x59/0x630 [cifs]
>    ? ida_alloc_range+0x34b/0x3d0
>    cifs_do_mount+0x11/0x20 [cifs]
>    mount_fs+0x52/0x170
>    vfs_kern_mount+0x6b/0x170
>    do_mount+0x216/0xdc0
>    ksys_mount+0x83/0xd0
>    __x64_sys_mount+0x25/0x30
>    do_syscall_64+0x65/0x220
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Fix this by adding a NULL check on devname in cifs_parse_devname()
>
> Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> ---
>  fs/cifs/connect.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 683310f..39abb18 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -1465,6 +1465,11 @@ static int cifs_parse_security_flavors(char *value,
>         const char *delims = "/\\";
>         size_t len;
>
> +       if (unlikely(!devname || !*devname)) {
> +               cifs_dbg(VFS, "Device name not specified.\n");
> +               return -EINVAL;
> +       }
> +
>         /* make sure we have a valid UNC double delimiter prefix */
>         len = strspn(devname, delims);
>         if (len != 2)
> --
> 1.8.3.1
>


-- 
Thanks,

Steve
