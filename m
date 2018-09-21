Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC78ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA5F21536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohWryXSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA5F21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeIUGNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:13:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40268 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:13:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207-v6so1292430wme.5;
        Thu, 20 Sep 2018 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c3311Hck8hRg6nWnDQH7QlcCgFYoXhs6RPf6F0rdeM=;
        b=ohWryXSh/ZIAN2BL5n2ktlh3Jc3Wv1lrVP7UG/O4NmZj30sKDA+ky3Lxyem2o6xHqF
         9c8mB2Bm0/NwE7hSwH2nLV020uA2Xkaf9eaHaueHMU5XIuZOwzxyKakuMASZFeByGdtt
         ZU1pWR4VpICGGfRS2X0qHdT0vkPmP4IPbmvVxXvGbM+zjI61ieWfmE0uJFkMkCEjKEsa
         W+DnPGO9Rd1CY1BGBYilH8zCbT0Xbbtdf7Q7/eesdoAceDC8sFOj4M1UGmWFHUkvhU5k
         7o+ZbAs/Tig9fS0MK8bTuvq/FXVmwXDL4GN/1Ww2crqHcGb98KLja+2In4b6bAu6BYiL
         UCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4c3311Hck8hRg6nWnDQH7QlcCgFYoXhs6RPf6F0rdeM=;
        b=rUSN8VdkS1bKqw/SiTDzucuS30Owj+tarxfO35H6h9k+wCcsksNOpKsNNzC1hR2yAm
         LvV2+0WdRpO8NzK1fhpWRxjTXdm9x9mCk1jFonYhuvgn2N8IQxXZowiiUairibxlGC4i
         WlgZHmdXwYEPvvnhgoZj74UHZlr7kX1dFBSQdu1srZV4gQgI65GfFKqZUerwcCeLWD4L
         MYZ3EgHvylWSqHvSL6Viqg3EjNXqto6JNd5i3UVuCJCGIK6UtdwIGgJ9pPngpD7ha12c
         GQYulucpRru15dqJMtDRWdLx5n4gUePN2NRvVZiw7A4g3yUc7sa05Cfd8EWBVy4VSDya
         K2Lg==
X-Gm-Message-State: APzg51D/yRxSVZ7aZwQtI5fHUIWMi5NPedM4fW5h8WeU3n/Z2sL8otov
        EAxJQdi7JvnEI5mddU+ayoo=
X-Google-Smtp-Source: ANB0VdbSnNlAABW5rit1x05ISaRl2xpxKgOBoaKRrfR4Vr7GNKcwgkksvRINHNXFbSZ/cmmdObeIsw==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr5019408wmr.75.1537489650403;
        Thu, 20 Sep 2018 17:27:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e10-v6sm5480752wrw.17.2018.09.20.17.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:27:29 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Simplify conditional check
Date:   Thu, 20 Sep 2018 17:27:23 -0700
Message-Id: <20180921002723.16600-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang generates a warning when it sees a logical not followed by a
conditional operator like ==, >, or < because it thinks that the logical
not should be applied to the whole statement:

drivers/scsi/qla2xxx/qla_nx.c:3702:7: warning: logical not is only
applied to the left hand side of this comparison
[-Wlogical-not-parentheses]
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses after the
'!' to evaluate the comparison first
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
                     (
drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses around left
hand side expression to silence this warning
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
                    (
1 warning generated.

It assumes the author might have made a mistake in their logic:

if (!a == b) -> if (!(a == b))

Sometimes that is the case; other times, it's just a super convoluted
way of saying 'if (a)' when b = 0:

if (!1 == 0) -> if (0 == 0) -> if (true)

Alternatively:

if (!1 == 0) -> if (!!1) -> if (1)

Simplify this comparison so that Clang doesn't complain.

Link: https://github.com/ClangBuiltLinux/linux/issues/80
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/qla2xxx/qla_nx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index de2bc78449e7..121e18b3b9f8 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -3699,8 +3699,8 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		/* Wait for pending cmds (physical and virtual) to complete */
-		if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
-		    WAIT_HOST) == QLA_SUCCESS) {
+		if (qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
+		    WAIT_HOST)) {
 			ql_dbg(ql_dbg_init, vha, 0x00b3,
 			    "Done wait for "
 			    "pending commands.\n");
-- 
2.19.0

