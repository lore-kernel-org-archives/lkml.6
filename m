Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C0D20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaxTy9XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAaUns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:43:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45956 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfAaUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1845793pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsNqhd3AQ8kfGW/zqflxwaEu1SwORSDLfajLFA1ecCU=;
        b=GaxTy9XLNm9jhcs+wAH5Cl5F9Ipnm2SN2TXJydN8fxbltt/t0GdeUvmDPdo3y4B+ND
         rI7a9TEPoqlJTt5QQqDL/CtcMhovnZXszKi9zeBHIAePdzwuKpnxUrpsyAtFA2cihBap
         TR84nw7vMteZaN6MOxRk5sj4GL3NK0KkZ0OXHUsmxUJ+NHbjw7Uk8MG1a2u+5WANJ5FO
         DrEMPScj0wV84Z03eJhIdE/AZLOLma7wJYWoFj4hqnWPReLNBZYNPQJIpyq0jat7w1a6
         Np9Clreut/3M+fpuMbEGlIkMJVJgXKmuXUnWcaCePjHHEqIA2HZK4suCQylb08/bXHNj
         orMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsNqhd3AQ8kfGW/zqflxwaEu1SwORSDLfajLFA1ecCU=;
        b=AWSEyDuRgIN0U4+9nhws7xBkD0U3WKbYxCFcchX58pN2m9UU5Th3rE52VPtw9U902P
         oAp6gnhtzXrVr8GveGQ8Q4XfgRvW92YcHsgLFF7vhvfZpuedZ6sR9XDPsu1wzjK/D8It
         qnPUW1aN60nfJCxJ19nSko0FOaCtcRqwjuKfaMqiBL1OZk6g3DGjZvC3RXKB3thhe5Za
         rEB+wzjB8LyyoxOZq4DB37nOvJghwF7OMJN7tr2Gq7TEtfyubVueee0at9oRSLTFWNvZ
         XpfanU1Rsz3lh7aPJ33OJqwG/29A5rG68TzZ6gXNegNcBdbixmRUdEDe/JZKCwhBaC2F
         hLBg==
X-Gm-Message-State: AJcUukcXEmwUZEHfNRKmcouWQ1WbJlKKLqVm2SPPqxMu3lI74SGtQHwe
        iQG3q/4rquOr467E8DJwx5E=
X-Google-Smtp-Source: ALg8bN6o09sFrkB9q7ygq997cdHJTaNdKpagPeBV+8R5s7eDCd5OVuoK+ch11yfpJjdANgNXxNZ2fw==
X-Received: by 2002:a63:e156:: with SMTP id h22mr32979730pgk.255.1548967426739;
        Thu, 31 Jan 2019 12:43:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:45 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/5] PCIE support for i.MX8MQ (DT changes)
Date:   Thu, 31 Jan 2019 12:43:28 -0800
Message-Id: <20190131204333.31846-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK. Marked as RFC since PCIe
support patch series is still waiting to be applied to PCI tree. I
anticipate that PCIe patches going through is just a maater of time,
so this series should be mature enough to solicit feedback.

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 23 +++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 97 +++++++++++++++++++-
 2 files changed, 118 insertions(+), 2 deletions(-)

-- 
2.20.1

