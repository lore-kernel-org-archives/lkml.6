Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F922177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 23:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfBCXBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 18:01:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbfBCXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 18:01:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x13MwmvZ064402
        for <linux-kernel@vger.kernel.org>; Sun, 3 Feb 2019 18:01:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qe7e1b6g9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 18:01:13 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 3 Feb 2019 23:01:11 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 3 Feb 2019 23:01:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x13N16Rh57737390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Feb 2019 23:01:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506BAA4051;
        Sun,  3 Feb 2019 23:01:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5426BA405D;
        Sun,  3 Feb 2019 23:01:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  3 Feb 2019 23:01:05 +0000 (GMT)
Subject: Re: [PATCH] tpm/st33zp24: Fix name collision with TPM_BUFSIZE
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        stable@vger.kernel.org
Date:   Sun, 03 Feb 2019 18:00:54 -0500
In-Reply-To: <20190201174117.23440-1-jarkko.sakkinen@linux.intel.com>
References: <20190201174117.23440-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020323-4275-0000-0000-0000030A0407
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020323-4276-0000-0000-0000381803F5
Message-Id: <1549234854.4146.24.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902030191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Fri, 2019-02-01 at 19:41 +0200, Jarkko Sakkinen wrote:
> Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
> ST33ZP24_BUFSIZE as it collides with TPM_BUFSIZE defined in
> drivers/char/tpm/tpm.h.
> 
> Cc: stable@vger.kernel.org
> Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

FYI, I'm seeing a similar redefined TPM_BUFSIZE in tpm_i2c_infineon.c.

Mimi

> ---
>  drivers/char/tpm/st33zp24/i2c.c      | 2 +-
>  drivers/char/tpm/st33zp24/spi.c      | 2 +-
>  drivers/char/tpm/st33zp24/st33zp24.h | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index be5d1abd3e8e..8390c5b54c3b 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -33,7 +33,7 @@
>  
>  struct st33zp24_i2c_phy {
>  	struct i2c_client *client;
> -	u8 buf[TPM_BUFSIZE + 1];
> +	u8 buf[ST33ZP24_BUFSIZE + 1];
>  	int io_lpcpd;
>  };
>  
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index d7909ab287a8..ff019a1e3c68 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -63,7 +63,7 @@
>   * some latency byte before the answer is available (max 15).
>   * We have 2048 + 1024 + 15.
>   */
> -#define ST33ZP24_SPI_BUFFER_SIZE (TPM_BUFSIZE + (TPM_BUFSIZE / 2) +\
> +#define ST33ZP24_SPI_BUFFER_SIZE (ST33ZP24_BUFSIZE + (ST33ZP24_BUFSIZE / 2) +\
>  				  MAX_SPI_LATENCY)
>  
>  
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
> index 6f4a4198af6a..20da0a84988d 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.h
> +++ b/drivers/char/tpm/st33zp24/st33zp24.h
> @@ -18,8 +18,8 @@
>  #ifndef __LOCAL_ST33ZP24_H__
>  #define __LOCAL_ST33ZP24_H__
>  
> -#define TPM_WRITE_DIRECTION             0x80
> -#define TPM_BUFSIZE                     2048
> +#define TPM_WRITE_DIRECTION	0x80
> +#define ST33ZP24_BUFSIZE	2048
>  
>  struct st33zp24_dev {
>  	struct tpm_chip *chip;

