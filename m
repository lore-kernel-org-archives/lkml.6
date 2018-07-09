Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18635208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18635208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeGIR1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:27:44 -0400
Received: from [92.117.122.195] ([92.117.122.195]:53700 "EHLO mail.eperm.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S933819AbeGIR1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:27:42 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 13:27:41 EDT
Received: from positron.chronox.de (tmo-101-88.customers.d1-online.com [80.187.101.88])
        by mail.eperm.de (Postfix) with ESMTPA id DEB6A2A0037;
        Mon,  9 Jul 2018 19:20:04 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Adrian Reber <adrian@lisas.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Date:   Mon, 09 Jul 2018 19:20:03 +0200
Message-ID: <4315456.xLu0sxa9ll@positron.chronox.de>
In-Reply-To: <20180708204359.GA19198@lst.de>
References: <20180502211448.18276-1-hch@lst.de> <20180704142116.GM17048@lisas.de> <20180708204359.GA19198@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Juli 2018, 22:44:00 CEST schrieb Christoph Hellwig:

Hi Christoph,
> 
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index 75846164290e..b7705ad66d78 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -29,7 +29,11 @@
> 
>  #include <linux/types.h>
>  #include <linux/fs.h>
> +#ifdef __KERNEL__
>  #include <linux/signal.h>
> +#else
> +#include <signal.h>
> +#endif
>  #include <asm/byteorder.h>

Without such a patch, libkcapi fails to compile as well. See [1].

Apart from your suggested patch above, do you have another suggestion how make 
the user space code compile?

[1] https://github.com/smuellerDD/libkcapi/issues/59


Thanks
Stephan


