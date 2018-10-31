Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C1620657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C1620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeKADWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730069AbeKADWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:22:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VIFJKv028942
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:23:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nffynmmfn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:23:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 31 Oct 2018 18:13:07 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 18:13:03 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VID27m59375728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 18:13:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1946111C052;
        Wed, 31 Oct 2018 18:13:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B81C111C04C;
        Wed, 31 Oct 2018 18:13:01 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.73])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 18:13:01 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v1 3/7] vfio: ap: AP Queue Interrupt structures definitions
Date:   Wed, 31 Oct 2018 19:12:53 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103118-0028-0000-0000-00000310C4D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103118-0029-0000-0000-000023CCF657
Message-Id: <1541009577-29656-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define all the structures we need to let GISA handle
the AP Queues Interrupt.

This patch defines the inline assembler for AP Queue Interrupt
Control instruction with GISA, some utilities to manipulate
the data in the registers used by this instruction.

We also define new ap_matrix components to handle interruptions
and adapter mapping.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_private.h | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5675492233c7..45103865bd7f 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -74,15 +74,92 @@ struct ap_matrix {
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
  * @kvm:	the struct holding guest's state
+ * @map:	the adapter information for QEMU mapping
+ * @gisc:	the Guest ISC
  */
 struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
+	struct s390_map_info *map;
+	unsigned char gisc;
 };
 
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+/* AP Queue Interrupt Control associated structures and functions */
+struct aqic_gisa {
+	uint8_t  rzone;
+	uint8_t  izone;
+	unsigned	ir:1;
+	unsigned	reserved1:4;
+	unsigned	gisc:3;
+	unsigned	reserved2:6;
+	unsigned	f:2;
+	unsigned	reserved3:1;
+	unsigned	gisao:27;
+	unsigned	t:1;
+	unsigned	isc:3;
+}  __packed __aligned(8);
+
+struct ap_status {
+	unsigned	e:1;
+	unsigned	r:1;
+	unsigned	f:1;
+	unsigned	reserved:4;
+	unsigned	i:1;
+	unsigned	rc:8;
+	unsigned	pad:16;
+}  __packed __aligned(4);
+
+static inline uint32_t status2reg(struct ap_status a)
+{
+	return *(uint32_t *)(&a);
+}
+
+static inline struct ap_status reg2status(uint32_t r)
+{
+	return *(struct ap_status *)(&r);
+}
+
+static inline struct aqic_gisa reg2aqic(uint64_t r)
+{
+	return *((struct aqic_gisa *)&r);
+}
+
+static inline uint64_t aqic2reg(struct aqic_gisa a)
+{
+	return *((uint64_t *)&a);
+}
+
+/**
+ * ap_host_aqic - Issue the host AQIC instruction.
+ * @apqn is the AP queue number
+ * @gr1  the caller must have setup the register
+ *       with GISA address and format, with interrupt
+ *       request, ISC and guest ISC
+ * @gr2  the caller must have setup the register
+ *       to the guest NIB physical address
+ *
+ * issue the AQIC PQAP instruction and return the AP status
+ * word
+ */
+static inline uint32_t ap_host_aqic(uint64_t apqn, uint64_t gr1,
+				    uint64_t gr2)
+{
+	register unsigned long reg0 asm ("0") = apqn | (3UL << 24);
+	register unsigned long reg1_in asm ("1") = gr1;
+	register uint32_t reg1_out asm ("1");
+	register unsigned long reg2 asm ("2") = gr2;
+
+	asm volatile(
+		".long 0xb2af0000"	  /* PQAP(AQIC) */
+		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
+		:
+		: "cc");
+	return reg1_out;
+}
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.17.0

