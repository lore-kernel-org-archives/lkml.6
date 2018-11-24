Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F55820868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKhAr+CU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F55820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeKYJEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:04:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40171 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeKYJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:04:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so13356712lji.7;
        Sat, 24 Nov 2018 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YixfoGq2C6OjiqyibDtG2o7lmVehH+2+6x/tT8ESK+s=;
        b=kKhAr+CUkhIlMmYPQP4zWvvbpinzvmMBhzFaBTzW+/4lnGVgYf28KTmJGHTnXT13KC
         Uc7bcF9JAHGHOKKLaoCpjZx7TLe2txeAtaZZR+8LWfm/1IKGNb5qW9LfB49J9N14LMAQ
         98NcZh0Gg+W3eIWQTBIUlKGOpinNKTfdXlDLqttcZ3NRA0Q8jH/TKlsS58Wjpv04nnI1
         lie2hnQLEwawzgcGSS6fk4UAwSaGuEr1JnC8uJwoRp6m02ciLjb43Gjplu5zyBeho55T
         dIhWJnoQ3+ZHLJrL2Y6E9q9FajcopX2pn+ryh+8UA/IMdjRuJjiE5gYMk9lgcYKLfIe7
         68kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YixfoGq2C6OjiqyibDtG2o7lmVehH+2+6x/tT8ESK+s=;
        b=SsRxFNhGMcgOwgYmhiDX88YfjhxZzltHPqU1xb+/hb2+CdiYZrSbbIC4ngG2NJwdvt
         V8UaPo7XUUyA/DQODFrqAEpCKCdiebpEK+Nk8SSMr2WlBzsbZpaOVwwCG/3PQmhZSOgQ
         QNlZSuw28pxowJBo5hV9CdqZwVKEL7sGHJJh8WTwCJZic4obYDF2UXs7+UgEIO4e/ffj
         IbE6PK//DjYLmyH3erFzh3bLgI4NcrLyXahy1n6SIXLsNyxEYsVgLrl0IRpA+1uCp24c
         9QFsZNxTqw5E5gB+F7RsoFWPcJWRq7a0h1KDrTTSqEouYq/UFSvIrWgNt5aQZ/KJuNoH
         AGRg==
X-Gm-Message-State: AA+aEWaW0sWdu4N5WRj1gwua4dG/T0Gu2AgAV0OIpqDdDtN3MrSNWLnc
        6j2wtrtwLcRdJ+8fXV50gQzCntpBSno=
X-Google-Smtp-Source: AFSGD/W4CD/ylh9NyMjChUPWmsvuGg3hzXPKKuN/70CSa4cgNT2hpH9CaCUPBAkHFTzn8qrStWYkFA==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr12668273ljk.109.1543097674205;
        Sat, 24 Nov 2018 14:14:34 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id x16sm8369281lff.26.2018.11.24.14.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 14:14:33 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/3] add support for Sensirion SPS30 PM sensor
Date:   Sat, 24 Nov 2018 23:14:12 +0100
Message-Id: <20181124221415.10081-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Sensirion SPS30 particulate matter
sensor. Along with a driver itself, new channel type and
two modifiers for distinguishing between coarse and fine particles
measurements are introduced.

Sensor datasheet can be downloaded from

https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/0_Datasheets/Particulate_Matter/Sensirion_PM_Sensors_SPS30_Datasheet.pdf

Tomasz Duszynski (3):
  iio: add IIO_MASSCONCENTRATION channel type
  iio: chemical: add support for Sensirion SPS30 sensor
  iio: chemical: sps30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +-
 .../bindings/iio/chemical/sensirion,sps30.txt |  12 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sps30.c                  | 359 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   3 +
 include/uapi/linux/iio/types.h                |   3 +
 tools/iio/iio_event_monitor.c                 |   6 +
 8 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 drivers/iio/chemical/sps30.c

--
2.19.2

