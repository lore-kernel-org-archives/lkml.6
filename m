Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC932C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AE8218D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Q28CDlCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AE8218D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933134AbeFURly (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:41:54 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:45993 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeFURlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:41:52 -0400
Received: by mail-lf0-f46.google.com with SMTP id a13-v6so5501686lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=byrYUmfqYiOquk3eutC146KO+EOprd25//eeGcksEpo=;
        b=Q28CDlCneHsXKSBTxt2aD0K7Re39O7uLzu22LLa5ylr9OgkkLfnj/Hhy0iCPZGDCVD
         iuCfl4Lr+C8Za7b2C6/HJAAVzePoA9CDslhFKyghJtCJ94eba+RPMekDi0aq/lpiydbk
         3dQeao873OaJ/BY/n6oiZisaWR7J9nSXUQyQQTvCDJvGMWNNiegjZae1TFPDHffYtkf5
         mbc/AIzD1GN9cdnSyOStbteFH/mhnmndENE7vdN1U4OL6dt+eXkN37C8keOSafgzcYYC
         fhS/rAvm0xSa4MLecdH1c3g462BcbpNcrXd1U91MySlLMb667QppmIT7Xri8RVN+QPRa
         F7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=byrYUmfqYiOquk3eutC146KO+EOprd25//eeGcksEpo=;
        b=oklz0pZzaDXmQduidWXiqGiiYRPFuIDop0Fe1Xz5uEBno3PcGz36wqM5irgMrr32O3
         1FTvFU+S/jrrbeNzRgkUCzbTI89MVMcbda1bNI6N5INQtZiGJyW5tjh9ypRi7PHFMNR0
         s188iFW9bF88681jDismVCQ2J5Mv+B5+Maq74xo7QQK3B7Fqp+0CGUj1zugLM6UREcz7
         auXxIaDRCL/r0JYp2y6JgMggRhwFJ4BDkyMhXGRyRWdAElGavOcCLa4doMbl5MhFu6Pw
         xjtt+5Kgw6RTHUE/fhXWEeSWyNfDYPPBQLdRM2V4pE7+GGy5YENFIS6csOhwiVdjO6jZ
         MSlg==
X-Gm-Message-State: APt69E3Yax6BPLZJE6wm3cNMJqfHD1X8NqSkNvN5MnP0J30QoMnHUICu
        +SRnZTRboGHMh2498PBRylf9YQ==
X-Google-Smtp-Source: ADUXVKIJbsZ47TNr0Xeu9BglUgwIbtvBHHOuS3s6cpzlnq/R0K6p8l/QiqkXcs/sQOwxQ+8awabxGA==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr17595335ljj.143.1529602910866;
        Thu, 21 Jun 2018 10:41:50 -0700 (PDT)
Received: from localhost.localdomain (178-16-155-142.obit.ru. [178.16.155.142])
        by smtp.gmail.com with ESMTPSA id s5-v6sm951756ljj.93.2018.06.21.10.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:41:49 -0700 (PDT)
From:   Andrey Gusakov <andrey.gusakov@cogentembedded.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, cphealy@gmail.com,
        andrew.smirnov@gmail.com, l.stach@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrey.gusakov@cogentembedded.com
Subject: [PATCH 0/3] ARM: dts: imx: add two ZII boards
Date:   Thu, 21 Jun 2018 20:44:57 +0300
Message-Id: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common part of dts was moved to imx51-zii-common.dtsi
for future reuse.

Andrey Gusakov (3):
  ARM: dts: imx51-zii-common: create common include dtsi
  ARM: dts: imx: add ZII SCU2 ESB board
  ARM: dts: imx: add ZII SCU2 Mezz board

 arch/arm/boot/dts/Makefile                |   4 +-
 arch/arm/boot/dts/imx51-zii-common.dtsi   | 317 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx51-zii-rdu1.dts      | 330 +++---------------------------
 arch/arm/boot/dts/imx51-zii-scu2-esb.dts  | 178 ++++++++++++++++
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 190 +++++++++++++++++
 5 files changed, 718 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-esb.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts

-- 
1.9.1

