Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74917217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfAWIzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:55:42 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.104]:42238 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfAWIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:55:42 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C6DFD8DF4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:55:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mEJxgyCN8YTGMmEJxgglQ6; Wed, 23 Jan 2019 02:55:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42602 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmEJw-0049UL-QR; Wed, 23 Jan 2019 02:55:40 -0600
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190123003741.GA12068@embeddedor> <20190123082849.GA1129@kunai>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Subject: Re: [PATCH] i2c: imx: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <5a0aaed8-adf6-b730-990a-5092538cfe68@embeddedor.com>
Date:   Wed, 23 Jan 2019 02:55:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123082849.GA1129@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmEJw-0049UL-QR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:42602
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 2:28 AM, Wolfram Sang wrote:
> On Tue, Jan 22, 2019 at 06:37:41PM -0600, Gustavo A. R. Silva wrote:
>> Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request.
>>
>> The proper pointer to be passed as argument is dma->chan_tx.
>>
>> This bug was detected with the help of Coccinelle.
>>
>> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I pushed a similar fix to linux-next yesterday.
> 

Great. Good to know it is fixed now. :)

Thanks
--
Gustavo
