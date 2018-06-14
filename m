Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 553FFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAEE208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAEE208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755177AbeFNMII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:08:08 -0400
Received: from verein.lst.de ([213.95.11.211]:46006 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754913AbeFNMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:08:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 296FA68C4E; Thu, 14 Jun 2018 14:16:28 +0200 (CEST)
Date:   Thu, 14 Jun 2018 14:16:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v1] aio: mark __aio_sigset::sigmask const
Message-ID: <20180614121628.GA27117@lst.de>
References: <20180608145505.29063-1-avi@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608145505.29063-1-avi@scylladb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 05:55:05PM +0300, Avi Kivity wrote:
> io_pgetevents() will not change the signal mask. Mark it const
> to make it clear and to reduce the need for casts in user code.
> 
> Signed-off-by: Avi Kivity <avi@scylladb.com>

Al, can you pick this one and the masking fix before -rc1?

> ---
>  include/uapi/linux/aio_abi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index ed0185945bb2..cdf115b03761 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -106,11 +106,11 @@ struct iocb {
>  
>  #undef IFBIG
>  #undef IFLITTLE
>  
>  struct __aio_sigset {
> -	sigset_t __user	*sigmask;
> +	const sigset_t __user	*sigmask;
>  	size_t		sigsetsize;
>  };
>  
>  #endif /* __LINUX__AIO_ABI_H */
>  
> -- 
> 2.14.4
---end quoted text---
