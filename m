Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AB820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="OH7mvdFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AB820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbeGaAsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:48:52 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55624 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeGaAsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:51 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A9041B00AA8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:34 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=x-mailer:message-id:date:date:subject:subject:to:from:from;
         s=dkim; t=1532992294; x=1533856295; bh=nUPtD8hw5jCjA1Z+gJ+gMPiT
        BtW8eevqZNDjs9ACRm4=; b=OH7mvdFEtCSyODCJPKm0Qyr6fUoqXSHINzcG9jOF
        8aI+dD/qa13TqJV0eBH9x+lrlRFqu+k4viIAmkcYCLO6ZSXhYH2xHopkN8iv2Vl1
        a0APfyoF8eJZIHq12f1T0D31yg8Ppgko65o1LpOttZu/wppQYK8L1AP6yX9OcGwQ
        eSE=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mCe5LF6wuHoO for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:34 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id BB7F0B0038A;
        Tue, 31 Jul 2018 01:11:32 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 0/5] Add CDTech 4.3" and 7" to panel-simple
Date:   Tue, 31 Jul 2018 01:11:12 +0200
Message-Id: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDTech 4.3" S043WQ26H-CT7 support
Add CDTech 7" S070WV95-CT16 support

Giulio Benetti (5):
  dt-bindings: Add vendor prefix for CDTech(H.K.) Electronics Limited
  drm/panel: add panel CDTech S070WV95-CT16 to panel-simple
  dt-bindings: Add CDTech S070WV95-CT16 panel bindings
  drm/panel: add panel CDTech S043WQ26H-CT7 to panel-simple
  dt-bindings: Add CDTech S043WQ26H-CT7 panel bindings

 .../display/panel/cdtech,s043wq26h-ct7.txt    | 12 ++++
 .../display/panel/cdtech,s070wv95-ct16.txt    | 12 ++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 drivers/gpu/drm/panel/panel-simple.c          | 55 +++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt

-- 
2.17.1

