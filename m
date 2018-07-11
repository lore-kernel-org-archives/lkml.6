Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6081C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3520B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImB6qrqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC3520B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeGKK0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:26:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33934 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeGKK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:26:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so17560351wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Eq3iFgUEMccFwguq5dV7SH8PNRBRjzNzijQtm+ciFpA=;
        b=ImB6qrqclNEWIMr0cj136Y3YF8djtHPwtLXCF21oZ9f0vNMKtqB9VSr+PDJNWJaVjo
         +aTcf+AhMW2MlL4VN9okn9GNNxJ6h1Ub/lID+OAniNE5xoeCL81P20y6euE09shqTfIs
         LIRsChlRcaXimF247peK1rrKy8++VpfevT67M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Eq3iFgUEMccFwguq5dV7SH8PNRBRjzNzijQtm+ciFpA=;
        b=WOThYJHbpt3+t/lpW3e+yjelmhKEkN0+pxdFCT8xeqzTdUGbnbOjvy5LGQ+YW2tSpL
         s1Ei0vzl7ctIBvSUs+/eQ7OdBfmJdFxpoh5jYdC3eMSRR0LAeNpjgHuiJz3yR3qWzxY1
         TYYJWmAtVcBA8U+06Br+zuKIRULtW1UUnTioT6t92oLdPNp+fHHsJvG+3GtPq/SnC915
         qrltdpOBofgPQ6WoqOYJibrdpnmUOh4q8WDZLtFQ4Y9sh80qXQ37hluA89yprE0q7abZ
         XyGGIIiCVa8y2bLhuoIMrMxBFItkahnx4M0eyWFJFdif/TKuSsfqh0rOU2EJPl1Q81+t
         X+zA==
X-Gm-Message-State: APt69E3vK4zJyUK87e/KU0oq8wTUlQtKtDt4bUsXxXlrxV9LJ8+3vy52
        6sDB+tEKsBtAp6A5ibKU55AFow==
X-Google-Smtp-Source: AAOMgpcVDOhAPQpxqLduzZ6/3e5lJlG7lDhPQJUkOxKDeUggwz8bh6SKSveOO6zqwCzbihY4lf3Rkg==
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr20860100wrq.116.1531304571775;
        Wed, 11 Jul 2018 03:22:51 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2462032wmu.37.2018.07.11.03.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:22:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [PATCH 0/4] nvmem: patches for 4.19
Date:   Wed, 11 Jul 2018 11:20:39 +0100
Message-Id: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This patchset adds support to imx6sll to existing imx nvmem provider
and a new sc27xx nvmem provider.

Can you please pick them up for 4.19.

thanks,
srini

Anson Huang (2):
  dt-bindings: nvmem: imx-ocotp: add compatible string for imx6sll
  nvmem: imx-ocotp: add support for imx6sll

Baolin Wang (1):
  dt-bindings: nvmem: Add Spreadtrum SC27XX efuse controller
    documentation

Freeman Liu (1):
  nvmem: Add Spreadtrum SC27XX efuse support

 .../devicetree/bindings/nvmem/imx-ocotp.txt        |   3 +-
 .../devicetree/bindings/nvmem/sc27xx-efuse.txt     |  52 ++++
 drivers/nvmem/Kconfig                              |  11 +
 drivers/nvmem/Makefile                             |   3 +-
 drivers/nvmem/imx-ocotp.c                          |   7 +
 drivers/nvmem/sc27xx-efuse.c                       | 264 +++++++++++++++++++++
 6 files changed, 338 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 drivers/nvmem/sc27xx-efuse.c

-- 
2.16.2

