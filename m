Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A8C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDEE20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlYDT6DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDEE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIHO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:29:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:29:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so8074799wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=egG+wv7egiPLa3wKGcpdblflGtAJEPzQHBfqilINBvM=;
        b=GlYDT6DNFEukWGlhVh6+o3w/CPhAnJG87ECz7+uGHMO5K0y+5j+IZXi8mmJhW2Z1d9
         RGX84bBupc4ahz5DXv9MRdNoP/5WNpbF4zRBc0Xj8fop/xUeZtS2L8d6QmsVe6dpUlhj
         nMAxKiAyMEbTXX8een2JTwU2wBIseCjZ/5BVXq8gskjNWMmrPi3CPF7UxOhqGUih4axG
         fFiJkNqyrwXPMSCGjWhTFuEssZO2ieFMVbitYIIYNVXnc7nsKBC+ZfSGv4Di1kTJBdzW
         dIWaayEtfmX08jeNUByWIDKCwrM5FBYUwQ4DSM2pQo7jlNS6KNH0P1ZPDEiv2wD6K0cc
         0h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=egG+wv7egiPLa3wKGcpdblflGtAJEPzQHBfqilINBvM=;
        b=HA5icMlgKMPohxmyyNwYtSeKUBEFOqd07VA9rOROgrpbYQHQRQCBkpX1+2y40RkR7p
         ulmzaKBG1aFXAvRfE7obGq7ZDR1lwyUyX22JfMpf1Ro/MlPoYtVFcm/ByftUpw8lzPdG
         pWgYDzx1zD7PRx5quhHbfsg2uNaSBgEBdcA45v4emx/hH01AIX/QpKwly5sMojKhUh45
         jMArDyt5ItjuHf4aFQgdykzdyP6+difbAoG4JcoPpDwRnPlDoCETBXGEcsbcI/h8HNNC
         S5k3j1H+MccFhpFdZyNggPOETqxK17t/fqBta8qLK0IzYdtu6e+nI3l0G+xnhT4QmQh6
         kSBw==
X-Gm-Message-State: APzg51BFOerF7KnFwUIccMB10nVcbRSLjJZMPmD0YwOJDnB/CbcwrXAE
        WR6C/z+odJhI5QkNCGAXhMrT88oq
X-Google-Smtp-Source: ANB0VdZbefeV5DMSkc/w31pbNgrp2ynUKAaGPj3CRVxxGy/DVBmFLovCEq9jp+DP7XhMzKx3NhHMQA==
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr6099037wro.29.1536399854858;
        Sat, 08 Sep 2018 02:44:14 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id t132-v6sm13975018wmf.24.2018.09.08.02.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 02:44:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 0/4] staging:rtl8192u: Style changes r819xU_firmware.h
Date:   Sat,  8 Sep 2018 10:44:05 +0100
Message-Id: <20180908094409.4043-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series of patches just clears simple checkpatch issues
with the header file r819xU_firmware.h.

John Whitmore (4):
  staging:rtl8192u: Remove unused RTL8190_CPU_START_OFFSET - Style
  staging:rtl8192u: Refactor GET_COMMAND_PACKET_FRAG_THRESHOLD - Style
  staging:rtl8192u: Remove typedef from firmware_init_step_e - Style
  staging:rtl8192u: Remove typedef from enum opt_rst_type_e - Style

 drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
 drivers/staging/rtl8192u/r819xU_firmware.h | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.18.0

