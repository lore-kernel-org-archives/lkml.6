Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173F42075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfBHOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:42:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbfBHOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:42:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18EaHIh111074
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 09:42:22 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhbay1b1h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:42:22 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 14:42:21 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 14:42:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18EgGLI22610090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 14:42:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6125B2065;
        Fri,  8 Feb 2019 14:42:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C17BEB205F;
        Fri,  8 Feb 2019 14:42:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 14:42:16 +0000 (GMT)
Subject: Re: [PATCH 1/2] tpm: Unify the send callback behaviour
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
References: <20190208140600.24996-1-jarkko.sakkinen@linux.intel.com>
 <20190208140600.24996-2-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 09:42:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208140600.24996-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020814-0060-0000-0000-0000030804F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158112; UDB=6.00604251; IPR=6.00938644;
 MB=3.00025494; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 14:42:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020814-0061-0000-0000-0000483A6DFD
Message-Id: <b53745b6-ed49-9e97-6f56-1378561888eb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 9:05 AM, Jarkko Sakkinen wrote:
> The send() callback should never return length as it does not in every
> driver except tpm_crb in the success case. The reason is that the main
> transmit functionality only cares about whether the transmit was
> successful or not and ignores the count completely.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
>   drivers/char/tpm/tpm_atmel.c         | 2 +-
>   drivers/char/tpm/tpm_i2c_atmel.c     | 6 +++++-
>   drivers/char/tpm/tpm_i2c_infineon.c  | 2 +-
>   drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 +-
>   drivers/char/tpm/tpm_ibmvtpm.c       | 2 +-
>   drivers/char/tpm/tpm_vtpm_proxy.c    | 3 +--
>   drivers/char/tpm/xen-tpmfront.c      | 2 +-

At least tpm_nsc_send (tpm_nsc.c) and tpm_inf_send (tpm_infineon.c) are 
also returning the number of bytes sent. I would consider tpm_crb the 
outlier that returns 0 and should return the length even though we don't 
need it...


>   8 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index 64dc560859f2..13dc614b7ebc 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -436,7 +436,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
>   			goto out_err;
>   	}
>
> -	return len;
> +	return 0;
>   out_err:
>   	st33zp24_cancel(chip);
>   	release_locality(chip);
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index 66a14526aaf4..a290b30a0c35 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -105,7 +105,7 @@ static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		iowrite8(buf[i], priv->iobase);
>   	}
>
> -	return count;
> +	return 0;
>   }
>
>   static void tpm_atml_cancel(struct tpm_chip *chip)
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 4720b2442ffe..aa11c8a1df5e 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -65,7 +65,11 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	dev_dbg(&chip->dev,
>   		"%s(buf=%*ph len=%0zx) -> sts=%d\n", __func__,
>   		(int)min_t(size_t, 64, len), buf, len, status);
> -	return status;
> +
> +	if (status < 0)
> +		return status;
> +
> +	return 0;
>   }
>
>   static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 3b490d9d90e7..3b4e9672ff6c 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -588,7 +588,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	/* go and do it */
>   	iic_tpm_write(TPM_STS(tpm_dev.locality), &sts, 1);
>
> -	return len;
> +	return 0;
>   out_err:
>   	tpm_tis_i2c_ready(chip);
>   	/* The TPM needs some time to clean up here,
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index 5700cc2ddee1..315a3b4548f7 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -465,7 +465,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	}
>
>   	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
> -	return len;
> +	return 0;
>   }
>
>   static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 07b5a487d0c8..aeae3222723c 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -192,7 +192,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		rc = 0;
>   		ibmvtpm->tpm_processing_cmd = false;
>   	} else
> -		rc = count;
> +		rc = 0;
>
>   	spin_unlock(&ibmvtpm->rtce_lock);
>   	return rc;
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 26a2be555288..d74f3de74ae6 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -335,7 +335,6 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
>   static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   {
>   	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
> -	int rc = 0;
>
>   	if (count > sizeof(proxy_dev->buffer)) {
>   		dev_err(&chip->dev,
> @@ -366,7 +365,7 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>
>   	wake_up_interruptible(&proxy_dev->wq);
>
> -	return rc;
> +	return 0;
>   }
>
>   static void vtpm_proxy_tpm_op_cancel(struct tpm_chip *chip)
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 1259e935fd58..4e2d00cb0d81 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -173,7 +173,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		return -ETIME;
>   	}
>
> -	return count;
> +	return 0;
>   }
>
>   static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)


