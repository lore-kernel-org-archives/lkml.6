Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfAHVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:33:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729507AbfAHVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:33:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08LTIBi028666
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 16:33:32 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvyb2w0yh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:33:32 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 8 Jan 2019 21:33:30 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 21:33:27 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08LXQiG13304032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 21:33:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91073AE063;
        Tue,  8 Jan 2019 21:33:26 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C734AE060;
        Tue,  8 Jan 2019 21:33:25 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.229.216])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Jan 2019 21:33:25 +0000 (GMT)
References: <20190108193108.GA12259@avx2>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: return exit code 4 for skipped tests
In-reply-to: <20190108193108.GA12259@avx2>
Date:   Tue, 08 Jan 2019 19:33:19 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19010821-0064-0000-0000-000003929B9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010369; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01143671; UDB=6.00595421; IPR=6.00923929;
 MB=3.00025041; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-08 21:33:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010821-0065-0000-0000-00003BF52229
Message-Id: <87zhsahm1s.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey Dobriyan <adobriyan@gmail.com> writes:

> Test harness uses 4 for SKIP, not 2.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  tools/testing/selftests/proc/proc-loadavg-001.c        |    2 +-
>  tools/testing/selftests/proc/proc-self-map-files-002.c |    2 +-
>  tools/testing/selftests/proc/proc-self-syscall.c       |    2 +-
>  tools/testing/selftests/proc/proc-self-wchan.c         |    2 +-
>  tools/testing/selftests/proc/read.c                    |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/tools/testing/selftests/proc/proc-loadavg-001.c
> +++ b/tools/testing/selftests/proc/proc-loadavg-001.c
> @@ -30,7 +30,7 @@ int main(void)
>
>  	if (unshare(CLONE_NEWPID) == -1) {
>  		if (errno == ENOSYS || errno == EPERM)
> -			return 2;
> +			return 4;
>  		return 1;
>  	}

Can't these tests use the KSFT_SKIP macro defined in kselftest.h?

--
Thiago Jung Bauermann
IBM Linux Technology Center

