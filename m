Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC300C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309E5208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E5208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeGITWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:22:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:33680 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeGITWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:22:13 -0400
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZWPiCo8pBBUrGD6hVxbvqydRGWvSUGBkHi/ixykK"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u69JLsb3T
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 9 Jul 2018 21:21:54 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Adrian Reber <adrian@lisas.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Date:   Mon, 09 Jul 2018 21:21:53 +0200
Message-ID: <1632268.WSg4zQ7CbY@positron.chronox.de>
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


