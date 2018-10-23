Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="ZWepeXxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJXHIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:08:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:08:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so1304362plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu53doKW+XP6/07uveMEsjoGezFlJALFkGSQ6XSINac=;
        b=ZWepeXxIGClGjwvxPNx+7g2GsJPkJWkjDVg8sonZFXuH5mbgoK2SU0zZN9z1IE0Pad
         dq3D3AfaZE4EAgrAFwuicpKKhzsm9F3Mdt4wg1hK1NHnac7IL58GGCuqJL6FbAFnBwkV
         i4Wu3wvFtwHmum12dHTLWF1v287D4UL/EEIE+rM7REP32gYdy16COcpLVMZ6RWmbYxyf
         qfLlBySSZ8CoZQjxsFF6qaRWlZu6BQPALHiGArgu9q5F8j10halvwQvdGZmPW1V+Q/4j
         bpBQzjEl+gWp9yr8y/FVTvAgZmJcmkkYyTzN8YgMSmBVjyUxztgUwLv/0liQft8p/VYu
         Trkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nu53doKW+XP6/07uveMEsjoGezFlJALFkGSQ6XSINac=;
        b=Idh2dr0K7AIlVq8/K0V2Dvivbq3ElPbjCesZ2qyRFsgVEKxT1Er0FNrijZ4a8Gm49D
         xqFWkVQ/zZy8VCeXQGzLrA5Z7+PaOqSx/6UKrT6kkQLQe5N7m6vo5RBsZJC/0FfBSlVX
         zg5TZJKV/3lm6I531tRNt4AHMyDFwTq9KdVYWq1oRI5ElAgnQCL7O/0DFBiGcpMEd2zA
         B2LuYoicVEaDvxbMhvqDxKDNHUGKtFEUe41wXW+U5XLoX9VX12EfsxhPWfazvBwtOjuD
         PiuVO7ztD8kj2ew+nEbW5dXskRFz2Uq8KzCZ/daQJXrwh2BxLqkKR0HHhTAZxMCONuWT
         Z7Gg==
X-Gm-Message-State: AGRZ1gIoaaVBFUy/zyJeXr53o04d/7lhSUPF427gcBw2PwgiKsdJlKIZ
        ckvkSGc4d7UcMM8S7931HK6Q1tk7AZw=
X-Google-Smtp-Source: AJdET5euL6v3d78aspc82p+8etLprGtl/ECKQIufRF8GyRxQvvkV6ZM0c6a0MPL+CLlLslVgj6S5Ug==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr143040pld.89.1540334569842;
        Tue, 23 Oct 2018 15:42:49 -0700 (PDT)
Received: from [10.11.47.17] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id i4-v6sm3157448pgt.4.2018.10.23.15.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 15:42:36 -0700 (PDT)
Message-ID: <1540334555.28908.1.camel@slavad-ubuntu-14.04>
Subject: Re: [RFC][PATCH 03/10] hfsplus: use fs_umode_to_dtype() helper
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, viro@zeniv.linux.org.uk
Date:   Tue, 23 Oct 2018 15:42:35 -0700
In-Reply-To: <20181023201956.GA15701@pathfinder>
References: <20181023201956.GA15701@pathfinder>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 21:19 +0100, Phillip Potter wrote:
> Replace if/else statements with common lookup table implementation.
> 
> Original patch written by Amir Goldstein.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  fs/hfsplus/dir.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index f37662675c3a..7b798a46c8ac 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -223,7 +223,6 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
>  				break;
>  		} else if (type == HFSPLUS_FILE) {
>  			u16 mode;
> -			unsigned type = DT_UNKNOWN;
>  
>  			if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
>  				pr_err("small file entry\n");
> @@ -232,21 +231,10 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
>  			}
>  
>  			mode = be16_to_cpu(entry.file.permissions.mode);
> -			if (S_ISREG(mode))
> -				type = DT_REG;
> -			else if (S_ISLNK(mode))
> -				type = DT_LNK;
> -			else if (S_ISFIFO(mode))
> -				type = DT_FIFO;
> -			else if (S_ISCHR(mode))
> -				type = DT_CHR;
> -			else if (S_ISBLK(mode))
> -				type = DT_BLK;
> -			else if (S_ISSOCK(mode))
> -				type = DT_SOCK;
>  
>  			if (!dir_emit(ctx, strbuf, len,
> -				      be32_to_cpu(entry.file.id), type))
> +				      be32_to_cpu(entry.file.id),
> +				      fs_umode_to_dtype(mode)))
>  				break;
>  		} else {
>  			pr_err("bad catalog entry type\n");

Looks good. Nice cleanup.

Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Vyacheslav Dubeyko.


