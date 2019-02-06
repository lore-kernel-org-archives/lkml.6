Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC07C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D20A218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhJ7CA6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBFTcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:32:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37898 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:32:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id 2so9246643qtb.5;
        Wed, 06 Feb 2019 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fXuxx5T/6D9bSfkO0RAbEIoq3LFv9bHNAJi6o1eR5OA=;
        b=ZhJ7CA6PwSLaSrTXJuESX7ByjaQci/oAAJrHsLuc/LNaki+sbPjncobhN5ytbx9HVP
         y6yA6t3KYlkQXUiC2AZFTCw23YfXKO1dwW4+5QLGbloIojDULkyF28w5UR4+Mt+57F+h
         ZX38ubSCTo81gNBNTWqrAi96vcPJ1nruu+MxR0u5OXTwSBZzSUBWqVvGuyLtnCCWrz4r
         DIMbWyE1Fe0YoovOuBuw5u8ehgHDQw/Q0Ti5YJZtYL2MZL3mIXypVNJIvdkq2EBSQyAC
         K9XC7MfOtwdHaHM1N3nlCHIqccRVyOJT5jL2/QVXVb7QmYeLsOoNj8ZnjvMvhtOvST2s
         NC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fXuxx5T/6D9bSfkO0RAbEIoq3LFv9bHNAJi6o1eR5OA=;
        b=iwv/dT4ER7UZh+cNtr1XhhBk4HXzbtfCDGQfqkr46OQuy4brrHe94dqGl3QKn97udE
         QpgRnfuYlbIKNt4Yz/7FfzWO2PtA2hFFkQPeqySm7mOeIdw4TD/Jz6enqzcDBP54Q26L
         TiEwP+p5FRBCAVmpvg1/X9nNDzq5cfK2GhxykXNo7HluyOiu0Y48it9c2CWOBYvRqXrN
         NYMe7d31yEvktIb58FriVIWS2TTyhZvezBlWi23uB+rR34AoEa9gA5qYD9jJlyYMJ8Fi
         wY6cVbPqdOnvYXynmOxiNSj0MnqpSffrTEOMPUyMiV1/PlCPOOI6MmUVyVA1k8U084Zs
         E4Mg==
X-Gm-Message-State: AHQUAuYNG7iCiLzpunp57/dtCE/MsDlHccYn13pA6vuodwFzKCMjSn3r
        2Sx6/ym5vTzHHKaWSUwb0fk=
X-Google-Smtp-Source: AHgI3IaQ6bI6uVbMNf3XZtM8bst1WZLRhfQWU7MWJzAr+s690HDG1MFbTzpT5A8JcOo29qIjVjw//Q==
X-Received: by 2002:ac8:728f:: with SMTP id v15mr8749234qto.260.1549481522067;
        Wed, 06 Feb 2019 11:32:02 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n92sm16491759qtd.85.2019.02.06.11.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:32:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 17:31:57 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/doc: Remove solved "VBlank issues"
Message-ID: <20190206193157.3b53ipdxtcqc4hv4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the list of broken tests on VKMS solved by patchset
https://patchwork.freedesktop.org/series/55994/

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 Documentation/gpu/vkms.rst | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 7dfc349a4508..61586fc861bb 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -23,17 +23,6 @@ CRC API Improvements
 - Add igt test to check extreme alpha values i.e. fully opaque and fully
   transparent (intermediate values are affected by hw-specific rounding modes).
 
-Vblank issues
--------------
-
-Some IGT test cases are failing. Need to analyze why and fix the issues:
-
-- plain-flip-fb-recreate
-- plain-flip-ts-check
-- flip-vs-blocking-wf-vblank
-- plain-flip-fb-recreate-interruptible
-- flip-vs-wf_vblank-interruptible
-
 Runtime Configuration
 ---------------------
 
-- 
2.17.1

