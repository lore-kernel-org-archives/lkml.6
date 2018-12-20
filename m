Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4493217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeLTRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:30:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732074AbeLTRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:30:17 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKHTFRm059172
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:30:16 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pgdcm64qg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:30:15 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 20 Dec 2018 17:30:14 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 17:30:10 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKHU9KM23855148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 17:30:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 422E5BE04F;
        Thu, 20 Dec 2018 17:30:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13D3BBE053;
        Thu, 20 Dec 2018 17:30:05 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.210.228])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Dec 2018 17:30:05 +0000 (GMT)
References: <20181219213338.26619-1-igor.stoppa@huawei.com> <20181219213338.26619-12-igor.stoppa@huawei.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] IMA: turn ima_policy_flags into __wr_after_init
In-reply-to: <20181219213338.26619-12-igor.stoppa@huawei.com>
Date:   Thu, 20 Dec 2018 15:30:01 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18122017-0012-0000-0000-000016ED72BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010256; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01134559; UDB=6.00589903; IPR=6.00914732;
 MB=3.00024772; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-20 17:30:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122017-0013-0000-0000-000055878A1D
Message-Id: <87pntwumw6.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=725 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Igor,

Igor Stoppa <igor.stoppa@gmail.com> writes:

> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 59d834219cd6..5f4e13e671bf 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -21,6 +21,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/prmem.h>
>
>  #include "ima.h"
>
> @@ -98,9 +99,9 @@ void __init ima_load_x509(void)
>  {
>  	int unset_flags = ima_policy_flag & IMA_APPRAISE;
>
> -	ima_policy_flag &= ~unset_flags;
> +	wr_assign(ima_policy_flag, ima_policy_flag & ~unset_flags);
>  	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
> -	ima_policy_flag |= unset_flags;
> +	wr_assign(ima_policy_flag, ima_policy_flag | unset_flags);
>  }
>  #endif

In the cover letter, you said:

> As the name implies, the write protection kicks in only after init()
> is completed; before that moment, the data is modifiable in the usual
> way.

Given that, is it still necessary or useful to use wr_assign() in a
function marked with __init?

--
Thiago Jung Bauermann
IBM Linux Technology Center

