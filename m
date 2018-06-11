Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D+wsKWxjHluKJwAAmS7hNA
	; Mon, 11 Jun 2018 11:56:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9199D607BB; Mon, 11 Jun 2018 11:56:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWI2t9cF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DFD2601C3;
	Mon, 11 Jun 2018 11:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DFD2601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbeFKLxQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41852 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFKLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so30063400lfa.8;
        Mon, 11 Jun 2018 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/Er5c2agXirdVWTPsUVQ80WpHs5LIL53DDkg9dnPxI=;
        b=OWI2t9cFucPuSV952r0jl5aGS/kvxZ5YUhnvX68A/4NTPgZFph3IPe7LUDwQ7I61Cn
         Zfx+KzjpDumSLkhIeRWmfTiGNuY7fe5+jtfRPUH3qbqoZ7Ul0Wd0876w4B1xsaDTZNNC
         C52PCpvecSrvmcgkO7ITRgVVzipkYmNrzvmXS4Onp1W7DbjIz1OAHGYNX5N5tF5vk1tK
         BzBkgljRgVVYa1L01LNt+jx26q+dkW1mjt1KXN/xQdnif+GYnZitEQSLy/0OSmh2tpGM
         229kYiou0YDmUY8dkcDDPKKFjFGwvsc9HjvvxymjnsKRncQeWER6iIs12lX61x5NRw6g
         qJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/Er5c2agXirdVWTPsUVQ80WpHs5LIL53DDkg9dnPxI=;
        b=iHgssAoFhbzYeBNnZvhsxtDMg14fZB+3A7SwVEpv8Wig94bbWUN+2qJJSCs1ROLCqM
         m2qyri3voMsGpPTJeF/gRodKCocSGruu8yATzH09ugiPcJ9eDRBQUh/GISQySZPV0IY7
         LiHCkmRurYQDb8i5MJ+cj/Utgs0FGJMwUvYSMXgZxpOaRgvIzKhYrCmdWn3f8NcEobB9
         SZ8l1Qc97BCpfBtcvvDZsUlHpLNbQPi5c904qNEECXnDzbvGOZQqIU3q0My/g//v8Nzv
         fDSj3exm8+5pWFNw2agwcNWSmQgoETNHH4riCeRraSIR3XFJbyRvYsK1C9dDvFOjvLOU
         aCUQ==
X-Gm-Message-State: APt69E027b4QXIdl3LjKXpJdOzCSPDUmwZMLsVr6pI4u11DQZdFmXV/l
        7uu6aWa0nHY9vyfdI+RTDFyBvgai
X-Google-Smtp-Source: ADUXVKLkQFsR/vMyy9FtPPowGdpNV+OLVVrICUrfFFFFiVyTs0AYMSf5bibLH8pyNnn6fZV8yNlFfw==
X-Received: by 2002:a19:944f:: with SMTP id w76-v6mr10652125lfd.90.1528717991300;
        Mon, 11 Jun 2018 04:53:11 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:09 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 10/24] file2alias: Support for serdev devices
Date: Mon, 11 Jun 2018 13:52:26 +0200
Message-Id: <20180611115240.32606-11-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows file2alias to generate the proper module headers to
support serdev modalias drivers.

Eg:

root@qt5022:~# modinfo serdev:ttydev | grep alias
alias:          serdev:ttydev_serdev
alias:          serdev:ttydev

root@qt5022:~#
	cat /lib/modules/4.16.0-qtec-standard/modules.alias | grep serdev
alias serdev:ttydev_serdev serdev_ttydev
alias serdev:ttydev serdev_ttydev

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 9fad6afe4c41..6082c41b7ad7 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -142,6 +142,9 @@ int main(void)
 	DEVID(i2c_device_id);
 	DEVID_FIELD(i2c_device_id, name);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b9beeaa4695b..dce6df3a159a 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -955,6 +955,17 @@ static int do_i2c_entry(const char *filename, void *symval,
 }
 ADD_TO_DEVTABLE("i2c", i2c_device_id, do_i2c_entry);
 
+/* Looks like: serdev:S */
+static int do_serdev_entry(const char *filename, void *symval,
+			   char *alias)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+	sprintf(alias, SERDEV_MODULE_PREFIX "%s", *name);
+
+	return 1;
+}
+ADD_TO_DEVTABLE("serdev", serdev_device_id, do_serdev_entry);
+
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
 			char *alias)
-- 
2.17.1
