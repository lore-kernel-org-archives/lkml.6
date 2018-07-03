Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D71C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A273223F62
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273223F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeGCNOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:14:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753068AbeGCNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:14:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63DBPlJ042449
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 09:14:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k07bgxw3m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:14:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 14:14:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 14:13:59 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63DDw0c40894508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 13:13:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ACD24C046;
        Tue,  3 Jul 2018 16:14:24 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 625014C044;
        Tue,  3 Jul 2018 16:14:23 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.97.127])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 16:14:23 +0100 (BST)
Subject: Re: [PATCH] ima: Remove unused is_ima_appraise_enabled() function.
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 03 Jul 2018 09:13:47 -0400
In-Reply-To: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
References: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18070313-0012-0000-0000-000002864C69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070313-0013-0000-0000-000020B7C8DC
Message-Id: <1530623627.3452.31.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 07:19 -0400, Stefan Berger wrote:
> Remove the unused is_ima_appraise_enabled() function.

is_ima_appraise_enabled() was introduced to coordinate between IMA and
the lockdown patch set.  Before removing it, let's wait and see if it
is still needed by the lockdown patches.

Mimi

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/linux/ima.h                   |  6 ------
>  security/integrity/ima/ima_appraise.c | 10 ----------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..7f6952f8d6aa 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -75,17 +75,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  #endif
> 
>  #ifdef CONFIG_IMA_APPRAISE
> -extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct dentry *dentry);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len);
>  extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
>  #else
> -static inline bool is_ima_appraise_enabled(void)
> -{
> -	return 0;
> -}
> -
>  static inline void ima_inode_post_setattr(struct dentry *dentry)
>  {
>  	return;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8bd7a0733e51..7bf7fcacfdbb 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -33,16 +33,6 @@ static int __init default_appraise_setup(char *str)
> 
>  __setup("ima_appraise=", default_appraise_setup);
> 
> -/*
> - * is_ima_appraise_enabled - return appraise status
> - *
> - * Only return enabled, if not in ima_appraise="fix" or "log" modes.
> - */
> -bool is_ima_appraise_enabled(void)
> -{
> -	return ima_appraise & IMA_APPRAISE_ENFORCE;
> -}
> -
>  /*
>   * ima_must_appraise - set appraise flag
>   *

