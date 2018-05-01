Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3245871-1525183739-2-15865871921998495997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525183738; b=bgKZUKmGAoFu3eMJadAhaZyg1Ng6ok8ey6qT7PY0VlL4Z9BBan
    /h73B7evyE3x2k8dYT5BU8dDn38DNgYrTPqdQiw1my+QVZ+a0KKmcuB2QkCJFQ6r
    foR3ANoDXjHTyFR4VXku446Nv9dtYeR8JfXJgSZlwJLsBl/YkfOaZ34R4VkwrYSE
    2BCMQ5eq4cnSnn6gSPHF6bF52wJVp+oxJNu8x/Ad1A4qZ+iCujwa3Ks897dNg/UE
    HGOVsNfmsiKTYrunRB/I06Rqdd0O0OOno1TXgrlMK/Rv9NSA+eLgpNEMDVgrSsf6
    eLtoAQotee3tD7QSTbXZvhG32rDFjieNgm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525183738; bh=4+Qcs8azC8yyd/EqijXShDgHZ3++Ko
    9kLYVu1kvk9Lw=; b=R0cFLOLLRRN4p1hkNREPq9LxGwdrhlTA8XweZb0aEMZhjW
    B8cs8XlfyyUCDe+h7qyYeF8gBvtdhNonck/G43IW/q7l6tlpyug+zTFPJUWmKjQs
    acLWplqztiA/XrJMRRY8C4VmL4h9mgKGHBkit75gXPVeLqQTc/+0jsF7gPpVJZdv
    KlSsuhnK/qfxBRtZ+v1bYjhA87NYn1XUYdzBBVEdawhcQ+kCDCeI5pgYy+um9LCW
    NOEwVRFg9gJROK2/W9HVFhdQ/UjFz9+lz20Hy9S7GxPb75RYEHIruXNXeyjDMTHD
    jGmlW5e6Ri+P1C1Sj8Ep5g1N6I5iQNCUN/YFDvjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=EJ48cL42;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=EJ48cL42;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLl6uGDU3wZp1uwhjMDaCH4eltvS874AMvpSf6lISv6MUIwWKAaPUCQ1iXBlW+Ek5R8xZCVTQTj0zpTIHzpfYMg2uXsLE+CHdaNl4MyM85vim8PUYMcH
    f+lVRKBUjSY5N3GiK79qg6EOv7dbGJl5o3riICS1vLXKbDU/i8iJMU4TsRjrqN+k4hif+gRyHShK8GTIWmKfQZAiDrdi9I70Ymug9YXwsGVJEmoVAYwtUnRW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KXQFBCsgnY3szuWKRloA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbeEAOIr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:08:47 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37138 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbeEAOIm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:08:42 -0400
X-Google-Smtp-Source: AB8JxZr+R6ZFtoQgXww7664g3VjXd1UESTwoaiP3gOCIbtB1bUCI0dfUU/s0hzQ+r0ts6qDwkUkkVQ==
Date: Tue, 1 May 2018 09:08:40 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Tejun Heo <tj@kernel.org>,
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
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
Message-ID: <20180501140840.GA27306@rob-hp-laptop>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:32PM +0200, Krzysztof Kozlowski wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
