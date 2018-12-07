Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E35C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAAB20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgRhhQF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAAB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGTLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:11:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGTLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:11:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so4430376lji.11;
        Fri, 07 Dec 2018 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR1ed9GSG9BdMzcMINLqVwYYXkRWiGYuUR9UH9XRe40=;
        b=SgRhhQF3xVp1KDgp08fv9DffIShhwiKHj6YQB3vVOnMBNVehZ+6WLxHJs/XR/x3XXV
         RramA5k69woEyGjasX7pehsmPFYvkRhX/S0slAOaIzvMolsZRg60hUTNvMutC2/PF5fH
         Mhv5lBueMqG7UFveIq8Jzz4m7AIXB3mTEWpNLe24PfeggvJy+fg68OtUXSmJk4CL3u+P
         S5mvI+m1n0SV6jGe5pxaXLKeH02sLq477sxQAmm6DhNrFrNQoQ66enLNNtpvAf4Hou1n
         LgplXDKSW9olCiMv/1W7VKQ7a6BkDWkKWZnf58p+jaFZb1d2C2eS+iweyyfdKHTs+kmr
         CHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR1ed9GSG9BdMzcMINLqVwYYXkRWiGYuUR9UH9XRe40=;
        b=bWysIIIphozyXZ3+DVvVsxUadlMB4+81hGkG0+i7AJ9qXUlOvZ7vHpo/3X2Idfwqjn
         CAEA9jIM88UDyOiITTISYV3gCGO4KgyCtZXgupqgLXBEr2ghIArh5F8MfmRnWHJH6Nvr
         N/SoxZphY91FKqNk3HP1DaA/+yH4XpU38QEV5RgGCQiQb9cCj2nVRvHlLLG9pfXJpvCC
         4uvx+us/9D1Xav6oL/EtjoRGGKO4bfOW52nY8n+mEfP9VKfJNnrE+NI7Km6261IRaBXp
         pQw4DTWCGWoVwrYKBHwtY98MPH1OCIb1wX8ZdKtGXdjH/xxzoYHlfm6phnxuQBTViHzE
         Ay0A==
X-Gm-Message-State: AA+aEWZ++Qpe8xf11ibJLes3yR0s1xka9b0a1RES2k3tumL0Ycdo+FSH
        OD5C8DQThSYe5O5BHxvkXW0=
X-Google-Smtp-Source: AFSGD/XSJe4ggEk3jerCBEO2iFMLtGWx+AlfEUveHZQTQTwrAR8Za7Xm1j6vkGbY/KwGqv2VgZ+9OA==
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr2001283ljf.129.1544209908606;
        Fri, 07 Dec 2018 11:11:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:11:47 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, broonie@kernel.org,
        arnaud.pouliquen@st.com, baolin.wang@linaro.org,
        smohanad@codeaurora.org, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
        geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: exynos-adc: Add support for S5PV210
Date:   Fri,  7 Dec 2018 20:11:33 +0100
Message-Id: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for S5PV210 adc variant to exynos-adc driver.

Jonathan Bakker (3):
  iio: adc: exynos-adc: Add S5PV210 variant
  iio: adc: Allow selection of Exynos ADC on S5PV210
  dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant

 .../bindings/iio/adc/samsung,exynos-adc.txt        |  4 +++-
 drivers/iio/adc/Kconfig                            |  2 +-
 drivers/iio/adc/exynos_adc.c                       | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1

