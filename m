Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E1920868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+HbEDD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E1920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeKYJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:04:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45066 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeKYJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:04:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so10886742lfa.12;
        Sat, 24 Nov 2018 14:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=P+HbEDD7S3tijmzF5mUDpL6PzzMVdhR7Sgv3RYIrG9pek+X434r375IqMvaioHTMTV
         sdXjQmrv7B3TsdMAFOjFrIAnNleGbXgHurxMNj9vNrXd5EqdzF7m5BkWEll17xehDTeV
         v1tNr9Rf0GiaCIv2gWcEjax+f8dJTr6kl2xUPRhDgofOW097/LTomZDOzny8ri0E16OB
         HDGkkTTUkffqInPsMCHHoHBctNZy/l8vk08GRMbKBenXZj/nN6a2+woQPRBoIjZYhHC4
         QFVXb6ZIWSzqgpRczWbQ3w8VMi+eXojx5tm758OennOcnZyIhGXSQohn+48w+mDcKOj+
         nOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=FqPMPV8EzRxmCQu1djl4QuqNc6SwETif0d+/Ga+ny/jc5sirzBF5BNytnQSF5o18mk
         A54lLE3Zqp4FnTyAIosdkzBOnH6kSAeunPqIGaDtox8ZmLmLN8VTTZPS2ZiQe3D4aVZi
         N1A5j/zvw7wFho0C3YvKfpIPnxep0DdGI33/trRrZaVXIE/Q4Oe1m2AGWElKI72XbUFs
         tYgYT43K7QH+LfqCBjEm/B5vlBkYX9bVb5ziTZZh2ghS2VPqjZIWvn30FsbzUfALhECo
         +gmibfx2jayA5dvdeJz1otGSy3b8T1eQF1LKTYZEoLW03PU0LDj8f/76TfCotYN9NOXz
         /gPQ==
X-Gm-Message-State: AGRZ1gKwWjfK4Af4avU0CdHgZnYueFC2/OjnCFBmSadunw2yhAakpAsp
        gQ7NGqlxiKRGH8OxpUwujx9s00abfxI=
X-Google-Smtp-Source: AJdET5cFwAqQZTtwVJDczTXMUaN9HUW9hV+rtncawVZp+Zeha7BY74DUBO3UQel2gM6naN6C8VWw6g==
X-Received: by 2002:a19:d287:: with SMTP id j129mr13160029lfg.26.1543097677576;
        Sat, 24 Nov 2018 14:14:37 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id x16sm8369281lff.26.2018.11.24.14.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 14:14:36 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 3/3] iio: chemical: sps30: add device tree support
Date:   Sat, 24 Nov 2018 23:14:15 +0100
Message-Id: <20181124221415.10081-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181124221415.10081-1-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Sensirion SPS30 particulate
matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
new file mode 100644
index 000000000000..6eee2709b5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
@@ -0,0 +1,12 @@
+* Sensirion SPS30 particulate matter sensor
+
+Required properties:
+- compatible: must be "sensirion,sps30"
+- reg: the I2C address of the sensor
+
+Example:
+
+sps30@69 {
+	compatible = "sensirion,sps30";
+	reg = <0x69>;
+};
-- 
2.19.2

