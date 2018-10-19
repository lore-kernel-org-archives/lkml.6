Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877AB2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877AB2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJSMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:52:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbeJSMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:52:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9J4d6Zf157040
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 00:47:53 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n76sm3tcq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 00:47:53 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 18 Oct 2018 22:47:52 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Oct 2018 22:47:48 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9J4llUI22085794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Oct 2018 21:47:48 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC1C7C6055;
        Fri, 19 Oct 2018 04:47:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06F7C6057;
        Fri, 19 Oct 2018 04:47:43 +0000 (GMT)
Received: from [9.77.200.130] (unknown [9.77.200.130])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 04:47:43 +0000 (GMT)
Subject: Re: [PATCH] tpm: tpm_i2c_nuvoton: use correct command duration for
 TPM 2.x
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181017163223.25141-1-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Fri, 19 Oct 2018 10:14:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181017163223.25141-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101904-0012-0000-0000-000016CB2640
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009898; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104769; UDB=6.00571953; IPR=6.00884819;
 MB=3.00023817; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 04:47:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101904-0013-0000-0000-000054CF0E03
Message-Id: <6e12d4b6-cb84-3be5-8a62-6868be43d43d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 10:02 PM, Tomas Winkler wrote:
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index caa86b19c76d..f74f451baf6a 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -369,6 +369,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	struct device *dev = chip->dev.parent;
>   	struct i2c_client *client = to_i2c_client(dev);
>   	u32 ordinal;
> +	unsigned long duration;
>   	size_t count = 0;
>   	int burst_count, bytes2write, retries, rc = -EIO;
>
> @@ -455,10 +456,12 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   		return rc;
>   	}
>   	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> -					     tpm_calc_ordinal_duration(chip,
> -								       ordinal),
> -					     &priv->read_queue);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		duration = tpm2_calc_ordinal_duration(chip, ordinal);
> +	else
> +		duration = tpm_calc_ordinal_duration(chip, ordinal);
> +
> +	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
>   	if (rc) {
>   		dev_err(dev, "%s() timeout command duration\n", __func__);
>   		i2c_nuvoton_ready(chip);

I only have Nuvoton TPM 2.0, tested for that.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com> (For TPM 2.0)


Thanks & Regards,
     - Nayna


