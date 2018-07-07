Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5705C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7748822453
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7748822453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeGGH56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:57:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeGGH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:57:58 -0400
Received: from localhost (unknown [37.170.5.79])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D921DAD2;
        Sat,  7 Jul 2018 07:57:56 +0000 (UTC)
Date:   Sat, 7 Jul 2018 09:56:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix range checks in kernfs_get_target_path
Message-ID: <20180707075631.GA24038@kroah.com>
References: <AM5PR0701MB26577F11198A56858D55C104E4470@AM5PR0701MB2657.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0701MB26577F11198A56858D55C104E4470@AM5PR0701MB2657.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 09:08:49PM +0000, Bernd Edlinger wrote:
> The strncpy causes a warning [-Wstringop-truncation] here,
> which indicates that it never appends a NUL byte to the path.
> The NUL byte is only there because the buffer is allocated
> with kzalloc(PAGE_SIZE, GFP_KERNEL), but since the range-check
> is also off-by-one, and PAGE_SIZE==PATH_MAX the returned string
> will not be zero-terminated if it is exactly PATH_MAX characters.
> Furthermore also the initial loop may theoretically exceed PATH_MAX
> and cause a fault.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>   fs/kernfs/symlink.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index 08ccabd..c8b7d44a 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -63,7 +63,10 @@ static int kernfs_get_target_path(struct kernfs_node 
> *parent,

Your patch is line-wrapped and can not be applied :(

