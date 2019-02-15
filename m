Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6358C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B7A21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7pu0GU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfBODVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:21:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBODVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AwjRuM4DjzJtODtzZyEza48FzxTdsBFsERrlwqwdPu0=; b=s7pu0GU3Gw5oDlkFcjXw0YxL2
        QL+VR19C2rXgiyR9bI9+ruPxvlr273Hj+FgUmE1EWkqn6GYK4J+Z9s/RFVEVo0Hy42ttiDsqSljlu
        fRSg3jscamcppMXnCfH3F6/vaDUOGO1e9Stp4enVSU2K1r5ZuNbws0MiPhSbaRp7gRLIO98LdO7RV
        dL+ybuGNp7TaRE3nfk1gXn8qNdZvjbrVJchizO/61bZVCAW7tD5TMH5LE4CT+KedxULQnURsv+dhB
        jSr8Bd50MAc59T8RllGf/I1nRcm0eDrHIeC7wdULVNZmLe1vCoT1vUtYnXIfdm6AHoPOK09alcNQP
        IKKHnh2nw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guU3f-0003sC-Bw; Fri, 15 Feb 2019 03:20:59 +0000
Subject: Re: mmotm 2019-02-14-15-22 uploaded (drivers/misc/fastrpc.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20190214232307.rIB08%akpm@linux-foundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <44c1e917-bd56-cc51-8b65-0bcedfcd5f4a@infradead.org>
Date:   Thu, 14 Feb 2019 19:20:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190214232307.rIB08%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 3:23 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-02-14-15-22 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series

on x86_64:

when CONFIG_DMA_SHARED_BUFFER is not set:

ld: drivers/misc/fastrpc.o: in function `fastrpc_free_map':
fastrpc.c:(.text+0xbe): undefined reference to `dma_buf_unmap_attachment'
ld: fastrpc.c:(.text+0xcb): undefined reference to `dma_buf_detach'
ld: fastrpc.c:(.text+0xd4): undefined reference to `dma_buf_put'
ld: drivers/misc/fastrpc.o: in function `fastrpc_map_create':
fastrpc.c:(.text+0xb2b): undefined reference to `dma_buf_get'
ld: fastrpc.c:(.text+0xb47): undefined reference to `dma_buf_attach'
ld: fastrpc.c:(.text+0xb61): undefined reference to `dma_buf_map_attachment'
ld: fastrpc.c:(.text+0xc36): undefined reference to `dma_buf_put'
ld: fastrpc.c:(.text+0xc48): undefined reference to `dma_buf_detach'
ld: drivers/misc/fastrpc.o: in function `fastrpc_device_ioctl':
fastrpc.c:(.text+0x1756): undefined reference to `dma_buf_get'
ld: fastrpc.c:(.text+0x1776): undefined reference to `dma_buf_put'
ld: fastrpc.c:(.text+0x1780): undefined reference to `dma_buf_put'
ld: fastrpc.c:(.text+0x1abf): undefined reference to `dma_buf_export'
ld: fastrpc.c:(.text+0x1ae7): undefined reference to `dma_buf_fd'
ld: fastrpc.c:(.text+0x1cb5): undefined reference to `dma_buf_put'
ld: fastrpc.c:(.text+0x1cca): undefined reference to `dma_buf_put'



-- 
~Randy
