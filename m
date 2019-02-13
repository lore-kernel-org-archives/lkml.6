Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C1C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA4220835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083629;
	bh=b6o6rB+lLbYQP5kR1RPM/B4UgDtpAPu/6kfEFg1Jcb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMz8EgJ7bTr6NihJ8pzyppUIfuthrQwIl2ISZK0cgT7HJpwTY5g6ADwftMn18dbFn
	 MRKiHGK0W05tKa8rJgL6KwgxVqbC91en+7O2TonUuKeLjwYW/N6hMxwo2xBmqC10++
	 EUZycYfWSqHDZAulxre+HtUO1XC0huw9psdaYE6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406610AbfBMSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404165AbfBMSrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:47:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FE2222D1;
        Wed, 13 Feb 2019 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083625;
        bh=b6o6rB+lLbYQP5kR1RPM/B4UgDtpAPu/6kfEFg1Jcb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yk1/yHmWlZ1zWz8S6FN2XgeWUYc8EkiMYTWPy6xLsx250/O2rwkuS/fnAM24OPiXp
         /PxTXXknR2XvsTrfDAt7jJXQlHEhHoAX8fH5vYX9b9aOdAp+Bc0lEk8oQtxpMlGPRM
         qVjUMncUeI50bltxwbjkC5mZTY0iEH5TtJzYsUAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.20 20/50] pinctrl: cherryview: fix Strago DMI workaround
Date:   Wed, 13 Feb 2019 19:38:25 +0100
Message-Id: <20190213183657.405950163@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit e3f72b749da2bf63bed7409e416f160418d475b6 upstream.

Well, hopefully 3rd time is a charm. We tried making that check
DMI_BIOS_VERSION and DMI_BOARD_VERSION, but the real one is
DMI_PRODUCT_VERSION.

Fixes: 86c5dd6860a6 ("pinctrl: cherryview: limit Strago DMI workarounds to version 1.0")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1631930
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/intel/pinctrl-cherryview.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1507,7 +1507,7 @@ static const struct dmi_system_id chv_no
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1515,7 +1515,7 @@ static const struct dmi_system_id chv_no
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1523,7 +1523,7 @@ static const struct dmi_system_id chv_no
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1531,7 +1531,7 @@ static const struct dmi_system_id chv_no
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
 	},
 	{}


