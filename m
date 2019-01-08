Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7C20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpltlmxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAHQ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34688 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so3471162lfc.1;
        Tue, 08 Jan 2019 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrC5TbkM7ooSeY1gmY25cHG+Xb4rV68ii2Clgc+hyVg=;
        b=SpltlmxDe1/qv4NwrTcqa96yZqYlpC5J/0wPhg89FJmH+mu2uOJZiBx4MdHNTHdkNn
         VeQLRPyR3MP6GYugfrGyj8+H0YM0P/B03hZcjY19hl7ufxKUjmol2pV9dDWeF6q+B4Lo
         R9OyN1qQejV+TBT11pESrH9YTFjqsDggbYorsL1uLpSgg6q2oMv+nsEH6F0AohWxb/LM
         4WuY5tA+QiRtBOVXRQRS5atI45RPuc8hOdgn0FfFn964vAgbwBWV/tjbeLXLTzfDXAZ9
         PUcn/vJ4EUOa2ivieJF1SDKVa9e3mZwtVQa57UwNHAkfz6DW2zx9piNqxJyt8NHEdJkd
         OXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrC5TbkM7ooSeY1gmY25cHG+Xb4rV68ii2Clgc+hyVg=;
        b=lOZsmWIlkILCSBFl0uazRhL7JGEs/2P2rLs8E1bBqx4GGHEe8evuFnwNqbO1/+BFHd
         o9k03yZHz11yWueoQWkwiYVw2aG/VPAu97fTnZ/ZtgcWwXvTYO9bDwSV3S6wpmlWl3aq
         8bijGyVgn1xPZwDo2lAK0xb5WAk4lyT88UaaEjCY3fE5Ue0l+azm/QOdI9RHb8165okC
         bTeAxHANndGHJkMh8QCgPNHkgq8rO/lb7XDkblKIk2KEiBj9yByNr3lMSjhwF0Ct3zZl
         kg19ZOXx5DsHgKZLt8tG9aNK8g78pmrxWNqC1kH+ZsBltcCTogThurqeru5+eK/9SZfP
         hwzQ==
X-Gm-Message-State: AJcUuker5cudDiFSorhF84A8Bep51Q5TsjeM1H0VEbxNCOu2rRT/TB6a
        g8hp+u8xCNJl7ER5zlnlueU=
X-Google-Smtp-Source: ALg8bN6M3Gd0kPYa9j9AQFE1qNP5Qra/Fr13PN2WFE4WNWuQlDYjzfl2K2VkssnNHzvKcudU8YNSqQ==
X-Received: by 2002:a19:645b:: with SMTP id b27mr1512410lfj.14.1546966567298;
        Tue, 08 Jan 2019 08:56:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:06 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ARM: dts: s5pv210: aries: Enable more drivers present on Samsung Aries based devices
Date:   Tue,  8 Jan 2019 17:55:57 +0100
Message-Id: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables more drivers for devices present on
 Samsung Aries based devices.

Changes from v1:
  - Removed already applied patches
  - Fixed name of mfc memory reservation nodes
  - Added separate patch with savedefconfig result
  - Fixed configuration of touchscreen

Jonathan Bakker (1):
  ARM: dts: s5pv210: aries: Support for more devices present on Aries

Paweł Chmiel (3):
  ARM: dts: s5pv210: aries: Add reserved memory for mfc
  ARM: defconfig: s5pv210: Run make savedefconfig
  ARM: defconfig: s5pv210: Enable more drivers present on Samsung Aries

 arch/arm/boot/dts/s5pv210-aries.dtsi | 90 ++++++++++++++++++++++++++++
 arch/arm/configs/s5pv210_defconfig   | 41 +++++++++----
 2 files changed, 120 insertions(+), 11 deletions(-)

-- 
2.17.1

