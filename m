Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D10C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89F5214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107286;
	bh=hD2g+8V+caVLkUMqz/oevXEcRxRBfCBAmK1JmqZOMYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCSmlPlWFNvkBUuO2tXATciutxsQ+okuXtQ6I3U5qm+xF8fGyBgW3J0PSTXrngc3t
	 +4VXIXh7ri3AQV3btUhN4nStIRkPhrxNfSiUcdbK7ldqqZCcE6WkfhgUoOc/6fC0DS
	 XkXCHhp85xbdIYtk+8wMnI/1BPWGhIIdH0IEZ/cE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F5214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeLFOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbeLFOlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5E7214C1;
        Thu,  6 Dec 2018 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107280;
        bh=hD2g+8V+caVLkUMqz/oevXEcRxRBfCBAmK1JmqZOMYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+ySPTEAwYM/Cz1YQPUN8a8b/y1dCyaqFaBYiU6UebQSxElAF8oFS18tpZfWm2mQK
         sYWQEuf7UHivMIz7zALmDWHAXd400l37YHhmGdQtDyUyjSLSe93e2jothRH0aC98/G
         twnmOiftr0mu/ZUYP8+LSGNMzoMXQU8D7SMiRzA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noah Westervelt <nwestervelt@outlook.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 36/41] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR
Date:   Thu,  6 Dec 2018 15:39:16 +0100
Message-Id: <20181206142953.225807974@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Noah Westervelt <nwestervelt@outlook.com>

commit ad33429cd02565c28404bb16ae7a4c2bdfda6626 upstream.

Add ELAN061E to the ACPI table to support Elan touchpad found in Lenovo
IdeaPad 330-15ARR.

Signed-off-by: Noah Westervelt <nwestervelt@outlook.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN061E", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },


