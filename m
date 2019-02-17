Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC924C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E6A218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw0sdqkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfBQTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:22:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:22:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id g12so1093693lfb.13;
        Sun, 17 Feb 2019 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s17GrLGIUdTwkDzobw/wjqzja8xYxsv0uTtwxlT/3DM=;
        b=Zw0sdqkB1ptCJ/O3HblCqXIsOyIEeRl9xJ9UwytBdzHMcgb5vsilTCDhHRTUgapVC4
         bSfczQGFFMueSjjk6WyxBNdjzADiGGntgMyU6dt9dr982lKeVaqcpBbIPrtVlFAsutng
         pyxh5j3Uo3mwNexeps+Ublt5rZzxyRBngWUnF+L2MLqcXPVQ4RdqPHG5fUK2gdWTvpRr
         h/1VxvPDIf05xtALq+mjDatiL1FgzzJ4geY4he1GkJ9Cd1r262LxMBorwNoLJHqU5Ejm
         yTdknxWtwJiiMo3k219Hsnam1H6Ingj/ZQtxIPz6eMDEFB89M+gvGQ3/VLT6aLbjV4WU
         LcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s17GrLGIUdTwkDzobw/wjqzja8xYxsv0uTtwxlT/3DM=;
        b=db7GZJMWJmIXznarnsCNnNdwWnF5FbQCOq7o2B2oT0rlnrQsupWljGlRcv9FmHpe8X
         TvGsFkX5lq8TuiY1lFEnr3Q/PBXMG5PCXyRrybgj8dvSLLMCQv8JRTGBusMlXXsthr9k
         VDr6Eoq7ot/hcjDPeQd52bNxD/LJPk4vFZ9wZ59qw0psDEDieTaLoD16YfAw5KCsf37b
         YpIPU6sA5QDwwUTlwX5nPBl8amx+KPTKcBHrRKl3Jvzk3cWFBvJA4N7t84yusUy3InbZ
         1oR+hhgHnl+RA90S06gJuvc3M+Fm6pMfg1RlsOE/7IWpSNP0hjcV2GqMYsllJYPoDpsI
         V/5Q==
X-Gm-Message-State: AHQUAuY3mm6+w0WE49b5kP8+yGIbGmf/0CgUFN3FMpxDKVDSg5JMMs4j
        IHrG2XdMEWY8TSjTP0X1hEBIy0zw
X-Google-Smtp-Source: AHgI3Ibbx3g4wX/ofVZsp596txpB9kSn72Mh6BgweSMcYiN8/4KJbOQ2qIT8eouWj2I/+NvYgH+xEQ==
X-Received: by 2002:a19:645e:: with SMTP id b30mr11508891lfj.15.1550431360128;
        Sun, 17 Feb 2019 11:22:40 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id j14sm2916766lji.32.2019.02.17.11.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 11:22:39 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/2] iio: chemical: pms7003: add other supported sensors
Date:   Sun, 17 Feb 2019 20:22:11 +0100
Message-Id: <20190217192213.15803-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the supported sensors list with a new ones belonging
to the PMSxxyy family. All share the very same binary protocol and
are capable of measuring PM1.0, PM2.5 and PM10 dust particles.

Tomasz Duszynski (2):
  iio: chemical: pms7003: extend supported sensors list
  dt-bindings: iio: chemical: pms7003: extend supported sensors list

 .../bindings/iio/chemical/plantower,pms7003.txt           | 8 +++++++-
 drivers/iio/chemical/pms7003.c                            | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

--
2.20.1

