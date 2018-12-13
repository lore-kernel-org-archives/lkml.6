Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2F420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676194;
	bh=1Pjd7n0fUGFHSpwILx3e1IjELNF5v/LyjciW7+Ykz7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EXio4QuwgeNy8bPOtWVOXG+MuaaHlrPWpM90cKUVDdxFQ2mL6+XXzkwYh1rfx6JTg
	 7LTCqzkyTgOYP+MZDuVs6/anJJrwjTjjZPZI2tOdfGKP9lztaEDspEgLz9ui6BkSy2
	 7mnKtIWAuzadK9RDz4IRaQfhxbmw8Lx9CqTr15+s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeLMEbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbeLMEb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A8E20873;
        Thu, 13 Dec 2018 04:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675487;
        bh=1Pjd7n0fUGFHSpwILx3e1IjELNF5v/LyjciW7+Ykz7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gaKMiXZ3ptDrGCZ/bw/3Is0RU6dyTviX6KnlS8IEdouN+W2cb1vQG8js76s+XOzvp
         jRZosTP8p5RUXRxBdXxIADjw4ATlS3+JCDyJZQxXDvD3TRHj/ddOjzqaQsVOCAvWrn
         o66SXwMH/cRUxd8CB5p+Xsot9KgMjlqe7Lzrd8Pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Teika Kazura <teika@gmx.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/41] Input: synaptics - enable SMBus for HP 15-ay000
Date:   Wed, 12 Dec 2018 23:30:33 -0500
Message-Id: <20181213043054.75891-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teika Kazura <teika@gmx.com>

[ Upstream commit 5a6dab15f7a79817cab4af612ddd99eda793fce6 ]

SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000
series,

This device has been reported in these messages in the "linux-input"
mailing list:
* https://marc.info/?l=linux-input&m=152016683003369&w=2
* https://www.spinics.net/lists/linux-input/msg52525.html

Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
Reported-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 65c9095eb517..54f0d037b5b6 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -178,6 +178,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3221", /* HP 15-ay000 */
 	NULL
 };
 
-- 
2.19.1

