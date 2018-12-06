Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F0C67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BEA20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108026;
	bh=+9tHsPEN2WAkMfMoMrOCCBvyFDvoTJBn9pCRIhoMQu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUJ1cH8Ba0oAI5QDxoE6QphShzIkR5KP831CcNL8iECL85uq60ZZhNj5fgGvQDqoD
	 oIhnXdn8ItpEZ7ZcmTALeJVh9ItjLBKcib5u/1Yi0G2B9ZVPMrqRmnwlNOA0SEeOo5
	 YtUf10L/RNTAOz2H5fsr4hgWBEDgcXUp7ttsBfO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BEA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeLFOpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbeLFOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE3920661;
        Thu,  6 Dec 2018 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107510;
        bh=+9tHsPEN2WAkMfMoMrOCCBvyFDvoTJBn9pCRIhoMQu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6NFUQaSbYpeUkWiwLbLxI+pr8Zwwjcgblky5DFTU37hTUsNOe/vkXRBM5t2x2pcx
         N4NkjjQy/fM63UcdNEvNkjpL+TzIq0GpjzEEdJ8eB+yhOXMvaJUYs4cLif7MKw0udE
         u6Ttj8GQ8EirxQRJ1jfQOZZ9le7zejRV9bPI8Qmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Wong <adam@adamwong.me>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 032/101] Input: elan_i2c - add support for ELAN0621 touchpad
Date:   Thu,  6 Dec 2018 15:38:31 +0100
Message-Id: <20181206143013.397759039@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Wong <adam@adamwong.me>

commit bf87ade0dd7f8cf19dac4d3161d5e86abe0c062b upstream.

Added the ability to detect the ELAN0621 touchpad found in some Lenovo
laptops.

Signed-off-by: Adam Wong <adam@adamwong.me>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1255,6 +1255,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
 	{ "ELAN0620", 0 },
+	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }


