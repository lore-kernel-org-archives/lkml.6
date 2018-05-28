Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeE1QD7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965967AbeE1KPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH 4.4 008/268] libata: Blacklist some Sandisk SSDs for NCQ
Date: Mon, 28 May 2018 11:59:42 +0200
Message-Id: <20180528100203.075107115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 322579dcc865b94b47345ad1b6002ad167f85405 upstream.

Sandisk SSDs SD7SN6S256G and SD8SN8U256G are regularly locking up
regularly under sustained moderate load with NCQ enabled.  Blacklist
for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4187,6 +4187,10 @@ static const struct ata_blacklist_entry
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
 
+	/* Some Sandisk SSDs lock up hard with NCQ enabled.  Reported on
+	   SD7SN6S256G and SD8SN8U256G */
+	{ "SanDisk SD[78]SN*G",	NULL,		ATA_HORKAGE_NONCQ, },
+
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
