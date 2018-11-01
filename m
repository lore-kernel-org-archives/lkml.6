Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A882082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jltgvSSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A882082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeKBDkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:40:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeKBDkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:40:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so9424542pgq.5;
        Thu, 01 Nov 2018 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VCTMTRrI1EpSumMm35VOs8i/2Cq4+p3VQNQk6qYblj8=;
        b=jltgvSSEjur5YiyG+FJE5IObcaVLpVjIUK8N4M/oO1eJfcSwJ2UR7xspdFDCLYe8JQ
         Gk3TJN7RaJkjFjoASsKAGHNqCuy6zE7naMvarba7bVlhXiVZ/InW8HdxXUSrMccJbROz
         m3tJqUq03UVPfUT4F3D+JWaW8DM/tCeuJeiglZkD8mHOB5xS7SbZce/s0ffJ4gAlE4TT
         SEM1rsMVe7NzldsBtpDKfNk5L4Xlp4DqXAMUuAws+jgqrvtNQNFeZWsTT3oGp2yliND/
         bG7/1H1/I/4CRYXD3oTgGPiP97fksZRyA6yWlw6GW0GgPAsnMHN8m4UWcAwGCwmHfcSP
         8U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VCTMTRrI1EpSumMm35VOs8i/2Cq4+p3VQNQk6qYblj8=;
        b=ZcxcMbNkRtoZe9ucDHMLvAh4BReW92jTHsOkoJLCRUL5rrQ2EC4yuIZnywk8VSsPPG
         1yq9hyx6Hc/VP5pcGq74f8uVvM1I1DeV1ofc5HCB2f/mPYl8cuRefXA7mBnknTHcXyvS
         f8zwdyEJweoWPkzwYXwfhZ8OO/xvGG9hR41srTDNOK8vT0VA6UzkpoHy5rBitnGbIy00
         B1IwRuoTW7EAqvzlg/fEv2B9euzZO265mMChJ4WsnC3ncrwYc2OQweaPfA4vSFTzYYmO
         VbTPPh8DJl2Irs+nMs//Vy6bJeh25bKfSknxNQmt6akHXsTP17ahz03xPnKsT05JSDMh
         VSUA==
X-Gm-Message-State: AGRZ1gLawq3BhqJVi7XDH2iSe5YYrOxtrHZpEcUb22IdTx7qND7KLtym
        o/ls1+MPeA1zTVVqz6iQMsozvzVz
X-Google-Smtp-Source: AJdET5cjr9ultafDffjCN3LTP3qBbzWf/msQyPeewjA3A1KF7yMArMY/ZQCAfU9Y71Nx1D3IhAPLhA==
X-Received: by 2002:a63:df03:: with SMTP id u3-v6mr7913220pgg.362.1541096894094;
        Thu, 01 Nov 2018 11:28:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i14-v6sm7763260pfo.121.2018.11.01.11.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 11:28:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arndb@arndb.de, Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Date:   Thu,  1 Nov 2018 11:26:06 -0700
Message-Id: <20181101182609.24142-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
result in the inability for the kernel to have a valid console device,
which can be seen with:

Warning: unable to open an initial console.

and then:

Run /init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100

Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
really is no drawback to defaulting this config to the value of
SERIAL_8250.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..d7737dca0e48 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -484,6 +484,7 @@ config SERIAL_8250_PXA
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
+	default SERIAL_8250
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.17.1

