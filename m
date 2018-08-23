Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD47C04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC012147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC012147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeHWMHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbeHWMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:21 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 358FCC74;
        Thu, 23 Aug 2018 08:38:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 198/217] ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems
Date:   Thu, 23 Aug 2018 09:55:11 +0200
Message-Id: <20180823075514.564213675@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Robin H. Johnson" <robbat2@gentoo.org>

[ Upstream commit 2c4d6baf1bc4f7729773ffcee9ba2a9781578633 ]

The ec_no_wakeup matcher added for Thinkpad X1 Carbon 6th gen systems
beyond matched only a single DMI model (20KGS3JF01), that didn't cover
my laptop (20KH002JUS). Change to match based on DMI product family to
cover all X1 6th gen systems.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2034,7 +2034,7 @@ static const struct dmi_system_id acpi_e
 		.ident = "Thinkpad X1 Carbon 6th",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20KGS3JF01"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
 		},
 	},
 	{ },


