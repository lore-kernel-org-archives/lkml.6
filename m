Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC174C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B5320020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rVw6273E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B5320020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030258AbeFSRPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:15:38 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35617 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:15:36 -0400
Received: by mail-lf0-f49.google.com with SMTP id i15-v6so668471lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVDyg2eFp3a3mAVhkEOCC9c0A3nI5/DCaXcSGKpAQUw=;
        b=rVw6273ElqWoXtkRJSm+dQK1XqbvUfdLRM1Y7Sj2srZWNTeLkcAPcX3Vq4b5JYfhb/
         l5EYKY5G6liP2ijxXfUrbcvxBPtaLgrHPOhwp6rRiyrNlynN7QqyYaZgiClraRUxIWpD
         GX7PSRewd2IWmJ7XuKagoo5BL/pegncZBJMeQmWk9qINSBF6FAAoM8daQ9Z0skOHPuWi
         YO4I8gP8W0qXB+esWIVkRKQN+lg4wqLIqQo29PiLqZ/lsglNrsug9RWeR89uapHXBQXn
         FOd+FtJ25iYRGhNO5WArj0/r94fIyjyfagS01DQ0l7kPTMPJt+IZ05Ia6rTzPIJSg/MG
         FrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVDyg2eFp3a3mAVhkEOCC9c0A3nI5/DCaXcSGKpAQUw=;
        b=LjNUHz0/Fh0hTffzf3oN+F3YuJmu04rCUl5i8HKM6vbZhc7l90MRLiTV/BrupElhao
         ZE1MHPAVSqGil8UCdgfx9jvCWualqly3GyLtuErKR1d425FXf8PoB6HWZ/NF8sucvOWu
         ejQL5bCMtX5pKC8nEEuKWi9J1Q4J0tzSjfFLUBLFxJpBswC5wOFwK5u1fZ2na13kmUGC
         1poOVCu+qdODfkIRUThmNgYpYGNROMUAxhQ7foBTX9BtD1iTwWDs8LC2uI2k1TFRz+CA
         0oW4LzYB5KeeFK+IfK+FgTXIX8Cm5q3kN9VpFlEpCzgj9YOUyHH6tZmqOlicA0EoPOmE
         01cQ==
X-Gm-Message-State: APt69E0k2giOtmTicCEbywRmxzXeLcF2qIc1kxUFsXrg9MBvdve001J+
        EtUxzOE02fDj65cj4gQOL1c7lNNN1GanhjL6oPmM
X-Google-Smtp-Source: ADUXVKKAao+XLBQvlwpOmAoY3TtoEL2BLhJKqwrqLN+EiZyT2/6dHpUo1E/pINTFXTdQyO+iaVPE6uTRgZbRYKG2qJE=
X-Received: by 2002:a2e:4d0e:: with SMTP id a14-v6mr12170183ljb.106.1529428534897;
 Tue, 19 Jun 2018 10:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-8-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-8-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:15:24 -0400
Message-ID: <CAHC9VhT_FRmjXe_6_t+FS3OvPKQTX91dzLK3=nVvJ3aPAohZcA@mail.gmail.com>
Subject: Re: [PATCH 07/13] selinux: Cleanup printk logging in selinuxfs
To:     peter.enderborg@sony.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/selinuxfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c0cadbc5f85c..2adfade99945 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -620,7 +620,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -956,7 +956,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -1147,7 +1147,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -1996,7 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>                 goto err;
>         return 0;
>  err:
> -       printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
> +       pr_err("SELinux: %s:  failed while creating inodes\n",
>                 __func__);
>
>         selinux_fs_info_free(sb);
> @@ -2046,7 +2046,7 @@ static int __init init_sel_fs(void)
>
>         selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
>         if (IS_ERR(selinuxfs_mount)) {
> -               printk(KERN_ERR "selinuxfs:  could not mount!\n");
> +               pr_err("selinuxfs:  could not mount!\n");
>                 err = PTR_ERR(selinuxfs_mount);
>                 selinuxfs_mount = NULL;
>         }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
