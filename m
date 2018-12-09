Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD7C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A4D20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A4D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeLIWL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37690 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbeLIWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002im-RD; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003JZ-8n; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dong Aisheng" <aisheng.dong@nxp.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.777812728@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 085/328] pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b4859f3edb47825f62d1b2efdd75fe7945996f49 upstream.

The > should really be >= here.  It's harmless because
pinctrl_generic_get_group() will return a NULL if group is invalid.

Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -388,7 +388,7 @@ static void imx_pinconf_group_dbg_show(s
 	const char *name;
 	int i, ret;
 
-	if (group > info->ngroups)
+	if (group >= info->ngroups)
 		return;
 
 	seq_printf(s, "\n");

