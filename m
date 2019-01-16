Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A82A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbfAPPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:17:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404817AbfAPPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:17:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GFBB3H046909
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:17:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q26s3h3cd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:17:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 16 Jan 2019 15:17:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 15:17:36 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GFHZ3Y60883150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 15:17:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A0C42047;
        Wed, 16 Jan 2019 15:17:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C68B94204F;
        Wed, 16 Jan 2019 15:17:34 +0000 (GMT)
Received: from [9.83.224.254] (unknown [9.83.224.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 15:17:34 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] gcov: add Clang support
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20190115183643.120619-1-trong@google.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 16 Jan 2019 16:17:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190115183643.120619-1-trong@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011615-0020-0000-0000-00000307510D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011615-0021-0000-0000-000021586E3D
Message-Id: <65bb2ab8-4929-db7c-9d54-491d87ec23ae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.2019 19:36, Tri Vo wrote:
> From: Tri Vo <trong@android.com>
> 
> This patch series adds Clang supoprt for gcov.
> 
> Patch 1 refactors existing code in preparation for Clang support. Patches
> 2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
> Patch 4 simplifies config selection.
> 
> Greg Hackmann (2):
>   gcov: clang: move common gcc code into gcc_base.c
>   gcov: clang support
> 
> Nick Desaulniers (1):
>   gcov: clang: link/unlink profiling data set.
> 
> Tri Vo (1):
>   gcov: clang: pick GCC vs Clang format depending on compiler

Overall this patch set looks good to me. It introduces a clean way for
GCC and Clang specific implementation details to coexist.

A quick test compile using GCC on s390 with the patch set applied was
successful, so it seems like the existing support is unaffected.

There are some detail suggestions on patch improvements that I'll post
in separate e-mails.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

