Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9B320879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2WxXtaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeL1PqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43387 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeL1PqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so18986672lji.10;
        Fri, 28 Dec 2018 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMbZvYttrIY99MsgX7LpMwSGvXx+jLrWuoMDuLPvPrA=;
        b=Q2WxXtaCtJYeaBriAn93J/ro47iolSV0RuP1CyrcaDfTFT2q1ch2hAXQKmvP2+TOgC
         EWHZSCE1hveYqHAyrGeLxTCBjZ8UKyAXP8vyQRxVnpZvtCpTLV3et7Tqb/mN6Rw0vWGU
         d9qzD4lpF/CaLzbTLwowzqRhEGVsKLhKgcVo1E5sJtuyh2TrGOgJnTTIqInG4IcQVWkK
         TDIcvbFyS22TLpudoTo8yY0iKwMOssbx3lDL9QR7IQ/IUZPPbyyjWVme1qLiR/+6QKG9
         jTNdxC84owqMR8wUzDj0F76r2s7Atzza8/nWUT21nB4Um4an4SQ3SUY63gBOA5nhdIYr
         u1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMbZvYttrIY99MsgX7LpMwSGvXx+jLrWuoMDuLPvPrA=;
        b=oii/SmDDKLYmC24dJKb1C0iFIAmq4L+PTrZzbggKlqb5H8CZtCrBKa53n+hqMNJ8oo
         HmrFqtLotD14uQmDfR3rAfLocULLkCUjPo1UvZ/hhjEBKx/atRIGgOVnRvRk9JGW75/F
         el+P/NCB+E/gzLfrrQATAxtBBa/0+TTRvuWFnftwxnkZ8SepKVEdk65TYkQb6cjf+qqn
         t8s0uc86aZryFKHw+UGZy9YLCEx0ivr1bMnidbsGFN5RV757oV1N66MH5gcIP4Qq7+xD
         StxXMGb71BTFR2t75TTrMDhhomOSz5VzRJ78ntTKb6NgDKwzlLssRucmAL9KIeyCgDMn
         Wmww==
X-Gm-Message-State: AJcUukduZmPGzz8nia2e1iX/hXMwDCxnGAFsaJKuIMoxt/KfkUiRFjxx
        uIy1aCmfAoZe7+O8dS9Qkxw=
X-Google-Smtp-Source: ALg8bN7OZLhtQ63WvQljilzCNFHHizIlMUhhofke9JjeN0ha0yxzG7tN6jRKo1pEodCyB5+0PNtGow==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr18356224ljb.89.1546011974750;
        Fri, 28 Dec 2018 07:46:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:14 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 0/7] Input: tm2-touchkey: Add support for Aries and Midas
Date:   Fri, 28 Dec 2018 16:46:02 +0100
Message-Id: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches adds support for Aries (Samsung i9000) and Midsa (Samsung S3)
based devices to TM2 Touchkey driver.

Changes from v1:
  - Added Reviewed-by to some patches
  - Use ints for keycodes (they could be bigger than 255)
  - Droped separate name changes
  - Added missing const in few places
  - Removed redundant cast

Jonathan Bakker (5):
  Input: tm2-touchkey: Correct initial brightness
  Input: tm2-touchkey: Allow specifying custom keycodes
  Input: dt-bindings: tm2-touchkey: Document new keycodes property
  Input: tm2-touchkey: Add support for aries touchkey variant
  Input: dt-bindings: tm2-touchkey: Add support for aries touchkey

Simon Shields (2):
  Input: tm2-touchkey: Add support for midas touchkey
  Input: dt-bindings: tm2-touchkey: Add support for midas touchkey

 .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
 drivers/input/keyboard/tm2-touchkey.c         | 132 +++++++++++++-----
 2 files changed, 108 insertions(+), 33 deletions(-)

-- 
2.17.1

