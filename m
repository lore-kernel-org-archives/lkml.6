Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32970208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32970208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbeGJSgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389729AbeGJSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE25EE78;
        Tue, 10 Jul 2018 18:35:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 05/56] ACPICA: Drop leading newlines from error messages
Date:   Tue, 10 Jul 2018 20:24:47 +0200
Message-Id: <20180710182503.762631262@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit a0d5f3b69af7733f3173a8e19d51f68a08017c76 upstream.

Commit 5088814a6e93 (ACPICA: AML parser: attempt to continue loading
table after error) unintentionally added leading newlines to error
messages emitted by ACPICA which caused unexpected things to be
printed to the kernel log.  Drop these newlines (which effectively
reverts the part of commit 5088814a6e93 adding them).

Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table after error)
Reported-by: Toralf Förster <toralf.foerster@gmx.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/uterror.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -182,19 +182,19 @@ acpi_ut_prefixed_namespace_error(const c
 	switch (lookup_status) {
 	case AE_ALREADY_EXISTS:
 
-		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
+		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
 		message = "Failure creating";
 		break;
 
 	case AE_NOT_FOUND:
 
-		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
+		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
 		message = "Could not resolve";
 		break;
 
 	default:
 
-		acpi_os_printf("\n" ACPI_MSG_ERROR);
+		acpi_os_printf(ACPI_MSG_ERROR);
 		message = "Failure resolving";
 		break;
 	}


