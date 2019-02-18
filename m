Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124362070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501063;
	bh=jnZBUdvBhZgz0hAETWtLQ9r/eQPSw2+RRuIFB1YrW3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RvLm8+XpdrgB2y+V3Cpt+//g6BNi+jv3gb6rgLCWoVFR0vtPkCN1Rt1Rbd/9MvbiA
	 S/M1hA8nFSpaUCOeAxJV37L3jcbfR0uXh4y3WGXmtxO343loB7pI4qsEmUQWTNcXrq
	 2X1LDnzsKTTLas1nuJw/OH3as0/bultDU148ySNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfBROoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbfBRNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409C221901;
        Mon, 18 Feb 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497707;
        bh=jnZBUdvBhZgz0hAETWtLQ9r/eQPSw2+RRuIFB1YrW3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJwL8eBYn/B7XTyioG0JOtFfQLcNqNGaXHJqVFN+SeT7HIUpbswRLikSXLTFREnzk
         92N6xqErWXvwt3Ggy+3nLfydWM9CUk3801KPQ+h1ukkmujOWXjP8pfzhQ8+eIOkVFf
         2f9Z5TOl2TwvWfXvl8nz4Xe1v6ji/TSkxbSkVuA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mauro Ciancio <mauro@acadeu.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.20 51/92] Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK
Date:   Mon, 18 Feb 2019 14:42:54 +0100
Message-Id: <20190218133459.490180126@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

From: Mauro Ciancio <mauro@acadeu.com>

commit 7ad222b3aed350adfc27ee7eec4587ffe55dfdce upstream.

This adds ELAN0617 to the ACPI table to support Elan touchpad found in
Lenovo V330-15ISK.

Signed-off-by: Mauro Ciancio <mauro@acadeu.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1345,6 +1345,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },


