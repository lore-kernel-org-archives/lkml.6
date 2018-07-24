Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441EF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/pKUtvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441EF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeGXOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:32:30 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37519 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeGXOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:32:30 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so2567714qke.4;
        Tue, 24 Jul 2018 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=34Jt/TfiYeD4uFz4HncW7pJOJQ4mwCQSoSXEddzbE5k=;
        b=s/pKUtvwEfrqx4pjXFzt5yXjYTPMp5Li5j7Wfiibn6LkoANnnaKSRdPCJsM6xZGn/d
         ct6amVP+EcxoI/Gobyk0tqTRD86sKLnSTgIadXyMgAvXVg8JGxUjIRQ1UM8xhePVeilI
         oKsb7jvO8EX5TDKjUYhVrCQQNC5TJhfs15tgEOl0uKNkKC4HIuUEJme2XjMfwIPergMk
         +fsfAmmLUhVaqGaGvH5UEB43RYnsCwpwDmeXRBJLe8YahD2OtxrkZQH6b1UVwkk9RauY
         a0ZVwpjMulZsM4BMiRLMst4QPLM6WTd1S4fa/ErbuY//EhwIg2RuukgT9SVdjOUP8vWj
         EY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=34Jt/TfiYeD4uFz4HncW7pJOJQ4mwCQSoSXEddzbE5k=;
        b=uCzGuAC6GYUBxKU0f96DFoIXw+n6oH9dRM71uK5vMkE6stfJHoo7H3n01u6Xvxu8Vx
         /ULAUOJi9JsHZDi8/X7WK7CIJpI2XFzPLeNEhEls6C0wpepVOsePFDnR5fVu8tRBWpAF
         pvYxWIGzb/Jpf5jbPl53+s6PCyJwOkjemwQ/GS04myujT5ywXxxa7+x78vFqI0yxqCoH
         fwn1kGeW6h1m/KKac7BlwIDlQIO3QCFrNI9+vKxRmYLr6GJrZfcjW7/PW+w9NkDMoaAQ
         MQghNbOQgDRdxjA8kF8Udf4/Z+Jb8VXbNSw/QqLecOSXXafLD0eLVQkvfwg02NQ1HYFA
         PZDQ==
X-Gm-Message-State: AOUpUlGgu950b2zolRFD1CerLpqiyTJKlTN0MgRWe5FNcqKo0FQq8LAS
        oOE2/WU6DUepYh7N5TeCFhw=
X-Google-Smtp-Source: AAOMgpf89htX4JGi4EIh6hJ8eFyYte0+pLeeqQWRIUI7IdzTF/1//fj380d4Onrr6p0M1vWvlmvUEw==
X-Received: by 2002:a37:c9da:: with SMTP id m87-v6mr15370792qkl.431.1532438760427;
        Tue, 24 Jul 2018 06:26:00 -0700 (PDT)
Received: from master-laptop.pgwipeout.duckdns.org (111.sub-174-204-1.myvzw.com. [174.204.1.111])
        by smtp.gmail.com with ESMTPSA id e20-v6sm16543346qkh.32.2018.07.24.06.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:25:59 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v3 0/2] Add support for cpcap regulators on Tegra based Xoom devices.
Date:   Tue, 24 Jul 2018 09:25:39 -0400
Message-Id: <20180724132541.17039-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

This is revision three of the patch.
I have changed the device match from Tegra to Xoom as per Dmitry's
suggestion, to be more accurate.

The CPCAP regulator driver can support various devices, but currently only supports Omap4 devices.
Adds the sw2 and sw4 voltage tables, which power the Tegra core, and a DT match for the Tegra device.
Tested on the Motorola Xoom MZ602, but supports the MZ600 (CDMA), MZ602 (LTE), and
MZ604 (Wifi).

v3:
Changed the devicetree match from Tegra to Xoom.

v2:
Stopped reinventing the wheel, using git email now.
Rebased against regulator for-next branch.

v1:
Fix conversion of tabulation to spaces.

Peter Geis (2):
  Add sw2_sw4 voltage table to cpcap regulator.
  Add support for CPCAP regulators on Motorola Xoom devices.

 .../bindings/regulator/cpcap-regulator.txt    |   1 +
 drivers/regulator/cpcap-regulator.c           | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)

-- 
2.17.1

