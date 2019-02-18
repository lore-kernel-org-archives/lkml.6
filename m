Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8396A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498163;
	bh=BDUp3h9X9QnP/JdpTz5lamfYoibm3yiEYPsJRDhRs5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqhhUJdjRgVP1LM+dceA6tFdkFplRj+AscMYAHldacbRCWJHV52qfAHX2Bp/XISuK
	 Z8WQJco8wKk2sOAqxTF7c5l7OLwRAcA8FoCfXJAd4sv/iSblojPDoFvq9dgSBc00O8
	 CYrp2F7G9L+gBz18j9X43Uh4ZY6Fx7CF2L+mxjmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfBRN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733074AbfBRNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F4921902;
        Mon, 18 Feb 2019 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498158;
        bh=BDUp3h9X9QnP/JdpTz5lamfYoibm3yiEYPsJRDhRs5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmVCLN/5OOiRkTfT6YvuQCpRmZj795Q4/Lov2a33SfSrLJz39b9DtSpZQX5Dyo+na
         N7cLwW5xwPAqUz3DW5TU8p1WgEv20lvNBTjRvoaGdnpnn0VWyIhrl/OKFLANNAJ1JU
         QvFM7vrE6VFpTRgwIJqyku9j/xyDy1LOCXQlgiW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mauro Ciancio <mauro@acadeu.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 41/62] Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK
Date:   Mon, 18 Feb 2019 14:43:47 +0100
Message-Id: <20190218133509.406946694@linuxfoundation.org>
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
@@ -1261,6 +1261,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },


