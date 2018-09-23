Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D01BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C34E214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 04:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBvAzbKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C34E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeIWKH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 06:07:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41752 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIWKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 06:07:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so7657820plr.8;
        Sat, 22 Sep 2018 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gi2nLE493jyCYyE6ZJWexf22Kq8q/sI54gpvthJl4NI=;
        b=DBvAzbKdOSyk0+dlPVYE5/FDoifTwzdUfcTjJzAjwvr35yZGS9+Y7hojPt3O85bdTm
         hU1wtfarLSwckUTWsjaWw8zkaPggAsCI3fQplo7eK0uEp6BjpcneUnxksmChl4zjmmzF
         x8NH0qFD2pQVIhtXOMLTlldE2vcJbGF9NavzYw1VJcT9rcgZ7bh7VBvf4Ukh8Zg8uke1
         MZYXlykiDVv6OxvoDQ7z6W9e1WnjbzmWwSP69/7P4NXKnPMl/3/0PO5l0YTzk+pEMrVD
         UVdlrG7VecNi0Rx/aw+ntEz/ZofrwKu9F56GY8/fn+sJaM5QO4vZeY5QFd4PtSw3ONd3
         iAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gi2nLE493jyCYyE6ZJWexf22Kq8q/sI54gpvthJl4NI=;
        b=I3yUs9u55Bd7VW5o7MbLyAy7fqmGs277NVwlipzZPEd2LYK5SAFE/DpHuGJGhKGp/d
         hjdYGWgclVZMZoBzYBbKpXGUTrnaPHYSKwdrhRBh7tVgwi4epsWdnwfzycIJDF89H2Cp
         7uWaDC7m2m/9qbZc06iiZe90UEGfbCURqOxIExpUVUehKlUTYTGBHgfr2kvEF9SYwxlu
         f67tDLQhf0D06HcX+ZCcDULPyvbyNYpC3h9ERXykCheeWYYGs+80DLybYG3htzRvX/vz
         Z6gjMs+HSB/ifSiD6/XDypjRcTPs4jrYuQ8i16+dsynVYlCUeMjgc6PLYXJ1ja8Uefc7
         CfEA==
X-Gm-Message-State: ABuFfoh6k357OU/Cn4+7+JKotc71GlcsNo7450DUZFkNoKaT5bVeGPDa
        zbrZtz23uNXztAmeCNCmJ/o=
X-Google-Smtp-Source: ACcGV618VOoeh+MFZjxQWm1TM7r63Isxyy8l9blK9dlSRj9besPgqVErlVsmfZWtVtjMxP+MThUkKg==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr4909674plq.156.1537675888598;
        Sat, 22 Sep 2018 21:11:28 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l10-v6sm68942799pfj.179.2018.09.22.21.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 21:11:27 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 0/2] Add an initial DT binding doc for ina3221
Date:   Sat, 22 Sep 2018 21:11:16 -0700
Message-Id: <20180923041118.8743-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
v3->v4:
 * Fixed one place in child DT node bindings (PATCH-1)
 * Changed the driver accordingly and added is_visible (PATCH-2)
v2->v3:
 * Fixed two places in DT bindings (PATCH-1)
v1->v2:
 * Redefined DT bindings (detail in PATCH-1)
 * Changed the driver code accordingly (detail in PATCH-2)

Nicolin Chen (2):
  dt-bindings: hwmon: Add ina3221 documentation
  hwmon: ina3221: Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  42 +++++
 Documentation/hwmon/ina3221                   |   1 +
 drivers/hwmon/ina3221.c                       | 164 ++++++++++++++++--
 3 files changed, 196 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

