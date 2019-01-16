Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9580206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfAPQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:14:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbfAPQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:14:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GG4AT5045544
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:14:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q25vx6gnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:14:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 16 Jan 2019 16:14:06 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:14:04 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGE31c61669532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:14:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9F4A4065;
        Wed, 16 Jan 2019 16:14:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85647A4069;
        Wed, 16 Jan 2019 16:14:02 +0000 (GMT)
Received: from [9.83.224.254] (unknown [9.83.224.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 16:14:02 +0000 (GMT)
Subject: Re: [PATCH 3/4] gcov: clang: link/unlink profiling data set.
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
References: <20190114210426.177543-1-trong@android.com>
 <20190114210426.177543-4-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 16 Jan 2019 17:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190114210426.177543-4-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011616-0016-0000-0000-000002465358
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0017-0000-0000-000032A0717D
Message-Id: <03d3a8d0-b9cd-28e9-6365-d74adcd4db59@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.2019 22:04, Tri Vo wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> gcov.h defines an interface to access gcov_info data.
> 
> Add Clang implementation of gcov_info_link/gcov_info_unlink interfaces.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Trilok Soni <tsoni@quicinc.com>
> Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
> Tested-by: Tri Vo <trong@android.com>
> ---
>  kernel/gcov/clang.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Please merge this patch into patch 2 as it fixes a number of problems in
that patch.

> 
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index b00795d28137..ea42deb852f7 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c

[...]

> +/**
> + * gcov_info_unlink - unlink/remove profiling data set from the list
> + * @prev: previous profiling data set
> + * @info: profiling data set
> + */
> +void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
> +{
> +	if (prev)
> +		list_del(&prev->head);

This is incorrect - gcov_info_unlink should remove info from the list,
not its predecessor prev.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

