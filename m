Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0BBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A421571
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4A421571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeI1UHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:07:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728748AbeI1UHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:07:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SDd1NS088705
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:43:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mskv9cuuk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:43:18 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 28 Sep 2018 07:43:18 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 07:43:14 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8SDhBaU27001024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 06:43:11 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80BC36A051;
        Fri, 28 Sep 2018 07:43:11 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D1096A04D;
        Fri, 28 Sep 2018 07:43:09 -0600 (MDT)
Received: from oc8043147753.ibm.com.endicott.ibm.com (unknown [9.60.75.213])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Sep 2018 07:43:09 -0600 (MDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [FIXUP v9] fixup! fixup! s390: doc: detailed specifications for AP virtualization
Date:   Fri, 28 Sep 2018 09:43:06 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180926164222.74731b74@t450s.home>
References: <20180926164222.74731b74@t450s.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092813-0020-0000-0000-00000E6E8A50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009786; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094891; UDB=6.00566015; IPR=6.00874926;
 MB=3.00023544; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-28 13:43:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092813-0021-0000-0000-0000632FF993
Message-Id: <20180928134306.1395-1-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Removes extraneous text from third line below:

+05          CEX5A Accelerator
+05.0047     CEX5A Accelerator
+05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
---
 Documentation/s390/vfio-ap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
index 599eb0f75c07..6a880a27cfb6 100644
--- a/Documentation/s390/vfio-ap.txt
+++ b/Documentation/s390/vfio-ap.txt
@@ -459,7 +459,7 @@ CARD.DOMAIN TYPE  MODE
 ------------------------------
 05          CEX5A Accelerator
 05.0047     CEX5A Accelerator
-05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
+05.00ff     CEX5A Accelerator
 
 Guest2
 ------
-- 
2.19.0.221.g150f307

