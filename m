Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC77C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C514921473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFphoySQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C514921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJBH4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:56:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38277 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJBH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:56:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so228935ljc.5;
        Mon, 01 Oct 2018 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IhmSTjit+371V2yMzx89W1i4kUHlGAQnNmreFIYpziw=;
        b=AFphoySQPDbaqJ84kY9V5TVV2t0Uv9bcjx/8DSp3d9IhBgik3s+gozo1zxgPs385XE
         GSVEm3EZh/vE1hak0qgC4/l6l/aq+lMSO4BnnNYc60sdVGHZ+haucc7iv2B2pIsm9YvN
         niscWEhwIv3Gnc8tMYNSNpDDfpKbbWVNX4VzLNJUZeb85J8zM1Ndiz5cCX8SCXx+QYhh
         g8enTSh6zBO/pHPiyYRpMjn9WjGR2ispc3/zmO047/fG/YOh8Ps6Zs/Kb+q1pJDhr/aH
         vW/TGBL8H+4UvToWdSWSFBQ8zp/CMMPDOkRtmLuBb9IGztehe8vk+RDSn0SDNZi9siw4
         JHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IhmSTjit+371V2yMzx89W1i4kUHlGAQnNmreFIYpziw=;
        b=NRc+BNOJ7VVOT1+C5LosyCP9+XqWGZIK6yyFVF5vuhmfzai4qHPT6U/p+8m0n5PrZr
         tA5gF+z276FpxwuaqM1VfDRsxXJr5nYDsMVE66N4r4qr/3JjQD+96WExbocoAMwNhkLO
         +PwHwsozkc+uEzxMfP0y58ll9C8n7ZTEUwu2WqYpwAkMpAweT9aB+7xco9UZGscfAVfO
         S6ANdtSiSpt4vk+BK66Q2Z+5tzZw7xLhvJIdhqEvJ2TXue/vj//7ypigH+4FFlQw0nwR
         +hulKv7ShpFOHfksniguTdg0MCuwenvJqd3pFfYzx03XMbK+RjiPiHJDbqXfyCpnsVvg
         epuw==
X-Gm-Message-State: ABuFfohIeRavewqQCzyUDJeW3N8nC67T6RAUIttte8TYRqWfIF55wJ0x
        zSi9J8wGrynf9eeHo1q1QWMb9UI0GctEb6EAPQ==
X-Google-Smtp-Source: ACcGV60cpjn07e8RCXxnRYFQRbrVATFzcZ0TAANWv6P4cOdnMR+uWenULdfULXhUL5gi/TVXByd/PqkA/ozeXx0oUxA=
X-Received: by 2002:a2e:21d2:: with SMTP id h79-v6mr7655713lji.46.1538442973518;
 Mon, 01 Oct 2018 18:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <463f424e3d4724a4ab7b84c395e7b0cf3068e31f.1538441538.git.rfreire@redhat.com>
In-Reply-To: <463f424e3d4724a4ab7b84c395e7b0cf3068e31f.1538441538.git.rfreire@redhat.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Mon, 1 Oct 2018 18:16:02 -0700
Message-ID: <CAKywueRxPtQHpSR9GBFW1o+j3cY=5B4DJZdv1bk+7Fkx2zf4YA@mail.gmail.com>
Subject: Re: [PATCH] CIFS: Print message when attempting mount
To:     rfreire@redhat.com
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 1 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:59, Rodrigo Frei=
re <rfreire@redhat.com>:
>
> By default, no messages are printed when mounting a CIFS filesystem.
> This information is valuable when troubleshooting and/or forensic
> analyzing a system and finding out if was a CIFS endpoint mount
> attempted.
> Other filesystems such as XFS, EXT* does issue a printk() when mounting
> their filesystems.
>
> Sample output:
>
> [root@ll-rhel7 ~]# mount -o user=3Dadministrator //172.25.250.18/c$ /mnt
> (non-existent system)
>
> [root@ll-rhel7 ~]# mount -o user=3Dadministrator //172.25.250.19/c$ /mnt
> (Valid system)
>
> Kernel message log:
>
> [  450.464543] CIFS VFS: Attempting to mount //172.25.250.18/c$
> [  456.478186] CIFS VFS: Error connecting to socket. Aborting operation.
> [  456.478381] CIFS VFS: cifs_mount failed w/return code =3D -113
> [  467.688866] CIFS VFS: Attempting to mount //172.25.250.19/c$
>
> Signed-off-by: Rodrigo Freire <rfreire@redhat.com>

Hi Rodrigo,

> ---
>  fs/cifs/cifsfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 7065426..3f5a31e 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -707,6 +707,7 @@ static int cifs_set_super(struct super_block *sb, voi=
d *data)
>         struct cifs_mnt_data mnt_data;
>         struct dentry *root;
>
> +       cifs_dbg(VFS, "Attempting to mount %s\n", dev_name);
>         cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);

Let's change the next FYI line to not contain devname thus avoiding
duplicate logging when FYI is enabled.

>
>         volume_info =3D cifs_get_volume_info((char *)data, dev_name, is_s=
mb3);
> --
> 1.8.3.1
>

Other than the comment above I agree with the change.

--
Best regards,
Pavel Shilovsky
