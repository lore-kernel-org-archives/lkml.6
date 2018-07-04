Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C77C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713AD246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713AD246DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGDBLO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:11:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:35547 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeGDBLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:11:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w641B0iZ012630;
        Tue, 3 Jul 2018 20:11:02 -0500
Message-ID: <cdaa71efbb25d96c1d5e0018880bf3554ce243c1.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi: sbefifo: Add missing mutex_unlock
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, joel@jms.id.au
Date:   Wed, 04 Jul 2018 11:11:00 +1000
In-Reply-To: <1530652889-26497-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1530652889-26497-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 16:21 -0500, Eddie James wrote:
> There was no unlock of the FFDC mutex.
> 
> Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Thanks. 

Cheers,
Ben.

> ---
>  drivers/fsi/fsi-sbefifo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 4f076fd..a34ff99 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -194,6 +194,7 @@ static void sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
>  		}
>  		dev_warn(dev, "+-------------------------------------------+\n");
>  	}
> +	mutex_unlock(&sbefifo_ffdc_mutex);
>  }
>  
>  int sbefifo_parse_status(struct device *dev, u16 cmd, __be32 *response,
