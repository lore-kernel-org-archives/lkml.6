Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B050C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB37F206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUsd7wnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbeLNS2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:28:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38220 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeLNS2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:28:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so5717598lja.5;
        Fri, 14 Dec 2018 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UY4MZrqT9fOFmcCS99HsY3w6J1Hvl7LgpuVuFvc2yho=;
        b=PUsd7wnfyputS55sdWacjqL3xgV1uC8A3h2wWzjzlJ6LSiTRlGJAHa+sFeZli6hoil
         BOmdYQ/5q4OODgQPcEtiDwct/jXmZyf1G5YkR2cs+mrD7VAS7RzzYG0FmK+zDMj2xHno
         qIIOB8TSKz+2unh8UicwsM6lPXxZfLqo8Mmrk9qsSc51J2L+3yrgTKEBAYdAS3X+HUZv
         n2l0glwwPAZxqsZOffhbuU1LaPo6uINNuvhLgUJvtta7GemzTAyFXe5IOjGnjCohi9D1
         9HZnMYY94r1U07O2oK67INxJwYgcH6EwcHiaUCe8SBOhIxSlP+oMcH4mI3lXXyhpK5XU
         MJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UY4MZrqT9fOFmcCS99HsY3w6J1Hvl7LgpuVuFvc2yho=;
        b=Ry8locCLyytqn0tRLNFAygY6ELWKnH27JAI/2Iy90Lp0VtPeL28nuDjrJXaMcKba6Y
         6AX1/P8Koqfb4Pw8zHaLO74bVEnMuygllswI+tYYWRkYpje41PT+ja0GU7XA5X8QMABi
         pkvQO+vLlLtot/LgS5zgUoxsUUMcvfhPVEMxwg0HXF0xeiZvVXYT/aclyWb191Jq3gxp
         Nx85iskS++VPc0kimAoukG32/F9BAPUY72CRuJX8jzodjsRIUK7MTVfv39HPXvh/A47B
         0/4J5oggBTtZ7tgwjfLlUVb6IkH170TyKH+7CZG1AxCM35PLgFNjK5V3ZFJZdQY8mKRA
         gXsg==
X-Gm-Message-State: AA+aEWaSiDk2VhGiDmdrmMO0xdoYbqehY+oiQe0Oh9YfGNIg7S/zvIFI
        +8BGr8KSEeMPEp3V2QGl8NtX1mD5yYw=
X-Google-Smtp-Source: AFSGD/WJU1CkJgptkvTSxCHFPEfgaEv3b44eFFGZapg7nbiIsCjIgQ2HuapfFWNGzv0v3HcAEaBx7w==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr2667379lji.130.1544812109268;
        Fri, 14 Dec 2018 10:28:29 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id e14-v6sm947961ljb.31.2018.12.14.10.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:28:28 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 0/3] add support for Sensirion SPS30 PM sensor
Date:   Fri, 14 Dec 2018 19:28:00 +0100
Message-Id: <20181214182803.9006-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Sensirion SPS30 particulate matter
sensor. Along with a driver itself, new channel type and modifiers
for distinguishing between coarse and fine particles measurements are
introduced.

Sensor datasheet can be downloaded from

https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/0_Datasheets/Particulate_Matter/Sensirion_PM_Sensors_SPS30_Datasheet.pdf

v4:
 * this will likely go in next release cycle so increase version to 4.22
 * use KBUILD_MODNAME in format specifier

v3:
 * convert be32 to cpu using predefined macro
 * remove semicolon: reported by semicolon.cocci
 * use capitalization consistently (particulate matter)

v2:
 * add support for PM1 and PM4 measurements
 * get rid of variable length arrays
 * do proper cleanup via devm_add_action_or_reset()
 * add extra level of precision (two decimal places) while displaying
   measurements
 * improve comments a little bit
 * slight refactoring and general improvements here and there

Tomasz Duszynski (3):
  iio: add IIO_MASSCONCENTRATION channel type
  iio: chemical: add support for Sensirion SPS30 sensor
  iio: chemical: sps30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |  17 +-
 .../bindings/iio/chemical/sensirion,sps30.txt |  12 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sps30.c                  | 406 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   5 +
 include/uapi/linux/iio/types.h                |   5 +
 tools/iio/iio_event_monitor.c                 |  10 +
 8 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 drivers/iio/chemical/sps30.c

--
2.20.0

