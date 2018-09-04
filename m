Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E32C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17E5206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="FU/IC2ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17E5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIDUAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:00:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37756 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeIDUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:00:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so3611734edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TDrqaT1AhaFpIsmPk2cT4l4hLg6yXcajNGqarZjJftU=;
        b=FU/IC2nisuNN4xyym3s1MpbxH9PKW8RZcCvNetoXMRZhvdmjGoLruZVtsdPWKanVt6
         X7WHBHS42u8visMN+C7Y1WwdIhvc0gT/isl0p1w3bUCwNQx5BeO95CgvlYFtb/bqh3NU
         h+KgLi1RPsuGOr9T7U9ho/ntg0B4Ar4GXNPqzcfLfWabPATDeCWAVg7Lx8jZ3GLquiHT
         /CWEL8hn4De4bti7q5PPmqmOU3YZLidxfxtYWYRHmTuTCh0PkdJ8JzWtmcPHxd6qzEG5
         6oUmpvEMp40wvzpatB/BF0LgtPOYTvXdmqTbuVJLdUAHourUJbM7J4Qb+sriN55IQgYk
         8h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TDrqaT1AhaFpIsmPk2cT4l4hLg6yXcajNGqarZjJftU=;
        b=S7bZ2+bUgdDQrW3NuNCoEFhYQcfPrKdosC7Y8eIAH+CmXMpmK8gZz2aihdr4WkLFXW
         nHNzT82vQKM3KBEKQBRBvqZDnR6bup0gM9BrTmO3IatGfBVRBHO5naTNWEZekCCwbwkG
         LOfn8f4h2b50L2x9ofWpmAWffITXXgRD+Jlzm/gGFvgunjgtPCuj0s1/CKBkx7RrDmpp
         27qlcMPe52NJ9AiNrLeUvU32AJI3c2EOaRzp9qcV0I6qkrPT5lUtDHZaAZDzC9QH28eF
         vrlHDMSdnC2NnnPPlrPiyXEXm00SzSiRGi6F4leJlkRXRM/J/HRHm3ARwLlSRCO9tB1a
         q7rg==
X-Gm-Message-State: APzg51ArlfDXyScG2pvIOVPAMxl5piUOb0zWR9nZCDEO++UyO6bf9J8/
        I0G+WUkaRPCN5f2oOfh6cHnQZ0fY7pCjiZ+LAeI5CA==
X-Google-Smtp-Source: ANB0VdZPNKiUh2wfG1yc1hKSmJ+LhlwMFfUp0iCXvgP+1FRkduUiyk5nsyYQetY4dbxac5WA85p9BFnLnnGbPnPgGuM=
X-Received: by 2002:aa7:d1d1:: with SMTP id g17-v6mr37605154edp.163.1536075265471;
 Tue, 04 Sep 2018 08:34:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2443:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:34:24
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Tue, 4 Sep 2018 12:34:24 -0300
Message-ID: <CADHB5bAFM=Qs6f0zf6iQuYfmT-ErSwG3-2mTsLnL-MCCUw1FhQ@mail.gmail.com>
Subject: [PATCH v2 00/03] Add clock driver for Actions Semi S500 SoC
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi Owl series S500 SoC
with relevant clock bindings and device tree info.
Updates from v1 to v2:
SoC supports were organized in alphabetical manner.
"_DELAY" suffixes were removed.
Patch generation format changed.
Commits were rebased on top of Saravanan's patches.
Changed patches ordering.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     |   8 +-
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   8 +-
 arch/arm/boot/dts/owl-s500-sparky.dts          |   8 +-
 arch/arm/boot/dts/owl-s500.dtsi                |  24 ++
 drivers/clk/actions/Kconfig                    |   5 +
 drivers/clk/actions/Makefile                   |   1 +
 drivers/clk/actions/owl-pll.c                  |   2 +-
 drivers/clk/actions/owl-pll.h                  |  15 +-
 drivers/clk/actions/owl-s500.c                 | 524 +++++++++++++++++++++++++
 drivers/clk/actions/owl-s700.c                 |  18 +-
 drivers/clk/actions/owl-s900.c                 |  18 +-
 include/dt-bindings/clock/actions,s500-cmu.h   |  78 ++++
 12 files changed, 664 insertions(+), 45 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.
