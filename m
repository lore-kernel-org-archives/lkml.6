Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650796-1524660926-2-3418017207954131235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524660926; b=k/5Jmd1RXjB8XJlMBVpFetXovZl6wSGkbxVLpjggVXc8/5Xp2A
    B9bEKGD/hSPmzKl8pLVAirFDNXV8ogEoCVDjSh12kic2MT8ckJVk0xuUGzF7qLX7
    H9VXjlwlo6G59cPNyv0/ZRBoPybDuw0Vr5n0lZNM8WWs9+RVTpgSqajL9fD3pn1p
    k/X/tstJA8gOUY3milrfp2T4y0rdEWQMmNR8ljCPWRD8n28OKnJGtb3FccYIrdTg
    g9YIbhpdpxvt2XiZPG5aLGglE8H5GqBFYcCm5VPlpD8nWNn++EX8MmTMq8SmnytI
    tcIMM6Dhuc+rU9KTXwTXpAIVwr6zefqHEZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524660926; bh=zx9FTn3UzvTAuiCfzkyQR1FbfEtshO1fkpxgTSGVG3
    s=; b=h6kuWxL7VHO+EemUL2kLD15dO+zo2UR1+9ZS7k4rWM134aQ+hF5DvWhLSx
    Js5AGktQVSAKkRcHoIKljTcQcIK3qQ34Gxi5o5sZAOEWu6o8uwmyCXtHyu9zTh1H
    yz62dUPhNl7wBm3y83fsciGFzjSHGjVKmEdARjndhARVBeuleW9zLJ77tDGwA8Hs
    xfYjpaLB/4zuxtazl1BEdtwCB0npATXmzcdgpzr84T4m2mdhkQoQ2E8NPaAJtHs+
    0kuYtnawLn+34QsQnr8U10NNDS/RNIFeS1nd7oUssyhrL/Tc/ahtiBGihNO2fJGC
    fCM0Ol7cvlJt+KTTEASLihIndnag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGki0t+oiwDnAL5gFR7m8jo6F+o7N17HZB2X+e2AwVNlX32a/4pLjTcfkmhRbYCBD0lIzSMIPYTlmpqGesRXaJAS4g89iLtlag0GsbWi9PPSmaEm2Yc7
    StqMj4/57p8agAq3cQ+r+S8VI3CIeE/u08VMS3TQZQT59qrk0g/d/x6hDaS3iKPMnyhniDMn8PP7nxEeeFi83WuFkkzHphrmUVknjj8kN3TwlT/Pb8XqVGJh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=EcIs9lBhwwurp556fc0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeDYMzN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeDYMzH (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 25 Apr 2018 08:55:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212EE2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx4/lHFdHBE3SuU+wNBUuIC6BBF2lhW267tHk7k2oF/bYNRMhNi4FHIbZ9JiXJFAg/5kYP57t4maSUZOnZj8Ivw0=
MIME-Version: 1.0
In-Reply-To: <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org> <CGME20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0@epcas2p4.samsung.com>
 <20180424203239.21885-9-krzk@kernel.org> <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 25 Apr 2018 14:55:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcOCSKbRMEn738MwvS6f2DhxNPDb0BcNn0FY2Jqx1MtbQ@mail.gmail.com>
Message-ID: <CAJKOXPcOCSKbRMEn738MwvS6f2DhxNPDb0BcNn0FY2Jqx1MtbQ@mail.gmail.com>
Subject: Re: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
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
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 2:49 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
>> The Exynos5440 is not actively developed, there are no development
>> boards available and probably there are no real products with it.
>> Remove wide-tree support for Exynos5440.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> It's good you didn't remove S3C64XX_SPI_QUIRK_POLL entirely as it will
> be needed for Exynos5433 ISP SPI controllers.

Ah, actually I did not plan to skip it... I just missed it :).
I should check affected drivers if this removal left any unused
symbols (except the one mentioned).

Thanks for hint!

Krzysztof
