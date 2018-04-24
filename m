Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668839-1524604360-2-18219729805942653146
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
    1524604359; b=KNJoSTVdhuisxMWGFtvdgY4bChDHa7pj4w+cbi93HegZJw+B4d
    uhLAhuTRI2+SfuPsQA+ho3woGBlRUiwGpTuT50qZqafBLtmxQAfBH9VUi3x4d15Q
    Fy2oqlGQ2qICDpsvitFpNvlUt0qr55CxJdfIz0Kwi7nLS41T2EDOl6gG9HoQ0UHf
    N+TzCPocYGT4hlWlzUIPTa0U1PceiVPMJngyc1P1UJ+DgkzUGNLIVxb9BoXJ2hjs
    sNqLWc/vmeN2Gs6HS5/gBS/xl9O1RuHGsTwR1BF4V0sKhuhLxvlHQiI0Dx+dsFeh
    pqqgPGDnwOREp/qU2o/8mAdqnwECb4BPI2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524604359; bh=6qIiZYSumiTaP7cdDrRYz1Qxiv0rb9WWviMIiiY8F+
    4=; b=fhAj7vm17KxkhR/hPU+jbJuIM1WBzvoNdSCFiAeGrDxlBJ3V30Dooevd0R
    /JvDKsL0UoaY7g2X0tzpPOkVnSTm3Wh/NoQvvS7n1ABkCBgg71LbrUAvpYje/HSO
    tLMN4KzVZ2Km08hoNFBVg142O0rtqK8SX07aCP0nJeHVrMuyOy73pjEVJIup7DYR
    ghLREs2YahD7vcQGzkL80bMA615eCDz8MLJwGnmKxy1HWyk8HkGY9ys+fwvNJsW7
    0cQc6s0ZjP3uJeObNAodT1QylfzShvcp2NR+9SaqBByM9WUGBiL6J9rOkiCJA94D
    +LsMmuH1k0ueqR8cblDOdDwfAG7Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ddPkcXKh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YQeTegAd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ddPkcXKh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YQeTegAd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFNiMJVkUgJZrrJIIKzIKsQRqph8PY6yl3ZV8xQ92BSIDnOGKrtQtc31ct4tV6aJsQ3VyZD+UUUuyfKkEILuqZjDtuNVAVHr7G4fq0ilD8lLDuIWpHYK
    AKgy04HfWHqD5qu5cknj+KNAv8Qx0HpZygRzPbk1uhqpXVTzvGTgXuDD8A72erD/DKWU9Vzm/ukE0qWyillRApDaLx24tpX/G/ClJEZTpgg/DB8zGfOdLXwO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=UUw0E1YPMYXNbQZAUSUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeDXVM2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 17:12:28 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38125 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeDXVMR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 17:12:17 -0400
X-Google-Smtp-Source: AIpwx49kdvAXbahUZHeseCAE6zQYTK23jUkRuuPlV0/pYGf6qeGKtr9JTIpb7taKIcdXj40QlW9ADgjGDDP5NJtLxi4=
MIME-Version: 1.0
In-Reply-To: <20180424205636.cdp4czq6hhs5gu5a@kozik-lap>
References: <20180424203239.21885-1-krzk@kernel.org> <CAK8P3a2CZU1CYFt0fdVSFFnj2Wg=mUcC=yuWAW7zDO0u2Q2dUQ@mail.gmail.com>
 <20180424205636.cdp4czq6hhs5gu5a@kozik-lap>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 23:12:15 +0200
X-Google-Sender-Auth: ClRbdF8XkpKQffim3nj6VCvEFsI
Message-ID: <CAK8P3a1Az9acSZwdhPz+Gwy6nSL=WAB6-z6Cq9m=nPLzF240_A@mail.gmail.com>
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

On Tue, Apr 24, 2018 at 10:56 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Apr 24, 2018 at 10:50:58PM +0200, Arnd Bergmann wrote:
>> On Tue, Apr 24, 2018 at 10:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The only dependency is through Kconfig symbol (SOC_EXYNOS5440).  After
> applying 10/10, which removes SOC_EXYNOS5440, some automatic code
> testers can complain about non-existing Kconfig option.  That's not big
> issue because all this will go away so indeed we could take everything
> in one release.

Right, I wouldn't worry about that. Kbuild itself doesn't warn about missing
symbols, so this is only for helpful automated checks that tell us that there
is still some pending work.

       Arnd
