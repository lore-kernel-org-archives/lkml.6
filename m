Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065540-1525281006-2-10801589808181489778
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525281006; b=IYlmPoB2AGW7KbweEO27ROm4CcXofrbIjnEgFTKz+GuTsjSxML
    DS7glrelF3o/3fmBFwflWx0jjMnTFU3aQuVf0TpRs/x4bR2tUsz/vut2R/K0T8jM
    jVOrBY2wY9J6Xab7zqXZ36mNeIV/sA1JLnewNnqtLzCaXk1AV9+FLwYBUFvi2Yc5
    fxmqyYXLHhZeIRG0YuCoAFug0BCwFWAKCzJlBCkb3yPYz51gVICuycgwPA6n+YFY
    jWSwYwD6KivNvuwU3YhyoZjzUzrdYmWojQ/5ScW+GeIhM9Ou5Z8N6OhDGBNlMl/3
    sk1vnCyE6Zche93qV2CbrwHbEPGFhBoyadtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525281006; bh=9HV1a9ZIzkdjEWn+YzeUmaoUnT6tHK
    +4oMGjMTzRwrs=; b=e5brUEHwlr8a/JIMvN41ysY8KWP3qvnwbG7jozWq8hIQfM
    Q4ngmHF8tI2Ez/9JgPOH0SyTt0QvHDr+xLl11QsmPYKlw9gDiCThFvaqb3R090rP
    s1T1yLYTGcMvgpH0uRoItdd9dveMwMxo9DiBXVsqhgQUZStIDuHYtKny7Efv6T3M
    3nUCDuzd6CvacMzrKOpFXOMu6kp7AMhxD2awKS1nVULTfjoOQImqNuJhvZLQgnd1
    FwHolJgcOzjHMAEQbFouLd3jbXTPxJE9v1mvAoU4ym3McZGsYRTTzhi3NmERt5d5
    BlRWtPcqVGpS97I7sYAedSS2j00ewGM3pJn8pdzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=XUim0MU6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
      header.d=1e100.net header.i=@1e100.net header.b=XUim0MU6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFlN1+7vpsCHY2LGuX19CJDQBgcBpXdCaDiWymRCQ+hBZ/SqHw6zhCmt+bQRrxTLe5qi2T4bkTyskwtWy15TCqi7rDMalr1PeyeO0iV3VV4HqDF6zIgl
    g4Q3DizJ4Ua/MsBDQiQbCD+cTm2ASxG6D90mKf9xbNM3j8pSYjLR9K/Vkl2ZZ0fZxS7C3L9QXus7CBCwSy1AVMHH3+fQYUbIzZdFEOnfkoW0NWG3xlDOGWo5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeEBRJs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 13:09:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38849 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBRJm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 13:09:42 -0400
X-Google-Smtp-Source: AB8JxZqfgD3nYBo5awbAr3gfQd0b8jMzx0RjgC+V55Zh4GGvNvBM66Vtb98V/0NDvb366vrtkkkWYg==
Date: Wed, 2 May 2018 19:09:37 +0200
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
Subject: Re: [RFC 07/10] pinctrl: samsung: Remove support for Exynos5440
Message-ID: <20180502170937.bqnzjk4e2h3k7t4j@kozik-lap>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-8-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:36PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/Kconfig              |   10 +-
>  drivers/pinctrl/samsung/Makefile             |    1 -
>  drivers/pinctrl/samsung/pinctrl-exynos5440.c | 1005 --------------------------
>  3 files changed, 2 insertions(+), 1014 deletions(-)
>  delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c
> 

Applied.

Best regards,
Krzysztof

