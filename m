Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF4121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500401;
	bh=tuUJjp1rIEhPRTPWr0dJZMu7fj2lKEFO6hDe5O1Agt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzQb0+8cfuXwYU63Xu00mbyCpx9hHeFu/c5k/j/nzUceXkngT7wmAfJtSf05C2Xk0
	 dXxEWBne6iG2FmLTIW+gaKTS/a4rUIMrAB6f4/sRRt7yliTgj4cg0GqYnU/C9F5RKc
	 5bFv1YkdYkwbFQjR2MCrqiPjZXDckmP2Pwxfomes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbfBROdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388043AbfBRN5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20EF20842;
        Mon, 18 Feb 2019 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498229;
        bh=tuUJjp1rIEhPRTPWr0dJZMu7fj2lKEFO6hDe5O1Agt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqA60vqAmdJ6TKunVGeJNHxEDEy/h0+QZVA3+o+gvS+oAt55WlVNcDKeNdSv2ZQEi
         pXF7PtAKlmbLpOqqk9zS1cpSpsP7qDL51tVM23ZuGSo1V8DdB2cQer9ZF68UcT40LH
         sxDwEYfDHmYll/K+KRr+tWoY/wF7e1pwQPQptF/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matti Kurkela <Matti.Kurkela@iki.fi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 48/62] Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780
Date:   Mon, 18 Feb 2019 14:43:54 +0100
Message-Id: <20190218133509.933211574@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matti Kurkela <Matti.Kurkela@iki.fi>

commit e8b22d0a329f0fb5c7ef95406872d268f01ee3b1 upstream.

Like Fujitsu CELSIUS H760, the H780 also has a three-button Elantech
touchpad, but the driver needs to be told so to enable the middle touchpad
button.

The elantech_dmi_force_crc_enabled quirk was not necessary with the H780.

Also document the fw_version and caps values detected for both H760 and
H780 models.

Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elantech.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1121,6 +1121,8 @@ static int elantech_get_resolution_v4(st
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu CELSIUS H760    0x570f02        40, 14, 0c      3 hw buttons (**)
+ * Fujitsu CELSIUS H780    0x5d0f02        41, 16, 0d      3 hw buttons (**)
  * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E546   0x470f00        50, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
@@ -1173,6 +1175,13 @@ static const struct dmi_system_id elante
 			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H760"),
 		},
 	},
+	{
+		/* Fujitsu H780 also has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H780"),
+		},
+	},
 #endif
 	{ }
 };


