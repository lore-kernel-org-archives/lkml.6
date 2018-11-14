Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEEEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655182243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO82zxl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655182243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeKODsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:48:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeKODsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:48:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so1444578pfc.3;
        Wed, 14 Nov 2018 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HAgiSSAX8RzeFKEvYMZyROM+JvxNPU2OkixfXR4Yx8s=;
        b=cO82zxl1bVufoAf2YoT7KoButydJR597rj/neYM1Z/jysUSumAVHESgv7CZSLAHni9
         6Hfau/zp3D5wuF2a1jBChKfbkUsWRL30ElGk3cbJkithtR/Nxvhrg6NOd8tu2S/NsIJ0
         HnKhRgQ7dpgbSR8fYhkUGEU/w/r08Cn0+d2/F4tYULkB10NjXUfuDXrn5M5rBghU3KaX
         mkQDfxRZNknfoqpE4txqsKBBOAwajupP0XBNuvplisOouHd/zfQv2PKHzhs+ZpYJ5634
         PmJ9EWEJxxjehP5bEHX+3g+R9iKLJWJClIPZTfI4yugMPHOq8a7jj7IA32DntmOaLXQa
         +CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HAgiSSAX8RzeFKEvYMZyROM+JvxNPU2OkixfXR4Yx8s=;
        b=uDf7GivlCdw5LXCTN4HJCx8K4WKA2EO94sC/WNRixzY27WGw4+vLOsX57D3sfXPyBK
         VzcM7ztQsmY81KdA5jajzW0nMbKvK4HlWxI6B3582JDMnX1qOdZlGgMaw5FOfPgLTx0v
         jjKQ/bWETe2MQpXV1gklB/yePq3lZ0ZmY+m2PumH5SEm2DMrLbmmJ7JgEq6QFPYf4/jK
         UOXAOSh3JAELFmUkyTdGC9cSN7SnYlL8AfZk9aCbptwpZybYZaciDwjBqnaTkX6nLJti
         pFbsMyyMiSH/lXOhdZuiP6dULM44BehaKcMQgy/mfameloM0d/VJ5vfM3DJ/EvmzF+oB
         reCg==
X-Gm-Message-State: AGRZ1gKI8tHnaH+n1JALsgoeFX9mnEN0ISSo63sWYOAmbo388CHaGqWw
        FXoCC+iJc5Oa9E6imTdScfs=
X-Google-Smtp-Source: AJdET5fa1CsEaV9qCNGJcnKFqRrFoSxA+yuT1t4Iw+xnI9ZPJTZsGxNCH5XBogW6a2gpviSCBCzyEg==
X-Received: by 2002:a63:4342:: with SMTP id q63mr2607474pga.63.1542217453700;
        Wed, 14 Nov 2018 09:44:13 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l187-v6sm21229149pfc.79.2018.11.14.09.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 09:44:13 -0800 (PST)
Date:   Wed, 14 Nov 2018 23:14:06 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <cover.1542215638.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Add all parts to the dt bindings as they
   are functionally different.
Changes in v3:
 - Drop busy pin in case of AD7818.
 - Set RD/WR pin and CONVST pin as outputs.
 - Add device tree table.

Nishad Kamdar (4):
  staging: iio: ad7816: Switch to the gpio descriptor interface
  staging: iio: ad7816: Do not use busy_pin in case of AD7818
  staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
  staging: iio: ad7816: Add device tree table.

 drivers/staging/iio/adc/ad7816.c | 113 +++++++++++++++++--------------
 1 file changed, 62 insertions(+), 51 deletions(-)

-- 
2.17.1

