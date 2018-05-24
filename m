Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527160286-2-10517356842326992385
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160286; b=h9Ffw3B2nsluNWthgHq6zV1pY6t0JNRqKi2NkSGIkZOiwcWmzT
    lR6gizNd/wNIzzSNPZaDV3AHGe9B61w3ygp7iEBz8k7KJelCNx+C78NJnAWMRg2v
    0nSN96GPe7wBQjMn0r2Qgd2mJYQLt2KOXKbaDeJ7EMZJCYR0LlXMfHqB9Hogt8WG
    eOq72spZluUjQejLYxBq2i7iMx4nIyT6cNow3rdfZC0tgyv4ytds9dwAZRqotXSJ
    F4vOOdKVAlSBpIMeuti6AuWCVJJ/TiCY9qHXK0YY0LmxDgJ7jmrvhFFzoROed031
    LjqRmCBURD/7HjcLG5TCMo5tP124++UZwt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527160286; bh=Q
    hwaDkCJYeDOTO8wWnhyAYMucEtH1MxDwaG2xiUlDZQ=; b=Pa8oR3f+DPFnlZWmM
    ug0UQjPzJ+89cV1DwrmdyVqIFkRlo6tz6p+msWlQaK/wC1O0aeb0kXtf8mktTRx7
    l96+YvNCzDo2Byn0D5pis4dj4UE0++3piARreDe66Q82xzGz6VfCYLX2WmtnOfuO
    4BrnJ/Rj1gX60zjdGqo4OV7cxfGRKCQazcMK2SDDCOcHrMImqK4U1umQBrzB+8oE
    LNN9Xuj1Cx9ZlqFoge70YjIQYIn6iHe25CU3l2laZN11RyNNY1t4grN3mr5dVpdV
    fOqXJIzv0K13Gq0N1POG+nL2D8de8Nt3Cd/Ht7SPnbfJgz+jN8RHsK1tnRu1F96G
    SKlvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE0DFfJiBUkMmoCdcujSdte3D/u0NYMK/HtvBVEwIQl2rMTB1gS8t/sH8LTREuyK9RrSWpr4vFbyWZ9u4gRlgTKOS4zlkdbn/Qvj7XT9D05vgGgMWJ5S
    PMwozb/rPtZwqzPe+qeJeh0sMC4SRMJaIL9biNQ5GVsoFbO/tr7TKSIvK3pwk3oIxuX75fMGSyCTTYX3DRAuuM56y5KJitJY+7ve2EStVsF/FpHx6Q+2vF4F
    tXJTCnztBditkmphnnVjxA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
    a=yDjZZI0ZNtGLMXPeQV4A:9 a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033068AbeEXLKr (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 07:10:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033043AbeEXLKo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 07:10:44 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH v3 5/7] ima: based on policy require signed firmware (sysfs fallback)
Date: Thu, 24 May 2018 07:09:34 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052411-0040-0000-0000-0000043D6275
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0041-0000-0000-000026429F34
Message-Id: <1527160176-29269-6-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240132
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fbbcc02a1380..dd1f263f950a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -451,10 +451,17 @@ int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case READING_FIRMWARE_FALLBACK_SYSFS:
+		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
+			pr_err("Prevent firmware sysfs fallback loading.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
 	return 0;
+
 }
 
 static int read_idmap[READING_MAX_ID] = {
-- 
2.7.5

