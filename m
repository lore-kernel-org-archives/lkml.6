Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKFdpitp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfAPUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:14:52 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38756 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfAPUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:14:51 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so2937973ywb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l9HGiB2QaCG+ZQSwLJEa2ko8TjgLeMDeavjJfrXdC98=;
        b=FKFdpitpEXtu/3S2xAZfETpvHvPDnvpYaccPl8hlFZuOvvgWTnYHLcXSn69ARiAviT
         4Tb2mWKqSBn4SPgK9Du8/hGYgYgP6CVbop9C92gFiUJxKIa0Swg8bgYM/p0QOCs1xSX0
         1GJwnTMUxUxg2kiq5BO16GZnf/3khdRUKfnVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l9HGiB2QaCG+ZQSwLJEa2ko8TjgLeMDeavjJfrXdC98=;
        b=rZG3SpBjs1t3IVQeSruDa6GMul9H2jEuBq75jL+OXIdobRCyS2X4S5yBaV386WjZJn
         UXi9MktzYc0H3BpnaONpBHhFm7FcAmnuQMDe9aTP+K78M6Vup+A7GFS3twq8zg+TezMi
         pYwZ0XHlDXZ5JfByuklI+TIwFxf1GOk2dxJHC9oT7yclv5FakY5Szm7lP5SHylFo3P+K
         rDGurne7QxdGkZegVjarOqq0bf1z4G50rjmw2w8PWkf2dKHdvoh0ICcIeSnSmHNIZ9e6
         e5eTqNZZGsFxAuDOCNMHD1WJs/1rMw2v12Ver268zwrwwBWQUQt3FfmHlU/JWbAmp/dT
         MvCA==
X-Gm-Message-State: AJcUukeTqcNGDFZUWVojODavKvowivDw/5WKhQCU3WZiC+2rwo8ZaXgC
        x15kS9qNLGNRx+lcJWmbXdBllg==
X-Google-Smtp-Source: ALg8bN5XsnsfdzUiyl9tMp2oDQv81CzTMnrSPVFmXKiWoBrnvviwanFtChxQMA7bXyneKLww30eyxA==
X-Received: by 2002:a81:554e:: with SMTP id j75mr9441089ywb.406.1547669690717;
        Wed, 16 Jan 2019 12:14:50 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 12:14:49 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 0/4] Add support for PWM Configure and stablize for PWM kona
Date:   Thu, 17 Jan 2019 01:45:12 +0530
Message-Id: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patchset contain support to make PWM changes configure
	and stablize
	Following are brief changes done
	a. Add support for version2 compatible string
	b. Change PWM config and stablize delay in PWM Kona

Changes since V1:
	- Addressed review comments

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-cygnus
  drivers: pwm: pwm-bcm-kona: Add cygnus-pwm support
  ARM: dts: cygnus: Change pwm compatible to new version

Sheetal Tigadoli (1):
  drivers: pwm: pwm-bcm-kona: Switch to using atomic PWM Framework

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 290 +++++++++++----------
 3 files changed, 158 insertions(+), 136 deletions(-)

-- 
1.9.1

