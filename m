Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD27C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD72082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BD72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pp3345.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLHV40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:56:26 -0500
Received: from saul.pp3345.net ([163.172.111.124]:40226 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLHV40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 16:56:26 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2018 16:56:25 EST
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 375A99A0715;
        Sat,  8 Dec 2018 22:46:44 +0100 (CET)
From:   Yussuf Khalil <dev@pp3345.net>
To:     dmitry.torokhov@gmail.com
Cc:     benjamin.tissoires@redhat.com, teika@gmx.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH RESEND] Input: synaptics - enable RMI on ThinkPad T560
Date:   Sat,  8 Dec 2018 22:44:26 +0100
Message-Id: <20181208214426.6628-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 7fd6d98b89f3 ("i2c: i801: Allow ACPI AML access I/O
ports not reserved for SMBus"), enabling RMI on the T560 would cause
the touchpad to stop working after resuming from suspend. Now that
this issue is fixed, RMI can be enabled safely and works fine.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
Originally sent this patch in August. Resending because it has a 
merge conflict with v4.20-rc5.
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
2.19.2

