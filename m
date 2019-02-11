Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C23C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09121855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900073;
	bh=6dRenVydqK1sbvsRWpEJMof+y21YdYzuAphinzH/GdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITRbSOcuQJ2mP3Z6MJuhYHMNR9UPj2IoSqzVFf+y20GyjIGEC6h0zsUx6jMuPz7cN
	 wl09bf4Kf2WNTfd1HBeG+H5xfIZkSYMLWpr2OVJ8uO1rxsdevFAuB/383WutNWwQFX
	 vj1CswTO7BVBng3gOAt5Kg+Wddlh5T3+IAoTJDNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfBKPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbfBKOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FEC2081B;
        Mon, 11 Feb 2019 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896074;
        bh=6dRenVydqK1sbvsRWpEJMof+y21YdYzuAphinzH/GdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0Esa11OCX+v3LYpOkF/V2U6dQkbMQWm+jh4XAXgxWbofRaI0wkbCafX3D6AqHrxq
         pSFN22GIKIEZr+xuaN3uyu0cfrwBe3Y+CP/VlcC8Q0q/1PKVi+2LSNjpUqs76ha2DD
         yA8MEC97QbpAEWQW06IqnO5IenZ7vabzwHc27feY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/313] ACPI: SPCR: Consider baud rate 0 as preconfigured state
Date:   Mon, 11 Feb 2019 15:15:45 +0100
Message-Id: <20190211141858.204121706@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b413b1abeb21b4a152c0bf8d1379efa30759b6e3 ]

Since SPCR 1.04 [1] the baud rate of 0 means a preconfigured state of UART.
Assume firmware or bootloader configures console correctly.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/spcr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 9d52743080a4..c336784d0bcb 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -148,6 +148,13 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	}
 
 	switch (table->baud_rate) {
+	case 0:
+		/*
+		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
+		 * Assume firmware or bootloader configures console correctly.
+		 */
+		baud_rate = 0;
+		break;
 	case 3:
 		baud_rate = 9600;
 		break;
@@ -196,6 +203,10 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		 * UART so don't attempt to change to the baud rate state
 		 * in the table because driver cannot calculate the dividers
 		 */
+		baud_rate = 0;
+	}
+
+	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
 	} else {
-- 
2.19.1



