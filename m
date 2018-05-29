Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473614-1527616962-2-15470725374358965431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527616962; b=R9iihF6DoClM3qLnXlqpA8ECjAram9AUHNNhC0cy+xDd950XCh
    8t8XCu81YyJzNtDFraubCqCU8I/DvTDhdv7JVAnOyl5n64QLd5PvG2x9AjGQrq6i
    O3C3ANwT14Jlez9x46G9BSkWYROE5Uuc7v7XZuajxmyW94xpsn47gDKmMPa1ZHlo
    n58dE7zKTFAG7ghFnM4yzFY11viJZ2YA8ABa0x086eQY0/hlLyk3vcyZ/a4k0RV8
    d2A7SDmsAGnbV9MCIf/YNKDf8jFOka/k1SpezU0+KeHHUegV70yOgQbWdTdl0M3Y
    +oBErfJ+23q4iQFnSDqU068+HZuB3poEoseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527616962; bh=D
    KWpeYfeo6t/yUjjC1w+Qiqyp8/wjJkj4Axidzq9I7Y=; b=J437grckxmWToy0i7
    tSrVpfy7UuOAzBAjGPNaz8N5pLAWg+kv4KafVPp/uXE6NRoETE1Attg0YzUPhl8C
    9BAtEUszq2ead9owjeRzu+tvTb/3JOWHawx9T9fwwMhsDH0VBaFXprzX8clLtG56
    +uX+HI6ZgzunhhDwWd15Mo44at0MUk/PEBnqh7u4ecaBCI8uGaD0sP/wZ9m7ZAe+
    eQL5yKK65Hom4Mqm1KgwPV/geQ25PcWCrWUYd2jvAeloLbgWgt/rVSMY8kJpbmfb
    jMc/2H7SbKI54va0WIu8nsyenawSLk4kl8XpWCMDf4KfjFMTqmYmyayJY9ymLxxy
    7mB2g==
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
X-CM-Envelope: MS4wfMlOt0ho7G94fYx6E0pqPr6cIn6uMSQ1pgUueNwKsvKHQt6wCzhhlh5L1YPEaMYpPsAPCaqeqVrwMK++dk79jswipqYR6YmL2F4oCNWsxbFZocqoZKWx
    3XaL/IhtJzj4BAmDRHiQ/43Eg29FZi0nlMgjN/odtblD+8Y4O8HNliPz53zT/NxV2DfzRx1GDF6wSeLHLBQGJu62y766csLsDCyLWZuUk8Bn1FYapqcy87Nn
    xARo/yxJNx2aGyNc2Kz6YQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=ti_eqcim9oWAIOH4GhMA:9 a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965862AbeE2SCh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:02:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965814AbeE2SC2 (ORCPT
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 4/8] firmware: add call to LSM hook before firmware sysfs fallback
Date: Tue, 29 May 2018 14:01:56 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052918-0044-0000-0000-00000558109D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052918-0045-0000-0000-0000289A201C
Message-Id: <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
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

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>

Changelog v4:
- call new LSM security_kernel_arg hook

Changelog v2:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.
---
 drivers/base/firmware_loader/fallback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..2443bda81631 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
+	int ret;
+
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
@@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
+	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
+	ret = security_kernel_load_data(LOADING_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-- 
2.7.5

