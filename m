Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uqL/BqlkHlu+CAAAmS7hNA
	; Mon, 11 Jun 2018 12:02:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B98A607E7; Mon, 11 Jun 2018 12:02:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtOFaZ/P"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B969C60351;
	Mon, 11 Jun 2018 12:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B969C60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeFKMCi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:02:38 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:40597 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932910AbeFKLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:52:54 -0400
Received: by mail-lf0-f50.google.com with SMTP id q11-v6so30082580lfc.7;
        Mon, 11 Jun 2018 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vl1R30rn3p7XsaxlIzDuw1OeWQEd1xLrteq/SuQsxIE=;
        b=LtOFaZ/PW3oyIMg1nYGGytY9fSmeB4gmO3HySUno/kBU+ctZawbhor0P3vUctky43W
         X6oBAyI8lA2h9rYuewwpSdIYvr4MURpaPOJOdjOoMwRu1iETPds0BJAniCt6ayYAc/IT
         R8nqXxavwXSkSQFLeoo1o4YvOvCbVO0Ff4IxadYjZdO7OLM4hu3rfkWoTN8adm9Tm6jT
         gvf2ez62ChaNggHrNjNw1CB5qD9eOki3TZuZOn/rs2YAH9ueDaLwDK81p+NqlDSkaKk+
         sM6s2oafMZhrd1fViH9+Da7im6dFo6XcoHjtS3cWTBLckzIbnlwyYyubIo/3grZgqi4N
         iCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vl1R30rn3p7XsaxlIzDuw1OeWQEd1xLrteq/SuQsxIE=;
        b=ZTSyNa20gTr4p07zGRfVgzKQtJoi08MQJiun109idYYYXfepmPc1ICSnS7OT5wlDXA
         G0EhjXQPBAgJ7B/QcI8mqJTRaAaVItENqZaDnD5xni3hGYhio0tmaxym8fqHisSP5NJ+
         PEC0idsJy7Mxj63NRjS8fo0yYsBKxbUGBxiTRxVtfOG7I7K8Cvo6CH7BV+mlt/+Btk74
         8XOpZArCa4wdbpFoTvSKfca6RZOB5nj2ez7XfeZrMqozBGrUvh53RrGMjXdRW4wIl5jT
         U2HB0UiUF3MMY0bREOPqGWCdIEPJ98yLUAkjj+JfXxEbY82zc0RCm1KUmo1E6Kl0p44j
         XDrA==
X-Gm-Message-State: APt69E3hRsu355g9zp8TUw6bBBH7IhcGkJCNJG0EwYaN0UBw8+Bt51Y6
        gcENIJEcvLceSXZvihsK/iDkCk7n
X-Google-Smtp-Source: ADUXVKICWU/It/pV97/lQiElly/6impuklU6GgCmJa64dutl+eWowjy45TAwKSuKVCR6cpAVl1tSag==
X-Received: by 2002:a2e:420e:: with SMTP id p14-v6mr12072256lja.26.1528717972367;
        Mon, 11 Jun 2018 04:52:52 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:51 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/24] serdev: Add id_table to serdev_device_driver
Date: Mon, 11 Jun 2018 13:52:17 +0200
Message-Id: <20180611115240.32606-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, serdev device driver can only be used with devices that are
nodes of a device tree, or are part of the ACPI table.

Id_table will be used for devices that are created at runtime or that
are not part of the device tree nor the ACPI table.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/mod_devicetable.h | 10 ++++++++++
 include/linux/serdev.h          |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7d361be2e24f..1877a4e43f1b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -448,6 +448,16 @@ struct pci_epf_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/* serdev */
+
+#define SERDEV_NAME_SIZE	32
+#define SERDEV_MODULE_PREFIX	"serdev:"
+
+struct serdev_device_id {
+	char name[SERDEV_NAME_SIZE];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
 /* spi */
 
 #define SPI_NAME_SIZE	32
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index f153b2c7f0cd..62f1b085a794 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -15,6 +15,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
 
@@ -68,6 +69,7 @@ static inline struct serdev_device *to_serdev_device(struct device *d)
  * @remove:	unbinds this driver from the serdev device.
  */
 struct serdev_device_driver {
+	const struct serdev_device_id *id_table;
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
-- 
2.17.1
