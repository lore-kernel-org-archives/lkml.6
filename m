Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A5EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E244620989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543202;
	bh=dK6Cqx5cboeqyjb115aseFceGhOm4vpdG2ggZW6fmgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q8v9gbm7tS313tWcofJ+zSLlrZupfX6mLBd3puhuV3nAG/mRJCXHYRhRpKz5xxRNr
	 1tua9L74GJbPs9EXBelyPUIkD9kHqXYRTyc7tkdxStME3Jxfyh16e/m6kJm/4Uf1x6
	 /OifSW9xsSCRIYMmtYDfv80EA48AHBys0V3URXUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E244620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeLKPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbeLKPqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AA020870;
        Tue, 11 Dec 2018 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543196;
        bh=dK6Cqx5cboeqyjb115aseFceGhOm4vpdG2ggZW6fmgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5OkBJfJA0k9nK2xbOz0t4uOtTiwZG0B1FDcgw3QBB13U9n1NM/S1BiQt20LZwglE
         q0TdODhd8yoip3RUkxVvyfVvzE3Ko1BALE515f8y+pfpOwXNKE4+J1pEsTFxXQkJiG
         t3qqIZKbU12p/F1S54ImtBQ681GzYFd8x9OmQ+gI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noah Westervelt <nwestervelt@outlook.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 48/91] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR
Date:   Tue, 11 Dec 2018 16:41:07 +0100
Message-Id: <20181211151609.869818814@linuxfoundation.org>
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
@@ -1253,6 +1253,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN061E", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },


