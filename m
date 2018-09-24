Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65412ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A07021480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A07021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeIXWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:41:29 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:35158 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729080AbeIXWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:41:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C438C180A812B;
        Mon, 24 Sep 2018 16:38:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: point07_fa5932dffc1f
X-Filterd-Recvd-Size: 2242
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Sep 2018 16:38:27 +0000 (UTC)
Message-ID: <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date:   Mon, 24 Sep 2018 09:38:26 -0700
In-Reply-To: <20180924113123.002918395@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
         <20180924113123.002918395@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 13:34 +0200, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.

Why should this sort of change be applied to a stable release?

> ------------------
> 
> From: Bart Van Assche <bart.vanassche@wdc.com>
> 
> [ Upstream commit 4c5743bc4fe3233cecc1c184a773c79c8ee45bbe ]
> 
> Avoid that the following compiler warning is reported when building with
> W=1:
> 
> drivers/infiniband/hw/nes/nes_hw.c:646:51: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/nes/nes.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> It'
> --- a/drivers/infiniband/hw/nes/nes.h
> +++ b/drivers/infiniband/hw/nes/nes.h
> @@ -156,7 +156,7 @@ do { \
>  
>  #define NES_EVENT_TIMEOUT   1200000
>  #else
> -#define nes_debug(level, fmt, args...)
> +#define nes_debug(level, fmt, args...) do {} while (0)
>  #define assert(expr)          do {} while (0)
>  
>  #define NES_EVENT_TIMEOUT   100000
> 
> 
