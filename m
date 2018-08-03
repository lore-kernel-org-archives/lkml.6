Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41199C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE75E2156B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKvl+gzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE75E2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeHCB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43579 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so1550564edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/MfJ2rdQSxavPT5U7PRnuAXjcNhrA5GUIu42/MplpIM=;
        b=uKvl+gzXsJnBlFtW46aguT3FkvlrtpMEuw+FlnhuM7C3HItRi+9ceIEwyr/xZ38LaS
         AC6cJOgzJTAXKCqRylUsbHMvmccZG4kZ+6eSKCupgY8Qy9TQIVlzp5a2xyJRqyuNNQ99
         xMSa5t7P9p9xiGevaqfMFMjNob8fdfy6J5j+GUDxTOoXAouwel1PbV9w39BH5LzHnAec
         pQqH7i2yrdCTJKo6X1fA8zm4O4+CARwpup+moUjI7RaodBb8bsr0s9PB3tW1hE5n4tzD
         myR6kafl8mp/8oi3zhs5LaRS34Hfadn++I1r62/OXz6zA6npWWnDThX7rggLPaJNXIoH
         7HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/MfJ2rdQSxavPT5U7PRnuAXjcNhrA5GUIu42/MplpIM=;
        b=RaeIsk1GgWuziUeZYclQjPVGkRU8KugT6sdI83ZJjF9vv0mliOGM7Yo3SYSzwMZo2H
         aW+dkox1nMEKgP30ipffv7gFmJAndgd7U7VvzUgqesNx3VRoW6JJ/vC5diGTelOeIjbu
         qgjBnEOT3Q15h31//Wmqi5iAwd2HgZBecv89RVZVRSFdaQ2GLU3aWxeTcIH7C0LAHt3N
         Q7FmFEnt/BIcYfKiqGQTF//mKuOfNZAW1WO8Fr+oFQ/N94wmPT5Mpxc7GbUbu8rVLG01
         uBm5DJ6/doitwGuUqxJu8NsCt3oQLDH/jJmX0GhERKWUORHXLNRDV8xS/ucokOgzKIR7
         pQyw==
X-Gm-Message-State: AOUpUlEIsqcr+qXuensvhc90ONu28hQB2lDgGLeGrl6EUiXDneqm+cDe
        bJWS3GKHgLhTPw9aO0nONpCJHqM6
X-Google-Smtp-Source: AAOMgpcPSYGieK/l1hRbPqG7VeT7JXTxolmwb4GpUi4P7kI0FT7quAhdK3E6UkwVf2Ocfmn5UR5bHg==
X-Received: by 2002:aa7:c803:: with SMTP id a3-v6mr5195508edt.124.1533254578049;
        Thu, 02 Aug 2018 17:02:58 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/18] staging:rtl8192u: Refactor DCMD_TXCMD_T structure - Style
Date:   Fri,  3 Aug 2018 01:02:05 +0100
Message-Id: <20180803000211.10589-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure DCMD_TXCMD_T is declared with a typedef, which causes a
checkpatch issue with defining new types. As a result the typedef has
been removed.

The structure's name DCMD_TXCMD_T, as a type, is meant to be lowercase
so has been renamed to tx_config_cmd.

The structures three members, (Op, Length, and Value) are all violating
the coding standard policy on CamelCase naming, so have all been renamed.
They have been renamed with longer names, (cmd_op, cmd_length and
cmd_value), to make the variable names easier to search for in code.

The magic numbers '4' and '12' have both been replaced with sizeof()
calls, as they both represent the size of data elements.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 10 +++++-----
 drivers/staging/rtl8192u/r8192U_dm.h | 11 ++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 6f17732d038d..4c8f674cf54d 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -510,7 +510,7 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	bool						viviflag = false;
-	DCMD_TXCMD_T			tx_cmd;
+	struct tx_config_cmd			        tx_cmd;
 	u8						powerlevelOFDM24G;
 	int						i = 0, j = 0, k = 0;
 	u8						RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
@@ -532,10 +532,10 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 	RT_TRACE(COMP_POWER_TRACKING, "powerlevelOFDM24G = %x\n", powerlevelOFDM24G);
 
 	for (j = 0; j <= 30; j++) { /* fill tx_cmd */
-		tx_cmd.Op = TXCMD_SET_TX_PWR_TRACKING;
-		tx_cmd.Length = 4;
-		tx_cmd.Value = Value;
-		rtStatus = SendTxCommandPacket(dev, &tx_cmd, 12);
+		tx_cmd.cmd_op = TXCMD_SET_TX_PWR_TRACKING;
+		tx_cmd.cmd_length = sizeof(tx_cmd.cmd_op);
+		tx_cmd.cmd_value = Value;
+		rtStatus = SendTxCommandPacket(dev, &tx_cmd, sizeof(struct tx_config_cmd));
 		if (rtStatus == RT_STATUS_FAILURE)
 			RT_TRACE(COMP_POWER_TRACKING, "Set configuration with tx cmd queue fail!\n");
 		usleep_range(1000, 2000);
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 66dfcbbf6e43..9a0105412350 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -139,11 +139,12 @@ struct dynamic_rx_path_sel {
 	long		cck_pwdb_sta[4];
 };
 
-typedef struct tag_Tx_Config_Cmd_Format {
-	u32	Op;			/* Command packet type. */
-	u32	Length;			/* Command packet length. */
-	u32	Value;
-} DCMD_TXCMD_T, *PDCMD_TXCMD_T;
+struct tx_config_cmd {
+	u32	cmd_op;			/* Command packet type. */
+	u32	cmd_length;			/* Command packet length. */
+	u32	cmd_value;
+};
+
 /*------------------------------Define structure----------------------------*/
 
 
-- 
2.18.0

