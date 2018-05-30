Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeE3Ldf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:33:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60879 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751750AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Tejun Heo" <tj@kernel.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.498932115@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 102/153] libata: disable LPM for Crucial BX100 SSD
 500GB drive
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit b17e5729a630d8326a48ec34ef02e6b4464a6aef upstream.

After Laptop Mode Tools starts to use min_power for LPM, a user found
out Crucial BX100 SSD can't get mounted.

Crucial BX100 SSD 500GB drive don't work well with min_power. This also
happens to med_power_with_dipm.

So let's disable LPM for Crucial BX100 SSD 500GB drive.

BugLink: https://bugs.launchpad.net/bugs/1726930
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4155,6 +4155,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NOLPM, },
 
