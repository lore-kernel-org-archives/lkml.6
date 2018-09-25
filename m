Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C430C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D482089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJjsU2rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D482089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIZFJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:09:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37087 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIZFJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:09:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so5644789pgq.4;
        Tue, 25 Sep 2018 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k6MM5l3O6/jSpLZtmDL2tdeUufk2+IOqsfl0XXbFTdA=;
        b=fJjsU2rVW9yksyqUn/6fR6CVaMB1HAHPOCAS76T6IHJXmJeYkaccPtP4Fb3Y81XXCd
         tOmtCZsdcwQuaE0vqUISWuFU8l9vms3gjlyWuMQKHjOXcc3/hFi3lFXQutqpsaqCPqtE
         fbpAszaW7OdJ/gW0b9Crjf80pCozFIW/hgI8wb2Qy9AmOUnR0jXOo4C8loqezP4iIiWy
         kNFv6/0H+0w7Kyx5FnjVc8lnkGsGc99O0W2srQDKuRwUs1gF4tXrhoYLekbVlVI8lYYX
         9u9oN+Wgc+xpE7eoa1Y8Eki4+wtsjUQExNnnS7aZf4uqiDCYZWyKrAkal8SUOvyNInlV
         Fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k6MM5l3O6/jSpLZtmDL2tdeUufk2+IOqsfl0XXbFTdA=;
        b=GvUTQlr4N2k1I3OjWVYoVnOiSG3NMd5Sot68ZBIQ7HtCBLak21CtgijUIG57tX2EPa
         Ae4pxnWjDwErfvv3FEsQ+gBtCbiIUbZ9JUY7NMiGLCRe41FmU7nmWwoYDhI1+BgqY5ig
         3e+qHZuMpB2cnIxro2J6VynKjRZCpQbvqQhCs3bhpf0nHmcof5dMvnMgX89fpLsf18Ch
         sd8UxCuiFqRYcY02jamBq4u4JlyUG5BjNuirZKYaMl78TZFt+QL+1p/zGN/FZ3g8zCDa
         84aLE7io7Qu7NPU1GYNOVRgu41VfkOSBY3xsre4IhHHR7ifwCHBnMEDdQVwscciURMkz
         z6vA==
X-Gm-Message-State: ABuFfogncuJ/L8c4l6fqJO8ejkze12TkWVrfsD8WjPzGMahcxOsGmvA7
        +TLob288CbY9w0Bwc98U0i8=
X-Google-Smtp-Source: ACcGV63nKKtQ3t23Nvfa8alxWvsu8xeAUkIo5/nJJIrxStuDOKEK/jHErcTrtGy58V+neJM29AFe0g==
X-Received: by 2002:a63:c608:: with SMTP id w8-v6mr3045693pgg.16.1537916390702;
        Tue, 25 Sep 2018 15:59:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n22-v6sm4652579pfi.185.2018.09.25.15.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:59:50 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 0/2] Add an initial DT binding doc for ina3221
Date:   Tue, 25 Sep 2018 15:59:28 -0700
Message-Id: <20180925225930.31886-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
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
  hwmon: ina3221: Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  49 ++++++
 Documentation/hwmon/ina3221                   |   1 +
 drivers/hwmon/ina3221.c                       | 161 ++++++++++++++++--
 3 files changed, 197 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

