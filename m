Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77782064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77782064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeIFO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:27:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbeIFO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:27:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w869oTo8088592
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 05:52:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maye2xxqm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:52:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 6 Sep 2018 10:52:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 10:52:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w869qlHa44171412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 09:52:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE53142045;
        Thu,  6 Sep 2018 12:52:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 688E94203F;
        Thu,  6 Sep 2018 12:52:41 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.222])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 12:52:41 +0100 (BST)
Subject: Re: [GIT PULL] s390 patches for the 4.19 merge window #2
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <20180824094225.68b2adc6@mschwideX1>
 <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 6 Sep 2018 11:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18090609-0020-0000-0000-000002C21844
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090609-0021-0000-0000-0000210F4D39
Message-Id: <3cbec995-e04e-7d32-265a-9a639ec2ac73@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2018 02:16, Kees Cook wrote:
> On Fri, Aug 24, 2018 at 12:42 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
>> Harald Freudenberger (5):
>>       s390/zcrypt: hex string mask improvements for apmask and aqmask.
> This (and an earlier 2017 commit) adds VLAs, which are being
> removed[1] from the kernel:
>
> drivers/s390/crypto/ap_bus.c:980:3: warning: ISO C90 forbids variable
> length array ‘clrm’ [-Wvla]
> drivers/s390/crypto/ap_bus.c:981:3: warning: ISO C90 forbids variable
> length array ‘setm’ [-Wvla]
> drivers/s390/crypto/ap_bus.c:995:3: warning: ISO C90 forbids variable
> length array ‘setm’ [-Wvla]
>
> static int process_mask_arg(const char *str,
>                             unsigned long *bitmap, int bits,
>                             struct mutex *lock)
> ...
>                 DECLARE_BITMAP(clrm, bits);
>                 DECLARE_BITMAP(setm, bits);
>
> Can someone please adjust this to make these fixed size again?
>
> Thanks!
>
> -Kees
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
Here is a simple solution which just hard codes the upper limit to 256 bits.
As all callers are only internal to the ap bus code and do obey to this limit
this shouldn't be a real limitation.

However, a version which really allocates will follow and then I'll discuss
with Martin, which version to post upstream.

========================================

From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 6 Sep 2018 11:29:36 +0200
Subject: [PATCH] s390/zcrypt: remove VLA use in ap bus code

The internal function to parse sysfs arguments uses VLAs -
dynamic bitmap arrays on the stack where the size is determined
by a invocation argument.

Reworked the code to have fixed sizes and check, if the caller
comply to this limit. However, one code path uses two of these
bitmap arrays and thus has a stack footprint of 64 bytes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index ec891bc7d10a..20f2fa2276c8 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -972,13 +972,13 @@ static int process_mask_arg(const char *str,
 {
     int i;
 
-    /* bits needs to be a multiple of 8 */
-    if (bits & 0x07)
+    /* bits needs to be a multiple of 8 and <= 256 */
+    if (bits & 0x07 || bits > 256)
         return -EINVAL;
 
     if (*str == '+' || *str == '-') {
-        DECLARE_BITMAP(clrm, bits);
-        DECLARE_BITMAP(setm, bits);
+        DECLARE_BITMAP(clrm, 256);
+        DECLARE_BITMAP(setm, 256);
 
         i = str2clrsetmasks(str, clrm, setm, bits);
         if (i)
@@ -992,7 +992,7 @@ static int process_mask_arg(const char *str,
                 set_bit_inv(i, bitmap);
         }
     } else {
-        DECLARE_BITMAP(setm, bits);
+        DECLARE_BITMAP(setm, 256);
 
         i = hex2bitmap(str, setm, bits);
         if (i)
-- 
2.17.1


