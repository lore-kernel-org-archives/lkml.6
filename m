Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4671C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9566B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REp44qVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9566B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeKAXh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:37:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41308 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeKAXh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:37:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so6402107pfn.8;
        Thu, 01 Nov 2018 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9rM/MZXOtyz58zrKy6bBr9nhnQkCN2qgcFSbQfX3gc=;
        b=REp44qVjCjwYyWNvsxw4+lyr0bNygzK2jlZ+thIaKLo7tO2nXOa8Ns6jMaTumDTUfL
         SRBFkdNDfGPupuQAa56wlFct+6iARP8oBps3LzXHMOwitW2MD6OridrcxrzMgDYHROHG
         8LEEwduuY+ihXFoPHP4/LPqPHPtx9+EUmcRd6R4HCcjZSDEwvjeeTaSh63lGBBUkPKB+
         +GR8Gj9Uo5oI1vCNiiG5WkBEo/6GbnXVe+y9nh7WmgU6mx3LPkM0Ne6lhTtQI1d5QWj9
         Q6Op0vx1Ru++ThIMMs9sij1NNH2CyOjB1Y0EDIWpuAyOmqdHPdcO2UBq2aJbp+WPZp/h
         9UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9rM/MZXOtyz58zrKy6bBr9nhnQkCN2qgcFSbQfX3gc=;
        b=ms+34A179LMdNS6h5ovCXigN3XEX/Up1Vj1DMcX8qf6DzxzytM0dmlnyc8BEF5zpcw
         uapVPkA+CEYhMxlnmZmVcZT5zczhR50JAKFd2kD0d1N2LQkUKUiaxldhSfPLZdYUXaKg
         VR+IQ8sx0VxYOzY2fqrTOkGmD37Ph1Ya0lTVQcH1ryv15DXCn5qVp6nQ9u8dHPcUxRd8
         fqe1F2DPTeu5WpeCnYRQpJxUKiv5sj5JJeCTdUsR4XH5Omy3vjOnHQhsdaJ/yK73vC3B
         89J88gFy+lXqaXYalnRQhbBQBsTd5hKYmVwHvLks9+pBV1rABSd+DO+y4XKHcmBJLssm
         BjJw==
X-Gm-Message-State: AGRZ1gLWEIFWuaBcDA4Cdx7R4xBE3GwjgnTRQfi+drtiEIQKofwaFOXN
        D/D7Slzr19pfgjsCnRbD9HGtd1SQ/l0AYB3yniw=
X-Google-Smtp-Source: AJdET5dLf6lylUQbNaCWX4XNRaGK055SVG/sjMtA29OlCOfcFCAz024a3rPTwvxt8K0ElTTscWfiKK0LD+CvYJrjyJs=
X-Received: by 2002:a62:39d2:: with SMTP id u79-v6mr8032741pfj.116.1541082853867;
 Thu, 01 Nov 2018 07:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181101131430.28901-1-colin.king@canonical.com>
In-Reply-To: <20181101131430.28901-1-colin.king@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 1 Nov 2018 09:34:03 -0500
Message-ID: <CAH2r5mvCPzdmVMMLXY+87stsPXky-GKtJVRuUanyVsGriYKjWw@mail.gmail.com>
Subject: Re: [PATCH] cifs: don't dereference smb_file_target before null check
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next
On Thu, Nov 1, 2018 at 8:14 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a null check on dst_file->private data which suggests
> it can be potentially null. However, before this check, pointer
> smb_file_target is derived from dst_file->private and dereferenced
> in the call to tlink_tcon, hence there is a potential null pointer
> deference.
>
> Fix this by assigning smb_file_target and target_tcon after the
> null pointer sanity checks.
>
> Detected by CoverityScan, CID#1475302 ("Dereference before null check")
>
> Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/cifsfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index e46af70153c0..db83938809a5 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1003,8 +1003,8 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
>         struct inode *src_inode = file_inode(src_file);
>         struct inode *target_inode = file_inode(dst_file);
>         struct cifsFileInfo *smb_file_src = src_file->private_data;
> -       struct cifsFileInfo *smb_file_target = dst_file->private_data;
> -       struct cifs_tcon *target_tcon = tlink_tcon(smb_file_target->tlink);
> +       struct cifsFileInfo *smb_file_target;
> +       struct cifs_tcon *target_tcon;
>         unsigned int xid;
>         int rc;
>
> @@ -1021,6 +1021,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
>                 goto out;
>         }
>
> +       smb_file_target = dst_file->private_data;
> +       target_tcon = tlink_tcon(smb_file_target->tlink);
> +
>         /*
>          * Note: cifs case is easier than btrfs since server responsible for
>          * checks for proper open modes and file type and if it wants
> --
> 2.19.1
>


-- 
Thanks,

Steve
