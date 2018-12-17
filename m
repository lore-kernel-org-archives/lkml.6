Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3194C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36742145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFtlb/Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbeLQPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:48:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52314 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:48:05 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so19207605itg.2;
        Mon, 17 Dec 2018 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nRL881EZCrOKRb05Wl4QjpBn6LXEs3V0EvcAYsmQNm4=;
        b=UFtlb/Gkx19LXTXO+rz1iw2ZhJEYBvSLb+ObXr3cRwZtN/urYKiKkyr9rtIBIpz0BN
         vccu9vr3S4eCqfuM9hZtJkQL/gAVyowU+ndkXEYpq6R2rEwxH7Ba4EdpqlHLQzYEWoiX
         NbHJTgm3hjFIkKQNLDW/IOwFzmj1xqxG7O6ApL6b6vsYjK1J0uxtGkgti6D7s5/Zvu9J
         It73AOGNliL5eKZYK54kH+QekoDmIP0YcY8EKyGFs6sNzkCVKgHYBhljE5KxcQALOJNv
         9JyqRyLNA0bYkXO156TyeWQz3kIlQ1zc/iRhaH21AGCiYUQWlV5yOhD0nYIsN9XnHCxP
         U6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nRL881EZCrOKRb05Wl4QjpBn6LXEs3V0EvcAYsmQNm4=;
        b=t5NNNyH+1j92ybEsOmhDTgR3g3g6WXpdbohA4Lm8JSmzwDdjYTjUcEdjw2XArIYk89
         B5ZxGUehEk/reHijSFU9e2Q8f5y32cr4OqzQNaXsY7Yj7oMNeA5/Rkz+UmzMHxbtGtkQ
         9FyRD8fqnK9JKMOOrU0OGRFwZ3rDlP0UvKKcFs6da0EyxNrIv0LtDidrckJuwtSlO4bY
         gtSQlriqXYYwgzIEH7lfSJk2kMzYRapYXdy0IYqK4bFxCwSNMnnUns/lkIHEylxOVBAN
         AawL+ogqebota5WS1XjCDZWwhP6Ec3wSPU5BToQUuI6L82Fc4KGql31jMuBNBGBHhzsc
         z1zw==
X-Gm-Message-State: AA+aEWZcVJ6aa3Bb79ztXYLDalzNsZ2yx7F9pEmtfsPjPSGu5kUm8eSQ
        n62AoUX4H3dEYGl2BFk3tsJXnYIgd6A=
X-Google-Smtp-Source: AFSGD/U2q01UjijA34ihHhkqN6N46oz3M79mgjdV80OrpbttrmXhKaVFpJdVKiWKKDD0tB+r+sMNKw==
X-Received: by 2002:a02:9a01:: with SMTP id b1mr12631230jal.18.1545061685036;
        Mon, 17 Dec 2018 07:48:05 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id y23sm18824174ita.1.2018.12.17.07.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:48:04 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] bus: imx-weim
Date:   Mon, 17 Dec 2018 10:47:57 -0500
Message-Id: <20181217154800.7448-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple address ranges per child node on imx-weim.
While we're at it, insert some code which guards against common config
conflicts.

v4:
	pick up patch after one-week delay
	Shawn Guo:
	changed devicetree patch position in the set
	clarified a confusing #define'd constant name
	minor coding style fixes

v3:
	added devicetree binding docs

v2:
	corrected acme@... in commit message example

Sven Van Asbroeck (3):
  dt-bindings: bus: imx-weim: document multiple address ranges per child
    node
  bus: imx-weim: support multiple address ranges per child node
  bus: imx-weim: guard against timing configuration conflicts

 .../devicetree/bindings/bus/imx-weim.txt      | 32 ++++++++-
 drivers/bus/imx-weim.c                        | 70 +++++++++++++++----
 2 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.17.1

