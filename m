Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3262C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD7F21763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD7F21763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeHMMGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:06:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728310AbeHMMGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:06:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7D9IclV027540
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:24:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku6a02guk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:24:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 13 Aug 2018 10:24:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 10:24:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7D9OoOc28180622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 09:24:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD55FA4053;
        Mon, 13 Aug 2018 12:24:54 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F3AFA4065;
        Mon, 13 Aug 2018 12:24:54 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.51])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Aug 2018 12:24:53 +0100 (BST)
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809110645.33b20c1f.cohuck@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Mon, 13 Aug 2018 11:24:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809110645.33b20c1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081309-0012-0000-0000-00000298F620
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081309-0013-0000-0000-000020CC1130
Message-Id: <36670270-13f7-f044-7419-57f444317fd9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is now the add-on patch which changes the returncode for the
ap_instructions_available() function.

I talked with Heiko Carstens and this patch will go into the next pull
request for the 4.19 kernel.

-----------------------------------------------------------------------------------------
From 9e050f843f3281da1f65292422e30f2dd1fd6d98 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 9 Aug 2018 11:59:34 +0200
Subject: [PATCH] s390/zcrypt: fix ap_instructions_available() returncodes

During review of KVM patches it was complained that the
ap_instructions_available() function returns 0 if AP
instructions are available and -ENODEV if not. The function
acts like a boolean function to check for AP instructions
available and thus should return 0 on failure and != 0 on
success. Changed to the suggested behaviour and adapted
the one and only caller of this function which is the ap
bus core code.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/ap.h   | 10 +++++-----
 drivers/s390/crypto/ap_bus.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 046e044a48d0..887494aa164f 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -49,20 +49,20 @@ struct ap_queue_status {
 /**
  * ap_intructions_available() - Test if AP instructions are available.
  *
- * Returns 0 if the AP instructions are installed.
+ * Returns 1 if the AP instructions are installed, otherwise 0.
  */
 static inline int ap_instructions_available(void)
 {
     register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
-    register unsigned long reg1 asm ("1") = -ENODEV;
-    register unsigned long reg2 asm ("2");
+    register unsigned long reg1 asm ("1") = 0;
+    register unsigned long reg2 asm ("2") = 0;
 
     asm volatile(
         "   .long 0xb2af0000\n"        /* PQAP(TAPQ) */
-        "0: la    %0,0\n"
+        "0: la    %0,1\n"
         "1:\n"
         EX_TABLE(0b, 1b)
-        : "+d" (reg1), "=d" (reg2)
+        : "+d" (reg1), "+d" (reg2)
         : "d" (reg0)
         : "cc");
     return reg1;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b023e35786ec..b1b73945d746 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1475,7 +1475,7 @@ static int __init ap_module_init(void)
     if (rc)
         return rc;
 
-    if (ap_instructions_available() != 0) {
+    if (!ap_instructions_available()) {
         pr_warn("The hardware system does not support AP instructions\n");
         return -ENODEV;
     }
-- 
2.17.1


