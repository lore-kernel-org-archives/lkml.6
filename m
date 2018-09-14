Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F042CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB6B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeINR5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:57:54 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:26222 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeINR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:57:54 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id CC93DE8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 12:43:35 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 125EE65;
        Fri, 14 Sep 2018 12:43:34 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 9649F36;
        Fri, 14 Sep 2018 12:43:34 +0000 (UTC)
Date:   Fri, 14 Sep 2018 07:43:34 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dimitri Sivanich <sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix fall-through annotations
Message-ID: <20180914124334.GA2205@hpe.com>
References: <20180913185317.GA1178@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913185317.GA1178@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Thu, Sep 13, 2018 at 01:53:18PM -0500, Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/misc/sgi-gru/grukservices.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
> index 0307690..4b23d58 100644
> --- a/drivers/misc/sgi-gru/grukservices.c
> +++ b/drivers/misc/sgi-gru/grukservices.c
> @@ -634,7 +634,7 @@ static int send_noop_message(void *cb, struct gru_message_queue_desc *mqd,
>  			break;
>  		case CBSS_PAGE_OVERFLOW:
>  			STAT(mesq_noop_page_overflow);
> -			/* fallthru */
> +			/* fall through */
>  		default:
>  			BUG();
>  		}
> @@ -792,7 +792,7 @@ static int send_message_failure(void *cb, struct gru_message_queue_desc *mqd,
>  		break;
>  	case CBSS_PAGE_OVERFLOW:
>  		STAT(mesq_page_overflow);
> -		/* fallthru */
> +		/* fall through */
>  	default:
>  		BUG();
>  	}
> -- 
> 2.7.4
> 
