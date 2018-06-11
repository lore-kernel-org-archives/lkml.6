Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9569FC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3102089C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssaEkzDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3102089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbeFKWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:47:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42531 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeFKWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:47:29 -0400
Received: by mail-qk0-f195.google.com with SMTP id j80-v6so13961742qke.9;
        Mon, 11 Jun 2018 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Arn+/TK0nKJUZP65oC25oChgxHVMacJZeE+3aeRp0Ik=;
        b=ssaEkzDVeT55L2XGUOewaPYD0dtZfLwi0RnrqdjoXKtO3g8STaZOlx2QGlOYM730js
         kduLYJpOTIlHn0cjSK3g6IEiCPzLpal+bUjYvadnWXICKIKEMuN3P1Bbpb5742vgPniq
         JFsIoifN0nMCF8JzJdYbgF2s+WJwHZVTaSuFrs8RR483wXe2O46SnPz/LXhpIKJeV4S1
         rGE77ny4l+U3Pl6hb5Om8F/BfZk2kyXqzzDUbRLpHh8BmyQLFGio1IMqjxUqO6khQWW+
         7Kk2BdTih1eEUJtKdrxJIydF3g9q/5UodQ5ZeY+Gat9zd2jHMvukNTG1wcQLFDEQCpHY
         LPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Arn+/TK0nKJUZP65oC25oChgxHVMacJZeE+3aeRp0Ik=;
        b=fR+wjC09ud4/LhQ7OhK9GSj2wFNzQTEFzor+5BIEKQ1Z3YbI2uAF3lNl+z/Q7qns48
         7mhne6zjUzQTuYUiVZcNpfr87qDCHnOtCEl7N4Spk9ebaqt/WNlYHXXrQsPjwwyLpHCA
         /M+/3DXO6vvNS4aJYH203oq+XkgqPYtVWo0dU4ZvA0aFv8YoZ5rFuYhZRHPLXzr3X+XD
         k9D5DYl89sYDoZB5i5HfAnc0ymYVgVXi+ESP+aUr2yjS4L6KW/xlGkEgt3wd6Xkr1xZs
         Kvkp/e3NRUiLmalbXGm/VM9OokNVgKMIy9RvUyxyUlvDuN6KpJn/HNsmZ3J+beRdgoER
         iQ4Q==
X-Gm-Message-State: APt69E19N8MZrpjd9xo9fevdOAqWwFHWSzsDfdGWPB4IfLO7tRZELrJT
        WTyHA45Bv3hzEWlrADE9uE4=
X-Google-Smtp-Source: ADUXVKKiV4IOGD+Bh23820aE76/oP/ksdV6NVRj5l9nrpPO4zqj56ARbPYfvcKVa0A8fQ8a9j2gNsg==
X-Received: by 2002:a37:4643:: with SMTP id t64-v6mr1061233qka.260.1528757248021;
        Mon, 11 Jun 2018 15:47:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i10-v6sm35645869qtf.20.2018.06.11.15.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:47:26 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] ARM: dts: IRQ_TYPE_NONE fixes for NSP and HR2
Date:   Mon, 11 Jun 2018 15:47:11 -0700
Message-Id: <20180611224714.7007-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series fixes incorrect interrupt type specifiers for the
NSP and HR2 SoCs.

Florian Fainelli (3):
  ARM: dts: NSP: Fix i2c controller interrupt type
  ARM: dts: NSP: Fix PCIe controllers interrupt types
  ARM: dts: HR2: Fix interrupt types for i2c and PCIe

 arch/arm/boot/dts/bcm-hr2.dtsi | 24 ++++++++++++------------
 arch/arm/boot/dts/bcm-nsp.dtsi | 32 ++++++++++++++++----------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.14.1

