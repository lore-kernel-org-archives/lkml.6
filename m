Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668839-1524603076-2-7024773274215105472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524603075; b=bCzqZ2fVjBZB80WQyCr0xH8816XqvE2T0hoWyKbBy9pmlkD75Q
    fbDpl6VTA3aGZ8PRbcRU5j6YA1xrJ83AcpZYZGBvgEe73WDsBiNQr0GwT5NH2+t6
    jcUpqZIPz4KlyOBvDE/wbhRarOUCVze57uPb39eLwRefMJuaEB9crQH/THrmWjWi
    f1gOnyLnaM3NZtSCYmpnSZTOpTp/nNnaVkpENZqdGQpSYPtk8mpa5E73TsUfBgB+
    dMjhc7yoy5GguhKqcbYyogpcfSQTIPdxLXg1qS9c1vQhzicN6+wJ3kaYEA+FpJtY
    N18BlthzFWpvoksNQJ+KGXiGkU5wF18kwAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524603075; bh=Z6gPOh/jEj4lGI2eY6a3/b7wDxkgzHx8A/zHRJgx/4
    M=; b=U9RvS1MVeNh0wiUJliaavcZgEm1bKTjJRbB1DH83nj/u3ZNZhs3KMRZb67
    AKoxtr9ZadUyr0IEFtYGCONuwRzwy+e4VgYFrN0siRazgzV8POA9js75vt/xu2iG
    HV1sZsQM5wK8u5TEITDFY5budSxbEnM27nn30fF8ZNXI2v5xx8d95D0i7r1KQXH3
    RcPK0ZV0+ZxUvpfPBbBkDDYn3N8k4ExBAom0IWXdxVIW6YhWvNddpcoDfjM5EYSS
    O19pvJaISRlCCrLQnSf6DR2FpJvIVSD3zJtYB4G/vCf4be7t42ihJbb1ehJpKAWi
    4fit53zL/yfzgu+Hs7r91tjT2BXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kzc16glL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F+loKIv5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kzc16glL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F+loKIv5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnpEXM034IGUeowFH0IrRN7c8g6Jf9+0w/YcMcgXuu0OCF3xyKR7gJTAfNUfQVA4D6HVxaGSnN7Ese+Ui0dDL9+1k+QYREvvA9LEJldR3oBnBd6j6Il
    gW0CzjkMOCO650AkKkeUNa+Z5tPLV1BVBQe6jOEuhrfGGfgbA5fDIZqPmDgMkM+bcu7l6R0V7Az8W9M033ioN0rrRa2NPRJDeT/l9QBSwaTa/XPktvr/TOxQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=HEhsBhvELOkTVMn1VSwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDXUvI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:51:08 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40418 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXUvA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 16:51:00 -0400
X-Google-Smtp-Source: AB8JxZoObi9xIkKK0kUspvbFRxp38FgRIWrRXKZu6O/eMGAD8xRTEEfBnaRpPwxyiHZ2rWAUNuvM8l753KqznyTRVO4=
MIME-Version: 1.0
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 22:50:58 +0200
X-Google-Sender-Auth: tm8Cgdv1OiNdC5zb29mesGlfdDU
Message-ID: <CAK8P3a2CZU1CYFt0fdVSFFnj2Wg=mUcC=yuWAW7zDO0u2Q2dUQ@mail.gmail.com>
Subject: Re: [RFC 00/10] ARM: Remove support for Exynos5440
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
>
> Overview
> ========
> Let's continue the removal of old platforms. We already get rid of Exynos4212.
> Now it's time for Exynos5440.
>
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
>
> The only development happening around it is the PCIe driver for Exynos5433
> (ARMv8). [1]
>
> Removing Exynos5440, makes our life slightly easier:
> 1. Less maintenance,
> 2. Smaller code, less quirks,
> 3. No need to preserve (imaginary) backward-compatibility for Exynos PCIe
>    driver (so it is easier to add support for Exynos5433).
>
>
> Because of point (3) above - I left the PCIe and PCIe PHY drivers intact.
>
>
> Dependencies
> ============
> I think about starting with removal of DTS in some kernel release (patch 1/10).
> Then all drivers can be removed/updated - subsystem maintainers can pick their
> patches freely.
>
> Finally, after getting rid of all Exynos5440 symbols, the last patch (10/10) will
> end in arm-soc tree.
>
>
> Any comments?

I don't see any hard dependency here, if this is all unused, I think we
can apply both patches 1 and 10 into arm-soc at the same time as merging
the other patches through the respective subsystem trees.

      Arnd
