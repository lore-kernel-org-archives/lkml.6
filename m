Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D764C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6776720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FWMVqFgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAKFVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:21:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34542 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfAKFVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:21:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so6415529pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
        b=FWMVqFggvtn9HchiFeiBPrzA6xmoVxb2I6zBZlwqpQ0FsXFc/yZvoUe5wzN3ylxK/b
         7vUmkqo0ZoH1XxcW/pc4OJy/ifYYZq1WLOB+peMpyCRJRJZm8rO5pCQTAjrRJ8/gZR8u
         QkFfMMruabjxsFAyUCwhA/JUrdrNnx37wF5VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
        b=XlI/0fxXvmR7AFiWakoqWv0Z7L/AkqahSS8slysZmvyO3FLJ5FSDJQYEyfmMEwFwLG
         UYHI0T9proZ7f5KLcNuWDZA1nlhmlZnKRrcclKXUjjxbPW9yRM/mHsOTbj9d3RyTnU7o
         w5ggXIvRnSMu6/LvyOYwMwt/1D2cwQLAwm7u3s+Uow+LmovayWceAmyGN85KzKKerWrT
         jRUAuTWWjA2kzufpHhR3J9piT+xxI7k/QTMGTHovUO6kjWULuVoecxX3yYO39CVlXbtL
         0S/sH8F5a8reZTFzz6pV7c5o2xUPs2ukkaPGODL3eVdMOYL57QJUhQD8er08JJww+8A9
         FcoA==
X-Gm-Message-State: AJcUukdYRkzq5m+Qg1RvZo5QBYzoMJNqr5Q5dnYCsMtIzct8n7M0TEkO
        qnFwRz4C1uYOf65GqDIDS6CQJw==
X-Google-Smtp-Source: ALg8bN5n6sF59rtRzq1JIaYiy5l1r/j61rUcweghWiW0MvMZNxS3OJoahxg0nBCBRFMIhGPFtEE/0w==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr2026212pgd.57.1547184064235;
        Thu, 10 Jan 2019 21:21:04 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:21:03 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH 0/3] Add support for PWM Configure and stablize for PWM kona
Date:   Fri, 11 Jan 2019 10:51:13 +0530
Message-Id: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
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

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
  drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
  ARM: dts: cygnus: Change pwm compatible to new version

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
 3 files changed, 100 insertions(+), 32 deletions(-)

-- 
1.9.1

