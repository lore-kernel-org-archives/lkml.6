Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F9C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8F821854
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdamasAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8F821854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHUXRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:17:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41685 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:17:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so15256192ljy.8;
        Tue, 21 Aug 2018 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2Zsdo1XhZLTDDIIKfjmSMVlN8EgCFbdSj37gG9c69o=;
        b=rdamasACz0U1QlG2x9NFrkLy7AdGkW/CAfdPuVlpGitPcChmXYuSzAv4e/47GtdnVl
         0McL5A6/u/F8O71Re9cvG9sBWTHjja675S4Rl9r5/+uTeWOKKUcswDH0c2BRwdmhGwOo
         3FrAxPvofu3qb1L1cAVlKIZLbTMHSoV5rWDcH5E44LfgGNlBCtzVvcMBFZz1xHj6eBhK
         rgHsttCXOViDvcKiVC3m/ZThu1sIVewffp7mYGXu9KeLAThye1+QBU8OTZmDwf4YxUkg
         YagbBVdWxW9+UOmNIs9x5F5hs8uIL8hQRfC9y3G+TclkUQCLsE80v1KyczexI1Bd2tOp
         Wm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2Zsdo1XhZLTDDIIKfjmSMVlN8EgCFbdSj37gG9c69o=;
        b=UQOiFZq8PUWysl8fl5hsYNTu0GXSxv5qMPcjg9VICWehnNb8UUWRbXUd5aHEiFSAaO
         uB/YZcbU8emzsf9bIbbk8X5Dg15ObWs+8MiBN44jXpYF0SG2+RI2m4xH+E9nYDpeo1TY
         irf8xyzEmHAJ2Ea2zcuKZYn8z5tor6eg0jC4UDiD+A4BJXsIb3ByU7dTiBNTdisjg0tt
         NgrsAL6dE3TRc/pBIPGgw05YkzvLJNFI1/h7TW1FPwHGOLoo0Yieb2Wp2Z5nM7qHsGkZ
         ZB+IGE2fROMnLuPA4Cznh56MzoQad6odL2zJrWCAMef2fVeP7ctQyqcMx8TVbSbizfmQ
         qGdw==
X-Gm-Message-State: AOUpUlG4I5obr124AaCy6zVOvSskL/tEiEC4JWY9qPsrlnEjzaVxZGFy
        6HYz+aj6k7kjavupdDX4L1Q=
X-Google-Smtp-Source: AA+uWPyWe8s1oAHuzyn1W2Kn5P1Yy52Mt1Xp0dIuMmhm7x8a84dGw7kYf0JF3kpY8IMnmsnRROEFHQ==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr37476355ljj.52.1534881334030;
        Tue, 21 Aug 2018 12:55:34 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id l141-v6sm2449374lfg.55.2018.08.21.12.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:55:32 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for ltc1660 DAC driver
Date:   Tue, 21 Aug 2018 21:31:26 +0200
Message-Id: <20180821193126.15733-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180821193126.15733-1-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for ltc1660 DAC driver and add myself as
maintainer of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- rename enumerated files, ltc166x* -> ltc1660*

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9276da915d9d..3db1edaf68bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
 
+LTC1660 DAC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
+F:	drivers/iio/dac/ltc1660.c
+
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.11.0.rc2

