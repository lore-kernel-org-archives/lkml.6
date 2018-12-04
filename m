Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64692082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vKicm5Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64692082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLDSP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:15:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36330 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:15:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so10371430wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PfOlnn1f4fKIRQOM4y1sfcAwAKRvx4cSG/oBf5oTFo=;
        b=vKicm5Jn9RzceO/lkcOPMygQJ3ycuZ16L95jXTrC9u9VsXYxmM9KbMDZvOPY2kFM3Q
         Cv5W7/51tcrmTnp5iHhClhR5hpfeqi+4QueXBWzOAUpyO+m+whJeOuCCC/m2GLTb79Rm
         ZUu7XFiUBlLEjIrVpswdbVZlHrFjw1x4LGNlxVLADirf/HWZcSAfEnglUMLGNPos7XYt
         xyCD35Oc/xR1fF60IWk3q24dWz1U14FC4aP92IFUO/3MdiMV+kCrOhq+dyI3dojhFsKr
         Z1fagvjh+lh3rhBf3/RwrOnKmQE9j9YV6V7Y/goaxWuyhH7nNvCawgLmamgyrtWObL5x
         J1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PfOlnn1f4fKIRQOM4y1sfcAwAKRvx4cSG/oBf5oTFo=;
        b=Jvv2yotCm6+gWqMDOskiZ0CvrVj9S+3idUIyqaQOv/PFE+umS2fTu/HHQ0kKfsspWw
         9Jn0FmY/EYS0TcpRJ89Jvt33ygYghDYflltINNIEYdr7jiZPi9mJvUMeQ0RG0eF3cf3s
         zak4XnGyaUV+ye/lsQhTeROr5NA+2eEFIaDPLBSxVK6lJ+VTGLRbQS2k1oPnaAU22xWi
         9Sq8ShTt6uTcyhHeQLYw3SyJcBYDyriKoIkm2uJk8CHoBU5hWX86ycF0ZPpQ61+2mq5q
         +jtpBdfpC9//vRhdp+bj02bWk2pkU0Bd62oHQqo3JWahCVZfz0EGh/aqxg0HO6/F2ViP
         V71A==
X-Gm-Message-State: AA+aEWbns+RpLjyr9Yn+ZQSRg+xWuMpTmWX9FW6QACEHGak1j/DY3zRw
        /Yh1CSBpqTbnTeB9RYonp1ZXqg==
X-Google-Smtp-Source: AFSGD/V2k9RSFuN5wdDqEJxLmtQv+cqUgrqdQGzVccZkult6Z3s/4Mjqze+VYN6wW+URUBchuz6PWQ==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr14216454wmh.114.1543947356561;
        Tue, 04 Dec 2018 10:15:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm37942897wrb.93.2018.12.04.10.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:15:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/1] regmap-irq: support chips with separate mask bits for irq edges
Date:   Tue,  4 Dec 2018 19:15:49 +0100
Message-Id: <20181204181550.29122-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'm working on an MFD driver (and its accompanying drivers in various
subsystems) for a simple low-power PMIC which exposes a single GPIO
line. It has a couple of interrupts all bunched together in two
registers and all of them but the one for GPIO are controlled by
single mask bits. The GPIO interrupt is configured with two separate
bits - one for rising edge and one for falling edge interrupts.

Since the device is relatively simple I would really like to avoid
having to write the entire irq_chip boiler code if regmap_irq_chip
would be perfect in this case.

We already have the type mask fields in struct regmap_irq. This
patch proposes a simple change that reuses them. If the mask_base
and type_base offsets are the same, the enable callback will
use the bits written to the type buffer by the set_type callback
to only enable the requested edge interrupt.

Bartosz Golaszewski (1):
  regmap: irq: handle HW using separate mask bits for edges

 drivers/base/regmap/regmap-irq.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.19.1

