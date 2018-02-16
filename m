Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeBPI2L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:28:11 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41963 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeBPI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:27:01 -0500
X-Google-Smtp-Source: AH8x224F40VScN28E9mq/epeOqM/9iDHRzPqHVRHjtkzpedDdwvgE+OVp0MlDy8fNNXBC07CbboScg==
From: Carlo Caione <carlo@caione.org>
To: linux@endlessm.com, hdegoede@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, sre@kernel.org, wens@csie.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH v2 3/3] power: supply: axp288_fuel_gauge: Do not register FG on ECS EF20EA
Date: Fri, 16 Feb 2018 08:26:16 +0000
Message-Id: <20180216082616.25084-4-carlo@caione.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180216082616.25084-1-carlo@caione.org>
References: <20180216082616.25084-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

The ECS EF20EA laptop ships an AXP288 but it is actually using a
different, separate FG chip for AC and battery monitoring. On this
laptop we need to keep using the regular ACPI driver and disable the
AXP288 FG to avoid reporting two batteries to userspace.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 4cc6e038dfdd..903891a9bcf0 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -708,6 +708,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
+	{
+		/* ECS EF20EA */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{}
 };
 
-- 
2.14.1
