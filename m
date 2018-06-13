Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADF67C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D25A208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D25A208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935924AbeFMO5v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:57:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935659AbeFMO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:57:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DEsLYo051244
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:57:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jk4gskd1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:57:48 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 08:57:47 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 08:57:44 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DEvhOE3932562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 07:57:43 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C9786E050;
        Wed, 13 Jun 2018 08:57:43 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268556E04E;
        Wed, 13 Jun 2018 08:57:43 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 08:57:43 -0600 (MDT)
Subject: Re: [RFC PATCH 4/5] fsi/scom: Add register definitions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        openbmc@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180612051911.20690-1-benh@kernel.crashing.org>
 <20180612051911.20690-5-benh@kernel.crashing.org>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 13 Jun 2018 09:57:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612051911.20690-5-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061314-0004-0000-0000-000014528995
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009183; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046401; UDB=6.00535906; IPR=6.00825376;
 MB=3.00021625; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 14:57:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061314-0005-0000-0000-000087BA0198
Message-Id: <4bbb38ae-2d34-b63f-ed67-d55d31673af3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 12:19 AM, Benjamin Herrenschmidt wrote:
> Add a few more register and bit definitions, also define and use
> SCOM_READ_CMD (which is 0 but it makes the code clearer)
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Eddie James <eajames@linux.vnet.ibm.com>

> ---
>   drivers/fsi/fsi-scom.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index 6ddfb6021420..e98573ecdae1 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -30,8 +30,25 @@
>   #define SCOM_DATA0_REG		0x00
>   #define SCOM_DATA1_REG		0x04
>   #define SCOM_CMD_REG		0x08
> +#define SCOM_FSI2PIB_RESET_REG	0x18
> +#define SCOM_STATUS_REG		0x1C /* Read */
> +#define SCOM_PIB_RESET_REG	0x1C /* Write */
>
> +/* Command register */
>   #define SCOM_WRITE_CMD		0x80000000
> +#define SCOM_READ_CMD		0x00000000
> +
> +/* Status register bits */
> +#define SCOM_STATUS_ERR_SUMMARY		0x80000000
> +#define SCOM_STATUS_PROTECTION		0x01000000
> +#define SCOM_STATUS_PIB_ABORT		0x00100000
> +#define SCOM_STATUS_PIB_RESP_MASK	0x00007000
> +#define SCOM_STATUS_PIB_RESP_SHIFT	12
> +
> +#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_ERR_SUMMARY | \
> +					 SCOM_STATUS_PROTECTION | \
> +					 SCOM_STATUS_PIB_ABORT | \
> +					 SCOM_STATUS_PIB_RESP_MASK)
>
>   struct scom_device {
>   	struct list_head link;
> @@ -85,7 +102,7 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
>
>   	mutex_lock(&scom_dev->lock);
>   	*value = 0ULL;
> -	data = cpu_to_be32(addr);
> +	data = cpu_to_be32(SCOM_READ_CMD | addr);
>   	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
>   				sizeof(uint32_t));
>   	if (rc)

