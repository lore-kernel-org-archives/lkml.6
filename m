Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D1A0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD220891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="uBrVuP8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gi/TZ0st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDD220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965530AbeFODik (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:38:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50101 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965160AbeFODii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:38:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B8B921BBE;
        Thu, 14 Jun 2018 23:38:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 14 Jun 2018 23:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=c10Qz0her06eu5JS/3Rl0i3BYIFLM
        OBo3tWJnquBemg=; b=uBrVuP8Pal8jRv7okQOTg9Ynn6cndODHmjd+swt3fYl+k
        dHbMBFkA6hyqraBYbQLeyGzftHklHqYmQ2eULYT/BSpk6DN96M5d3wmLND9u32y4
        mPINxXwB4B4SR+rpmMUnX/35DC7k92akr/9NdOJ1JLJ0y4tGqc4mrfuRr38IbbZ5
        YRa7eT5Ux2BG8WXiCR+Ty5tv2A+zQ2AfkR2ImF5jb5Y96+7ErqsHhUWVfUjAiBhc
        RKwriwlb9GrrvuGsaZx9h/YMTtD0VW/sWondyV7tnRLrbZX9rL/ioekcbpNRb/u0
        6ZBz0jq9sXX6svtd0OYx46mu1WrWcDLzlG2V6nJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=c10Qz0
        her06eu5JS/3Rl0i3BYIFLMOBo3tWJnquBemg=; b=gi/TZ0stSdDXw8tg/CTzH3
        lvrCgr3gE3sdI2NxNJkt1+AKgEHU5ENs2ytcqAkx2frXXEb+CZE4Ps/ESasTeRJt
        XVvJ3d6IAtpbwbDQ8cn8JrcsucxrPZNyVxpgoBn8LmVWshtSXseAybU6YwL6NE0d
        GYLD8fLefl8UHYCPzR11VPJzI71r2Pf4d0VA8vR70zqPVPmPQJfXiCR8Eru1RKfc
        aTjLLj1YPHmrRmn8hKYwFrpQZy2nfGbSY8cg5wbGELfWxozK1YCdcO9FhrqkIJGN
        psuDRugDKz1ySqdoh3V2nL9/p5tuJSQ2pI4M8KSUmSLgTL7B1CSKomuN/2hflwsA
        ==
X-ME-Proxy: <xmx:vTQjW9yAnnS5083CFgmiEik9zJKsDE2SD0SInI8De3qUiCAiLJV17Q>
    <xmx:vTQjW2n1_4VwEq_JogxL4TvNCDLd3WiziNA4F7DATWkA2EwbIVZjQg>
    <xmx:vTQjW-miubVeEU_feLjLZdO_X95U2j_E7oQOfLEBMtCtYSvDWrcSyg>
    <xmx:vTQjWwzSY_QP5VrYImYqITiFwzg2Pj2OXwR7AboakJPY3_ulyTJx3A>
    <xmx:vTQjW7qtT9aMDEBxX7ru5SgCIFticwRfawULa6WxIKSvWbN3wywV5w>
    <xmx:vTQjW6d9H1DojhWlQ0LvUPbIcwS1LfNqrkBn_x8nH_FXXdb6IDfnow>
X-ME-Sender: <xms:vTQjW4QtWHbfZn5eurWnHrSuaaFDmDtpc8van2xVajtqQismt93grw>
Received: from localhost (unknown [118.209.42.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C348B1025D;
        Thu, 14 Jun 2018 23:38:35 -0400 (EDT)
Message-ID: <1529033913.2717.1.camel@themaw.net>
Subject: Re: [PATCH] autofs - fix directory and symlink access
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Jun 2018 11:38:33 +0800
In-Reply-To: <152902119090.4144.9561910674530214291.stgit@pluto.themaw.net>
References: <152902119090.4144.9561910674530214291.stgit@pluto.themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 08:06 +0800, Ian Kent wrote:

Opps, missing Signed-off-by, please add it!

> Depending on how it is configured the autofs user space daemon can
> leave in use mounts mounted at exit and re-connect to them at start
> up. But for this to work best the state of the autofs file system
> needs to be left intact over the restart.
> 
> Also, at system shutdown, mounts in an autofs file system might be
> umounted exposing a mount point trigger for which subsequent access
> can lead to a hang. So recent versions of automount(8) now does its
> best to set autofs file system mounts catatonic at shutdown.
> 
> When autofs file system mounts are catatonic it's currently possible
> to create and remove directories and symlinks which can be a problem
> at restart, as described above.
> 
> So return EACCES in the directory, symlink and unlink methods if the
> autofs file system is catatonic.

Signed-off-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs/root.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index a3d414150578..782e57b911ab 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -559,6 +559,13 @@ static int autofs_dir_symlink(struct inode *dir,
>  	if (!autofs_oz_mode(sbi))
>  		return -EACCES;
>  
> +	/* autofs_oz_mode() needs to allow path walks when the
> +	 * autofs mount is catatonic but the state of an autofs
> +	 * file system needs to be preserved over restarts.
> +	 */
> +	if (sbi->catatonic)
> +		return -EACCES;
> +
>  	BUG_ON(!ino);
>  
>  	autofs_clean_ino(ino);
> @@ -612,9 +619,15 @@ static int autofs_dir_unlink(struct inode *dir, struct
> dentry *dentry)
>  	struct autofs_info *ino = autofs_dentry_ino(dentry);
>  	struct autofs_info *p_ino;
>  
> -	/* This allows root to remove symlinks */
> -	if (!autofs_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> +	if (!autofs_oz_mode(sbi))
> +		return -EACCES;
> +
> +	/* autofs_oz_mode() needs to allow path walks when the
> +	 * autofs mount is catatonic but the state of an autofs
> +	 * file system needs to be preserved over restarts.
> +	 */
> +	if (sbi->catatonic)
> +		return -EACCES;
>  
>  	if (atomic_dec_and_test(&ino->count)) {
>  		p_ino = autofs_dentry_ino(dentry->d_parent);
> @@ -697,6 +710,13 @@ static int autofs_dir_rmdir(struct inode *dir, struct
> dentry *dentry)
>  	if (!autofs_oz_mode(sbi))
>  		return -EACCES;
>  
> +	/* autofs_oz_mode() needs to allow path walks when the
> +	 * autofs mount is catatonic but the state of an autofs
> +	 * file system needs to be preserved over restarts.
> +	 */
> +	if (sbi->catatonic)
> +		return -EACCES;
> +
>  	spin_lock(&sbi->lookup_lock);
>  	if (!simple_empty(dentry)) {
>  		spin_unlock(&sbi->lookup_lock);
> @@ -735,6 +755,13 @@ static int autofs_dir_mkdir(struct inode *dir,
>  	if (!autofs_oz_mode(sbi))
>  		return -EACCES;
>  
> +	/* autofs_oz_mode() needs to allow path walks when the
> +	 * autofs mount is catatonic but the state of an autofs
> +	 * file system needs to be preserved over restarts.
> +	 */
> +	if (sbi->catatonic)
> +		return -EACCES;
> +
>  	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
>  
>  	BUG_ON(!ino);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
