Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8986C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D23206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfAPWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:52:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728877AbfAPWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:52:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GMnHrv138289
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 17:52:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2b29x1h7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 17:52:18 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Wed, 16 Jan 2019 22:52:17 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 22:52:13 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GMqCsY20381776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 22:52:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78F1AC6061;
        Wed, 16 Jan 2019 22:52:12 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E9D7C606E;
        Wed, 16 Jan 2019 22:52:09 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.211.227])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 22:52:09 +0000 (GMT)
References: <20190116213102.25268-1-jarkko.sakkinen@linux.intel.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH,RESEND] selftests: add TPM 2.0 tests
In-reply-to: <20190116213102.25268-1-jarkko.sakkinen@linux.intel.com>
Date:   Wed, 16 Jan 2019 20:52:03 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19011622-0004-0000-0000-000014D3F603
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010420; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147494; UDB=6.00597738; IPR=6.00927789;
 MB=3.00025163; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 22:52:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011622-0005-0000-0000-00008A3FFD2E
Message-Id: <87r2dcqkq4.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:

> Added the tests that I've been using for testing TPM 2.0 functionality
> for long time but have out-of-tree so far residing in
>
> https://github.com/jsakkine-intel/tpm2-scripts
>
> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
> ---
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/tpm2/Makefile      |   3 +
>  tools/testing/selftests/tpm2/test_smoke.sh |   4 +
>  tools/testing/selftests/tpm2/test_space.sh |   4 +
>  tools/testing/selftests/tpm2/tpm2.py       | 696 +++++++++++++++++++++
>  tools/testing/selftests/tpm2/tpm2_tests.py | 227 +++++++
>  6 files changed, 935 insertions(+)
>  create mode 100644 tools/testing/selftests/tpm2/Makefile
>  create mode 100755 tools/testing/selftests/tpm2/test_smoke.sh
>  create mode 100755 tools/testing/selftests/tpm2/test_space.sh
>  create mode 100644 tools/testing/selftests/tpm2/tpm2.py
>  create mode 100644 tools/testing/selftests/tpm2/tpm2_tests.py
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1a2bd15c5b6e..e4556132cbc4 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -47,6 +47,7 @@ TARGETS += sysctl
>  ifneq (1, $(quicktest))
>  TARGETS += timers
>  endif
> +TARGETS += tpm

This should be tpm2, right?

>  TARGETS += user
>  TARGETS += vm
>  TARGETS += x86

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

