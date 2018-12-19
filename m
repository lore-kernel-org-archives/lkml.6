Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE19C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A6C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeLSW0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:26:30 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.190]:17603 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728247AbeLSW03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:26:29 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7D6F91F999
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:26:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZkIOgs8A1iQerZkIOgxauz; Wed, 19 Dec 2018 16:26:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=47192 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZkIN-000D2a-Uh; Wed, 19 Dec 2018 16:26:28 -0600
Subject: Re: [PATCH 17/41] scsi: isci: phy: Mark expected switch fall-through
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <c07224fd421852f2cb717e6a3e6180eacb5ba372.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <cf2645c4-c192-a7b1-cf6e-9276f6b3b6c9@embeddedor.com>
Date:   Wed, 19 Dec 2018 16:26:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c07224fd421852f2cb717e6a3e6180eacb5ba372.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZkIN-000D2a-Uh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:47192
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping:

Who can ack or review this patch, please?

Thanks
-- 
Gustavo

On 11/27/18 10:29 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 703127 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/scsi/isci/phy.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
> index 1deca8c5a94f..7f9b3f20e5e4 100644
> --- a/drivers/scsi/isci/phy.c
> +++ b/drivers/scsi/isci/phy.c
> @@ -778,6 +778,7 @@ enum sci_status sci_phy_event_handler(struct isci_phy *iphy, u32 event_code)
>   			break;
>   		case SCU_EVENT_LINK_FAILURE:
>   			scu_link_layer_set_txcomsas_timeout(iphy, SCU_SAS_LINK_LAYER_TXCOMSAS_NEGTIME_DEFAULT);
> +			/* fall through */
>   		case SCU_EVENT_HARD_RESET_RECEIVED:
>   			/* Start the oob/sn state machine over again */
>   			sci_change_state(&iphy->sm, SCI_PHY_STARTING);
> 
