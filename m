Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4967420818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBvVb6Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfBERMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:12:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37346 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:12:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so2529498qkl.4;
        Tue, 05 Feb 2019 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ny9mDsm0gK1seokI+RlknD9vLulYoiTeF8LzfjgbIVQ=;
        b=PBvVb6MpGTGyLC+3NrKz0nP4+CQtJtbqbGgtfQ1Pd+nEXfwLSCiqr5t1of7YzNugyI
         WYEqEoFHqCPtv6cr2DiyLER9yYSNoRKZWfBUfl+vdRoKAP1/VQ+I8efeGd9gR0mfkCzR
         RYtBlm2ZVyvQnILeT5ZZnfpdtvHKHoPv7M3vPqSAYDdhc9B6wow36ASXg0OqNEipMWOj
         QAdwQh3JQe439ZYmZhH/srASIWjzzShSxAaak8cj/TBB2r5US//1Jf+bBYj/kbiv+nUr
         Bma4ZI8vmpzIS2dDBEiUYrQLtvaSD+NELNBP7dI1kA/jDupx90F7IzJecN5Kn8dX5O+r
         leaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ny9mDsm0gK1seokI+RlknD9vLulYoiTeF8LzfjgbIVQ=;
        b=YWBM578oST7dBPkXlMpQW5kN80SNr4qTZFFsJE6GzTLIAqxOyH2hUg8O8CO4XWZXQr
         LikchmBJjQ8nayFc5MGcbGBCzmLy3pUBht2n5Uq/UwVwOM7Cqxj/uNF0hsxURVCvX5VL
         AgmxEluWfJPd0yXMKl7e0XYVyyrngHuIrWWF1DNvKrEYfx/C5eVPCt4ooKzIwF3nm1lO
         Nq8qU3tjVFP8c69W9WrRFy33zjtdkJtjYRiwhxUF9zyiqqrVWjToDqp89xbZlxCm9lLU
         9OOPuXAB92LkVlG5wKRKFShCalEP458JVDD6nHQUVuzCc1oGnX2gW2YePpXfFOeo2rkq
         XibQ==
X-Gm-Message-State: AHQUAuahgwDRx5IPoT1m4SBOwZdFC7mzPJ5STP0hjTdPP0Z9kKw6yABC
        cpU+rVjM3RwVkyeOespYANg=
X-Google-Smtp-Source: AHgI3IaoD/oVMdbXjwO4kOfls69wvRXPTt7dXMK4DGsOiu2lDqJHqT1CGHEHU1uGVeMopjZ4OgmWbw==
X-Received: by 2002:a37:494e:: with SMTP id w75mr4311183qka.52.1549386768141;
        Tue, 05 Feb 2019 09:12:48 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o128sm15089366qkc.7.2019.02.05.09.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:12:47 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:12:42 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 0/4] staging: iio: ad7780: move out of staging
Message-ID: <cover.1549385784.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds user input to ad7780 'gain' & 'filter' gpio
pins, moves regulator initialization to after gpio initialization to
maintain consistency between probe and remove, adds SPDX to the driver's
license, and moves the ad7780 to the mainline.

Renato Lui Geh (4):
  staging: iio: ad7780: add gain & filter gpio support
  staging: iio: ad7780: move regulator to after GPIO init
  staging: iio: ad7780: add SPDX identifier
  staging: iio: ad7780: moving ad7780 out of staging

Changelog:
*v3
	- SPDX and regulator init as patches
	- Renamed filter to odr and ad778x_filter to ad778x_odr_avail
	- Removed unnecessary regulator disabling
	- Removed unnecessary AD_SD_CHANNEL macro
	- Changed unsigned int to unsigned long long to avoid overflow

 drivers/iio/adc/Kconfig          |  13 ++
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/ad7780.c         | 359 +++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig  |  13 --
 drivers/staging/iio/adc/Makefile |   1 -
 drivers/staging/iio/adc/ad7780.c | 277 ------------------------
 6 files changed, 373 insertions(+), 291 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

-- 
2.20.1

