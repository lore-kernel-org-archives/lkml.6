Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48336C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D18E222A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6OzwRQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfBPPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:18:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44575 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:18:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so1404819pls.11;
        Sat, 16 Feb 2019 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RMBQjKzVGTp8CXBL5fsjpgOAbLUavTMlh8VMnWlbNfw=;
        b=d6OzwRQWwWMxhmz14k4jlvOFORFp26jsurSzUH0BRhnlHUuh6DWrkRhTocsuQEA78O
         gGYuLCM90Gp3O9yedAfOO5aoEPP2cZ/aPhhtQ7bAMtk8rD4Gsp9IAkdrBknx5Qm+Vqtx
         JA0aP7w7kwfecwBZ8T21SyGfPvI511u0VOjaWm2gfWf6r6gflSYaIQ+5GiRL5QUCnNMz
         p8oG/MN9ORROx2E15Q65l++iJ8RJkC/Iva8sytTDuqFSNry7atvIPJOjojFio2oyNRMB
         OVlnb78rzE6tTidSslQUCCYh6UHNGLyPjUAzJHD7ukFuJjxdgl05NO/a6SVK4Xvf7ki8
         0MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMBQjKzVGTp8CXBL5fsjpgOAbLUavTMlh8VMnWlbNfw=;
        b=fVPBB4lPxx0kkVDLot8eTOBMb2ulIPZFSSOifDqp2meJBZV7ERiHN1EaoXy52YQcUr
         Yk7CvCTDd6NKluQHINRzWwT2YBsPqIDjsI9ezNq/a3UG7Ele8Jl5bCHC+b1qvOvGLjR8
         ZJPrkP6FrcMpNH8U66L3I5+lJ+6Nle4XILSo4OIbU5GVxWDhkxORqCEyaY/ZFawDcVY/
         /QEsMGZxN9AF0SNuOrXqc6GtKwhIoL1KEljzHprq8RLqGYv+RZybeb8K/j9tmT5YyehY
         l/qAI+7tLr6MZhJGh8n/ZZ1yYrVfKzd638pXbAsyeqh3bmUfhFtOBpM6HFXIPNFk4Wt6
         0fvg==
X-Gm-Message-State: AHQUAuasUTg2SUmmqc27Loc0Odv9Jqa/tKAdWwOe624Jg5YIsuriZpjp
        UtTIsx55nQV31vuvQHdJKos=
X-Google-Smtp-Source: AHgI3IZpCeyCq33+o5pN0TDUaWGOm9bD/ImSus+fIHXdPDVztz2MxYMVgWfM3C1jeVyKoP8Ec90B1w==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31mr16093636plb.87.1550330314215;
        Sat, 16 Feb 2019 07:18:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d13sm13861474pfd.58.2019.02.16.07.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:18:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/3] PM / devfreq: do some cleanup
Date:   Sat, 16 Feb 2019 10:18:23 -0500
Message-Id: <20190216151826.11584-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The informations come from the coccinelle tool.

drivers/devfreq/tegra-devfreq.c:577:5-8: Unneeded variable: "ret".
Return "0" on line 603
drivers/devfreq/rk3399_dmc.c:325:2-3: Unneeded semicolon
drivers/devfreq/event/rockchip-dfi.c:214:2-3: Unneeded semicolon

Yangtao Li (3):
  PM / devfreq: rk3399_dmc: remove unneeded semicolon
  PM / devfreq: rockchip-dfi: remove unneeded semicolon
  PM / devfreq: tegra: remove unneeded variable

 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 drivers/devfreq/rk3399_dmc.c         | 2 +-
 drivers/devfreq/tegra-devfreq.c      | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.0

