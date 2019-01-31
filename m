Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA58C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F206218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OryN5+08";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nx4HIoEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfAaDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:20:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:20:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 242C660C17; Thu, 31 Jan 2019 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548904833;
        bh=NfvCSE4QRdgO2piosvYXvd9qsyd0QTthZBp4yxpJ0Io=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=OryN5+088/2+PS3ObLVOJveqKV227wfzJ4uBgXPQwiV0D8Q1OO0RLLwXzdxAkzGRH
         /QTL7pek4Z2jVcZEq4Og2Iu323lMxhrT9Lg+1q1g4nPK+VAS3rqUJxLeVx20AY57zi
         iPNfXx5pbduXcfvT83XwUJLTQmZyY2pGM54wW/Q0=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3984660C02;
        Thu, 31 Jan 2019 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548904820;
        bh=NfvCSE4QRdgO2piosvYXvd9qsyd0QTthZBp4yxpJ0Io=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nx4HIoEJ59K1nCBL9Jei4SWR6pgiRQcgzVx46INmvm8WNP4hA57uWL9km7qV+3ih/
         liQ0fU2/YSQwfXT4zOwMShkq8SCFSsvNZBBdb25QkSERkG/f6g/SPugLaY/CSjHhjx
         yaPGEKMjxd5PidQWRzKiOKy5F0SvItJUqMPFypwk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3984660C02
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 31 Jan 2019 08:50:11 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
Message-ID: <20190131032011.GC7308@codeaurora.org>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546514295-24818-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

Can we merge this patch, if there are no further comments?

Thanks,
Sahitya.

On Thu, Jan 03, 2019 at 04:48:15PM +0530, Sahitya Tummala wrote:
> In the vfs_statx() context, during path lookup, the dentry gets
> added to sd->s_dentry via configfs_attach_attr(). In the end,
> vfs_statx() kills the dentry by calling path_put(), which invokes
> configfs_d_iput(). Ideally, this dentry must be removed from
> sd->s_dentry but it doesn't if the sd->s_count >= 3. As a result,
> sd->s_dentry is holding reference to a stale dentry pointer whose
> memory is already freed up. This results in use-after-free issue,
> when this stale sd->s_dentry is accessed later in
> configfs_readdir() path.
> 
> This issue can be easily reproduced, by running the LTP test case -
> sh fs_racer_file_list.sh /config
> (https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/racer/fs_racer_file_list.sh)
> 
> Fixes: 76ae281f6307 ('configfs: fix race between dentry put and lookup')
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> - update comments relevant to the code.
> 
>  fs/configfs/dir.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 39843fa..f113101 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -58,15 +58,14 @@ static void configfs_d_iput(struct dentry * dentry,
>  	if (sd) {
>  		/* Coordinate with configfs_readdir */
>  		spin_lock(&configfs_dirent_lock);
> -		/* Coordinate with configfs_attach_attr where will increase
> -		 * sd->s_count and update sd->s_dentry to new allocated one.
> -		 * Only set sd->dentry to null when this dentry is the only
> -		 * sd owner.
> +		/*
> +		 * Set sd->s_dentry to null only when this dentry is the
> +		 * one that is going to be killed.
>  		 * If not do so, configfs_d_iput may run just after
>  		 * configfs_attach_attr and set sd->s_dentry to null
>  		 * even it's still in use.
>  		 */
> -		if (atomic_read(&sd->s_count) <= 2)
> +		if (sd->s_dentry == dentry)
>  			sd->s_dentry = NULL;
>  
>  		spin_unlock(&configfs_dirent_lock);
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
