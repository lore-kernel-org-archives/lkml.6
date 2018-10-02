Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C8C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216982064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9tjs6CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216982064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJCCCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:02:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46798 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeJCCCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:02:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so380033pgv.13;
        Tue, 02 Oct 2018 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hr5dcYumIG6JIbThdJSOFbybVtoBzDv7zhZH3CEGRbI=;
        b=D9tjs6CVVZz5LOF5qVaTsUzVHUVkLJBx2KuX9Vdrf/GULRTHIRsPXoAeX02IRpcGso
         K7aPu/KlPKLfLXlB9V/zHW5eCkw3Y1s4Yp/SuF9mzIQHtcr8XHswAl5O7BoFXcv6q2i8
         qtSovk1zWFTFDo81xb/2lXJ9cOils0zsILZNn8w4t/Sw0Of4Jy/4HK9oF6yqtQcRrxdj
         U0A86SXPmYxEcWaolPWS2yhQAebyna8BBZuBAyZJKo4VaB9dq/h1NcQhBUWyWrgsiixg
         KsdXkfrMw0KlfiNFP2gGlk+TCHBH2Q9X/gD6aVfIB20aXgctXcL0JD1NNZm52KAq9rh4
         jUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hr5dcYumIG6JIbThdJSOFbybVtoBzDv7zhZH3CEGRbI=;
        b=sACL9ADsvdGflhq0clxlvtwVHXipJ7BtRViKaz04/hivCdhWjoTHfr9bbj2sB+lXeD
         CtmYZlJjrGQbaJaZawqM6fWPWf1nj99QIi0b0PD3SgqvhawBLClR9tEtLzV/lYEl11JJ
         wZv4kMpIUX6gbusedzBAYI5OXS3eRzHweoHemoRcPfaik4WD3bSuFvSZuJ/MRPRxGP9+
         QC69GN3tTLZVN2uq4CyOYO+Gc96uiLTNvmyMUVkFkTT4kr2rGMD1vo7g5aSiYTAQSnv/
         fgj4D8v95lf2+8ZkanJ7bFx7zUVm8ByN5yWvFVMhi4U0ySleCg/5//HNyo95qfvUcnU5
         PcIA==
X-Gm-Message-State: ABuFfohuwq7yKOsysIijZCd7gM9v8p+qnCP09EERvUgf3C9F7qIt00tL
        MVPdPbLvt2NDZyxMN+EjVWrp9b4cqcq63b7A8iU=
X-Google-Smtp-Source: ACcGV62DObUQTlYcCm/jq7RfsGeNQihQ+JHvipCKyMc71kR8AAly4drgNliRlOsK1LvA9XGfkGGtF6Ygz2UFfgAoxwM=
X-Received: by 2002:a62:c999:: with SMTP id l25-v6mr7708480pfk.10.1538507833762;
 Tue, 02 Oct 2018 12:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
In-Reply-To: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 2 Oct 2018 14:17:02 -0500
Message-ID: <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure that these aren't logged by the automounter (for ext4,
xfs etc.).  When I looked in my dmesg logs I didn't find matching log
entries in the file systems themselves.  Do you have an example?

On the idea of adding cifsFYI logging here - I slightly prefer using
ftrace (trace-cmd, ie dynamic tracing) so there is less overhead and
easier to turn on/off following the example of xfs, f2fs, nfs, nfsd
etc.
On Tue, Oct 2, 2018 at 6:57 AM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Currently, no messages are printed when mounting a CIFS filesystem and
> no debug configuration is enabled.
>
> However, a CIFS mount information is valuable when troubleshooting
> and/or forensic analyzing a system and finding out if was a CIFS
> endpoint mount attempted.
>
> Other filesystems such as XFS, EXT* does issue a printk() when mounting
> their filesystems.
>
> A terse log message is printed only if cifsFYI is not enabled.
>
> Sample mount operations:
>
> [root@corinthians ~]# mount -o user=administrator //172.25.250.18/c$ /mnt
> (non-existent system)
>
> [root@corinthians ~]# mount -o user=administrator //172.25.250.19/c$ /mnt
> (Valid system)
>
> Kernel message log for the mount operations:
>
> [  450.464543] CIFS VFS: Attempting to mount //172.25.250.18/c$
> [  456.478186] CIFS VFS: Error connecting to socket. Aborting operation.
> [  456.478381] CIFS VFS: cifs_mount failed w/return code = -113
> [  467.688866] CIFS VFS: Attempting to mount //172.25.250.19/c$
>
> v2: Created a loop to select the right cifs_dbg message to be printed,
>     considering the current system's scenario, in order to avoid a
>     duplicate message or stripping out important information in
>     debug.
>
> Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
> ---
>  fs/cifs/cifsfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 7065426..7fde6bc 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -707,7 +707,11 @@ static int cifs_set_super(struct super_block *sb, void *data)
>         struct cifs_mnt_data mnt_data;
>         struct dentry *root;
>
> -       cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
> +       /* Prints in Kernel / CIFS log the attempted mount operation */
> +       if (cifsFYI)
> +               cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
> +       else
> +               cifs_dbg(VFS, "Attempting to mount %s\n", dev_name);
>
>         volume_info = cifs_get_volume_info((char *)data, dev_name, is_smb3);
>         if (IS_ERR(volume_info))
> --
> 1.8.3.1
>


-- 
Thanks,

Steve
