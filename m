Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F06ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKIBT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:19:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbeKIBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:19:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8Fd9tj010111
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 10:43:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nmqanadc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:43:51 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 8 Nov 2018 15:43:50 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 15:43:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8FhkfD27263088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:43:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBFBCB2066;
        Thu,  8 Nov 2018 15:43:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE3D3B2064;
        Thu,  8 Nov 2018 15:43:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 15:43:46 +0000 (GMT)
Subject: Re: [PATCH v5 14/17] tpm: remove TPM_TRANSMIT_UNLOCKED flag
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181108141541.12832-1-jarkko.sakkinen@linux.intel.com>
 <20181108141541.12832-15-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 8 Nov 2018 10:43:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181108141541.12832-15-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110815-0052-0000-0000-00000352B1CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114503; UDB=6.00577823; IPR=6.00894601;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 15:43:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110815-0053-0000-0000-00005EB2D26F
Message-Id: <5a0628cb-84e2-6fab-8fce-a77dc7adceb2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 9:15 AM, Jarkko Sakkinen wrote:
> Added locking as part of tpm_try_get_ops() and tpm_put_ops() as they are
> anyway used in most of the call sites except in tpmrm_release() where we
> take the locks manually.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-chip.c       |  2 ++
>   drivers/char/tpm/tpm-dev-common.c |  4 +---
>   drivers/char/tpm/tpm-interface.c  |  8 --------
>   drivers/char/tpm/tpm.h            |  8 ++------
>   drivers/char/tpm/tpm2-cmd.c       | 13 ++++---------
>   drivers/char/tpm/tpm2-space.c     | 15 ++++++---------
>   6 files changed, 15 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 32db84683c40..157505b0f755 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -58,6 +58,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>   	if (!chip->ops)
>   		goto out_lock;
>
> +	mutex_lock(&chip->tpm_mutex);
>   	return 0;
>   out_lock:
>   	up_read(&chip->ops_sem);
> @@ -75,6 +76,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>    */
>   void tpm_put_ops(struct tpm_chip *chip)
>   {
> +	mutex_unlock(&chip->tpm_mutex);
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
>   }
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index c7dc54930576..582caefcf19b 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -33,7 +33,6 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	struct tpm_header *header = (void *)buf;
>   	ssize_t ret, len;
>
> -	mutex_lock(&chip->tpm_mutex);
>   	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
>   	/* If the command is not implemented by the TPM, synthesize a
>   	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> @@ -48,7 +47,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	if (ret)
>   		goto out_lock;
>
> -	len = tpm_transmit(chip, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
> +	len = tpm_transmit(chip, buf, bufsiz, 0);
>   	if (len < 0)
>   		ret = len;
>
> @@ -57,7 +56,6 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	else
>   		ret = tpm2_commit_space(chip, space, buf, &len);
>   out_lock:
> -	mutex_unlock(&chip->tpm_mutex);
>   	return ret ? ret : len;
>   }
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8d75c103f280..5865b9671d20 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -227,10 +227,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   	memcpy(save, buf, save_size);
>
>   	for (;;) {
> -		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
> -		    !(flags & TPM_TRANSMIT_NESTED))
> -			mutex_lock(&chip->tpm_mutex);
> -
>   		if (chip->ops->clk_enable != NULL)
>   			chip->ops->clk_enable(chip, true);
>
> @@ -257,10 +253,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   		if (chip->ops->clk_enable != NULL)
>   			chip->ops->clk_enable(chip, false);
>
> -		if (!(flags & TPM_TRANSMIT_UNLOCKED) &&
> -		    !(flags & TPM_TRANSMIT_NESTED))
> -			mutex_unlock(&chip->tpm_mutex);
> -
>   		if (ret < 0)
>   			break;
>   		rc = be32_to_cpu(header->return_code);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 10a5bcf806aa..c7c06de651a0 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -488,14 +488,10 @@ extern struct idr dev_nums_idr;
>   /**
>    * enum tpm_transmit_flags - flags for tpm_transmit()
>    *
> - * @TPM_TRANSMIT_UNLOCKED:	do not lock the chip
> - * @TPM_TRANSMIT_NESTED:	discard setup steps (power management,
> - *				locality) including locking (i.e. implicit
> - *				UNLOCKED)
> + * %TPM_TRANSMIT_NESTED:	discard setup steps (power management, locality)
>    */
>   enum tpm_transmit_flags {
> -	TPM_TRANSMIT_UNLOCKED	= BIT(0),
> -	TPM_TRANSMIT_NESTED      = BIT(1),
> +	TPM_TRANSMIT_NESTED      = BIT(0),
>   };
>
>   ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index f2b0e5c52a57..d6abc964ef66 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -652,17 +652,12 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>   	u32 blob_handle;
>   	int rc;
>
> -	mutex_lock(&chip->tpm_mutex);
> -	rc = tpm2_load_cmd(chip, payload, options, &blob_handle,
> -			   TPM_TRANSMIT_UNLOCKED);
> +	rc = tpm2_load_cmd(chip, payload, options, &blob_handle, 0);
>   	if (rc)
> -		goto out;
> +		return rc;
>
> -	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle,
> -			     TPM_TRANSMIT_UNLOCKED);
> -	tpm2_flush_context_cmd(chip, blob_handle, TPM_TRANSMIT_UNLOCKED);
> -out:
> -	mutex_unlock(&chip->tpm_mutex);
> +	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle, 0);
> +	tpm2_flush_context_cmd(chip, blob_handle, 0);


This lock was covering quite a few commands from being interfered by 
others. Is this still guaranteed to work after or can different 
subsystems like trusted keys and IMA and /dev/tpm0 users interfere with 
this previous atomic sequence ?


>   	return rc;
>   }
>
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index d1c371db1ab7..341d4b90ba2f 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -38,8 +38,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
>
>   	for (i = 0; i < ARRAY_SIZE(space->session_tbl); i++) {
>   		if (space->session_tbl[i])
> -			tpm2_flush_context_cmd(chip, space->session_tbl[i],
> -					       TPM_TRANSMIT_UNLOCKED);
> +			tpm2_flush_context_cmd(chip, space->session_tbl[i], 0);
>   	}
>   }
>
> @@ -83,7 +82,7 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>   	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
>   	tpm_buf_append(&tbuf, &buf[*offset], body_size);
>
> -	rc = tpm_transmit_cmd(chip, &tbuf, 4, TPM_TRANSMIT_UNLOCKED, NULL);
> +	rc = tpm_transmit_cmd(chip, &tbuf, 4, 0, NULL);
>   	if (rc < 0) {
>   		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
>   			 __func__, rc);
> @@ -131,7 +130,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>
>   	tpm_buf_append_u32(&tbuf, handle);
>
> -	rc = tpm_transmit_cmd(chip, &tbuf, 0, TPM_TRANSMIT_UNLOCKED, NULL);
> +	rc = tpm_transmit_cmd(chip, &tbuf, 0, 0, NULL);
>   	if (rc < 0) {
>   		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
>   			 __func__, rc);
> @@ -167,8 +166,7 @@ void tpm2_flush_space(struct tpm_chip *chip)
>
>   	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
>   		if (space->context_tbl[i] && ~space->context_tbl[i])
> -			tpm2_flush_context_cmd(chip, space->context_tbl[i],
> -					       TPM_TRANSMIT_UNLOCKED);
> +			tpm2_flush_context_cmd(chip, space->context_tbl[i], 0);
>
>   	tpm2_flush_sessions(chip, space);
>   }
> @@ -417,7 +415,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
>
>   	return 0;
>   out_no_slots:
> -	tpm2_flush_context_cmd(chip, phandle, TPM_TRANSMIT_UNLOCKED);
> +	tpm2_flush_context_cmd(chip, phandle, 0);
>   	dev_warn(&chip->dev, "%s: out of slots for 0x%08X\n", __func__,
>   		 phandle);
>   	return -ENOMEM;
> @@ -504,8 +502,7 @@ static int tpm2_save_space(struct tpm_chip *chip)
>   		} else if (rc)
>   			return rc;
>
> -		tpm2_flush_context_cmd(chip, space->context_tbl[i],
> -				       TPM_TRANSMIT_UNLOCKED);
> +		tpm2_flush_context_cmd(chip, space->context_tbl[i], 0);
>   		space->context_tbl[i] = ~0;
>   	}
>

