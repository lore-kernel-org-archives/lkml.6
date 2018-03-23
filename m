Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024708-1521833264-2-5096148107528013085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521833263; b=BRmazSxsPCu/2F2u+8EWIey0U3aGu1wtVrouNSyhac7dYDt
    44dPdd1BaDDV/tz5EFHVR+fZXYsmYYYKZMsy7iT5g8JbztphwwjTMP/Z2o6NcavC
    Rl/C5IaDbYNDkgZXEG18mLLlEblgVd8LDvO1N49jWhjP+uPulyxxOHC1c+RFkpFN
    NvPuzkEvcnl/aZTl8jfz/XSkUlaiBeHQSuNwQZOZBMWzbYzTbOtdKFxdC0Qv/iW2
    A2SjzzvZIADq9pALFHiSy/dLdFhGX9XjzfIE4ZXgYRL616QaK8hO62BqLK3GVL66
    0gaGUoriVZfVVSPe+DgldDWHSShOLdOqCURStmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521833263; bh=OIQ0qNJ2ghdQoY20g9iT76A1N1
    jozonYLJqxv4iJE00=; b=asNiLhl3q831KvLVbsto6Uuvt/lh+hY4egD1BUaDVM
    qMimtYxAugolFeSVKpf2Ht9K9X0XwqOc+F6nJ0qqH35//G9QZcpnZzuLomv8CGA8
    kMHQ+WBVtFh8cWaZKe0iHHncIsGSMeFawx1odfPa1orTQQmwY6AaPBYC+Y5YN3qQ
    0Bg/RGG5LGoLpo0mTCDNd9AbASGORikslEMEY0gmeat33z1K2Q4wVmJXBXyzTgVI
    QyAgD9R51HLso3smdiKcEbJGAVbyOhWdmjJz8EjM/KJwKIavk9ulEUKLKEUW8d8e
    ihUTTvk9Bj+12T0py9iZJMsVzLu6rl7mY2b43tjO6EbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCWT0o (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:26:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWT0o (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 15:26:44 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] usb: core: Copy parameter string correctly and remove superfluous null check
Date: Sat, 24 Mar 2018 03:26:35 +0800
Message-Id: <20180323192636.16586-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

strsep() slices string, so the string gets copied by
param_set_copystring() at the end of quirks_param_set() is not the
original value.
Fix that by calling param_set_copystring() earlier.

The null check for val is unnecessary, the caller of quirks_param_set()
does not pass null string.
Remove the superfluous null check. This is found by Smatch.

Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6fb8d5433268..29e5f32b38df 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -31,10 +31,15 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 	u16 vid, pid;
 	u32 flags;
 	size_t i;
+	int err;
+
+	err = param_set_copystring(val, kp);
+	if (err)
+		return err;
 
 	mutex_lock(&quirk_mutex);
 
-	if (!val || !*val) {
+	if (!*val) {
 		quirk_count = 0;
 		kfree(quirk_list);
 		quirk_list = NULL;
@@ -133,7 +138,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 unlock:
 	mutex_unlock(&quirk_mutex);
 
-	return param_set_copystring(val, kp);
+	return 0;
 }
 
 static const struct kernel_param_ops quirks_param_ops = {
-- 
2.15.1

