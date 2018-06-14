Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BB1E6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724D4208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwyAmLIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724D4208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936267AbeFNOwh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964839AbeFNOGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EDF8208CB;
        Thu, 14 Jun 2018 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985201;
        bh=2r8QGWNFBYENsvndDZeMlNAXTdhnJE6jPk+BXM9WE5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwyAmLIugZ6IUYcSAl1KALWiq67UowZQes6Asbhb3rxwJ1c7Hkg4g2oP0wxo07BTe
         OxKyfs/lFCCSo5VHDdAhpwQHoSfvwYf8+zCZ6+r3+XOJaTsFgpD9YZ+OiPNq1oyH59
         QD0vYhRjGoHDvXa+wsPLs1D0l4oU1SIYsgkLbFQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Wienke <languitar@semipol.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.17 35/45] Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID
Date:   Thu, 14 Jun 2018 16:04:26 +0200
Message-Id: <20180614132128.749131586@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Wienke <languitar@semipol.de>

commit e6e7e9cd8eed0e18217c899843bffbe8c7dae564 upstream.

Add ELAN0612 to the list of supported touchpads; this ID is used in Lenovo
v330 14IKB devices.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199253
Signed-off-by: Johannes Wienke <languitar@semipol.de>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1262,6 +1262,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
+	{ "ELAN0612", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };


