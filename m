Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeFANhW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:37:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49327 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeFANhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:37:19 -0400
From: Colin King <colin.king@canonical.com>
To: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (k10temp) Make function get_raw_temp static
Date: Fri,  1 Jun 2018 14:37:13 +0100
Message-Id: <20180601133713.8817-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function get_raw_temp is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
drivers/hwmon/k10temp.c:149:14: warning: symbol 'get_raw_temp' was not
declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/k10temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index d3fae5a8e508..17c6460ae351 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -146,7 +146,7 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-unsigned int get_raw_temp(struct k10temp_data *data)
+static unsigned int get_raw_temp(struct k10temp_data *data)
 {
 	unsigned int temp;
 	u32 regval;
-- 
2.17.0
