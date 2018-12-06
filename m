Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE9C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62DA2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcd3IfUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62DA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLFVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:05:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44620 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:05:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so1652440lji.11;
        Thu, 06 Dec 2018 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlckCdPuY2t2qCWWyGwxN4+a8ep4ZV8vwpKhBBe/rkY=;
        b=Xcd3IfUoBMIpAVpGSWJYQvadKlS8CMl0K/jA0jHms0vZUBP3RWEPw7PpDA4P0sJnBu
         xVJLwjj1WmKMWD7kO9Nb+g75Bity61Eg9Xg0OSz79D33oaJ2FJ98QRNpVh0JOOl3hjbe
         jrEFXHIe32/en+ERBAXVuDbqUiFg+egGXLc4rVyE82hUpkBys/o4W4njSiNf2gfpIjg8
         9L5zMK8Rpvifi4NALWBJD2RdLLt69ux9Fa/y3boK9vlvs9zuzH3srPCA5oRi9PHPzKbn
         dg8iDynZtDkxKW5U2DG2uwJ+6kdhDJDgmsQvII9otMXU0yN0CqhFrFfBbK3G0krsg5VJ
         PeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlckCdPuY2t2qCWWyGwxN4+a8ep4ZV8vwpKhBBe/rkY=;
        b=Qo7xhCn7NwLmBAPP0pMCBrJizPlwYI7By5w7CVEzSYglgQqX2ttyHJEzOqJLMrLGoN
         xv/GzhSgJUmj/IWy5jn0GOVYgUbEwO2BVa1Ghoyb9cf9UxNWDgyBT73Z4imNW2HPtvYy
         +uSvanCiG7/PIapMMRzhZlsMcC+cznkDrc+tW2n/Hl2WkMaDg6UjN0qy41jzfU0a4K9L
         W2l0RwS8q3JoQLL7eZhG9Mrp0ay+I4I3G9f+cYgkvYtLA/YcdJIu89xQ/ZJ+Drk4Iron
         3ZMr20pHQ/8BQo5HYfpvlSu73sElyOPSXbsN9wiVVoQQLKwUYXRh6lV+o8HEDJZR9Mp7
         P2/w==
X-Gm-Message-State: AA+aEWZ0744MN69+DkPtXZuHdLgg24C5n1CkEfg0RojZBjpOOTf3ozml
        r7OVKKPMSb3wH5+3HrreZaT3QUZg
X-Google-Smtp-Source: AFSGD/Wp3u5+A4Cn5HOe3az/aTUCQK5egYDuOEZ3VPX8x01gYAnYnQWJf5gj60dlU2My/vT+g12Nng==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr8031302lji.93.1544130309269;
        Thu, 06 Dec 2018 13:05:09 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id e94sm267366lfi.23.2018.12.06.13.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:05:08 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 0/3] add support for Sensirion SPS30 PM sensor
Date:   Thu,  6 Dec 2018 22:04:40 +0100
Message-Id: <20181206210443.21052-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
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
2.19.2

