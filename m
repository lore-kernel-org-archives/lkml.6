Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA9AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfBAP4X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:56:23 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17867 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfBAP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:56:22 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11FpGw9003434;
        Fri, 1 Feb 2019 16:56:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qcnvqh1qq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 01 Feb 2019 16:56:15 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7816738;
        Fri,  1 Feb 2019 15:56:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 577565126;
        Fri,  1 Feb 2019 15:56:14 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 1 Feb
 2019 16:56:13 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 1 Feb 2019 16:56:13 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
Subject: RE: [PATCH -next] remoteproc: make rproc_check_carveout_da static
Thread-Topic: [PATCH -next] remoteproc: make rproc_check_carveout_da static
Thread-Index: AQHUudxGKL1acz/0tEqjRTyTD6T3sKXLGQjw
Date:   Fri, 1 Feb 2019 15:56:13 +0000
Message-ID: <519ceef457d744e98659a2c7aa6fdd4d@SFHDAG7NODE2.st.com>
References: <20190201031317.18820-1-yuehaibing@huawei.com>
In-Reply-To: <20190201031317.18820-1-yuehaibing@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of YueHaibing
> Sent: vendredi 1 février 2019 04:13
> To: ohad@wizery.com; bjorn.andersson@linaro.org
> Cc: linux-kernel@vger.kernel.org; linux-remoteproc@vger.kernel.org;
> YueHaibing <yuehaibing@huawei.com>
> Subject: [PATCH -next] remoteproc: make rproc_check_carveout_da static
> 
> Fixes the following sparse warnings:
> 
> drivers/remoteproc/remoteproc_core.c:279:5: warning:
>  symbol 'rproc_check_carveout_da' was not declared. Should it be static?
Correction already sent on ML few weeks ago. See [1]

Regards,
Loic

[1] https://patchwork.kernel.org/patch/10755763/

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index 54ec38f..5d4954d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -276,8 +276,9 @@ rproc_find_carveout_by_name(struct rproc *rproc,
> const char *name, ...)
>   *
>   * Return: 0 if carveout match request else -ENOMEM
>   */
> -int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry
> *mem,
> -			    u32 da, u32 len)
> +static int rproc_check_carveout_da(struct rproc *rproc,
> +				   struct rproc_mem_entry *mem,
> +				   u32 da, u32 len)
>  {
>  	struct device *dev = &rproc->dev;
>  	int delta = 0;
> --
> 2.7.0
> 

