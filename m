Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7368AECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7882089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx1UnMrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7882089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeGNMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:45:57 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46984 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeGNMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:45:57 -0400
Received: by mail-lj1-f174.google.com with SMTP id 203-v6so15335881ljj.13;
        Sat, 14 Jul 2018 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRacs/0sUk8Brhz/EZ6vg8kcRACVqEmifaDYBaSj0So=;
        b=rx1UnMrkGJCUWjv1P0TxlHnEPu/TT193gchHC5L/SutKueFdWUonc7uRlKoELdNvqL
         demXLb/6zFqXc5y3EIbaEMMy5nqD2bVLOm96VgaR5N0F9Dnph0swk6GrLtFEqwhNBgg6
         bpawwHcApqrtxgRlXyZOmTBoaCUG9rwMnX/PrQyLcFjzGZsPa/TvU1iFy5QDg4ym8mzb
         q/g+IMKZolI/Ykx8opohgiCMHzd5vXiTNfTVUeO1MVbvJCj50MvN+qybGjOOh37EOT7L
         3p+GZXiltk+k07H9W/pyY9zvs19/k93KMPNPLSBFgvlx+eqOrt0XqlFfiuPPBJKHFXFa
         BgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRacs/0sUk8Brhz/EZ6vg8kcRACVqEmifaDYBaSj0So=;
        b=Q7mgx5Oui+iM8qRlWaU1vn/to2k80i1QNY3PltYgrr9fwd93wLgtkPtXQU4GARr7KJ
         w3WqW1K1jnrVOWJx4tpyGiTgG+afvL2ey2iX7GsYVJBOpO56Z44XrETcURvCcQU+nuJs
         VY8Ub9tur6ZOQr7iC/VZ+F1F8IjnFV+5RZbZgWT+Qp5T0V5+P9d6Lyg/1QiyVQGVBDB4
         8w7a/SF9xH2IliwYHhv4GCtsKh2oo4ZbdW6LrWuSvWFGTpMDvLhrHWu8e1Hlr7sU7XSN
         g2tLG8tCvWRgy8q0bXh3hInTz4CXbjz5QWnYf3xvrgqepDnhvXObDzHW6gTr/tFnPfx4
         vd2Q==
X-Gm-Message-State: AOUpUlEaWPpdWnD5/OcMRtMSw7SpybQyIT/zMLdFLiF8GlteSJFJY2YH
        t7WVMn+CmAb9nohJR50Gq8Y=
X-Google-Smtp-Source: AAOMgpcbPvZwl0LLoqT/yTTS4oMtGAVfMKMZO2ZBc895r6onLBtxfmR8leTYNaRelCiRD4zan2AlUQ==
X-Received: by 2002:a2e:2ac3:: with SMTP id q186-v6mr5384498ljq.123.1531571219596;
        Sat, 14 Jul 2018 05:26:59 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm5860732lfi.36.2018.07.14.05.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 05:26:58 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/3] power: supply: max8998-charger:
Date:   Sat, 14 Jul 2018 14:26:50 +0200
Message-Id: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series compose of 3 patches.

First patch, fixes platform data retrieval issue in max8998 charger
driver, which could cause NULL pointer dereference.

Second patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Third patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

All patches has been tested on, Samsung Galaxy S (i9000) phone.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit for charger properties
  - Removed already applied patch

Paweł Chmiel (2):
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

Tomasz Figa (1):
  power: supply: max8998-charger: Fix platform data retrieval

 Documentation/devicetree/bindings/mfd/max8998.txt | 24 +++++++++++
 drivers/power/supply/max8998_charger.c            | 52 ++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.7.4

