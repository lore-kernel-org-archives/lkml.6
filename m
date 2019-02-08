Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB0A217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628168;
	bh=Ocr0gDfjjb58Oh1RlbDcPBcNhRyWiymk0jG5hLQ7Gvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uq5NijpwvlhJMHZ+feSizDZcWsvINLwJrFXjOm075cndCtzaSKkUVJufPo58O7OMG
	 LaQUqXIrd59sbwZ7q9hzwCzTbRIYxdSibDcFI6LYs1pBk3alxIIgNqf6bNZ8aeafnN
	 7EjFXWK94r4ngyR+HrdgKHhXSG5bpmSSzH8f+dD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfBHMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:16:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2D02086C;
        Fri,  8 Feb 2019 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628166;
        bh=Ocr0gDfjjb58Oh1RlbDcPBcNhRyWiymk0jG5hLQ7Gvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdWeQPlZHCBoCYyjfX4pDvC1GTOW4DyD+P31xttm4AbaK9i042RjnZ8jCVTwzXODa
         2133DuBzeGzob9sRglc9CSJ6agFluDxxUG7UZVL4CnaLHaBBtDPwisOFL4uf5BN7Uf
         zqRdUDH11OidWtz70nSopISk1wF0dKEy0OkRTyv8=
Date:   Fri, 8 Feb 2019 13:16:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, rppt@linux.ibm.com,
        ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v3 14/15] habanalabs: add debugfs support
Message-ID: <20190208121603.GC23483@kroah.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
 <20190204203254.4026-15-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204203254.4026-15-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:32:53PM +0200, Oded Gabbay wrote:
> +int __init hl_debugfs_init(void)
> +{
> +	hl_debug_root = debugfs_create_dir("habanalabs", NULL);
> +	if (IS_ERR_OR_NULL(hl_debug_root)) {
> +		pr_err("can not create debugfs directory\n");
> +		hl_debug_root = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

This function should just be one line:
void __init hl_debugfs_init(void)
{
	hl_debug_root = debugfs_create_dir("habanalabs", NULL);
}

No need to do anything else, or check anything.

thanks,

greg k-h
