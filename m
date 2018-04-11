Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476210-2-15942105131277673300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476210; b=ATKD2XO5gs4LcaO0SHUC2yrxSIz5XaHE5cVU3y4WPlKS793a6E
    sgFjYV5HjxiZF15SLNCvKcT8PUvuV6jNKMGMWs9LVY6vkxXW6oGeLpljBXWD7EfG
    /Kcu6Bq6UWFFgerAyNvficKJkTgZv4uZjW0zqM8Q8aaNeiHmIs1gu4TVjzQpyUyD
    WmlBPd+bFEcQKbu+WpA1Y5Oag+0mvApGmgh5K4S7T7g3b+IsW5jI6RKn1CqsSoct
    gUSBAMrgj4bMH9lRgfp4Vk9qZYa727FXpzaP81kh7p661RySvkB4M+p18Cjuuo4y
    cWYkuD6QGeMphpH+y614Zf6r6G3jGKk1FxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476210; bh=/LGCeOrHOPV/2AyAPLK3lyOdZBx43T
    Mkk67SSFEfSvM=; b=K/yN6ko4feqXH7gDHcLz97f8LLy8gEZEwaDJY6+RCwfL3H
    KQzy5067m+1O9pOq1LlAe+USi4jwi7TcoGg+g5O5vBnAohq1OREzWs3pJvGauSyF
    98OZagOu5uzh0NkcROsrkVZWWkKX57FgAJIDBGsUkUUTpeO7OUOttz4FOuDa454q
    maAuf4gBN9QtlcL92/rjyu/p8iXjX3/3LsPZ7RM0dQDXHKNpxbYH2yxfNQchEZFC
    fV5jI3CzAnTO1KngvhC71qNJN0EBokL0emBkNL5i9aKrpS21A8m/VoVDOPrRVNbP
    sAHlixh3vCwXUHsEkDUChUpY3OFQVXmG9ors0URQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPef0IqDMWkGRoNwApk0uB2vcDfT3CvP5KvVXfrNBXDy3M2zF0EO+5fBEIu1QWe9TNN8KDfjsvMcOOdN1fI3sgU06sc2UY3dW0CyVU7xZ/OP5NDlR/0R
    UG3wuuqD3sbyNvFP/pH7QAhJV/4oABr66Bh8hRyBrFAEOQ6B2HhCxr7AGUeVWF2O2s9ek5+M1afx5lvIg6sDREvTBerxZmBPU0o6yg/uMF2lMI8lJe6bzMqS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=qx11HIuZkImnOul2uTcA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755460AbeDKTtv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:49:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933975AbeDKS6o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 137/310] ACPI: EC: Fix debugfs_create_*() usage
Date: Wed, 11 Apr 2018 20:34:36 +0200
Message-Id: <20180411183628.343999234@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 3522f867c13b63cf62acdf1b8ca5664c549a716a ]

acpi_ec.gpe is "unsigned long", hence treating it as "u32" would expose
the wrong half on big-endian 64-bit systems.  Fix this by changing its
type to "u32" and removing the cast, as all other code already uses u32
or sometimes even only u8.

Fixes: 1195a098168fcacf (ACPI: Provide /sys/kernel/debug/ec/...)
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c       |    2 +-
 drivers/acpi/ec_sys.c   |    2 +-
 drivers/acpi/internal.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1518,7 +1518,7 @@ static int acpi_ec_setup(struct acpi_ec
 	}
 
 	acpi_handle_info(ec->handle,
-			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
+			 "GPE=0x%x, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
 			 ec->gpe, ec->command_addr, ec->data_addr);
 	return ret;
 }
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct ac
 		return -ENOMEM;
 	}
 
-	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
+	if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
 		goto error;
 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
 				 &first_ec->global_lock))
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -158,7 +158,7 @@ static inline void acpi_early_processor_
    -------------------------------------------------------------------------- */
 struct acpi_ec {
 	acpi_handle handle;
-	unsigned long gpe;
+	u32 gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	bool global_lock;
