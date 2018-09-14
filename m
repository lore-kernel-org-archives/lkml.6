Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FCFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2574320671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2574320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeINSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:45:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeINSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:45:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D516D61;
        Fri, 14 Sep 2018 13:30:47 +0000 (UTC)
Date:   Fri, 14 Sep 2018 15:30:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH 07/20] platform: goldfish: pipe: Replace an array of 1
 with a variable
Message-ID: <20180914133044.GB16982@kroah.com>
References: <20180827182315.126345-1-rkir@google.com>
 <20180827182315.126345-7-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827182315.126345-7-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:23:02AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> There is no reason to have an array of 1.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  drivers/platform/goldfish/goldfish_pipe.c | 28 +++++++++++------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index 24e40deb98cc..e9e3e791c0d4 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -205,7 +205,7 @@ struct goldfish_pipe_dev {
>  	unsigned char __iomem *base;
>  };
>  
> -static struct goldfish_pipe_dev pipe_dev[1] = {};
> +struct goldfish_pipe_dev goldfish_pipe_dev;


Why do you need a static structure at all?  Shouldn't this be tied to
the dynamic device the driver core gives you?  That way you can handle
any number of these devices without any code changes needed.

thanks,

greg k-h
