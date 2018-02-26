Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeBZOLK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:11:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:36338 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753312AbeBZOKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:10:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="207119174"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 04/18] thunderbolt: Do not overwrite error code when domain adding fails
Date: Mon, 26 Feb 2018 17:10:34 +0300
Message-Id: <20180226141048.83949-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226141048.83949-1-mika.westerberg@linux.intel.com>
References: <20180226141048.83949-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Thunderbolt domain adding fails for some reason we currently
always return -EIO instead of the real error code. To make debugging
easier return the actual error code instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/nhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 80c33c7404f5..9e58d09f6029 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1036,7 +1036,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		 */
 		tb_domain_put(tb);
 		nhi_shutdown(nhi);
-		return -EIO;
+		return res;
 	}
 	pci_set_drvdata(pdev, tb);
 
-- 
2.16.1
