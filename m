Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C344AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01A2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A01A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeIZM6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:58:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbeIZM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:58:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q6hpXY118618
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:47:17 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mr3u6b4ke-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:47:17 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 00:47:16 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 00:47:13 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q6lAcK49938632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 23:47:10 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA8D178060;
        Wed, 26 Sep 2018 00:47:10 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F3F7805C;
        Wed, 26 Sep 2018 00:47:08 -0600 (MDT)
Received: from [9.124.31.41] (unknown [9.124.31.41])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 00:47:07 -0600 (MDT)
Subject: Re: [PATCH v4 01/21] tpm2: add new tpm2 commands according to TCG
 1.36
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-2-tomas.winkler@intel.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Date:   Wed, 26 Sep 2018 12:14:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180921135820.20549-2-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092606-8235-0000-0000-00000E06E7B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009773; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093792; UDB=6.00565356; IPR=6.00873830;
 MB=3.00023509; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 06:47:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092606-8236-0000-0000-000042C67982
Message-Id: <a6bbd85b-9f24-1e04-fa00-660a8b96ae87@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> 1. TPM2_CC_LAST has moved from 182 to 193
> 2. Convert tpm2_ordinal_duration from an array into a switch statement,
>     as there are not so many commands that require special duration
>     relative to a number of commands, the switch statement function
>     is called tpm2_ordinal_duration_index().
> 3. Fix kdoc comments for tpm2_calc_ordinal_duration().
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2-V3: Rebase.
> V4: 1. Fix kdoc
>      2. Rename tpm2_ordinal_duration() to tpm2_ordinal_duration_index()
>      3. Move the two functions close to each other in the file.
>
>   drivers/char/tpm/tpm.h      |  41 +++++---
>   drivers/char/tpm/tpm2-cmd.c | 236 +++++++++++++++++---------------------------
>   2 files changed, 113 insertions(+), 164 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f20dc8ece348..0f08518b525d 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -134,22 +134,31 @@ enum tpm2_algorithms {
>   };
>
>   enum tpm2_command_codes {
> -	TPM2_CC_FIRST		= 0x011F,
> -	TPM2_CC_CREATE_PRIMARY  = 0x0131,
> -	TPM2_CC_SELF_TEST	= 0x0143,
> -	TPM2_CC_STARTUP		= 0x0144,
> -	TPM2_CC_SHUTDOWN	= 0x0145,
> -	TPM2_CC_CREATE		= 0x0153,
> -	TPM2_CC_LOAD		= 0x0157,
> -	TPM2_CC_UNSEAL		= 0x015E,
> -	TPM2_CC_CONTEXT_LOAD	= 0x0161,
> -	TPM2_CC_CONTEXT_SAVE	= 0x0162,
> -	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
> -	TPM2_CC_GET_CAPABILITY	= 0x017A,
> -	TPM2_CC_GET_RANDOM	= 0x017B,
> -	TPM2_CC_PCR_READ	= 0x017E,
> -	TPM2_CC_PCR_EXTEND	= 0x0182,
> -	TPM2_CC_LAST		= 0x018F,
> +	TPM2_CC_FIRST		        = 0x011F,
> +	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> +	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
> +	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> +	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
> +	TPM2_CC_SELF_TEST	        = 0x0143,
> +	TPM2_CC_STARTUP		        = 0x0144,
> +	TPM2_CC_SHUTDOWN	        = 0x0145,
> +	TPM2_CC_NV_READ                 = 0x014E,
> +	TPM2_CC_CREATE		        = 0x0153,
> +	TPM2_CC_LOAD		        = 0x0157,
> +	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
> +	TPM2_CC_UNSEAL		        = 0x015E,
> +	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
> +	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
> +	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> +	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
> +	TPM2_CC_GET_CAPABILITY	        = 0x017A,
> +	TPM2_CC_GET_RANDOM	        = 0x017B,
> +	TPM2_CC_PCR_READ	        = 0x017E,
> +	TPM2_CC_PCR_EXTEND	        = 0x0182,
> +	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
> +	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
> +	TPM2_CC_CREATE_LOADED           = 0x0191,
> +	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
>   };
>
>   enum tpm2_permanent_handles {
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3acf4fd4e5a5..be0a9ebcd7d7 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -40,129 +40,95 @@ static struct tpm2_hash tpm2_hash_map[] = {
>   	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
>   };
>
> -/*
> - * Array with one entry per ordinal defining the maximum amount
> - * of time the chip could take to return the result. The values
> - * of the SHORT, MEDIUM, and LONG durations are taken from the
> - * PC Client Profile (PTP) specification.
> - * LONG_LONG is for commands that generates keys which empirically
> - * takes longer time on some systems.
> +/**
> + * tpm2_ordinal_duration_index() - returns an index to the chip duration
> + * table (enum tpm_duration), that describes the maximum amount of
> + * time the chip could take to return the result for a  particular ordinal.
> + *
> + * The values of the MEDIUM, and LONG durations are taken
> + * from the PC Client Profile (PTP) specification (750, 2000 msec)
> + *
> + * LONG_LONG is for commands that generates keys which empirically takes
> + * a longer time on some systems.
> + *
> + * @ordinal: TPM command ordinal.
> + *
> + * Return: TPM_MEDIUM, TPM_LONG, TPM_LONG_LONG, and TPM_UNDEFINED.
>    */
> -static const u8 tpm2_ordinal_duration[TPM2_CC_LAST - TPM2_CC_FIRST + 1] = {
> -	TPM_UNDEFINED,		/* 11F */
> -	TPM_UNDEFINED,		/* 120 */
> -	TPM_LONG,		/* 121 */
> -	TPM_UNDEFINED,		/* 122 */
> -	TPM_UNDEFINED,		/* 123 */
> -	TPM_UNDEFINED,		/* 124 */
> -	TPM_UNDEFINED,		/* 125 */
> -	TPM_UNDEFINED,		/* 126 */
> -	TPM_UNDEFINED,		/* 127 */
> -	TPM_UNDEFINED,		/* 128 */
> -	TPM_LONG,		/* 129 */
> -	TPM_UNDEFINED,		/* 12a */
> -	TPM_UNDEFINED,		/* 12b */
> -	TPM_UNDEFINED,		/* 12c */
> -	TPM_UNDEFINED,		/* 12d */
> -	TPM_UNDEFINED,		/* 12e */
> -	TPM_UNDEFINED,		/* 12f */
> -	TPM_UNDEFINED,		/* 130 */
> -	TPM_LONG_LONG,		/* 131 */
> -	TPM_UNDEFINED,		/* 132 */
> -	TPM_UNDEFINED,		/* 133 */
> -	TPM_UNDEFINED,		/* 134 */
> -	TPM_UNDEFINED,		/* 135 */
> -	TPM_UNDEFINED,		/* 136 */
> -	TPM_UNDEFINED,		/* 137 */
> -	TPM_UNDEFINED,		/* 138 */
> -	TPM_UNDEFINED,		/* 139 */
> -	TPM_UNDEFINED,		/* 13a */
> -	TPM_UNDEFINED,		/* 13b */
> -	TPM_UNDEFINED,		/* 13c */
> -	TPM_UNDEFINED,		/* 13d */
> -	TPM_MEDIUM,		/* 13e */
> -	TPM_UNDEFINED,		/* 13f */
> -	TPM_UNDEFINED,		/* 140 */
> -	TPM_UNDEFINED,		/* 141 */
> -	TPM_UNDEFINED,		/* 142 */
> -	TPM_LONG,		/* 143 */
> -	TPM_MEDIUM,		/* 144 */
> -	TPM_UNDEFINED,		/* 145 */
> -	TPM_UNDEFINED,		/* 146 */
> -	TPM_UNDEFINED,		/* 147 */
> -	TPM_UNDEFINED,		/* 148 */
> -	TPM_UNDEFINED,		/* 149 */
> -	TPM_UNDEFINED,		/* 14a */
> -	TPM_UNDEFINED,		/* 14b */
> -	TPM_UNDEFINED,		/* 14c */
> -	TPM_UNDEFINED,		/* 14d */
> -	TPM_LONG,		/* 14e */
> -	TPM_UNDEFINED,		/* 14f */
> -	TPM_UNDEFINED,		/* 150 */
> -	TPM_UNDEFINED,		/* 151 */
> -	TPM_UNDEFINED,		/* 152 */
> -	TPM_LONG_LONG,		/* 153 */
> -	TPM_UNDEFINED,		/* 154 */
> -	TPM_UNDEFINED,		/* 155 */
> -	TPM_UNDEFINED,		/* 156 */
> -	TPM_UNDEFINED,		/* 157 */
> -	TPM_UNDEFINED,		/* 158 */
> -	TPM_UNDEFINED,		/* 159 */
> -	TPM_UNDEFINED,		/* 15a */
> -	TPM_UNDEFINED,		/* 15b */
> -	TPM_MEDIUM,		/* 15c */
> -	TPM_UNDEFINED,		/* 15d */
> -	TPM_UNDEFINED,		/* 15e */
> -	TPM_UNDEFINED,		/* 15f */
> -	TPM_UNDEFINED,		/* 160 */
> -	TPM_UNDEFINED,		/* 161 */
> -	TPM_UNDEFINED,		/* 162 */
> -	TPM_UNDEFINED,		/* 163 */
> -	TPM_UNDEFINED,		/* 164 */
> -	TPM_UNDEFINED,		/* 165 */
> -	TPM_UNDEFINED,		/* 166 */
> -	TPM_UNDEFINED,		/* 167 */
> -	TPM_UNDEFINED,		/* 168 */
> -	TPM_UNDEFINED,		/* 169 */
> -	TPM_UNDEFINED,		/* 16a */
> -	TPM_UNDEFINED,		/* 16b */
> -	TPM_UNDEFINED,		/* 16c */
> -	TPM_UNDEFINED,		/* 16d */
> -	TPM_UNDEFINED,		/* 16e */
> -	TPM_UNDEFINED,		/* 16f */
> -	TPM_UNDEFINED,		/* 170 */
> -	TPM_UNDEFINED,		/* 171 */
> -	TPM_UNDEFINED,		/* 172 */
> -	TPM_UNDEFINED,		/* 173 */
> -	TPM_UNDEFINED,		/* 174 */
> -	TPM_UNDEFINED,		/* 175 */
> -	TPM_UNDEFINED,		/* 176 */
> -	TPM_LONG,		/* 177 */
> -	TPM_UNDEFINED,		/* 178 */
> -	TPM_UNDEFINED,		/* 179 */
> -	TPM_MEDIUM,		/* 17a */
> -	TPM_LONG,		/* 17b */
> -	TPM_UNDEFINED,		/* 17c */
> -	TPM_UNDEFINED,		/* 17d */
> -	TPM_UNDEFINED,		/* 17e */
> -	TPM_UNDEFINED,		/* 17f */
> -	TPM_UNDEFINED,		/* 180 */
> -	TPM_UNDEFINED,		/* 181 */
> -	TPM_MEDIUM,		/* 182 */
> -	TPM_UNDEFINED,		/* 183 */
> -	TPM_UNDEFINED,		/* 184 */
> -	TPM_MEDIUM,		/* 185 */
> -	TPM_MEDIUM,		/* 186 */
> -	TPM_UNDEFINED,		/* 187 */
> -	TPM_UNDEFINED,		/* 188 */
> -	TPM_UNDEFINED,		/* 189 */
> -	TPM_UNDEFINED,		/* 18a */
> -	TPM_UNDEFINED,		/* 18b */
> -	TPM_UNDEFINED,		/* 18c */
> -	TPM_UNDEFINED,		/* 18d */
> -	TPM_UNDEFINED,		/* 18e */
> -	TPM_UNDEFINED		/* 18f */
> -};
> +static u8 tpm2_ordinal_duration_index(u32 ordinal)
> +{
> +	switch (ordinal) {
> +	/* Startup */
> +	case TPM2_CC_STARTUP:                 /* 144 */
> +		return TPM_MEDIUM;
> +
> +	case TPM2_CC_SELF_TEST:               /* 143 */
> +		return TPM_LONG;
> +
> +	case TPM2_CC_GET_RANDOM:              /* 17B */
> +		return TPM_LONG;
> +
> +	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
> +		return TPM_MEDIUM;
> +	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
> +		return TPM_MEDIUM;
> +	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
> +		return TPM_MEDIUM;
> +	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
> +		return TPM_MEDIUM;
> +
> +	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
> +		return TPM_LONG;
> +
> +	case TPM2_CC_PCR_EXTEND:              /* 182 */
> +		return TPM_MEDIUM;
> +
> +	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
> +		return TPM_LONG;
> +	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
> +		return TPM_LONG;
> +
> +	case TPM2_CC_GET_CAPABILITY:          /* 17A */
> +		return TPM_MEDIUM;
> +
> +	case TPM2_CC_NV_READ:                 /* 14E */
> +		return TPM_LONG;
> +
> +	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
> +		return TPM_LONG_LONG;
> +	case TPM2_CC_CREATE:                  /* 153 */
> +		return TPM_LONG_LONG;
> +	case TPM2_CC_CREATE_LOADED:           /* 191 */
> +		return TPM_LONG_LONG;
> +
> +	default:
> +		return TPM_UNDEFINED;
> +	}
> +}
> +
> +/**
> + * tpm2_calc_ordinal_duration() - returns the maximum amount of time
> + * the chip could take to return the result for a particular ordinal
> + * in jiffies.
> + *
> + * @chip:    TPM chip to use.
> + * @ordinal: TPM command ordinal.
> + *
> + * Return: A maxiaml duration time for an ordinal in jiffies.
typo  *maximal*
> + */
> +unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> +{
> +	unsigned int index;
> +
> +	index = tpm2_ordinal_duration_index(ordinal);
> +
> +	if (index != TPM_UNDEFINED)
> +		return chip->duration[index];
> +	else
> +		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> +}
> +EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
> +
>
>   struct tpm2_pcr_read_out {
>   	__be32	update_cnt;
> @@ -748,32 +714,6 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
>   	tpm_buf_destroy(&buf);
>   }
>
> -/*
> - * tpm2_calc_ordinal_duration() - maximum duration for a command
> - *
> - * @chip:	TPM chip to use.
> - * @ordinal:	command code number.
> - *
> - * Return: maximum duration for a command
> - */
> -unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> -{
> -	int index = TPM_UNDEFINED;
> -	int duration = 0;
> -
> -	if (ordinal >= TPM2_CC_FIRST && ordinal <= TPM2_CC_LAST)
> -		index = tpm2_ordinal_duration[ordinal - TPM2_CC_FIRST];
> -
> -	if (index != TPM_UNDEFINED)
> -		duration = chip->duration[index];
> -
> -	if (duration <= 0)
> -		duration = msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> -
> -	return duration;
> -}
> -EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
> -
>   /**
>    * tpm2_do_selftest() - ensure that all self tests have passed
>    *

