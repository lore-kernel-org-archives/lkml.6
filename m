Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB988C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A522083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5VYGb8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A522083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeJAKaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:30:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54210 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeJAKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:30:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so7210387wme.3;
        Sun, 30 Sep 2018 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh1LwaZnIS3FN2zpyzeew4yGTLDa7wxq/RUNH/zcvp4=;
        b=o5VYGb8MzEZaIU2z3oZC6JBJONgS/81BjQ7w7xizzIMYEbWOujSXHPVgCvo3BDSshH
         aVvOxbhRey2ozACY+o7qW2CEEmKBlgq3nI279Xd17Di4BKpe+ItNwIHkug8ab5rEdHlM
         3RcA8vA9KEASuOQFEJjK5C6yYdXukuoFDRd1hbN1/zG4Gyij29JIyPMuNbIoONNht1uT
         dnRBoXfrFoMkCtCEprBECbo5+uw4HCxONWFKafBzHzXGf8X5PKLyq7e+YGgWyAw8Qd74
         J9P2gBXVrDnGZ9EZ5/rZsNwDDTTSPnhicvz3jLRQwBjRxhH03S9QnyC3wHN8nROEX2PR
         sY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh1LwaZnIS3FN2zpyzeew4yGTLDa7wxq/RUNH/zcvp4=;
        b=CbEPxHT56t+2CGg1zlfpd/dGP1ymQY6hDr/GWgDzw20PzIXNgbwbbXeIeHA7BNvOgc
         xr75BRKU7AQAWEItXQ1l/PgQCdNfbYsy3mGBuqsLzQHhPqvh2K2uPuMzMEw1PRwT8B+v
         bCHiMIqPCRmkf9inLPldlnoXgZuNxj6LwsUZMw/upJG6qMCaa5b1k92EofVBl1uYXBKV
         fiXmdUBHOT5ajKFKBM66COBHGt4Bt5E8x95VriC0YalJ8ryMSNnocKoy7iOiwQbsg5jB
         K5ztbcydmI7Tz4Zc3DlNibLyPqWPEYa3k0szaoIva4MLvqXxAGG/+9CcOlFQpAJcUMr3
         XRIg==
X-Gm-Message-State: ABuFfojgLGmmA1/HM9ptVJOz53qN41Zwk+Of0X84wpWSK6bm4yG8ti/p
        PPJ9l1yms1J7asAbbgX0cWE=
X-Google-Smtp-Source: ACcGV63y0XCDupU6x3FsmcclClQVG2KkAyUT2IqynJv/9OJYSfInPwEAHbqhkBVaDWKbiJIRj40DEQ==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr7869197wmc.80.1538366065265;
        Sun, 30 Sep 2018 20:54:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d16-v6sm7580803wru.88.2018.09.30.20.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 20:54:24 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cxgb4: Use proper enum in cxgb4_dcb_handle_fw_update
Date:   Sun, 30 Sep 2018 20:51:43 -0700
Message-Id: <20181001035143.30670-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:303:7: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                         ? CXGB4_DCB_STATE_FW_ALLSYNCED
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:304:7: warning: implicit
conversion from enumeration type 'enum cxgb4_dcb_state' to different
enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
                         : CXGB4_DCB_STATE_FW_INCOMPLETE);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

Use the equivalent value of the expected type to silence Clang while
resulting in no functional change.

CXGB4_DCB_STATE_FW_INCOMPLETE = CXGB4_DCB_INPUT_FW_INCOMPLETE = 2
CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
index 6ba3104ff7eb..9bd5f755a0e0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
@@ -300,8 +300,8 @@ void cxgb4_dcb_handle_fw_update(struct adapter *adap,
 		enum cxgb4_dcb_state_input input =
 			((pcmd->u.dcb.control.all_syncd_pkd &
 			  FW_PORT_CMD_ALL_SYNCD_F)
-			 ? CXGB4_DCB_STATE_FW_ALLSYNCED
-			 : CXGB4_DCB_STATE_FW_INCOMPLETE);
+			 ? CXGB4_DCB_INPUT_FW_ALLSYNCED
+			 : CXGB4_DCB_INPUT_FW_INCOMPLETE);
 
 		if (dcb->dcb_version != FW_PORT_DCB_VER_UNKNOWN) {
 			dcb_running_version = FW_PORT_CMD_DCB_VERSION_G(
-- 
2.19.0

