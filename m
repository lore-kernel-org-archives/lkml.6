Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4050400-1524624520-5-4879448063221985733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524624520; b=Fc2aWcd9l6AOd7tEf4Zl6JvSIFqJf18mda9S9gsoL9JI5r6/tC
    hS6fFISLO+Hr2/axWd8k42tEnwh7ainkPPS49arsZlI70nOpKhZMblKysihdX+5F
    SUcrWgvr0CF6Yhw4hRFSJffKjKAAb5644M56dkvYcFO49h2emiQE7Gq7JRKsZBpW
    JZMHKiwueQq3atBYgbuLxIYkoDnsCLWCm2MchcPhHF2fxOC2sMG6YU5aAGFhkimL
    j3wdJTZvGWhzAo37a008cb47N1Jhn7jyH4WKWTsha0a3CDAZPJNLPADFPtVUrIvT
    6If+ltm22GLqdMDPcB/7OfW56qf5i4JcfREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524624520; bh=fMGRejOQfvyve7wthfMd3mhvXzTEg0
    EO0xu8ZOVPNe0=; b=BEudWwgKBi67Ta1VCybaUdZpG107fbYJ/eQw8ozYi+RH6J
    M4hsju9Op3ygylDLA/h5ntF7+2UjwAbxTP05goUvDZ18ahqT3Gmb6RbYPClWo2M8
    vU84TZjx7YAQanMsBWpyoeBHZ3BnaS2zW3C+TTPFwtHson1WhExNiXMR0/vIpbzA
    YBXoV5Kx2UKW/wi/jDRxdQACk6jv7mH5ULVhlDaUG1n0ZhIT+eX8+WLvYDTPFwcj
    VssvcLG4vgrqrzDZ3RhPuQpPWz/WT07rP0nDMyTT6lFBnu/1vmmPoDir7RRxlwyH
    YC1KO/oatSj2l2Tz7py+NsOMNkHB7jntLzQthoWg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FmQdjuyC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ORJTSLpn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FmQdjuyC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ORJTSLpn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfElfCgr7ECa3r3mCCcLoBlBpUF5xgsFWTcdLYX4FBUL9lkaH6i86kz+Xlh7E+m6wX21x9kxox3Im8GGZgimEj8TWoSYJkJAFPCXChtjouLZacdferaZJ
    GYH1/vgPT4T3XyVJTqEeuCq26KdxghwDjyOlRZ2bxfCoLC2a2jtmU/wRAM0xa1zk20fIZl/rs3jWTM/1bw3QVPjt+ECwyIHMjNSx6WqAU9LAgmCmvzP5kDmd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDYCsc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 22:48:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37193 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeDYCsa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 22:48:30 -0400
X-Google-Smtp-Source: AIpwx4+r5JmLQ4uzIDTkEITghNoHaB/+TeCMtqz/a6VhSxFNapnnJzTLjUQ7USkKUjx9NWmMT/x2Yg==
Date: Wed, 25 Apr 2018 08:18:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
Message-ID: <20180425024824.7ej2sz5jlbiuqeqh@vireshk-i7>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-4-krzk@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24-04-18, 22:32, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
>  drivers/cpufreq/Kconfig.arm                        |  14 -
>  drivers/cpufreq/Makefile                           |   1 -
>  drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
>  4 files changed, 495 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
>  delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
