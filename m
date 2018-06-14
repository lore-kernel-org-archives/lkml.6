Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3969BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB5208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh8hySMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CB5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966286AbeFNONj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966249AbeFNONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C506208DA;
        Thu, 14 Jun 2018 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985611;
        bh=ELPhhzM6U9onf/QJnfYNu+SVLrOAssKGFSrrmZGhMuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kh8hySMNV/RhhoHK/m1Z9ONpgpmfgBIQOAwf8etxcUeNBS4GGdbg0NZ/M62bubyPe
         uIywNAgKjbtVP3d/tn5kngcEtUOdOmqpYbGasiJ2DgkhdF6MArRsN/aG8yLm9olbxw
         72Uunby5nGfGt7HsIvkzYRRAulAmlxVldqws2LaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Lee <flibitijibibo@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 22/24] Input: goodix - add new ACPI id for GPD Win 2 touch screen
Date:   Thu, 14 Jun 2018 16:05:17 +0200
Message-Id: <20180614132725.417192072@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Lee <flibitijibibo@gmail.com>

commit 5ca4d1ae9bad0f59bd6f851c39b19f5366953666 upstream.

GPD Win 2 Website: http://www.gpd.hk/gpdwin2.asp

Tested on a unit from the first production run sent to Indiegogo backers

Signed-off-by: Ethan Lee <flibitijibibo@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/goodix.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -425,6 +425,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
+	{ "GDIX1002", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);


