Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E9020449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298426;
	bh=Si3/0D2pzCJRy1cth8oQaB+i8RiC2T74upRwreSMa48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHywiiiyO/I81ilyKivkQGeZz+/WaMoknlIDAOAC2MD7kt0Cn2KiRiyJu5PCb+3E/
	 h59GaNPSsUM9dQTHYfOUitVl9y2VZMutx6GqjU39Hv76zLRMJBnIKf37PYZIV9otfB
	 kWf9cU/ppPhyDT/3/MrZ5O5r5xInL5mNuUI095Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbeLTJaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732133AbeLTJaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035BB20656;
        Thu, 20 Dec 2018 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298207;
        bh=Si3/0D2pzCJRy1cth8oQaB+i8RiC2T74upRwreSMa48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vn6JovvB1kZdpDTb3ErfnjC94NPILfisr58JpXSY9Jdx0pS5qx0luZaA3FqFW6YVy
         xiaFA5aairLFQqAVtHbywotJfCpvryJz3Dv4L8gTU/J9yqnB33dBX88xhWP48LbaPo
         BQSZWrmF+10Yrd5fdwzgNNgtEiyRLAU9JYyAQngo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitesh Debnath <niteshkd1999@gmail.com>,
        Teika Kazura <teika@gmx.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/67] Input: synaptics - enable SMBus for HP 15-ay000
Date:   Thu, 20 Dec 2018 10:18:52 +0100
Message-Id: <20181220085905.125027029@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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
index c42813d50591..2bd5bb11c8ba 100644
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



