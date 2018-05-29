Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2486798-1527616962-2-4905983728914257669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527616961; b=D9176/+TrsOxmcBID6ds3deFtAFjA/Jw6Xk+lOIqA25o7jTbs3
    jEtQyH3Mm9bfW2B2de2ka3fGxY64QcrQZPXQ7V9JKYZkZJ2hByoCR9/5h2TP/DW7
    6/RurgUyedcsTtkixgK5ovFetLqsHh4MGIr5Jjy+puwY+bWdY/PW1mm9ha43CtQ3
    5uh+k9t6mMcwETL5oPh9koiHepZ93HrbVwdwOxdCe6zIjOBU7UvAEe8rPg2ReOTR
    nfj+/RlfiRhbI+o58hM/8YS3PlLKP5XFthVyqewr1+ZISULP6X0gw/VL7gneERKR
    b2zjPK/K8Hfdet8aDw7v5ifC50787JlrfIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527616961; bh=d
    lMhOC2XT5p+paxSYyequWnSF63H+SPmvAu09Qs6O28=; b=De9YyatI7AntLknaS
    nTMH/CztKq+gErkE3qKaI6/X2kapFazbp43lKgFAlqvI/xyOwigozpwXFQz3DVui
    pktc/+ZRvHtDpWpy1991NTGvT0ZlNOUlt2LerRNMHDZ+EmbksDkDjpB9f0D8a5Fa
    LD6Luk4gBphxdBsACH/cX4/xrUG9h1m+6ysFUSm+8LITaAluRva+cJloBT3SU6zI
    wMDFWidoP5lfhapv+PFHCGw/rsQMo511aQtXHFPTaUfo0oYppn9TItqU1MYkvj3w
    xxwTaDh+m8rp/JyFTOPSp271HUDYtsJZ+08P1aoSxPnSAxLIqUbi6pdN4C7eanGL
    ARBcw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/NRTgIs25gzQgznXLBmbnRKVBnoO27Ga74q/X7BHIPEgLcKQqf0WQabDnVC9qxnU8dWnnjhvUOx4DWq5125q3qcUcZtabI5kwi+HajHBf0cJnWN87V
    1j+lrn9f7bfeQzMf8G7KPL+BpijvrRukeW7i1WvnaQUKf9s1rI35/DRNvgzTn/K5Lkbk6Kom3cNArvidyuwY8PnJrjCN4dVsF9dHS/MC5m/pZPv4r6FJZ0R/
    mqf6Plu9q8BX45VM549tgg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
    a=YDPIykgoBt4Y5rfgiSYA:9 a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965603AbeE2SCd (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:02:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965813AbeE2SC2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 14:02:28 -0400
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
Subject: [PATCH v4 5/8] ima: based on policy require signed firmware (sysfs fallback)
Date: Tue, 29 May 2018 14:01:57 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052918-0044-0000-0000-00000558109F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052918-0045-0000-0000-0000289A201D
Message-Id: <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290195
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Luis, is the security_kernel_post_read_file LSM hook in
firmware_loading_store() still needed after this patch?  Should it be
calling security_kernel_load_data() instead?

---

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a565d46084c2..4a87f78098c8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 		return 0;
 	}
 
@@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case LOADING_FIRMWARE:
+		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
+			pr_err("Prevent firmware sysfs fallback loading.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
-- 
2.7.5

