Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC295ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF0208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eD7zKSZc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eD7zKSZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DF0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeISGWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:22:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeISGWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:22:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDB976020A; Wed, 19 Sep 2018 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537318057;
        bh=VRaob6D0wcpMGJdQ0wtXZW1gkTnQIghgI7j8E9wJcPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD7zKSZcMBBlbEmqCSINk5sCS3BMTmy0uI4WqcPxeSYk1NZO7aqEBhumGTNVE2ny3
         hgd34CAnm3q6bFYlPv0VJV3OPaORt9PgaWbgFqhblK4Vo6GZSEkxfzcQgewLIA8exY
         rhehU3Cr5BbuYWfiDlNsXoE7u2g56x2TN21vrJ8U=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C27C6074D;
        Wed, 19 Sep 2018 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537318057;
        bh=VRaob6D0wcpMGJdQ0wtXZW1gkTnQIghgI7j8E9wJcPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD7zKSZcMBBlbEmqCSINk5sCS3BMTmy0uI4WqcPxeSYk1NZO7aqEBhumGTNVE2ny3
         hgd34CAnm3q6bFYlPv0VJV3OPaORt9PgaWbgFqhblK4Vo6GZSEkxfzcQgewLIA8exY
         rhehU3Cr5BbuYWfiDlNsXoE7u2g56x2TN21vrJ8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C27C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 19 Sep 2018 06:17:32 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Message-ID: <20180919004732.GF22939@codeaurora.org>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918021805.85032-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:18:04PM -0700, Jaegeuk Kim wrote:
> This fixes wrong error report in f2fs_rename.

I think f2fs_cross_rename() path also needs the same fix?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 98d3ab7c3ce6..d653be777529 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	struct f2fs_dir_entry *old_entry;
>  	struct f2fs_dir_entry *new_entry;
>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
> -	int err = -ENOENT;
> +	int err;
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return -EIO;
> @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (err)
>  		goto out;
>  
> +	err = -ENOENT;
>  	if (new_inode) {
>  		err = dquot_initialize(new_inode);
>  		if (err)
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
