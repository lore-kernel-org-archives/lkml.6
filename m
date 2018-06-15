Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8341CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388FB20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3eKATvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388FB20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965815AbeFONm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:42:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45643 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936144AbeFONm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so9967641wrm.12;
        Fri, 15 Jun 2018 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Pn0n44zKPmOWSd824pfHgLDNMlrKh0VjWoGYmZxYIJs=;
        b=u3eKATvOAq/p3OBDJFe7qV/Oc16KNboDCSguCGfCbTtucgMxTwX8Sa3E8IP63mZJlk
         iEYahQQnuhK2WjOQW5xY8H0ddTE+o2pZu1bwDo6F9rOINYnQV8hfV/tZYT2PWExpSu+M
         IimhDfouNjHD9vjFskNl5raJ5vbW3t7lpyJ3L610kN1f95HSJTNqtNF9m4v8rTFqpah0
         jPlobmy/4uwsf46GWx5rD0OG9OuSf7aouaxYrQJX7KH0ZjOUFl5GRcV6AKRSfrP8MH4k
         v6mslpS0A2ERe8mRFUvquhfo+OZGPBUbxnF5XN+aNZppg3htboRhyCOEFSNmIIyiO/QQ
         HtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Pn0n44zKPmOWSd824pfHgLDNMlrKh0VjWoGYmZxYIJs=;
        b=l7YGqIy/fqK4J6TCb1Vp+Ko1gByWPDMHPwqCzIopYw7gvI7vDiFynFuiNqPM3WDfsx
         qUvdTNXOStbFRh7+vkvY185BVw/Ar2GmNpFiqdAk9YzhMNt8TSNI7L7RZT03khSuFTg5
         wQfFeDv2jXoiIZCqQWb2wNuW9Qiv5ZtKasFuUQovrv8jF4GuswXWwEdPHTB7h6fDmVZD
         V9J7bzo3jt3KENUP01Kt7g4RuB/z4Tw7wjW0APICcLurFpMVe43GQu6GTkBpTgTG1MqS
         c4t9y3MvyurOAfF903VrKr8BZOqzCtdJHsWtT8AXrOb5E3uV6etmBIZ3N8Kuaivw5vsu
         D4ag==
X-Gm-Message-State: APt69E322xen9Z2Odz33Bxm69KCBAbvyK9d0vpASsGdMiu1LXRLHcVV1
        GqAi5QjlWUhxDKIDca0s0PD50m1C6jw=
X-Google-Smtp-Source: ADUXVKLW0hJ6kPm+/vgzPN7aTWY+DUnC8Sa/arSD0MW265jJZ/XruWFqzPF+5i5XJI3l+Ca0v3nTFA==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr1644567wrc.44.1529070144683;
        Fri, 15 Jun 2018 06:42:24 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9816346wrp.64.2018.06.15.06.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 06:42:23 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 1/6] dt-bindings: add laird and giantec vendor prefix
Date:   Fri, 15 Jun 2018 14:40:50 +0100
Message-Id: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix "laird" for Laird PLC who make
CPU modules and system on chips.
Also adds "giantec" for Giantec Semiconductor, Inc. who
make eeprom memory used on Laird designs.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a38d8bf..adf808c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -132,6 +132,7 @@ geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
+giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
@@ -188,6 +189,7 @@ kingnovel	Kingnovel Technology Co., Ltd.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
+laird	Laird PLC
 lantiq	Lantiq Semiconductor
 lattice	Lattice Semiconductor
 lego	LEGO Systems A/S
-- 
2.7.4

