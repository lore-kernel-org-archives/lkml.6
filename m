Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99807C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5016A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QfwPijhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5016A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934260AbeFLUVo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:21:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42320 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFLUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so286653qty.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XdAn8DzcjkseOYchmpnUVbnf2XXk7plXG68DUnpc7nc=;
        b=QfwPijhr0+WGd9h0y+vicm9qSN/IrLqcDsj7FAVsBUkz9s5Grkrwsw13Xnc746yOnO
         Z9X42i4xLX7w23LpQg6sMc0qrcZcwPMAao1Lbdc1lSuguBHq3Q2Zz29u+y+9wu6FYoHT
         FManFHeFwaOO0rCe0iExlJqG/2BBxP0hcWHLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XdAn8DzcjkseOYchmpnUVbnf2XXk7plXG68DUnpc7nc=;
        b=M5fJghhk3duIeN3Eb9v9Owx8nuBuM25fjt6wPloEwIXsAnKkeLEH80vjhvk7wG7Zwn
         ny0oj2rQ4cTP4AJsJs9i7vNC/hgX8o4zgM+Wh+ZdE3MC6hJtq3HWqzccCZGArCw6y6Zd
         2PPO23FGh4gz8DEEbx5rSaTjZyPfUxXiN0JGTqxBEVxytSq5kjE3aB31Kmegvt96IfKm
         mNV1z9slphQRDtKK112RYJVEZvu9pEt5r2VxHP36e5e2rIJvwB09tteifRgqurcGRp+K
         vQDPoKTu0jUd3Qgv2kWxh5Hx8taGcvCMNXmAHakK6+DvvvGcDoowa4rd+iYZBfZPZJvM
         tFOQ==
X-Gm-Message-State: APt69E1SyR6ZUhO9xFilfGp3D7B5xj9NzhiFrdpBXk7ERFjJqC78NKa2
        C/N7LqlcdOrzk0aboWDEsUC1oA==
X-Google-Smtp-Source: ADUXVKKnZSSjM9idXOieiiwkd6/HHzdgB4eQYlI6Kv4szG7IyIpd2xpte4gbtaZfQeInv3uL9/BomA==
X-Received: by 2002:a0c:f4c5:: with SMTP id o5-v6mr2004287qvm.123.1528834902124;
        Tue, 12 Jun 2018 13:21:42 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:40 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/5] Fix Cygnus, NS2, Stingray interrupt type
Date:   Tue, 12 Jun 2018 13:21:26 -0700
Message-Id: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes incorrect interrupt types for I2C and PCIe in DT
for Broadcom Cygnus, NS2, and Stingray SoCs

This patch series is based off v4.17 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: cygnus-ns2-dt-irq-type-fix-v1

Ray Jui (5):
  ARM: dts: cygnus: Fix I2C controller interrupt type
  ARM: dts: cygnus: Fix PCIe controller interrupt type
  ARM64: dts: ns2: Fix I2C controller interrupt type
  ARM64: dts: ns2: Fix PCIe controller interrupt type
  ARM64: dts: Stingray: Fix I2C controller interrupt type

 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 24 +++++++++++-----------
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  8 ++++----
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.1.4

