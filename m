Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBWQc7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:32:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeBWQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:32:57 -0500
From: Colin King <colin.king@canonical.com>
To: "Rafael J . Wysock" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][ACPI-next] ACPI: battery: make function __battery_hook_unregister static
Date: Fri, 23 Feb 2018 16:32:55 +0000
Message-Id: <20180223163255.3899-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function __battery_hook_unregister is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/acpi/battery.c:654:6: warning: symbol '__battery_hook_unregister'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cfdef4c1d097..b4580b2e8706 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -651,7 +651,7 @@ static LIST_HEAD(acpi_battery_list);
 static LIST_HEAD(battery_hook_list);
 static DEFINE_MUTEX(hook_mutex);
 
-void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
+static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
 {
 	struct acpi_battery *battery;
 	/*
-- 
2.15.1
