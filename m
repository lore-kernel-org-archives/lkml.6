Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C64ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF05A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF05A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKBBGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:06:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728561AbeKBBGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:06:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1Fx3bZ045390
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 12:03:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng3pjjy07-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:03:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 1 Nov 2018 16:03:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 16:03:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1G35mU6095356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 16:03:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5DBD4C046;
        Thu,  1 Nov 2018 16:03:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05AE34C044;
        Thu,  1 Nov 2018 16:03:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.26])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:03:03 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms
 with PCR read
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 01 Nov 2018 12:02:53 -0400
In-Reply-To: <20181030154711.2782-5-roberto.sassu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
         <20181030154711.2782-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110116-0008-0000-0000-00000289B359
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110116-0009-0000-0000-000021F3DAD8
Message-Id: <1541088173.4035.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:
> Currently, the TPM driver retrieves the digest size from a table mapping
> TPM algorithms identifiers to identifiers defined by the crypto subsystem.
> If the algorithm is not defined by the latter, the digest size can be
> retrieved from the output of the PCR read command.
> 
> The patch retrieves at TPM startup the digest sizes for each PCR bank and
> stores them in the new structure tpm_bank_info, member of tpm_chip, so that
> the information can be passed to other kernel subsystems.
> 
> tpm_bank_info contains: the TPM algorithm identifier, necessary to generate
> the event log as defined by Trusted Computing Group (TCG); the digest size,
> to pad/truncate a digest calculated with a different algorithm; the crypto
> subsystem identifier, to calculate the digest of event data.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 10 ++++---
>  drivers/char/tpm/tpm.h           |  4 +--
>  drivers/char/tpm/tpm2-cmd.c      | 45 ++++++++++++++++++++++++--------
>  include/linux/tpm.h              |  6 +++++
>  4 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 4d0f5da5bf98..49761c88c21e 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -989,7 +989,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  	if (!chip)
>  		return -ENODEV;
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct);
> +		rc = tpm2_pcr_read(chip, pcr_idx, digest_struct, NULL);
>  	else
>  		rc = tpm_pcr_read_dev(chip, pcr_idx, digest_struct->digest);
>  	tpm_put_ops(chip);
> @@ -1052,8 +1052,8 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>  		memset(digest_list, 0, sizeof(digest_list));
>  
>  		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -			    chip->active_banks[i]; i++) {
> -			digest_list[i].alg_id = chip->active_banks[i];
> +			    chip->active_banks[i].alg_id; i++) {
> +			digest_list[i].alg_id = chip->active_banks[i].alg_id;
>  			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
>  			count++;
>  		}
> @@ -1154,6 +1154,10 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  		goto out;
>  	}
>  
> +	chip->active_banks[0].alg_id = TPM_ALG_SHA1;
> +	chip->active_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> +	chip->active_banks[0].crypto_id = HASH_ALGO_SHA1;
> +
>  	return rc;
>  out:
>  	if (rc > 0)
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 633e16f42107..8662e8587dce 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -237,7 +237,7 @@ struct tpm_chip {
>  	const struct attribute_group *groups[3];
>  	unsigned int groups_cnt;
>  
> -	u16 active_banks[7];
> +	struct tpm_bank_info active_banks[7];

Commit 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
PCR banks") defined active_banks[7].  Subsequently, commit
4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event
log") defined TPM2_PCR_ACTIVE_BANKS as 3.  I'm not sure which is the
correct value, but the number of active_banks should not be hard coded
here.


>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> @@ -565,7 +565,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>  }
>  
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
> -		  struct tpm_digest *digest_struct);
> +		  struct tpm_digest *digest_struct, u16 *digest_size_ptr);
>  int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>  		    struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 8babd826ad27..8e821e7b4674 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -180,11 +180,12 @@ struct tpm2_pcr_read_out {
>   * @chip:	TPM chip to use.
>   * @pcr_idx:	index of the PCR to read.
>   * @digest_struct:	pcr bank and buffer current PCR value is written to.
> + * @digest_size_ptr:	pointer to variable that stores the digest size.
>   *
>   * Return: Same as with tpm_transmit_cmd.
>   */
>  int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
> -		  struct tpm_digest *digest_struct)
> +		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
>  {
>  	int rc;
>  	struct tpm_buf buf;
> @@ -219,6 +220,9 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  		goto out;
>  	}
>  
> +	if (digest_size_ptr)
> +		*digest_size_ptr = digest_size;
> +
>  	memcpy(digest_struct->digest, out->digest, digest_size);
>  out:
>  	tpm_buf_destroy(&buf);
> @@ -249,7 +253,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>  	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
> -	int j;
>  
>  	if (count > ARRAY_SIZE(chip->active_banks))
>  		return -EINVAL;
> @@ -271,14 +274,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>  	tpm_buf_append_u32(&buf, count);
>  
>  	for (i = 0; i < count; i++) {
> -		for (j = 0; j < ARRAY_SIZE(tpm2_hash_map); j++) {
> -			if (digests[i].alg_id != tpm2_hash_map[j].tpm_id)
> -				continue;
> -			tpm_buf_append_u16(&buf, digests[i].alg_id);
> -			tpm_buf_append(&buf, (const unsigned char
> -					      *)&digests[i].digest,
> -			       hash_digest_size[tpm2_hash_map[j].crypto_id]);
> -		}
> +		tpm_buf_append_u16(&buf, digests[i].alg_id);
> +		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
> +			       chip->active_banks[i].digest_size);
>  	}
>  

These tpm2_pcr_extend changes don't belong here in this patch.  Please
move them to 1/5.

>  	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> @@ -855,6 +853,26 @@ int tpm2_probe(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
>  
> +static int tpm2_init_bank_info(struct tpm_chip *chip,
> +			       struct tpm_bank_info *bank)
> +{
> +	struct tpm_digest digest = {.alg_id = bank->alg_id};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> +
> +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
> +			continue;
> +
> +		bank->digest_size = hash_digest_size[crypto_algo];
> +		bank->crypto_id = crypto_algo;
> +		return 0;
> +	}
> +
> +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
> +}
> +
>  struct tpm2_pcr_selection {
>  	__be16  hash_alg;
>  	u8  size_of_select;
> @@ -909,7 +927,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  		}
>  
>  		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
> -		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
> +		chip->active_banks[i].alg_id =
> +			be16_to_cpu(pcr_selection.hash_alg);
> +		rc =  tpm2_init_bank_info(chip, &chip->active_banks[i]);

Please fix the formatting in the above 2 lines.

There's been discussion in the past on removing scripts/Lindent from
the coding-style documentation, but that hasn't happened quite yet. I
do think section 3 "New drivers" in Documentation/hwmon/submitting-
patches has a good balance.

* Running your patch or driver file(s) through checkpatch does not mean its
  formatting is clean. If unsure about formatting in your new driver, run it
  through Lindent. Lindent is not perfect, and you may have to do some minor
  cleanup, but it is a good start.

thanks!

Mimi  

> +		if (rc)
> +			break;
> +
>  		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
>  			sizeof(pcr_selection.size_of_select) +
>  			pcr_selection.size_of_select;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4f00daf44dd2..3f91124837cf 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -46,6 +46,12 @@ struct tpm_digest {
>  	u8 digest[SHA512_DIGEST_SIZE];
>  } __packed;
>  
> +struct tpm_bank_info {
> +	u16 alg_id;
> +	u16 digest_size;
> +	u16 crypto_id;
> +};
> +
>  enum TPM_OPS_FLAGS {
>  	TPM_OPS_AUTO_STARTUP = BIT(0),
>  };

