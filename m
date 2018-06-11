Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kBMVDXQnHluZBwAAmS7hNA
	; Mon, 11 Jun 2018 07:43:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2343B607A4; Mon, 11 Jun 2018 07:43:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH5uTzXv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7EFDA60385;
	Mon, 11 Jun 2018 07:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EFDA60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeFKHm5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:42:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41347 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbeFKHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:42:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so28990535lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AB9HW+MbAX/UIhbYC4nArSowRt9LtNbjBvoEqCJX8Ck=;
        b=pH5uTzXvdFe0lObw0tPGVziqPLV9fQ8PTGw6k4wz0ZniAzbbdRO4GSx7P8zNvu6kNf
         P9fpPu5Oj2BfbB6oydfQbbn5sVkIxP89P6ZyF9yVQn73RtGG2VFxrUyBTZTKcOO5I+0/
         0FdXrPbo/iHnWMDrLOAWzgKj8yCzQ36v/iiHjZRsYWCwYMlcNqYjC3AS8Qyazy/vLBrf
         8HBaMbECVD/inqRL65XeVv1mUB22yHU3Vag+oVemAIa5A2x0hUVQw5xH7TfT1W6rr/Qz
         lSRMrxtbU2yHKRF1si86Lt6v4GcCVI3xpY7NVdQC6jqqqPF7sUpSUJ6uiXqJwaT86CtJ
         cr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AB9HW+MbAX/UIhbYC4nArSowRt9LtNbjBvoEqCJX8Ck=;
        b=FPap3VTGlT9KFUzk+6kFTlIiqUuyt852b9UHwxExAUDiLzOij5h/AztfBNRDyW8Pgx
         wFDkDtjptbWnnzjeLyH190KtF2dNgjbQnAiANsuxG/NqihY/Nereq2Wm2tX7gztOjvGk
         HelNYCpNEag7ueF3wca2XiOuukUdeR4Qb/UjH+Vyh5hFWW3f0W6VTDaMwknBuP3oTIlz
         jeeLWbdvKarNcWzvt7bq3MCXrPj7w94ps6MOT0XPsxwali9WRZKF4tvbrp4SPZVwx8i4
         ECopQDrVrbM24op0BC9V9KpaUkCO+jxt5nWvi7L6jj+56BIW7wPXmvp4YH/W8/UgOt9J
         hfiw==
X-Gm-Message-State: APt69E0+GI7tBHzLyJONjfJngHH1/QrZFKdsGvPvC5V+dvEHyZgNgeS8
        O7rfGTt1lpBl2EmYugQ2wVQ=
X-Google-Smtp-Source: ADUXVKJbI/+a7Hga4pb23iYD9tsXD4/4ItgF1gOG3VbMcW/hTAZtwlQxjibHEX6He48XcsFUIjbgIA==
X-Received: by 2002:a19:de0a:: with SMTP id v10-v6mr9165535lfg.94.1528702975049;
        Mon, 11 Jun 2018 00:42:55 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4548661ljg.84.2018.06.11.00.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 00:42:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@xi.terra>)
        id 1fSHTD-0002mt-VV; Mon, 11 Jun 2018 09:42:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] MAINTAINERS: update two greybus sections
Date: Mon, 11 Jun 2018 09:42:02 +0200
Message-Id: <20180611074202.10668-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a file entry typo and drop the obsolete timesync entries, which were
all caught by:

	scripts/get_maintainer.pl --self-test=patterns

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This has been reported and at least partially fixed in the past, but due
to various other clean-up work that was going on in MAINTAINERS at the
time, was never applied.

Johan


 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..09d7f9eb5c13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6065,7 +6065,7 @@ F:	drivers/staging/greybus/bootrom.c
 F:	drivers/staging/greybus/firmware.h
 F:	drivers/staging/greybus/fw-core.c
 F:	drivers/staging/greybus/fw-download.c
-F:	drivers/staging/greybus/fw-managament.c
+F:	drivers/staging/greybus/fw-management.c
 F:	drivers/staging/greybus/greybus_authentication.h
 F:	drivers/staging/greybus/greybus_firmware.h
 F:	drivers/staging/greybus/hid.c
@@ -6074,12 +6074,10 @@ F:	drivers/staging/greybus/spi.c
 F:	drivers/staging/greybus/spilib.c
 F:	drivers/staging/greybus/spilib.h
 
-GREYBUS LOOPBACK/TIME PROTOCOLS DRIVERS
+GREYBUS LOOPBACK DRIVER
 M:	Bryan O'Donoghue <pure.logic@nexus-software.ie>
 S:	Maintained
 F:	drivers/staging/greybus/loopback.c
-F:	drivers/staging/greybus/timesync.c
-F:	drivers/staging/greybus/timesync_platform.c
 
 GREYBUS PLATFORM DRIVERS
 M:	Vaibhav Hiremath <hvaibhav.linux@gmail.com>
-- 
2.17.1
