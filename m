Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7577C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDC72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="D8HGrzy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDC72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeLCKIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41774 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLCKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so11449201wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gylxsZ9fcYlwwbMYTHy/WVwKOtRSFqkbXsc3NH3T39A=;
        b=D8HGrzy7OYGWo08Qc+ECKpX1y2ejt5+HrIc/yd+Vbf49JlWm2ZtoOGx6cVj697YjZB
         ZJrcHmYFaBvGDFacfQ9PvGob03Zzvd+GFDzL/EnZ8oE6nKeKfBWveveUlZSZtvmkvRRo
         jqqsnsC9ocZh40KMwLM4IAvllIzfpIjKgl5CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gylxsZ9fcYlwwbMYTHy/WVwKOtRSFqkbXsc3NH3T39A=;
        b=JFYqjnBf2wcZyJB0buUNJACfJaYrLQ1wxHQEStf2oWP59uVXZHWaKYBbdjyzcwVM5y
         lGMTLXuexLEScQeCetkWrAe3jjVyW/FP4Py+H6ISny8pLRHRT+WE/uZHB1VOdGUC/Anw
         PtJjH1zruNBfm2V09qGuCtLG+Uurg8Yio5kNqKgnh8xvW3vUEg7pLESlOg7rXLE4vnJx
         mQr+pf5xTK8nU6C4XeoZCGtK4FXyygJ8WIaFDdHeY2S4Vux6B/i6A8yivOawh0zn4vxq
         kTp82pjKIT8uy+7ABYURwfGzby+pUfVYdqDEuFU64c8YRBpemTVTBFUgh4nNgl1yAh3Z
         cQPw==
X-Gm-Message-State: AA+aEWaxvldG39vqHxwWv12iQudFlyfjantil7Q75Dy0FvKv8mRXlC5L
        xNjau9PhqYr5vo5/ljnLu463rw==
X-Google-Smtp-Source: AFSGD/X/ftP2iitUfgcxC8dWoPI4Wirc8tHDe0MCInKQ/fAjCaSEPe51HLEf83+T1guceMN9DtEBIQ==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr14405877wrw.113.1543831675070;
        Mon, 03 Dec 2018 02:07:55 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:54 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/5] media/sun6i: Allwinner A64 CSI support
Date:   Mon,  3 Dec 2018 15:37:42 +0530
Message-Id: <20181203100747.16442-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support CSI on Allwinner A64.

The CSI controller seems similar to that of in H3, so fallback
compatible is used to load the driver.

Unlike other SoC's A64 has set of GPIO Pin gropus SDA, SCK intead
of dedicated I2C controller, so this series used i2c-gpio bitbanging.

Right now the camera is able to detect, but capture images shows 
sequence of red, blue line. any suggestion please help.

Any inputs,
Jagan.

Jagan Teki (5):
  dt-bindings: media: sun6i: Add A64 CSI compatible (w/ H3 fallback)
  dt-bindings: media: sun6i: Add vcc-csi supply property
  media: sun6i: Add vcc-csi supply regulator
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node

 .../devicetree/bindings/media/sun6i-csi.txt   |  4 ++
 .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 +++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 15 ++++++
 4 files changed, 99 insertions(+)

-- 
2.18.0.321.gffc6fa0e3

