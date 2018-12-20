Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E788C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2420656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298060;
	bh=LvBOPeFHmILXU0oyv8FsG2Tt6sjDLJvbpLokZ+Kv4F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIX8wsDJFP456YO0l0aoRB54tX/8nqXdNJMqKW+wz/3oyw3ivfyFDARcK/aiPDtO2
	 2Ngq+7P4WBXuwOqKqipaPMm/y0/si/3UeBx2CyZ5tBsyoz7JC00VdraE8hh6sgBj7y
	 +3XscWUBV7oXuKc1BGqlWl88L3xiT2ZSG/zkjGtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeLTJ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732338AbeLTJ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:27:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379262177E;
        Thu, 20 Dec 2018 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298053;
        bh=LvBOPeFHmILXU0oyv8FsG2Tt6sjDLJvbpLokZ+Kv4F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RME39Of+7KrSMNds9VLMkJDfu6HTV4AbwNHhkLuXGH+pzbUiqSwp0cG3gD0CxG+Ot
         JqlLhAxJmGXKK85rKsYFK7c83WkxtV+vFLmMoWlfNGSSrI20OZSETEYT1UUs2ZvdI/
         srbKb1l3vGWdafDEUwZDiKMQSiyZE3otZ2ri2D3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitesh Debnath <niteshkd1999@gmail.com>,
        Teika Kazura <teika@gmx.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 54/72] Input: synaptics - enable SMBus for HP 15-ay000
Date:   Thu, 20 Dec 2018 10:18:53 +0100
Message-Id: <20181220085924.469367434@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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



