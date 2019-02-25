Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1DC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0918C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxep7No9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfBYUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:23:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44918 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:23:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id q128so8611166ljb.11;
        Mon, 25 Feb 2019 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZZbDJ03fuvRTtOjkU1SQSqYPNvtWoI29SVzP7AwhVw=;
        b=cxep7No9mmfbbUWbJ830/O89fa1vM6POERPWIScRoV/bm3G1C4eFXcPeaX/RPe/A5q
         3n+jY0nYXVRIO7dbNl+EUx0Nyd9sPiUzbLZ4p76gddMqi04i5PGDgxJakRbSgI4a7X7N
         V+iE1cOEBbuug1GNztE6gZ3GBUL1UU8yRCux8U1cOEJ999wT6lqUSzXngliRtSy4+Qdx
         OQlIezOZzkuANgGvHjSRdS46St+D4oORt0DJbvMANCJ2LtY2OCpcvv6BbrlORLSmBEis
         +JHRuKw5IV8MMZKevhBErSv0m8julpNU6z4rRxrWOEboSvAFnokE3XWWxAnbfwxKbUL/
         IsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZZbDJ03fuvRTtOjkU1SQSqYPNvtWoI29SVzP7AwhVw=;
        b=kKZnTWAeWcAV4Z95KvOHoH3jtfKjyVP3ioAxNaEJLDzA5VEmGkRQ74Kz9zb1LuqVMq
         PTtbJNR3JxtE7/88+lXHQAMHU5usORq9x8neRWOlagcZfDO7SnjBTkh4whDWlFpH1XmD
         1P8u5S4wp/Y3Gft7pQ+X+b2k6kot2F2Kwbfz9KC3FwO5Fwjyeoth5JoVB9QQjYd7Z7eM
         8TN2VKoarT1Ak1flUN8YAwXiZHFeZLHc0rHzvVL/LKDCyreuaZCm7vkhAIohUCZhPWUl
         nQPu6ZvH2+QSfH/sxkOoACCNgKgtH6Bi/UyvKN4dLA72oshAjMrCBUdmhKSQm43UbTbx
         NB+w==
X-Gm-Message-State: AHQUAuYfrb0UkUht9+Okeb2uBfAyAte3vZmTJK7jPNKNhjFgn0F2coWw
        oES3B4ezitDl3c1ig3JsYsHL5RTfyZw=
X-Google-Smtp-Source: AHgI3IZJWz8/WgB7k1CGtY680C4WP4CPq/iUOd/tOpkEM/W4UnL6NEYrM1weRbzlr16/Oal+PpkVlQ==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr10953668ljd.8.1551126232172;
        Mon, 25 Feb 2019 12:23:52 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id 5sm2449485ljf.86.2019.02.25.12.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:23:51 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] docs: driver-api: iio: fix errors in documentation
Date:   Mon, 25 Feb 2019 21:23:26 +0100
Message-Id: <20190225202326.17178-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve IIO documentation by fixing a few mistakes.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/driver-api/iio/buffers.rst     | 2 +-
 Documentation/driver-api/iio/core.rst        | 6 +++---
 Documentation/driver-api/iio/hw-consumer.rst | 2 +-
 Documentation/driver-api/iio/triggers.rst    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 02c99a6bee18..e9036ef9f8f4 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -26,7 +26,7 @@ IIO buffer setup
 ================

 The meta information associated with a channel reading placed in a buffer is
-called a scan element . The important bits configuring scan elements are
+called a scan element. The important bits configuring scan elements are
 exposed to userspace applications via the
 :file:`/sys/bus/iio/iio:device{X}/scan_elements/*` directory. This file contains
 attributes of the following form:
diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
index 9a34ae03b679..54f193edbf8b 100644
--- a/Documentation/driver-api/iio/core.rst
+++ b/Documentation/driver-api/iio/core.rst
@@ -2,8 +2,8 @@
 Core elements
 =============

-The Industrial I/O core offers a unified framework for writing drivers for
-many different types of embedded sensors. a standard interface to user space
+The Industrial I/O core offers both a unified framework for writing drivers for
+many different types of embedded sensors and a standard interface to user space
 applications manipulating sensors. The implementation can be found under
 :file:`drivers/iio/industrialio-*`

@@ -11,7 +11,7 @@ Industrial I/O Devices
 ----------------------

 * struct :c:type:`iio_dev` - industrial I/O device
-* :c:func:`iio_device_alloc()` - alocate an :c:type:`iio_dev` from a driver
+* :c:func:`iio_device_alloc()` - allocate an :c:type:`iio_dev` from a driver
 * :c:func:`iio_device_free()` - free an :c:type:`iio_dev` from a driver
 * :c:func:`iio_device_register()` - register a device with the IIO subsystem
 * :c:func:`iio_device_unregister()` - unregister a device from the IIO
diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
index 8facce6a6733..e0fe0b98230e 100644
--- a/Documentation/driver-api/iio/hw-consumer.rst
+++ b/Documentation/driver-api/iio/hw-consumer.rst
@@ -1,7 +1,7 @@
 ===========
 HW consumer
 ===========
-An IIO device can be directly connected to another device in hardware. in this
+An IIO device can be directly connected to another device in hardware. In this
 case the buffers between IIO provider and IIO consumer are handled by hardware.
 The Industrial I/O HW consumer offers a way to bond these IIO devices without
 software buffer for data. The implementation can be found under
diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
index f89d37e7dd82..5c2156de6284 100644
--- a/Documentation/driver-api/iio/triggers.rst
+++ b/Documentation/driver-api/iio/triggers.rst
@@ -38,7 +38,7 @@ There are two locations in sysfs related to triggers:

 * :file:`/sys/bus/iio/devices/iio:device{X}/trigger/*`, this directory is
   created once the device supports a triggered buffer. We can associate a
-  trigger with our  device by writing the trigger's name in the
+  trigger with our device by writing the trigger's name in the
   :file:`current_trigger` file.

 IIO trigger setup
--
2.20.1

