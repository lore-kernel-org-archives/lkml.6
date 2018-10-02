Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B74C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D485206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isXGeE61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D485206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJBHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:46:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43828 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJBHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:46:06 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so271198ioa.10;
        Mon, 01 Oct 2018 18:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zNKC5IexTJ9xFaJAwWCqBWSTpXgFwMHZAfLsYuCfX/M=;
        b=isXGeE61hEIfTkOyIex5n3r/xtZuNjh6s6QG0n4YLPMTomHceKHcJZix2mhFMXSHHi
         IGHVC//xSu6kbKVxjhOoAqj+IN4axbe5X2+uvEfJuiOtDhnHAcl1by+fMc0BVPBnEFRP
         NkFMgG/4WAxp+RDJqoo4Cc25s6wrMnEc7CKqdHEqCrv0EOS3GZ9SJsLYMJ/QzW6JE9MP
         Eh6DwczEHjYbSqJb2OTamhjG2Vy8SB5E0AC79Vx5bALkjIZZMk9L4XUmiX+JjRJB+K4M
         9zY0/XYFQ/CYKG/aMwkqDpuU9I5lDKTG5Jp68/rnEM1XKbiDJFnykcNDs5ChGXx2pWzG
         mVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zNKC5IexTJ9xFaJAwWCqBWSTpXgFwMHZAfLsYuCfX/M=;
        b=XhlLVmeaAUYbmkIEi35laLxkO97KOop2Y0XZHRM/nDgbUY+FnFWlWTjMY0gpAXPeO4
         BgR9GGrXdYeqVo621GN2sYuG4cr99kggNfUTSKOzV+Sw+a5enmd8jLNYI2vEfPYvGQkP
         fs1yGKppupd5nCuWCfvIJIldzMnl34oFxZzOsEd2PtozfSSAZ9dn1rXBVdbgnAzfadBH
         XDz2BFVwwTsqTralUN4fg1/rDeBShfq41fkPQgc3g5qco7wLuo5fKmqQKpBGqdlRxyrD
         QYikS0BsjzNMM31cGBtk2FyIJVZ1kMEw3khY1bHFGpgv//ALAbDurEt5KT/77tHT/nP3
         lj2w==
X-Gm-Message-State: ABuFfoiTMTyQjajo6hKF5LO2wbJ4OZY8+wyXEt6Owuy2byhfPdBrXiy9
        rWLooHALrf+2em4edo4FRl4=
X-Google-Smtp-Source: ACcGV60yWaHiDIvxOBPPWkJyg1cEojYZPTBZbN9GSYSNpqAd6nqRFmFwsHB/pQYfdj5TGXTQZc6o0g==
X-Received: by 2002:a62:5d0c:: with SMTP id r12-v6mr10182241pfb.123.1538442334369;
        Mon, 01 Oct 2018 18:05:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x20-v6sm26084959pfe.131.2018.10.01.18.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:05:33 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v9 0/2] Add an initial DT binding doc for ina3221
Date:   Mon,  1 Oct 2018 18:05:21 -0700
Message-Id: <20181002010523.2019-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
v8->v9:
 * Fixed a potential race condition (PATCH-2)
v7->v8:
 * Refined two places in ina3221 driver (PATCH-2)
v6->v7:
 * Refined the example in the binding doc (PATCH-1)
v5->v6:
 * Removed status property and merged examples (PATCH-1)
 * Added in[123]_enable sysfs nodes (PATCH-2)
v4->v5:
 * Changed two property names of child node (PATCH-1)
 * Changed the driver accordingly and simplified is_visible (PATCH-2)
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
  hwmon: (ina3221) Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  44 ++++
 Documentation/hwmon/ina3221                   |   2 +
 drivers/hwmon/ina3221.c                       | 235 ++++++++++++++++--
 3 files changed, 267 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

