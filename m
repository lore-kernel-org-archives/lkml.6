Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E5C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeFTUjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:39:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeFTUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:39:15 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AEE1DCB8;
        Wed, 20 Jun 2018 20:39:14 +0000 (UTC)
Date:   Thu, 21 Jun 2018 05:39:12 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mawanda Henry <mawandahenrynaco@gmail.com>
Cc:     mawanda111@gmail.com, xdeguillard@vmware.com, moltmann@vmware.com,
        pv-drivers@vmware.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/misc: SPDX-licensing
Message-ID: <20180620203912.GA12402@kroah.com>
References: <20180620170524.GA18126@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620170524.GA18126@sesnaco>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 08:05:24PM +0300, Mawanda Henry wrote:
> Attach SPDX license header. Concatinate int on unsigned
> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/misc/vmw_balloon.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 9047c0a..762429d 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * VMware Balloon driver.
>   *
> @@ -247,7 +248,7 @@ struct vmballoon_stats {
>  	unsigned int doorbell_unset;
>  };
>  
> -#define STATS_INC(stat) (stat)++
> +#define STATS_INC(stat) ((stat)++)
>  #else
>  #define STATS_INC(stat)
>  #endif
> @@ -275,7 +276,7 @@ struct vmballoon {
>  	struct vmballoon_page_size page_sizes[VMW_BALLOON_NUM_PAGE_SIZES];
>  
>  	/* supported page sizes. 1 == 4k pages only, 2 == 4k and 2m pages */
> -	unsigned supported_page_sizes;
> +	unsigned int supported_page_sizes;
>  
>  	/* balloon size in pages */
>  	unsigned int size;
> @@ -559,7 +560,7 @@ static void vmballoon_free_page(struct page *page, bool is_2m_page)
>  static void vmballoon_pop(struct vmballoon *b)
>  {
>  	struct page *page, *next;
> -	unsigned is_2m_pages;
> +	unsigned int is_2m_pages;
>  
>  	for (is_2m_pages = 0; is_2m_pages < VMW_BALLOON_NUM_PAGE_SIZES;
>  			is_2m_pages++) {
> @@ -796,7 +797,7 @@ static void vmballoon_add_batched_page(struct vmballoon *b, int idx,
>   */
>  static void vmballoon_inflate(struct vmballoon *b)
>  {
> -	unsigned rate;
> +	unsigned int rate;
>  	unsigned int allocations = 0;
>  	unsigned int num_pages = 0;
>  	int error = 0;
> @@ -936,7 +937,7 @@ static void vmballoon_inflate(struct vmballoon *b)
>   */
>  static void vmballoon_deflate(struct vmballoon *b)
>  {
> -	unsigned is_2m_pages;
> +	unsigned int is_2m_pages;
>  
>  	pr_debug("%s - size: %d, target %d\n", __func__, b->size, b->target);
>  
> @@ -1234,7 +1235,7 @@ static int __init vmballoon_debugfs_init(struct vmballoon *b)
>  {
>  	int error;
>  
> -	b->dbg_entry = debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
> +	b->dbg_entry = debugfs_create_file("vmmemctl", 0444, NULL, b,
>  					   &vmballoon_debug_fops);
>  	if (IS_ERR(b->dbg_entry)) {
>  		error = PTR_ERR(b->dbg_entry);
> @@ -1266,7 +1267,7 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
>  static int __init vmballoon_init(void)
>  {
>  	int error;
> -	unsigned is_2m_pages;
> +	unsigned int is_2m_pages;
>  	/*
>  	 * Check if we are running on VMware's hypervisor and bail out
>  	 * if we are not.
> -- 
> 2.7.4

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
