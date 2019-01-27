Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C359AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CCC21473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enkv7g6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfA0STs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:19:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38734 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfA0STr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:19:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so10235229lfk.5;
        Sun, 27 Jan 2019 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7Xb4yPG85jlMuLRU3473tCMgZkpOw6XFjvHhmT4K6g=;
        b=Enkv7g6hct8AR9cQSRKoF5eXIiFra6+okK/L7hQjsXr/U6t4bdOrO0nA7GLVOoQmMB
         taBg+1w11XNFp6zOrPd/6be82FLguLgGhHVGEoQQSgrCKdoCBDRXyi/KFa6NDXkE6psz
         ik5cmS8Hl60ErEu/WGpf3OKXMBFM91JDF6fBiQSt+SvxgmdTymwZVEafssUGjNFm2cu3
         PbpPiZxWp/lbU4bHDwV1zgfpWxQCAadk4Mx8YuZKDah6sgorFK20kWRDsoTwq1Ox9N89
         OAvaKqdPZ7Bwaeg+UE3qtJNYeytoKPuqqLexNhPIDLJqXD6ZsKMxmp2zkFJn2YGP8saA
         EwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7Xb4yPG85jlMuLRU3473tCMgZkpOw6XFjvHhmT4K6g=;
        b=R3BZp1hgunELDspOA2DTG+pN/2z2qtEaZav1Np59riZOjWgYY+3XYFw1svHV9apIYd
         NKkCpBqSNNi9LBKuOPMM3Qp9hjAQ0C/bu3WNHJWeOMK064W1sdv+MzSOrwP+EVNFl/Sz
         sG/PXqD5LFD4i8HgkXv5hqdbbV7uakP2fkblFVIQOkKAEoccLx0hPEbZC4IjswDFXQxt
         xOYC4Ec6c10mKAMegCsghLHfOvtZECaHL5vkqrU0qun/KSg0uncFnB7WtCOJ6WxQ2qOs
         ko+dli5GeGNZcUGQa48S8fWhxaRbNYUp6JOu4e9L4ck0ieN3jWo6OUlAB1IPBkqbwH2w
         RXUg==
X-Gm-Message-State: AJcUukeL4gAXgH/GeS1Xz89cz6XzdLCAlEoS4JFxl00ss6LWsyMR4MxQ
        p5PlH3PRNgM+IAAjj9cG9QlPeky9eZQ=
X-Google-Smtp-Source: ALg8bN4buBCdc/sb7QZN8lPxJPAbLYfZmQjLi8dNu7bv2J4zTfqqgUh4POCf5pmAKDH/8KOUMRjTbQ==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr13745265lfd.90.1548613185062;
        Sun, 27 Jan 2019 10:19:45 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id c20sm2518923lfj.67.2019.01.27.10.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 10:19:44 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        johan@kernel.org, robh@kernel.org, jic23@jic23.retrosnub.co.uk,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 0/3] add support for PMS7003 PM sensor
Date:   Sun, 27 Jan 2019 19:19:13 +0100
Message-Id: <20190127181916.19948-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Plantower PMS7003 PM matter sensor.

Unfortunately datasheet is not available for download from the Plantower
website so one needs to find it elsewhere, for instance here:

https://download.kamami.com/p564008-p564008-PMS7003%20series%20data%20manua_English_V2.5.pdf

v2:
 * check number of bytes returned from serdev_device_write()
   (due to changes in linux 5.0 serdev api)
 * add missing pins descriptions to the driver binding
 * keep commands in the lookup table
 * buffer data and process everything in one go instead of using state machine
 * keep pm offset in channel address to simplify reading measurements

Tomasz Duszynski (3):
  iio: chemical: add support for Plantower PMS7003 sensor
  dt-bindings: add Plantower to the vendor prefixes
  dt-bindings: iio: chemical: pms7003: add device tree support

 .../iio/chemical/plantower,pms7003.txt        |  19 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/pms7003.c                | 343 ++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 drivers/iio/chemical/pms7003.c

--
2.20.1

