Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A71C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InrgZ4bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEA820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbeGLClI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:41:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37539 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGLClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:41:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id n15-v6so3440973pgv.4;
        Wed, 11 Jul 2018 19:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rM/XLnZ4ERqEllAhmXX2H1tj/qTgojFHE1D53R5iDL8=;
        b=InrgZ4bX9MVWBr4ZbZ3B1ZwhKm8zi+AubbYSA5rtw4UrPBYkHFlNF04Zdr8rFmZbT2
         urp6kxg18NoSf6sPTxeDVS/3+Fe8umnb+yx2hT1FECqxm1yN6wJy101IBfxrnUAXtbCo
         FDiGFC3F0224CiUJy803m51svTHZfZa+vqvPo2UUuF42JJ56WSivgFHpbopK3PWeJfsd
         x9tvzY2FDVajaOBIFU71oNEERnLHXyS+h36qHRj5VxWpWcZdcCUgvdQvoWiT0sj5uSCM
         06aTcuRvX1z25Yx5lvhUWDZHOvF39VOOi1TiWmWGUZ36+zKbCVwSJmOFvZVIz5cRc/OW
         NiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rM/XLnZ4ERqEllAhmXX2H1tj/qTgojFHE1D53R5iDL8=;
        b=jpdHbWZaH3NuECRZQZT8KYIifXo8so4SduBM46jOQ9Bqq44SXfTjFPhlr7YJwfnnp7
         EPT26k5ZnJpj1kjQRO4lzWSN2i9ISct6FZoVXWUcNLdrXQhC+ZyMeGyg0aFjnZAq+5G2
         Ljm6sNd3d9S/r9qC+D8M1QRRihhJZO6Y+34lqOVmrI+kKcUB0b9aVPK7b5KOpgkIqrqp
         72fgmFSdJ/bTomgi/hvqHNngZFyTb0oiKQFKw3PzBlzM5GKQQ6rG55DhFKTeU42aIOPQ
         13hXcIvse/VN6jbCfnEXW17etx/pDIAzFCeSGtpQx+hMftiINSQKmV5UTKAn0AyRDGXo
         x6Gw==
X-Gm-Message-State: AOUpUlFUAf6fypv9MN557V9Pc/UhWWjBQW5A6uwq/KDYa5Scp9WCBlbG
        WFkvqpXQgAWd/0KmWD2FZJE=
X-Google-Smtp-Source: AAOMgpfM653p0mIFpjkul/HMVsY/uoJrAMz9e8VMRRKr0ePOChd1yHA6jqnN3svXo6YBCrfNQutvUw==
X-Received: by 2002:a63:1644:: with SMTP id 4-v6mr370239pgw.103.1531362832783;
        Wed, 11 Jul 2018 19:33:52 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w16-v6sm57260335pfi.101.2018.07.11.19.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:33:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/2] Follow up fixes for SCU3 ESB
Date:   Wed, 11 Jul 2018 19:33:35 -0700
Message-Id: <20180712023337.30112-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn:

Here's a couple of fixes for things I missed in the
[original-submission]. Sorry about the inconvenience.

Thanks,
Andrey Smirnov

[original-submission] lkml.kernel.org/r/20180711050704.11492-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
  ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string

 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1

