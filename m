Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72749C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72D20685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="A8pKSbx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNml2iEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeKDDAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:00:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50845 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbeKDDAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:00:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AAE2A21CDD;
        Sat,  3 Nov 2018 13:48:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 03 Nov 2018 13:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id; s=fm1; bh=ffWZP/NcpTDES4g6V2
        GUUEJfX+JXRzFSdfpwoUZ8s2M=; b=A8pKSbx0/hQbbEONdP7ZODqO0P16LMoz+t
        Qj+geJaWrM6rKV3aLbklvKgyF/Cb1Z1ugeaEFSTCYQ7NBLEe7lN93DUX0qaos+Tk
        MzGFw7BnY4VffVteLCa5LSvQXbVwHBd6n9rKHdidxtVajLCzgrIVinNZmNcUgVUM
        TfhT8dyO6YXyM+u1r4QV+Nl9ysCph1yzd4KgRUMaHbu8F5Iaa00hb+0SkLxJIksn
        rZ9vH08bn0Mu+P49L7SNFLmQBDfqb6uRLwEuRIk1QF0PFZp8MTHu0oP1wFamSARS
        vk3gA6DlaIqsiWcC6evDYwRrdankrIGNTbweL1bEwIY4SHWSh1eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ffWZP/NcpTDES4g6V2GUUEJfX+JXRzFSdfpwoUZ8s2M=; b=xNml2iEj
        c3S/Pd9J0NcypcOSwzZT4YEiSDbXHZLRm2NkyH5VRhWiM2oNcpSr5Hc1aU+Qp49c
        wrc06yx085b+XKiXD+qWNKLY9GkW9n3rI2TzLqP3DTmUoO6er+TJmiEw7UkzYGe9
        uV3zeTYBvuDUMsmYRZiMG/x9TSkuNUVyRsLpXCYShDC1DdGlVZ/+9Gk1MmmagVii
        XMNE1u4xl+7uqaaJRVs4oAnNy4wMrb3eGexQa2SxcInFEwqYb+4jWHvVTkz9galx
        5OGD1aSyLBLFgVgyx056+/aYqFmkOzKmwn5hoxOZfwcyfTYYdWmX0Fae4l72xZIV
        OvW7zl91/ofULg==
X-ME-Sender: <xms:cd_dWwtvrMphasrt5YyiWFOvSGjDMRxnKYlczrVOlbFL5tMD2ulhuQ>
X-ME-Proxy: <xmx:cd_dW4RRCojCU6v1KvUXsdJZ7yrjr5pcuTHx54JuHthg8W18ffXV_Q>
    <xmx:cd_dWwwzaCjHJtKEIWVADZfedOEv47rEx43lMgLB-R5XoKQl5-mJjA>
    <xmx:cd_dW004-1tkNhTvRqTlWzkCs6GGDsm4WjY_0mDUkC8fphhYkVC3-Q>
    <xmx:cd_dW9s5mvb5nPe2zlZgKy3rOZIRMIFzTIySV_zRVU2f2tY17US0GQ>
    <xmx:cd_dWxJxIxDag7XUvJVb-NrVXDqUJxYBbs8uIKTSvjZetN-gybvN5A>
    <xmx:cd_dWyI6WlFkmGtSWdBA8ebkjL9C2TFMczGyzzhLj9sB7lQzjwX3ew>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A462E4408;
        Sat,  3 Nov 2018 13:48:32 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Samuel Holland <samuel@sholland.org>,
        Mike Frysinger <vapier@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] vt: Fix screen updates after CSI K sequences
Date:   Sat,  3 Nov 2018 12:48:31 -0500
Message-Id: <20181103174831.1666-1-samuel@sholland.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In d8ae72427187, start was changed to point to the character under the
cursor, instead of the beginning of the cleared area. The offset was
correctly applied when clearing the backing buffer, but not when
updating the framebuffer region. Fix this by having start point once
again to the beginning of the cleared area.

Cc: stable@vger.kernel.org
Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/tty/vt/vt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b0b89d..be7bc83d6c41 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1528,7 +1528,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 static void csi_K(struct vc_data *vc, int vpar)
 {
 	unsigned int count;
-	unsigned short *start = (unsigned short *)vc->vc_pos;
+	unsigned short *start;
 	int offset;
 
 	switch (vpar) {
@@ -1548,7 +1548,8 @@ static void csi_K(struct vc_data *vc, int vpar)
 			return;
 	}
 	vc_uniscr_clear_line(vc, vc->vc_x + offset, count);
-	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
+	start = (unsigned short *)vc->vc_pos + offset;
+	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
 		do_update_region(vc, (unsigned long) start, count);
-- 
2.18.1

