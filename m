Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F399C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AD020863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="qTABjKJu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u0/3/4wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AD020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937220AbeFSDBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:01:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33275 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934644AbeFSDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:01:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 89B6021D2C;
        Mon, 18 Jun 2018 23:01:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Jun 2018 23:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=iIOG9FWy9AIPCZ35fAdq85FqkG51I
        M8/qLsjF+/+Pto=; b=qTABjKJuhOOv9IqGnclnaa3t5w0pb0QPxglCEE4kH1JPM
        I3FLJkKjhSaHX4FoewqT6xdtPYdczsPt6uz7vzMWer6Ep1g3J9mm1HMzFzkjMH9J
        51HV8aCzG3s9Eq8gkRVKzmDM6ZF1tw74MNhRUgG2T6tXoaYPDZ+LSSyplFjVBcob
        DBryo5yWySJQz5W0oXkP2gvgdh20lIotPjnBW367NyCRbYLsaVj9gEmgEv1SkBZd
        K6Hw6oPdITGIIMUIOnJtLORTM4NhmroFSb0GhhDLq9RgP3zzyyiqsroci8+6KETD
        8S97CkF6mt3dheI2XHBxIOdDRhDLVpKQppM/LnHhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iIOG9F
        Wy9AIPCZ35fAdq85FqkG51IM8/qLsjF+/+Pto=; b=u0/3/4wMxRAWUy770ggjJz
        x9cmh3PNxlZxalpJEfI/8IDx1fTsTVdO9V5K3irfOZogc/abxXZfJoG3Km9N2rQi
        5iLsrS4/VUBWaEUPpXcpPzBJUzvQrV09YnAvffYOMrDB/tT9egnDUUsrT4Q8gG/k
        hXUZhjf/SlWBbgkIyLM/wcZosk8RV6Tq/j05f0xmi7GUF3LO6cmTxsf3Pk0E3y0a
        4Qe7RVBAUySe8BmleO8NzAUy31fvRFB4GuGCxF9DeWw/6aLw2yMCn327R9pqbwwJ
        ofFG2ReiLKlzL+oSugxM4rZlT1zn4l1t5c4wVvBA5GXHATJ7CdO3h7LxiaOzFl0A
        ==
X-ME-Proxy: <xmx:AXIoW-AvSy8AgwYW58DFcxPzKyrdYKjMNlnKHShLhoxbbGoh9oaiag>
    <xmx:AXIoW-Tq0kUnUnv1f9xNrJCZRwxj0KO5vRxOBHrsxs-7L4R53ZLA4g>
    <xmx:AXIoW_opCli3SVpBnVJAk44U3lszxCZxgVU4-S_rhW7bDlk-tArJFw>
    <xmx:AXIoW3ViliVZ3BeesPdwr9-d9dV8ONk_8OZWwk419lbSmfJpvbEajg>
    <xmx:AXIoW9_zy6r4OA7AbRLqO5dW_qX15mcCqcGwy9eFNJD8NJO_f15UWw>
    <xmx:AXIoW1fLA4NSQo6O3l3lvtNiiAGDC0bdMbJIriumGBP6wnO6MPNPHA>
X-ME-Sender: <xms:AXIoW2ER_HPDSb-SC3lWP4owebcusk6M7f6fN3oPJFjxBiJ58AMkLA>
Received: from localhost (unknown [118.209.60.167])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC767E4855;
        Mon, 18 Jun 2018 23:01:19 -0400 (EDT)
Message-ID: <1529377277.20979.1.camel@themaw.net>
Subject: Re: [PATCH 1/7] autofs - fix directory and symlink access
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:01:17 +0800
In-Reply-To: <152937661793.20656.604490449672006599.stgit@pluto.themaw.net>
References: <152937661793.20656.604490449672006599.stgit@pluto.themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Very sorry, clearly I have already sent this to you.
Unfortunately I didn't stop this in time, please ignore.

On Tue, 2018-06-19 at 10:50 +0800, Ian Kent wrote:
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
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
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
