Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3768412-1524033585-2-9422494303567331080
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524033585; b=mfEAZ8J+f1edttU8P3T4udIagFCjPmd+Gd5Hf25BEZP7TT66Zd
    rlT/v7TV2ulY0KDYewsj8z/vbfi+HqqHnSv4BQqKYIaoUqFRMO49AHCuVRokxZAY
    JpGatqUd8O373YZ+/zZpVHohVggJQDPOyheZM5Cqi0JPCqm9tE6w1m04FHtenx8B
    P2dzgyLrttYilZ/7taa5HkoOea9P197anGTfLnSWJOgOzAw/kUqypiTyjZnal9GF
    Lu4R1n3G6lltYTGJ8PM73+1bkRrfOdWaMgfdmhc0ddZMoeu90SB2iPElzjC14i/c
    Hg/tOAWdsZyXbm3+nNIR+cq/1FqDOK0Kwdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524033585; bh=CRVBqAA0ILR2DHvtQrUn/qDsSk1OX8
    i6L8/0KOUc9k4=; b=Q1dnS9oeNbpWLPaP1XrIyg+HhWRFxEaHozrt1ZZqyfQlJz
    dMXP6FAonnrYWHnA2Y2DRF7rqpR6aIh7ckEne60ClXBifa+4DIwPlXl43VVNdck8
    J3XTLUQoQ3iOx73B/DUC8oYdLMEz3A3T9Fx4q7cYk4+/BodrCCMmfI70uFCRzhrC
    GuLrhwXn8w8zYxcm9eC5uVFFS7Qhq/ayZ/s50Y8pcJ6LFMQQnGAUkYHFFmWadRGe
    qs1kNCGFAH81VQ3NM6B04w5FQJKKL+y2EA8Q/DpQ4foYJKZK6GqXvMjVwgYki09R
    CKgRuKgsAaiXyTX7euwKcTjMBGGpoGscBAEEB0ew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEJxbhvriYo199pfqYHTO9rdRM1/KW39tBCOcKTU3TMxzYI8iA0inGYHvKDGgAAKhixfSkMnz20Tbq1a44EPgIRzYSSXbZbvdAOjg6zi2XaBiyDAnd0E
    crW9zfMm5ihlvfsujsO07wHLItvcRWteZ9FfI987Z1NH7IidNyJmmF+f85qFeNku5lNnmgJK7e0sTKlV7G1rrSlLSiUOxHdqzE62SeMDyMR1u0gWWfgGzLDt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=4hirlG-2ErW7RMWNpGEA:9
    a=T9KE5mTaSm2qF8Kh:21 a=H4AH90sMA9K8_StT:21 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeDRGjb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 02:39:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751955AbeDRGjb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 02:39:31 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: jeyu@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        peterz@infradead.org, acme@kernel.org, me@tobin.cc,
        keescook@chromium.org, stable@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] module: Fix display of wrong  module .text address
Date: Wed, 18 Apr 2018 08:39:04 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041806-0044-0000-0000-000005497423
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041806-0045-0000-0000-000028898653
Message-Id: <20180418063904.100200-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180061
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()'
when not restricting") for /sys/module/*/sections/.text file.

Reading file /proc/modules shows the correct address:
[root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 94208 1 - Live 0x000003ff80401000

and reading file /sys/module/qeth_l2/sections/.text
[root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
0x0000000018ea8363
displays a random address.

This breaks the perf tool which uses this address on s390
to calculate start of .text section in memory.

Fix this by printing the correct (unhashed) address.

Thanks to Jessica Yu for helping on this.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index a6e43a5806a1..40b42000bd80 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
 {
 	struct module_sect_attr *sattr =
 		container_of(mattr, struct module_sect_attr, mattr);
-	return sprintf(buf, "0x%pK\n", (void *)sattr->address);
+	return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
+		       (void *)sattr->address : 0);
 }
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
-- 
2.14.3
