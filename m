Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F36214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864366;
	bh=WGSSYCz1v60BLcb6HB2fncD5oZqBX8Uw6TPhNCs8NuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yDCSWYbVpWCadpRR9RwV6h/SmxYRTUeBLwgeCbPbLwk6I9ZcVrFma/V8ilLpwK2K2
	 Qr+FW0wn9deZhVz569Yr3wYbNLItkdBUfYRZ5PfmPzEzAZC3qpYOBSGI2aY/qGcZW6
	 qvCilphEmTuGRGuPs2N2ZJQcPaMx+nJ6Yl2SreVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeLZWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeLZWkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923742054F;
        Wed, 26 Dec 2018 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864019;
        bh=WGSSYCz1v60BLcb6HB2fncD5oZqBX8Uw6TPhNCs8NuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyJwAfyqTQ6s8HMjHHb1BqgR1KJZXW9j+0t1s0jnm4VZ/5efmPlh1GyvL/iQEJ+7D
         OVjMlSUTE9aKucvGTa6M9v5xPKSrD/v0EzdCU2kIQ4NVqprbZfXKCNK34G+kZMpGyM
         MHqOUoot1Y0MPFO7ExPMyO6410CXYpOBB7kW7rBg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/59] Input: synaptics - enable RMI on ThinkPad T560
Date:   Wed, 26 Dec 2018 17:37:55 -0500
Message-Id: <20181226223839.150262-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yussuf Khalil <dev@pp3345.net>

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
index 54f0d037b5b6..515a0b0d48bf 100644
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

