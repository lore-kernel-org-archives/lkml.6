Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650796-1524657867-2-9723050627887443998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524657867; b=iVDK6veyqOaW7XpfoucbVT6BnfXX2xiQt9KAs4Dyf8SPbXnQgB
    0KQ0ZE/hvyC7FyXXvNSi767690K4APgVTKKPVg0C00CLkdG2YqdfxQ4LzamtU09l
    rzafDS+K4BV7e9qZ0Gb6axoh9uJnIIxREHsLqjOPeGcJS/uZBmnJOTI077FXo9t/
    znl9/Iyb9Oz09glsOItejnpcn+mO4keC8mO09NLv7rRSczY1gblQwad7WZVsQoCM
    n7rz1JCWX9/r2prGAMoIvSPszK2K7ryks/Yz3kuVqcxUdqcqBl3mGE2MjGk86tKE
    qeFS6gX2IRs4waelqkpKnkZipP2D+j/oKvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524657867; bh=PY92VfCWGlSnmYYwVSWZXRUJwS66yb
    NvScDNbHlD2bY=; b=ahoILLzoR9zg7av9lgKte/dZkzDcIPgwi93xBDxEq+tx+Z
    +RiRyZF8K8CW8/2olhvXeGESeANvGjQpoohly5a8Pzs12/kZEt1bKDDKCuNezY5J
    9a+7AlbpGlWDSQECqO/eOFLH4XMl/5QX8BfHjWiZz56yo01ftzugFUzOO7AE/1qi
    unFvjvLp8tlrCc9NfRjXH69LyveaBcNCbYt4/T3Ij2aqAubkL0EMcXkT13/tehSU
    mlHrLw4ESTIMaAZCDqsG/EBVAiHitPFEYWEhlCWlVh5wutnRXzCG7KNVcndkhJKL
    nnko9SinWVEvy6XrQn16v+DyBtOyyhuP5gPTdnEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJEXkemFZ0IzlIoOBh4++ruRfhD/3y2WIjZtH2QfIXX7pXRwhjmJYU5QpK46zc26j2cPoSBMje7TiimegPvB0sOzQTg6O8IxUDFX2oTC0dZUFd5z30Wu
    +/OLCblo2SnN4HUcmtOA9qr3S9mR0Z6GVX2Vl/rstkf9EyszvYi9TprQ6M/lCfPBZfqZurpnyaC7nYWGUDJx0syMT1+yJOXKODtkR6gUHXkfTJIj2hwxyL56
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDYMEV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:04:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeDYMEP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 08:04:15 -0400
Date: Wed, 25 Apr 2018 14:04:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 09/10] usb: host: exynos: Remove support for Exynos5440
Message-ID: <20180425120407.GA6582@kroah.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-10-krzk@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:38PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/usb/host/ehci-exynos.c | 7 -------
>  drivers/usb/host/ohci-exynos.c | 6 ------
>  2 files changed, 13 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
