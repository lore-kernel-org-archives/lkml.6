Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9012FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FFD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FFD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeH1TpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:13 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34435 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1TpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so3742999ois.1;
        Tue, 28 Aug 2018 08:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RS9DGtX4STxIW/QFMBJaiW6yoQbqx44eoJmEIppM3Tg=;
        b=hyDlEBmxnGJNxEPBhNuUWTZD/g2uykvINUO3y4PU+JhKva+0xJswCGS+VXwlS59Bs5
         0GeLEwfN/oQIKIacD0p45IaTFgcqmcnyM0wC0WXwpfHPxjg7WquLDEilgUiZM0fPhRwI
         1EfbLahJYdDMzNOEh0/EfP/mVtGhKzwC2uoBn2crZ4gtzm1KZ3GuMiM5IROoV1JHjETC
         6VjRfsW/8k4zGfjxJC5lzJxSL4CdCRZyfV4TyBPLIdp0f1l3X2LYC+vawvyeae76WcJE
         GCmNe/VvbejcoYatLEzBFVAAbsflnsifNE8+RoQ+Js1kSYPMM8m2rSKQ76s/+1cibmpr
         ko7Q==
X-Gm-Message-State: APzg51Au+nhkR7OshFHX224G5jGAy5e81MN8HPwtbTtvjf81k1hp1Mmw
        yziSZaJHKRwrvtZgmOjvlg==
X-Google-Smtp-Source: ANB0VdYex9UP7nuVu4H9qjTw6oH5LRk79FsyGLciybN6ZfNZD9yj/6mqHruZn+rmNedsDo3pAsWCWg==
X-Received: by 2002:aca:3ec5:: with SMTP id l188-v6mr1554147oia.181.1535471575710;
        Tue, 28 Aug 2018 08:52:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o68-v6sm2902294oik.56.2018.08.28.08.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:52:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] of: Convert to using %pOFn for node name printf
Date:   Tue, 28 Aug 2018 10:52:50 -0500
Message-Id: <20180828155254.10709-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the DT portion of converting node name printf's to use the 
%pOFn format specifier rather than device_node.name. Patches for other 
subsystems are independent and have been sent separately.

Rob

Rob Herring (4):
  of/unittest: remove use of node name pointer in overlay high level
    test
  of/unittest: add printf tests for node name
  of: Convert to using %pOFn instead of device_node.name
  vsprintf: print OF node name using full_name

 drivers/of/device.c   |  4 ++--
 drivers/of/of_mdio.c  | 12 ++++++------
 drivers/of/of_numa.c  |  4 ++--
 drivers/of/overlay.c  |  4 ++--
 drivers/of/platform.c |  8 ++++----
 drivers/of/unittest.c | 26 ++++++++++++++++----------
 lib/vsprintf.c        |  9 +++++++--
 7 files changed, 39 insertions(+), 28 deletions(-)

-- 
2.17.1

