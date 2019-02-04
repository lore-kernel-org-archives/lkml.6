Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8B1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C67A2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="zL1rd2Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfBDRa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:30:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfBDRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:30:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so246010pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkIFtzWxWklUq1pCUF8ZR+oB2vU+JzRaPiZGjUSnXs4=;
        b=zL1rd2JpynyO2uHz5TVGHmSmEQMYeMYQsp8GOvSkL+Cu7mEIw7KdY7Yl+y6pJ87fSJ
         XOq9dBqEJTvjstwe1zCyhp2vKobD0JvADbym1kvqFmgBpOqp+dDZM1WqitDQ4K+fbET1
         nu/4ZkE6M1lg4aTN2xbsb4LhBEo1PtyuJnKLIomiUx3uc6DDAQ6UWwe2km8+hI2z5pzj
         t0GvO2oLNPpWeAbG1I/gyqYidKpXL6cmldbUQIQTdPRRG2OxyQwONq6QRVarAm8ZPWPw
         AFANdDnMiP7lwcuvcNT+9DmNmecvtfT2wID5m/82R2wX78UZxJ/UC8FT53/SrZXWRLTg
         ehNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkIFtzWxWklUq1pCUF8ZR+oB2vU+JzRaPiZGjUSnXs4=;
        b=WSZe4RvGKQxVxTeYFLCcEszjMy1tDx8D0BMl95Fy+b/ataXPA8nginLmBwi0SKbR4o
         BDCmwgR/wW3ZAJNFvHRSCarUya4M/IonhwF0TyQWTZz5FlWhMZEshI7pnXbMUZXu/7qD
         1DOytZbLyEH95cK1MiAA7/FOiz+UFH1R9fTc95c3+a/pbUCUuxmYbEMil6VfS4aI+NMn
         7rcibNPqxXNxrmVCe6vYmu4e2suK07euiC6PCUC/q14DisydHSQtXXdeED8qL0qft0aK
         LiKiHuwIANAwvKV5nMjxaGFDW6HLYk4I+nmCYl5ir8s8Oa0kcaWYDujyLPZRI+TT4joX
         bpBw==
X-Gm-Message-State: AHQUAuYXAF8ZIltb8LoCvcktJGzh3AU0mAU2eAyMVdViXj06LWRhMGn9
        KzYPWe/WPARIokTy2r96tbGMEQ==
X-Google-Smtp-Source: AHgI3IYTKPZa9k80RwvEv/RuprZYul5IquBVDjXZlV9jm2tlrK11ZcRFE0UMde1Natu4C6Wqtj6lVQ==
X-Received: by 2002:a62:22d4:: with SMTP id p81mr524544pfj.16.1549301454368;
        Mon, 04 Feb 2019 09:30:54 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id v89sm1228788pfk.12.2019.02.04.09.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:30:53 -0800 (PST)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com, andrew@lunn.ch, robh+dt@kernel.org,
        davem@davemloft.net, moritz.fischer@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 0/3] nixge: Fixed-link support
Date:   Mon,  4 Feb 2019 09:30:37 -0800
Message-Id: <20190204173040.5538-1-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

This series adds fixed-link support to nixge.

The first patch corrects the binding to correctly reflect
hardware that does not come with MDIO cores instantiated.

The second patch adds fixed link support to the driver.

The third patch updates the binding document with the now
optional (formerly required) phy-handle property and references
the fixed-link docs.

Thanks,
Moritz

Moritz Fischer (3):
  net: nixge: Make mdio child node optional
  net: nixge: Add support for fixed-link configurations
  dt-bindings: net: Add fixed-link support

 .../devicetree/bindings/net/nixge.txt         | 60 +++++++++++++++++--
 drivers/net/ethernet/ni/nixge.c               | 44 ++++++++++----
 2 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.20.1

