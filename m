Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4944222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993564;
	bh=mCMJyo7VtrJCKbTL0coPi8tQwBGv5oshlEKt9XIzZf8=;
	h=From:To:Subject:Date:List-ID:From;
	b=bBqfZBFoYdY3XTtn2+RiFsw2a2CxUxY3w6YyxZTKR4RlU7JDNQ/HUUtnKdocRVSGL
	 LTLtSJ4d6H60/mWsx3rU4aqox/bu2bC1J830cAu9D/lxo2gUouY9As21AVjAw1ICkI
	 hAsUse86RrCTqnQnRFIKki0ntwVN43UZbjdZ7kqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfBLRqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfBLRqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:46:02 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81E020842;
        Tue, 12 Feb 2019 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993562;
        bh=mCMJyo7VtrJCKbTL0coPi8tQwBGv5oshlEKt9XIzZf8=;
        h=From:To:Subject:Date:From;
        b=05BL48sgJ1Whf3TZzGbhrTfVI01E8eqvBDuI4+tfQ1kAfdc+4AG3067f8MpKywfgW
         LfcMOGTy+lwiTZlQs0swbDJltFjz+IKBnrhHz4/30bjqTJNRm4dakcK5Q33u1rFkN1
         g3jiVFUXKWJT2xWaj8tcCbmmiAtyFM1G87IyX3Ck=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM/dts/iio: exynos-adc: Use proper number of channels for Exynos4x12
Date:   Tue, 12 Feb 2019 18:45:48 +0100
Message-Id: <20190212174550.4383-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The DTS patch depends on iio change.  I will take it through samsung-soc
for consecutive release, once iio/adc gets accepted.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  iio: adc: exynos-adc: Use proper number of channels for Exynos4x12
  ARM: dts: exynos: Use ADC for Exynos4x12 on Exyno4412

 .../bindings/iio/adc/samsung,exynos-adc.txt     |  4 +++-
 arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
 drivers/iio/adc/exynos_adc.c                    | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

