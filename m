Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824FC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420282154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZq8ePU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420282154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeIVNph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33344 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so3745546pge.0;
        Sat, 22 Sep 2018 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=FZq8ePU7atSHKj/De1aqoz5mzj2sqyFvAlAfJMZFFEb3kefa3CvAK3BBbPqRPpAgTu
         5NC0FTEalVZ0pDDDcL/8U5RkwExTMw1QKlPoMnYGAQlCydqMNamMVSG4BBNY3iIlTfd8
         ePRkXV4DF860gkOvrlr5bwp2R/dIYLgcBnBqZVQuV1nGqivpAKDOdUmWXy4XhSZxSmOp
         6VMDkONsNp4lVlLp0+qogjMv3dSqErSe9Ii2st+WXjjcpYl5SSKmjSYHrkggEffQ28pz
         7FWErag3pQ5mv6NfabcxONl2xWeYdEKH+7jo4txxay4fRBf+fAur4//y9QvQqwTon4W2
         Qhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=hx1zgPCP9LTp3E2h+Olm9M7OBNUqU37KvNy9jCJ5oNySk53nK1i718DBdcnsy665k4
         IF2WW8+5wlI5xW6hRTCveU5GGyhRMO8BTGPIvdfjtIwUhDun+aB4ywMIN40Dd6644tVO
         qRdkJGtwaRJFsEqI2UY+uF2alPb8DEM+0ADsxakOslaYrActESPUeeV9tNiWlUTypym9
         TTka4Q3gJMIwRfeLSByV3rn7xX/l433eARGsmCtgiBlE/d+UR0E68j4bPEmCuSJyVLXX
         Tu1lK5t3ZABrEUvk7cqEP2+k8uvYgNZpx381wcnuB8yb48wCp3r6erMWyfcmYrF4gVld
         JIqg==
X-Gm-Message-State: ABuFfohHqhrq4D9b0BqY3udJt+Z6JkYk6PHf6xGQiL3TnRGvVkbrazyk
        aTTgVqrzTbULt9B+vk8a+DU=
X-Google-Smtp-Source: ACcGV62FafytttGzuwR9XuWtgDWcjoDPpu8WbhfR8HFUim7BIip24mmUxk6s7H2+gPzllLPBeUx5Jw==
X-Received: by 2002:a63:4716:: with SMTP id u22-v6mr8990pga.95.1537602779566;
        Sat, 22 Sep 2018 00:52:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:52:58 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv4 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date:   Sat, 22 Sep 2018 07:52:32 +0000
Message-Id: <20180922075238.884-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is series v4 since my previous patches were incomplete with driver
changes missing.

v4 changes.
squash cd-gpios and wp-gpio changes into single patch.
change the subject prefix to "ARM: dts: exynos:"

These changes add UHS-I tuning for dw_mmc-exynos driver.

Rebased on Krzysztof branch next/dt
[0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git 

Anand Moon (6):
  ARM: dts: exynos: Added UHS-I bus speed support
  ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
  ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
  ARM: dts: exynos: Add CD and WP pins to Odroid XU3/XU4 SD card
  ARM: dts: exynos: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  8 ++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 10 ++++++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.17.1

