Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9177C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F49520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sf/LAZ/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F49520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeKROpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40866 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeKROpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so43865890qki.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=S+7CTcmPbfUrr15yUwPEj2UuF/ATpWK83e6y3LV/4F4=;
        b=sf/LAZ/1QnB3vk7VxpQjUrjAKOUkCzN6MHPVHUJCXJg4bIxoJi9aH/e0LMWHoSJFgB
         5dODHi4sSzwc6rmc6eV8l8evm51K9cTXs3+nZeu2XWlr2oDymgZS85yqJ0c6OLKVH8wl
         4U1wfWMn3MLoswRF7+xGk4lpv3gBXDAbhltI7FpiMhBSIR661JtgdFEz+lIE7RoF16f1
         ZKkZWlIJS/wcEerbkW0FvCmxkY5TjH2X2x7C0BquELXr3NCOPLeWrYO0pzBbSTB3OwQz
         aFWeekgMVudwG3rsKHS1lFMMbJiPXtHtMwjS5MGgAIi9zls23xa5A+9XlRdgzFUBoTNx
         yPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S+7CTcmPbfUrr15yUwPEj2UuF/ATpWK83e6y3LV/4F4=;
        b=V4A09uNbgd5cRDPcwWVKaL9ZSW/vldhh8uMiL1ltU1Q/XJxDsibCbhDnh4WKlEyeDg
         AywxqxgFsM8U140bUPL8s+ZaDUPiPjlJuUC3SSqJAVKOUn1C26HPOb2reHhuoC3puYgy
         KI9qiMYZ9AtJ8Kb72/zSvl5OQYXKvibFIVuDXdGxOPR6tmiwtOcbEVJH950HyHAX37Kj
         ohNyRZ5kwRa4bAr7azs17uOIZeGtA+C295iQkuCUj5d7KxYRrDNU1lATiZko91/nC/0k
         jv8F4+lEuR69voUBMFE9Xk8Dt/CNUXPxz+xBuWi7PhdPqsZaXZ2s2QUHJcCn3R+PQXUF
         srYA==
X-Gm-Message-State: AGRZ1gItiN98mn2Gg+TcoUhQb9taF5HaHNmbXpVktBNDXBpYkfbXPjj0
        XXoiWl2PsMo2QJfSOlA4/VPr/w==
X-Google-Smtp-Source: AJdET5fB18mnZYfHRm7FwWqr756H84WwIaHMhi2UziCPnlpTYi+7bvqQoHJumWbYx6FRboDQP3m0pw==
X-Received: by 2002:a37:bd47:: with SMTP id n68mr7400387qkf.203.1542515171199;
        Sat, 17 Nov 2018 20:26:11 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:10 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 0/7] staging:iio:ad2s90: Add dt support and move out of staging
Date:   Sun, 18 Nov 2018 02:25:33 -0200
Message-Id: <20181118042540.12697-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree support to ad2s90, adds the respective dt-binding  
documentation, solves all remaining codestyle problems in the driver code and
move it out of staging.                                                                 
                                                                                
This patch set completes all the remaining itens listed to be done before moving
the driver out of staging, enumerated in this mail thread:                      
https://marc.info/?l=linux-iio&m=154028966111330&w=2.

Alexandru Ardelean (1):
  staging:iio:ad2s90: Add max frequency check at probe

Matheus Tavares (5):
  staging:iio:ad2s90: Add device tree support
  staging:iio:ad2s90: Remove spi setup that should be done via dt
  dt-bindings:iio:resolver: Add docs for ad2s90
  staging:iio:ad2s90: Replace license text w/ SPDX identifier
  staging:iio:ad2s90: Move out of staging

Victor Colombo (1):
  staging:iio:ad2s90: Add comment to device state mutex

 .../bindings/iio/resolver/ad2s90.txt          |  28 ++++
 drivers/iio/resolver/Kconfig                  |  10 ++
 drivers/iio/resolver/Makefile                 |   1 +
 drivers/iio/resolver/ad2s90.c                 | 131 ++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig          |  10 --
 drivers/staging/iio/resolver/Makefile         |   1 -
 drivers/staging/iio/resolver/ad2s90.c         | 127 -----------------
 7 files changed, 170 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 drivers/iio/resolver/ad2s90.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s90.c

-- 
2.18.0

