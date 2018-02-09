Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBISIZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:08:25 -0500
Received: from gateway30.websitewelcome.com ([192.185.197.25]:31045 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752201AbeBISIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:08:23 -0500
Date: Fri, 9 Feb 2018 12:08:21 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ACPI: SPCR: Mark expected switch fall-through in
 acpi_parse_spcr
Message-ID: <20180209180821.GA20326@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ekD5y-000uzJ-BQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:35108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1465078
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 drivers/acpi/spcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 89e97d2..9d52743 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -115,6 +115,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 			table->serial_port.access_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+			/* fall through */
 		case 8:
 			iotype = "mmio";
 			break;
-- 
2.7.4
