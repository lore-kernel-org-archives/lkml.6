Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860BE2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gqjySLsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860BE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeLJLxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:53:30 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42400 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeLJLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:53:30 -0500
Received: by mail-wr1-f52.google.com with SMTP id q18so10152801wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrjHwcuROIb2yaHjWhbPdQUeR2mzVfHSy4hu2P4P2YM=;
        b=gqjySLsFWbjDh5S/oJf9ihN5ukXUQ0uZminWG3GS+B4kBMIfeYK12YxQa44ofGoZtl
         J/NUqHB3sJ+Ht8TX7zOhKxTjij9w0j2lpsD9vMN9huZ+04MJWKIRg50rq8dFOc6fTAJV
         7YxMRDJgCEM3Ort9TtHOqF7hvfjHZA4M7bcd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrjHwcuROIb2yaHjWhbPdQUeR2mzVfHSy4hu2P4P2YM=;
        b=Iy3Gaw3RbJ4a4aE00doTiQz1dsX3tDVziAovCMHBev00V9Y15BixD86XVp7sPj2bvO
         F4LK676Je2jZ++PCb3ncaBo9uPyJvjiA0uyH5a2E8VaoDI58thIzb/t48foDAWO981S7
         mp+D00et8jTbUGzUnrsjgnsI5bOpmPpcHnvKHtcyJFxhzTfFVv3BnkIcJ0wH6ZyldYfW
         CJUMIrRal5aqJGCyn/hldRfjBEE+rq+q5Y2cFuZtmZS2/I7X3IO0oeH0Met04+b0/y4R
         jZ5mWkQOBkgXRDLiDnfYTt4TJjU6i7fxYYoSx2yT5d4+cpe1+XSMhvg2MqKdVf0KuixE
         jt9g==
X-Gm-Message-State: AA+aEWappMb+6aqLobMv00hlIZAX9gRSFYKQEatTFsjYvzMaQqv/An5n
        JjlhRqbABtvWHkTSIVNmOx/6uA==
X-Google-Smtp-Source: AFSGD/Xg5dlEHx0sqv/GAzXC/PYVrTNVwS/ru98fByEDIf2fuH9Z+t8M5fNdnbA6dA0lKKcMqY7m2Q==
X-Received: by 2002:adf:8068:: with SMTP id 95mr9524972wrk.181.1544442808329;
        Mon, 10 Dec 2018 03:53:28 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:53:27 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/6] media/sun6i: Allwinner A64 CSI support
Date:   Mon, 10 Dec 2018 17:22:40 +0530
Message-Id: <20181210115246.8188-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support CSI on Allwinner A64.

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

Note: This series created on top of H3 changes [1]

[1] https://patchwork.kernel.org/cover/10705905/

Any inputs,
Jagan. 

Jagan Teki (6):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 compatible support
  media: sun6i: Set 300MHz mod clock for A64
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../allwinner/sun50i-a64-amarula-relic.dts    | 53 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  6 +++
 4 files changed, 85 insertions(+)

-- 
2.18.0.321.gffc6fa0e3

