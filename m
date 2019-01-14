Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94266C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EBF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx6/bCSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfANUkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:40:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfANUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:40:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so424476wrs.10;
        Mon, 14 Jan 2019 12:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiTzvOsBbU68HbKrMMBK2Tr5Tf5KHxDi+fruJqdMvPQ=;
        b=Cx6/bCSPuhYVbWZESsxZV8kFEinXq7if+votofKKWwX4b1qDQP1TpUResFvKXXLPJh
         Vr4HeOEI2gwxvcG7EsNn/OIRjiH4d4goIsdeQd2YKcJiqwlDfhtbBZIlFpeSmQw6+d3U
         xn3Cba6RNo0D5Ko4DzwL4kDlHvLwLrZQmH+W9yjgL3zSZnK7tkyygljy4JZR3nv4QHuI
         PV3RtydyNNoMsTIOpMoLOsCxaGUscXNz5wIbf9GXnPiWrJUfzwP90JZqB1mZxqwINmra
         0HSwuA9nNgEECiiCQx72SL4y4V1fpcvkdI7OjRU4hvt0DDIVR6OPnHCyJP3LS9jueYDm
         K/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yiTzvOsBbU68HbKrMMBK2Tr5Tf5KHxDi+fruJqdMvPQ=;
        b=ghz7RoBYfMPrttMSKHCFrsErqLpfL4EXygLBu/qPdyuBFuNDyq28A2xpM0VefUcxnA
         i2n/uQJg0VaSBc+FqLdiDyqn5opUel3H/pVDJufgRWUKCKohvzrdtrCSRph8FiFVxEso
         4FTCzZbKfN0h8Jc3TBwqLIpUQ5C3MSAjFH1VpTTHyMlyp+1XMETVEc43ZftJ2lZ07chM
         1uIHLgsIVHdHfKLmquzKYhUDjI0vZ14sFEvgDNOBEP/Wbqz33nHC3rvxPjvC6qv8BZSZ
         htJWotghJFn4HjNm4uNgYjzQtrRB4jZJmI6ph3b9/oiIjLKfhX8TJzM2M0tKYKXK7XWm
         Aemg==
X-Gm-Message-State: AJcUukc6lkeomShmeWurIrEKP/ZhTFKhYix0/xzOH1tam8JwrjusXxMC
        /We1UzWiamgAGUNa3HW4VvA=
X-Google-Smtp-Source: ALg8bN7Ufx1yqDYCv8+hnYZCJwneHtn+lNizrVxSBFRt/pcLoPIbpGcDn96f+oAuQzhbdJ8CFrCsKQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr202335wrq.265.1547498449523;
        Mon, 14 Jan 2019 12:40:49 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id c202sm37000661wmd.40.2019.01.14.12.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:40:48 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CBAEB11422AD; Mon, 14 Jan 2019 21:40:47 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: offb: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:40:44 +0100
Message-Id: <20190114204044.20528-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  drivers/video/fbdev/offb.c:211:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/video/fbdev/offb.c:142:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/video/fbdev/offb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..e0f0c5351306 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -141,6 +141,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
 		out_le32(par->cmap_adr + 0x58,
 			 in_le32(par->cmap_adr + 0x58) & ~0x20);
+		/* fall through */
 	case cmap_r128:
 		/* Set palette index & data */
 		out_8(par->cmap_adr + 0xb0, regno);
@@ -210,6 +211,7 @@ static int offb_blank(int blank, struct fb_info *info)
 				/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
 				out_le32(par->cmap_adr + 0x58,
 					 in_le32(par->cmap_adr + 0x58) & ~0x20);
+				/* fall through */
 			case cmap_r128:
 				/* Set palette index & data */
 				out_8(par->cmap_adr + 0xb0, i);
-- 
2.19.2

