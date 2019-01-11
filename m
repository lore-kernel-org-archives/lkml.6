Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DB62133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217458;
	bh=4FoINgJJCkQSNnCNToub5MKyeNVC7qtBJQXsSzqpN9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KAR4CFcVjSb8SY1hBQkYzziP58vSN+SO/uVL3xbGWQYbZ11Ln1vuO1RKqMYOEwPrz
	 gcPAxxTmKH0/SJme8Nj8iSeRYx6ZTjJNg5bizZCXvu3eora4q3ph0Iw7dB6XmSBkWk
	 jQfcLsqQSP0lBf0514MfK4pMpYRZi4/b6ijg4PSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfAKOhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389761AbfAKOh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CA6204EC;
        Fri, 11 Jan 2019 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217445;
        bh=4FoINgJJCkQSNnCNToub5MKyeNVC7qtBJQXsSzqpN9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aJ2wuTRuq9xBeQ15O/rQ6C2NAiKYW/r3Ir6flM4CWAf/1lolpiFXJCvYYwd0zer4
         VkDLDF6PV9cyVvLNCebBOGPzbytVMNAh+0xq2y2cLv2rI1njlDBANyIisryCoNrTcb
         +2qhnHzlBFQYi2uJMifzyOkFSu2AraBCBvlS4Y0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yussuf Khalil <dev@pp3345.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/148] Input: synaptics - enable RMI on ThinkPad T560
Date:   Fri, 11 Jan 2019 15:13:23 +0100
Message-Id: <20190111131115.316639908@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit ca5047286c9c93a01e1f471d00a6019536992954 ]

Before commit 7fd6d98b89f3 ("i2c: i801: Allow ACPI AML access I/O
ports not reserved for SMBus"), enabling RMI on the T560 would cause
the touchpad to stop working after resuming from suspend. Now that
this issue is fixed, RMI can be enabled safely and works fine.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Yussuf Khalil <dev@pp3345.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2bd5bb11c8ba..7bdf8fc2c3b5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -171,6 +171,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN005b", /* P50 */
+	"LEN005e", /* T560 */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
-- 
2.19.1



