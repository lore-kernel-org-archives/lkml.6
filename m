Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA31C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ACA2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543198;
	bh=1GRBb6TU2Me5zjt598cY/S3W588XXOSPJhgR5L/Ezb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wntqySnehTY+zKnTpan7v0rFXWnJ8YbWjqTukpiBIN73qkQ0UweyqWyKzdlSqwUwX
	 u3if3wSMqh1v+TTAXy1LAPHIN+lgPIzZVVT/dQHV1BPZaLjvYp7+TM5R2Dn5XZrKvr
	 9b7hoxqC/YpOrZUsNdwGExpDFKKat+XT5dm4KedQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ACA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeLKPqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbeLKPqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997422087F;
        Tue, 11 Dec 2018 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543194;
        bh=1GRBb6TU2Me5zjt598cY/S3W588XXOSPJhgR5L/Ezb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2yHTiV83gtC3R2/iz9P83wqyzC7lQ/Pn5KcgIvxNMefk8F9OppkuiLM4pPGzNK8W
         k9z0/2z6htxIrAl9EeDGNwVwu4BXqtsQLh+12Z0Hv6aMdx89rNKxxbmwkCz8DMHqoT
         hWfRyKNY9CCWSIex8K/pJsH8lhsycjicnfL2GJzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Gaskin <patrick@pgaskin.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 47/91] Input: elan_i2c - add ELAN0620 to the ACPI table
Date:   Tue, 11 Dec 2018 16:41:06 +0100
Message-Id: <20181211151609.811096651@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Gaskin <patrick@pgaskin.net>

commit 3ed64da3b790be7c63601e8ca6341b7dff74a660 upstream.

Add ELAN0620 to the ACPI table to support the elan touchpad in
the Lenovo IdeaPad 130-15IKB.

Signed-off-by: Patrick Gaskin <patrick@pgaskin.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1253,6 +1253,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }


