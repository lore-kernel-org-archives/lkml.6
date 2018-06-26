Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64555C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650126EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2650126EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeFZSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:36:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754900AbeFZSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:36:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QIY9rF103263
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:36:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2juts1ga2c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:36:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 14:36:17 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 14:36:14 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QIaDW918088270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 18:36:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9302805A;
        Tue, 26 Jun 2018 14:35:55 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BBE628058;
        Tue, 26 Jun 2018 14:35:55 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 14:35:55 -0400 (EDT)
Subject: Re: [PATCH v6 3/5] tpm: Convert tpm_find_get_ops() to use
 tpm_default_chip()
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
 <20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Tue, 26 Jun 2018 14:36:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18062618-0040-0000-0000-0000044580FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052698; UDB=6.00539686; IPR=6.00830622;
 MB=3.00021866; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 18:36:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062618-0041-0000-0000-0000084B9760
Message-Id: <17ca4660-150b-b536-bbda-01629aac11f6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 01:23 PM, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index f551061262c9..b01d34983766 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
>    */
>   struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
>   {
> -	struct tpm_chip *res = NULL;
> -	int chip_num = 0;
> -	int chip_prev;
> -
> -	mutex_lock(&idr_lock);
> +	int rc;
>
> -	if (!chip) {
> -		do {
> -			chip_prev = chip_num;
> -			chip = idr_get_next(&dev_nums_idr, &chip_num);
> -			if (chip && !tpm_try_get_ops(chip)) {
> -				res = chip;
> -				break;
> -			}
> -		} while (chip_prev != chip_num);
> -	} else {
> +	if (chip) {
>   		if (!tpm_try_get_ops(chip))
> -			res = chip;
> +			return chip;
> +		return NULL;
>   	}
>
> -	mutex_unlock(&idr_lock);
> -
> -	return res;
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return NULL;
> +	rc = tpm_try_get_ops(chip);
> +	/* release additional reference we got from tpm_default_chip() */
> +	put_device(&chip->dev);
> +	if (!rc)
This should say 'if (rc)'.
> +		return NULL;
> +	return chip;
>   }
>
>   /**


