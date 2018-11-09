Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B820720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V/Hjndmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B820720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKIXpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39120 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeKIXpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so2045386wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQxAvsz6eZHL2jjicI4Z0Mwsyk2aDw0JU6AF0+HrVlk=;
        b=V/HjndmbseqEXYEkWfb6aEr9MZbrxkv4vYCpPoKsFByBBJrFRlzGDWiFNWv1GOsJa3
         oZLVAu+7gbHM++zhMDt2EXXduED5h9rUTor1QU+rMlkxzKkrkZnr2+GYtIDrXOubCoBi
         0oUiXuYIl8Oj+WBSIT2iH9qY0VM15ik5K36ANcuZSl+EMK1zYMvONKw3RYq5sV/oj2Kz
         xmicJ27kSq69amLabCtCGbQpo4R8muOllOIvxT5y+myAq+xwa3WAiKZqWQtOMSwUUdwA
         XtmpZXDkMcHfMGXrq/QfKSP7KIV/tfgVDkqGy05Bg//WnbmEjGHV4tEd2+yMLLZVMey6
         YS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQxAvsz6eZHL2jjicI4Z0Mwsyk2aDw0JU6AF0+HrVlk=;
        b=lueOgtTqwa/J/OaXKBhddhhMHAhucfPURExikkKo0cLFcaUUSvka/EFrLvHYaHxtkU
         e+Kmb2iRON6imry8LZz7EWu7G8Btv8XVX0Rc4/HI9i2brJOqcr+QBVaI78T6/FZJ/3gf
         WPNI4Yqjqw9NsyhqKLYynCxnk2F3E1TE6KCXd7NTzwcaid5xjjFHP4nTaZsPVUw/RttG
         Pir8yjd48+U+l+94/BjGp7I78wfrwKPeSbw0kwlBV0HDKYkdfi4s7uPkxR/KEt/zd4mW
         GSWWuedJoruzzXNJcsm7esIiq85f8q0hk2mSRaWYbD1vD7A/dvEn0GFGZZhFreeFBG9a
         Z9Ow==
X-Gm-Message-State: AGRZ1gJLXfUUblCIV95Oi7879x2jkgrK6qRK15OdA/2gxEEeeXuFolmx
        efgg8MMA32Kv7upNXIo7MZv1+Q==
X-Google-Smtp-Source: AJdET5fojjhtna8wd+iKzMlOunk94TtmxHBL2fB4Hhcu19Vd1NeXLEyDYCd5Il6V//RKpAEUTRhLVg==
X-Received: by 2002:a1c:83cb:: with SMTP id f194-v6mr4623327wmd.26.1541772295680;
        Fri, 09 Nov 2018 06:04:55 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm15964987wrn.66.2018.11.09.06.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:04:55 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ARM: dts: meson: set pinmux bias
Date:   Fri,  9 Nov 2018 15:04:41 +0100
Message-Id: <20181109140445.17795-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic chipsets, the bias set through pinconf applies to the pad
itself, not only the GPIO function. This means that even when we change
the function of the pad from GPIO to anything else, the bias previously
set still applies.

While trying to boot from SPI, I noticed the eMMC was not working anymore.
Even if the related eMMC pad are not used by the SPI, the ROM code sets a
pull-down on the eMMC pad and leaves it that way. This breaks the eMMC
later on, in both u-boot and Linux.

The underlying issue is that we inherit whatever was left by previous user
of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
setup we get is undefined.

There is nothing mentioned in the documentation about pad bias and pinmux
function, however leaving it undefined is not an option.

This patchset consistently disable the pad bias for every pinmux functions.
It seems to work well, we can only assume that the necessary bias (if any)
is already provided by the pin function itself.

I can't really test every pinmux configuration and it is fairly possible
I missed something so it would be nice if more people could confirm if
nothing (new) is broken after applying this series.

One things could be the i2c. Usually the i2c pull-ups are physically
present on the board but, if they are missing on platform, we may define
a special pinmux setting with pull-up enabled.

One last gotcha, I recently posted fixups around bias setting to pinctrl
which have been merged: [0] [1]. These must be applied before applying this
series, otherwise when requesting 'bias-disable' you'll probably get a
pull-down instead.

Changes since v1 [2]:
 * Fix wrongly placed bias-disable on meson8

[0]: https://lkml.kernel.org/r/20181023160319.27003-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20181029151340.9087-1-jbrunet@baylibre.com
[2]: https://lkml.kernel.org/r/20181108104426.1877-1-jbrunet@baylibre.com

Jerome Brunet (4):
  arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
  arm64: dts: meson: disable pad bias for mmc pinmuxes
  arm64: dts: meson: consistently disable pin bias
  ARM: dts: meson: consistently disable pin bias

 arch/arm/boot/dts/meson8.dtsi               |  12 +++
 arch/arm/boot/dts/meson8b.dtsi              |   9 ++
 arch/arm/boot/dts/meson8m2.dtsi             |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 111 ++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  60 +++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  62 +++++++++--
 6 files changed, 231 insertions(+), 24 deletions(-)

-- 
2.19.1

