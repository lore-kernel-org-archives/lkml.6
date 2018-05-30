Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeE3LiS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60758 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752177AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Hans de Goede" <hdegoede@redhat.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.94286340@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 133/153] libata: Make Crucial BX100 500GB LPM quirk
 apply to all firmware versions
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 3bf7b5d6d017c27e0d3b160aafb35a8e7cfeda1f upstream.

Commit b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB
drive"), introduced a ATA_HORKAGE_NOLPM quirk for Crucial BX100 500GB SSDs
but limited this to the MU02 firmware version, according to:
http://www.crucial.com/usa/en/support-ssd-firmware

MU02 is the last version, so there are no newer possibly fixed versions
and if the MU02 version has broken LPM then the MU01 almost certainly
also has broken LPM, so this commit changes the quirk to apply to all
firmware versions.

Fixes: b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB...")
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4156,7 +4156,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NOLPM, },
