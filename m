Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2908C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AC222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDz9wr2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfBLU7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:59:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55312 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfBLU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:59:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so99462wmh.5;
        Tue, 12 Feb 2019 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWTF1SES5GRIXXlitUdnPP06DsCUYUrOBCWQQ/pJq/k=;
        b=PDz9wr2rxAXcw2dmw0xsyOCdwb3SQ3nVI1sDoaPNoXCdx7TREPPkCKe96S7mrNasA+
         sCQ97flHPbfjX1NnM/EaatGuRc0MTQmDGgUHieDLbevS7N8ZjKMbfemrZSiCMFTFIppn
         mEwcpg+zNJn31zlu6rLU+HI3xjWrgmYGn2BsGeokOXRC89pkJgTjRTnwmpQ2RrS79DtC
         SU/6l6oDwhB3VxTs3shzmWpESLE7YdmYzyVfuyrP+kPNwQQ2KFYavsw4XJzH7PoJ772W
         BCFW48QofTo0/pEPm6V1KP4Dr88no7V5z7lTNyhkH38e+XIPAwXWUFqyrd7B/BSj+u65
         0NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWTF1SES5GRIXXlitUdnPP06DsCUYUrOBCWQQ/pJq/k=;
        b=K959gb1lROtzfhU5T+Bz0rFZEa0plo/uuDoFDEthqhbPSDKQi89lPBMc7AqbUINmYW
         3GA3YwRYL+7vyV293plztRmTSiU+SQics9oP2GI/w3s0Z1x1j6MLNZfXDVmBh+HCZ/ph
         f3gVPtlakF0xnXpb1SZZMoZ0t8Dk07S5wyTkEW5Ls+7cQCSM/512lUry9Wm5fmtYSVC4
         ujXLeIu+fmvsaz/UGe3UnGAS1JnSbTHuarRtLxWzw5wheU5BS7kMCB8jyNK8jBHJvm8q
         Gw8/2jQWIr6eA7jdq/9VyfZ0APZcb5CwtUZIl2Ms4qVnt7C+Km1Kp0o86/sk/sqjV6Eu
         MoKQ==
X-Gm-Message-State: AHQUAua3tTCZKCHXjLeoCCMpWiK82Gboh4vwNssRIgWkFe/QBk7hOdJn
        +SeMSe4DIP2nsECaa9KR7lu/eeZH
X-Google-Smtp-Source: AHgI3IalTm6xrbghuck8dqaV6JjYNL5T22H27R/wSTR8AaMAaausQIff9Gx6nXRS4Kc1WT/Nv9SWlA==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr577096wmf.94.1550005162297;
        Tue, 12 Feb 2019 12:59:22 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.70])
        by smtp.gmail.com with ESMTPSA id z14sm10355940wrm.48.2019.02.12.12.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:59:20 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gtf9D-0003PI-7S; Tue, 12 Feb 2019 23:59:19 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Date:   Tue, 12 Feb 2019 23:59:01 +0300
Message-Id: <20190212205901.13037-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212205901.13037-1-jekhor@gmail.com>
References: <20190212205901.13037-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
mfd device driver.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 64a3aece9c5e..be84bb2aa837 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -60,6 +60,7 @@ static struct mfd_cell cht_wc_dev[] = {
 		.resources = cht_wc_ext_charger_resources,
 	},
 	{	.name = "cht_wcove_region", },
+	{	.name = "cht_wcove_leds", },
 };
 
 /*
-- 
2.20.1

