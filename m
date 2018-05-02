Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065540-1525280899-2-7646392993840636938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525280898; b=WjTyKD6olF4iGhGO37DMpsFXEovbmMADQspADbtbJkqY5zBi+I
    T3rFCZA4SRp5IkysKzRkfyygZ4HVYDTViITy6zAIsBBGRmPw0ynop1QKZxinQ5xX
    P3tThDBs0lyJWvxmwGASmD6Q42GHGjNUlnN4MQDApTxtBg6h5Et75QWP8W5NQIyN
    mZMb7s/5Ah1hB8aacIhyu9RJyijqVX0B5mZVTxMVBvh4aOsZ5kCodR06nDqN53e0
    ariJ9HI+k2juD4a50WqnEV0+0O7yYzGvxycHrzzoswm3QjlNLfJxF66LBUm3/A7S
    fZj4PZY+Tc87ujzoh8f5SjFem/0lUlbYsLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525280898; bh=emgreoYM/JuMGj+S0vwWPbSNTupmS7
    DwTRP38lEoe58=; b=ajYiNnFxU3tvEUz+8DS8tuh0p9iZmXAmtRIDJnk+Jcr6fx
    0ZthW1uoHfO2JJ7JLxCOMKBALOpIlGPl5cabWfH2lPTug+SGbzqJRKQtDNs4c/Wt
    iKGIzd4lzNfjKx8i95Qc8kuLrPcM/g3NsraoZiVhhCHMDrkkt82nWcz+2auZ/8Yh
    XYSGUL3bsOguKW7qQUbPpcvcS5XqGwUHEZPB2xTLMnsq2Dt8RZt/QnyKVjX46Agc
    M3DALY2tVMzGFR35AXyDDo3OHcOMde0eUvvD/bcV8qxp/yP5ZSxyHzcVo14cERTg
    ZuGJxqLMCZqdVgR3W0A3EgZyym+ApC74yey9yR8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=T+TNzkLV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=T+TNzkLV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDSmphJ04ryEz3A3PbcIQtBiY6+JxBVmlKy/42vCeXxr2VURSwRWvkG2G3/V4cahM8Gq1V+EUS4+3oIXC9tjXm/7ov1tfZFd/9+7NKpDuid+tRdT2wHv
    oCGbIxCFhWEcnZx+91R2tlXPY+GTHro/Y5T1DrWGK/xC68P+sqWYAVFu6ZD0XRviKHJ4MfIb9YHH/EDtXyLjBBCGKKh4iuTLsfFGaRDW08QJpQ3F/LPH7Hq7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=HEhsBhvELOkTVMn1VSwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeEBRIF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:08:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40003 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeEBRH4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 13:07:56 -0400
X-Google-Smtp-Source: AB8JxZoeQDrisWc2GjrWutLFghIVEoabRUWCZeQms8ANJxLmh1Oi/zilaBH8fOixdm2fHBQXumMA1g==
Date: Wed, 2 May 2018 19:07:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
Message-ID: <20180502170751.5ci6hgvtlytwyvqh@kozik-lap>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:30PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   2 -
>  arch/arm/boot/dts/Makefile                         |   2 -
>  arch/arm/boot/dts/exynos5440-sd5v1.dts             |  42 ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  81 -----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  21 --
>  arch/arm/boot/dts/exynos5440.dtsi                  | 355 ---------------------
>  7 files changed, 523 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi
> 

Applied.

Best regards,
Krzysztof

