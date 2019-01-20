Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF58C676F4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B1E2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uppWnQw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfATPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:36:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46855 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfATPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:36:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so8543666ply.13;
        Sun, 20 Jan 2019 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A/Jsitz8t0jwpJshk5WhVv/ja/VQeqHos6vsHDkCVrU=;
        b=uppWnQw5eTJldWpcJVLa4/P3LQCF5tLUBMEl1vGigc40jmMDj/Ef+56OfLdk+5VR9e
         xDypksZ00kuroPQFtWTPMP9Jxo4d+ZGtC8K+JailCkcsGZrFQdk7oLLhBeZIvUOaDfHY
         mZIwfscRxG8fd/xKxT1ohcs7beev1Q1TdDQ8QgIUXPPezqEjErE11AQpHVg1AFjVuMs6
         ifjVOTFUX87WHqT/9kt01p0FcCQ+skyW4euvT0nlE6qdJ0BjhIw/yT0Jk9Lw69rHTAQ2
         MhcjBRYdvjs0ujZEbrJX86Ipj0w7lulmK9sxRjAzWvZ7ei01C+mLcHIzqbqRorO1MF4X
         elwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A/Jsitz8t0jwpJshk5WhVv/ja/VQeqHos6vsHDkCVrU=;
        b=INle0vWSnm0T8JD/Nh/jXMa/VUvvFg7/ozPg+Kb3LHv0LTl/Bvhex/obIZF0u+TJLW
         jJIn7vyOv9Ff380PpMGw6JFmge8TK86aGaplj+lw4PY0TngyRkyywzT+og9StPzylXgX
         ddGE6bJcevCLi1VnlToi7fSNcSMJtWaM4kngwYmJ5TiMfjihKk3qnVxW8bgPBN3pBXQJ
         zdHDuhnO3QQS/bNr41XPHMOkZvJAYQ79nEUjR1FF4YGCVDNjbp1O+X3ivQJx470CUGuV
         +K9saqDoMhQvt6SfoDO9UC4OpPJKbMKv27gfNQAHU/Pi3HUM04PJFaVzh9xPe31nvrPO
         FFMw==
X-Gm-Message-State: AJcUukeO68ack5qJ4+zXlDqAWvGetrz9R7WBh3qF16dlFJdrEZ/CbclR
        blOKP/hPDL4wCDJMX05nkCc=
X-Google-Smtp-Source: ALg8bN5LgM1ijcYE0QF6IBdl57lawk0Rn2bjkzRVcJuBqQdWQmPRLzjTDzk9+MOH1Ghw4g4Lzfy6iA==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr25172806pls.124.1547998601077;
        Sun, 20 Jan 2019 07:36:41 -0800 (PST)
Received: from localhost.localdomain ([223.189.18.171])
        by smtp.gmail.com with ESMTPSA id o8sm21451376pfa.42.2019.01.20.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 07:36:40 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v3 0/3] adt7316 regmap implementation
Date:   Sun, 20 Jan 2019 21:06:30 +0530
Message-Id: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consist of some initial patches for heading
towards the regmap implementation and also the final patch
which enables the driver to use regmap API thus removing
the redundant and common code.

Changes in v3
  -Fetch the changes from remote and rebase to have it in
the current working directory.

Changes in v2
  -Change the val_bits to 8 and add two more patches
having a different change before the final implemetation
of regmap.

Shreeya Patel (3):
  Staging: iio: adt7316: Remove irq from bus structure
  Staging: iio: adt7316: Remove multi read and write functions
  Staging: iio: adt7316: Add regmap support

 drivers/staging/iio/addac/adt7316-i2c.c |  97 ++--------------
 drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
 drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------------
 drivers/staging/iio/addac/adt7316.h     |  15 +--
 4 files changed, 103 insertions(+), 251 deletions(-)

-- 
2.17.1

