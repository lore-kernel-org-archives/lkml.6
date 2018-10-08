Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B86C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C7A20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRtynmQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C7A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJHVe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:34:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D32F2075C;
        Mon,  8 Oct 2018 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539008551;
        bh=irArNEDErMVp4bXjv+I5F40It8qUH/GT27K8tTMyTMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRtynmQpoQk/IyJt/9qt9yWU0T6moosvIMLw/vH8us2LZEDeGekFlBZPU8WshqYAN
         dii2QKIzwI3sqCxNewyP5b1/AG8aP7bFa8AJY4AYw/th7NZn2TTBTzrJiI4exuxwuj
         8xqIDi5+T6ZQ+Es9H5k3fG1sTS/kP6mfmOBdpK2g=
Date:   Mon, 8 Oct 2018 16:22:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: erofs: add SPDX identifer
Message-ID: <20181008142228.GB13359@kroah.com>
References: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:14:09PM +0200, Loic Tourlonias wrote:
> Add SPDX identifier to simplify header and remove whole license text
> 
> v1 -> v2:
> 
> Move SPDX identifier to first line and change comment delimiter

The "changes" need to go below the --- line.

> 
> Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
> ---
>  drivers/staging/erofs/lz4defs.h | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
> index 00a0b58a0871..cdacc57e6a08 100644
> --- a/drivers/staging/erofs/lz4defs.h
> +++ b/drivers/staging/erofs/lz4defs.h
> @@ -1,32 +1,12 @@
> +/* SPDX-License-Identifier: BSD-2-Clause*/
>  #ifndef __LZ4DEFS_H__
>  #define __LZ4DEFS_H__
> -
>  /*

Why delete that line?

But wait, why do we even have this file at all?  What's wrong with the
lib/lz4/ code that we have in the kernel today?  Shouldn't the code
using these files be moved over to use the lib/ code instead and this
file be deleted?

thanks,

greg k-h
