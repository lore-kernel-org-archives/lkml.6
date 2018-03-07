Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452097-2-13430412597817996455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452096; b=mlxahaj88JDLo7gZk+DuXPJY+ng6md+uRECoAuJ+7adwuqF
    EUlWJyFDGWVT9L7x4N3VF2OwPSVW3afq9WXH35ex4PVMhh+yZEEFuTNd14zt7doZ
    I6GcdKtzAr22E5l9ognmTb3t6NDIVxLGmEKVpIzy4MLlmRETox/qddRezn4ct3Jp
    BmLD0DofjwxxKMHqkLlchMfXetXR+0wi3ExpdW5zmDfyssnz+E0OyAEdD4rtGwrA
    I07UNi/Nt6QPC52d4yCpCxDuPvNqbYJ4dqXVv8amM7aw+7yTht1xy9h3UJ4fPk1z
    0PDbhvza2EYqatyLWnNxuHwxI6KS3REnZMWCa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452096; bh=sPiW7dTGv9tbOoYCUqA4UG388W
    7pim6bHKOZEUj3I9c=; b=jQ8fvD9I66kbBnunjmVZBm3VFeKV48ryGSvNyJD8q0
    XXmzKilf3RRfVjV22KFBqHTFhEOTcIiBeTEtHpYP2ZVUgVa+5fp5ml/XvS6DuLW4
    uV1U9JAMikYGh0szS67Mc22C4CtCoVVeKM1eiRk6l1U8ma9GsF0GmgPcy/PIKqTK
    K+pmkwX72lQUbiI7q9USU9bxaa1fAwWEm5vgk1tRJgLm8y0Oaie606BMj0EKIwWG
    Gq5GB3YwUJ1t5s3+icaIoz7XdPycrggxFfwLj9p6lyDwnUC+tjxg09BR3jMmrwzc
    ZAGW0sjw1xZFnRNJ7FCLBN7jtsbbYthiQMwFc1M7WvdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965564AbeCGTsJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:48:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965178AbeCGTsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:48:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 106/110] ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530
Date: Wed,  7 Mar 2018 11:39:29 -0800
Message-Id: <20180307191053.550476543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Heng Feng <kai.heng.feng@canonical.com>

commit 36904703aeeeb6cd31993f1353c8325006229f9a upstream.

The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
of box.

The touchpad relies on its _INI method to update its _HID value from
XXXX0000 to SYNA2393.

Also, the _STA relies on value of I2CN to report correct status.

Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
correctly set up, and _INI can get run. The ACPI table in this machine
is designed to get parsed this way.

Also, change the quirk table to a more generic name.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198515
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/bus.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -66,10 +66,37 @@ static int set_copy_dsdt(const struct dm
 	return 0;
 }
 #endif
+static int set_gbl_term_list(const struct dmi_system_id *id)
+{
+	acpi_gbl_parse_table_as_term_list = 1;
+	return 0;
+}
 
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
+	/*
+	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
+	 * mode.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
+	 */
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell Precision M5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
+		},
+	},
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell XPS 15 9570",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
+		},
+	},
 	/*
 	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
+	 * DSDT will be copied to memory.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
 	 */
 	{
@@ -83,7 +110,7 @@ static const struct dmi_system_id dsdt_d
 	{}
 };
 #else
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
 	{}
 };
 #endif
@@ -1001,11 +1028,8 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
-	/*
-	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
-	 */
-	dmi_check_system(dsdt_dmi_table);
+	/* Check machine-specific quirks */
+	dmi_check_system(acpi_quirks_dmi_table);
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
