Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D27C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E170B25E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6XFsC2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E170B25E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeFZPbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:31:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45250 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeFZPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:31:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id m13-v6so7188849lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B7+9LY2tNp/C0Mli/uekdwlXVVqMDxTnhJMNz5MMPHI=;
        b=N6XFsC2/S6bAQ2DuOSdBDY0YZP2PG9nEzE7InaKr+T9HoLaBNvKgAbVSbDYynmfucX
         r3v/Tdm2Jt8xzpwbpyLefSx/AFsdYyEy2mR4BqqnIh+7uSlreNoK2Ahkm5gbHUHNReeP
         MvGGF06APcMn2AHLjQHwXv9fZQqKSAu60GNm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B7+9LY2tNp/C0Mli/uekdwlXVVqMDxTnhJMNz5MMPHI=;
        b=rOpx3OX0fmq4ZUJNSMp8BFT/spezrPkznc5qFkdzYw0WU71EUjA91cTFx/oGNAu0SC
         zCO+U9U6ihnMgR1hI+deRbar2vgm+DgDEhZR+XabCsJCwzfsGBGkOGnCDDYTSB1rJEEX
         g91Sd2gAbruji5aR1ivezVzvTD8TAs33GmgUfgqVXJPpLSdOJ/vSApnc6HktN983GJQl
         B1NU9jBZUauqEYom4eCSje/FzIqGe85A2W8Zjh0YffMyiSs975ai191nc1PNMHE9u/5G
         iPJCgU8XIOqTL7qnN3+08Ns58qmuwCvdeKT6zv3/TQBD3JCIOzoLQ6PqlX/qYK0WqP/R
         6IJw==
X-Gm-Message-State: APt69E3dsUjlXO++wH1PphjjjRrETXNqg1fc7tkt4PDCUu36mrK1bYgk
        TohUMq619VYSKbmb8HjH9JoIog==
X-Google-Smtp-Source: AAOMgpfYQhuMawt26m2NyWU+kdQto09IA5xnG1sYoBGjLdNO0A/95u3+5FAtctaFOzFqMU+J15e6XQ==
X-Received: by 2002:a19:2a5b:: with SMTP id f88-v6mr1567456lfl.63.1530027096317;
        Tue, 26 Jun 2018 08:31:36 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id h6-v6sm298122ljg.16.2018.06.26.08.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 08:31:35 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] sh: configs: remove no longer needed config option
Date:   Tue, 26 Jun 2018 17:31:25 +0200
Message-Id: <20180626153125.515-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
in the defconfig anymore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/sh/configs/sh7785lcr_32bit_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 2ddf5ca7094e..7aa78ced9ffa 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -72,7 +72,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-- 
2.18.0

