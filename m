Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600B4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC62087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjYX/up5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAC62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJVU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:26:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40740 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:26:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so18985502plv.7;
        Mon, 22 Oct 2018 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGnQnh9pSjdWkaRcOQSlf8jt8zh/2L9nHuzvcwoIkUM=;
        b=ZjYX/up5UxOSZXaGEp+lSJ044zru4guyIkuB/ob1BoGSoUJym/wJDjPxjS52C9sMZl
         M/dnDwVsmjeTHd1ThwQK0ry0EvHFQ6ij/FZEKCUE7sSffeynpnZ72WW3HvX9cH9lLCDY
         X1tjifWeLPPXTYIjYyaZ69hsa1v3KufR17rR7hm7sZDQBk/Ovy6vJ7O4ndwWEv43fFlY
         5MFKGi15syhjzF7SYW6HZJpcm50HAr4NM6hlu4tpZ/zaZHklkZvpSurZryt/KqAn5PRk
         Eyyo8guMPqDNwPAFnZOFFVTciCpkpf1o4/G57u4ncm3P/F90viD5H6zWFGd0bitWdOjj
         Oyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qGnQnh9pSjdWkaRcOQSlf8jt8zh/2L9nHuzvcwoIkUM=;
        b=XFDrvdprExeHQ9JHsPuSjnKSYgB4FrOuKeM1dwD9OGbJWMBfqHoHhI7q9ISxLsw653
         6mfEDfgq1sCgEcgmUi+e5AKigjgbusRlsqju5rvVB7frSTLgADW60PdhH+57NawdIGoZ
         ebHSb65nLKccDcDVFZmqQ5jXp5vEdLhfE0rFnR2rXQE9qEBXPpT15oj3KqP7TcEoI+A0
         fjFFTEvuMaE5+E0QcZHRn9BpX9U6Q/UnGhyuzQlpUGIR5eOjEo/NJeIoBM5jwwCCWg0V
         v3jDeqzr1/53iNJFUBSmaDakWKrsL8QI8VOX00J7GeElh7Mz1LGB4BUGbWXw4xCIwrJt
         eGYA==
X-Gm-Message-State: ABuFfoi/lccf30qsfbUulctbxScg/so1ITQvTRneWMjQ1tqbwj4B64QX
        XYmB410TjWfngrBZMJziGiIbjxzJ
X-Google-Smtp-Source: ACcGV61Rbxo8U53fww//LKYE/lFPVINvybSIMA8fjQUbm7NbG2QnpJbDCuyf93bCsPAOw5sFCUyLqA==
X-Received: by 2002:a17:902:e201:: with SMTP id ce1-v6mr43114482plb.47.1540210093937;
        Mon, 22 Oct 2018 05:08:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id m19-v6sm10553986pgv.93.2018.10.22.05.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:08:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/6] Mask read inputs for get_multiple callbacks
Date:   Mon, 22 Oct 2018 21:08:07 +0900
Message-Id: <cover.1540209293.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation for several drivers' get_multiple callbacks return
additional input states that were not requested by the mask passed in.
Although the current caller in the kernel does not care, it would be
prudent to ensure the behavior of the get_multiple implementations is to
return exactly the requested input states and not more. This patchset
ensures such behavior by applying a final mask on the read inputs before
setting the bits array.

William Breathitt Gray (6):
  gpio: 104-dio-48e: Mask read inputs for get_multiple
  gpio: 104-idi-48e: Mask the read inputs for get_multiple
  gpio: gpio-mm: Mask read inputs for get_multiple
  gpio: ws16c48: Mask read inputs for get_multiple
  gpio: pci-idio-16: Mask read inputs for get_multiple
  gpio: pcie-idio-24: Mask read inputs for get_multiple

 drivers/gpio/gpio-104-dio-48e.c  | 2 +-
 drivers/gpio/gpio-104-idi-48.c   | 2 +-
 drivers/gpio/gpio-gpio-mm.c      | 2 +-
 drivers/gpio/gpio-pci-idio-16.c  | 2 +-
 drivers/gpio/gpio-pcie-idio-24.c | 2 +-
 drivers/gpio/gpio-ws16c48.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.19.1

