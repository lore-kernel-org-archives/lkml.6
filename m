Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619581-1524704735-3-6543238337060852931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524704734; b=RMzPIGTDExG3LjmqgN5SqcYnITF9NHulUn6lsIMEtokF/uF3S4
    Gs+9jQET3TCWS8k7+fHMNaHl1ds8uVuzbH7EQ8MQX7zeKVYeeHt9T9mO7iq0jEC6
    0fuIrfo976n/Brk6TMVPHnzoP27YXJ/JDFnncuaAhm5mg6xP50H76UhZyC3+Htry
    dFo1MttksEjIrzugJUdfaxCrl+cHV7xipDsUkMeTziwn/jP/n+GnU/Mw8Y5/X/dD
    b+A8ZbqmYQV50Ra0bvf5wWuOAp+0MDvhQvZk3kNBDG87LvkFZ06UZXibg4/suDMi
    KuCFYHMwDCE68M05UBQ5M0uRzF1ZNQfR3dJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1524704734; bh=kHa4BEazde/z
    qZ52+S+WCaBLcb0kXRkKWh2QhYUHUm4=; b=GotR+EX9AZKoE+08csFxHQ0F/tCQ
    NT9urQpec5p0iItxt2WLi1H5CyogVhz7T9DBjJn9mfLAq5+2rqF5ZV6YnUUYVoHa
    35/Ys8UxpthAs7PvpdBZBall1c79Ks6hIM3Q5v4Fy6GImvEQjqw0uEp5B19rmwBZ
    nrFgFYx/8Brw/cOdzD9ARAhVj7S9R1oficnB6sEe+Wu67WYZnKcz9+SoT8vINSf+
    byBIvQhgFjKOHKOyPedjPpNbKjGegcXjryJBaIDKQ4+4kvjDp1V7e9JUDRaDqV5D
    0QbPPlKIT81Lqn6EXL9VQzag6OH5dROYdtn7TzSMtuw8BD0w9Pxj1ijpTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ayP4wQx+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ayP4wQx+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHpvB2UL/grlvWq1VUrjWqGD01nhhzeL/ty4oyULUu0lQcVkLjr93+VBq4FAVIGeLRikJO/wKz4ocDBGo8gpG3jfJCvr9wsb61tVG6Scdm2E5BKpr/r5
    d6OUBwDoHfjwZsFd19+Pesc0TjD82wpvBSzwKz7QZkRHypJYk7cYQQWiY1l49UDoOyPZpvZR+2TC24NymtGaYwb+ImvWRolGCTHSE4KVw6ELEjd47/Twy6OD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=KXQFBCsgnY3szuWKRloA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeDZBFZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 21:05:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:31634 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeDZBFN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 21:05:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180426010510epoutp010515d75a9c2e1b27d2e5b97fc74cad51~o1tsHpMoz0396203962epoutp01i
X-AuditID: b6c32a46-145ff70000001024-b2-5ae125c25d9d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AE125C2.70105@samsung.com>
Date: Thu, 26 Apr 2018 10:05:06 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
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
Subject: Re: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
In-reply-to: <20180424203239.21885-4-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGPff2foB2u3RsO2PJZNctcSQw2lo4mGEEJ9xENI3ujwWzlCvc
        QF1psbcsMhPtZECHA+dWHIIbGzBJkMnnHOUzAWTaLXyM8aGuFdbJ0C3Bic7KAL3tnXF/nec8
        +b3nfd8nOTSu6qciaKPZJljNvIklQxVfD+6Kix7cOZceW/g+qvPfwdDqyWEKtVY2E6hi7jaJ
        aoZGCFRzY4pAhXXNJLp35TSGZpaLCfSx7y6ORkdbKORcacBQm09C7h/3Eqi9ZgUgx+ofAA13
        3sLQRNfnJFoqGwKocrQPQ0fuf0+h2i+KcDRQ0QvQxSEPhS5Mj2No3P0yck8vkeja1esEKuod
        otDtuXISDd4rIdDaVKsCnXg4RqLlhm8AauySWrT+yb24g2s62wS4ialxnHu4fBJwizNFFDdd
        /zvOuao8FFfX8wvGtTUeI7mbUz0k13+mieLa6z/gbnz7IcEt9k2SXMdkiYKr9vgBV97RCPRh
        6cKeHIHPEqyRgjnTkmU0Zyeyr7xheMmgi4tVR6sTUDwbaeZzhUR2b5o+OsVokrJkIw/xpnzJ
        0vOiyO5+YY/Vkm8TInMsoi2RfVOt1sSoY+NjNBrp1B54XqOTkAwhZ9XzGZ5XTr074b5A2kEX
        UQpCaMg8B30/1ZIBrWI6AbzjTisFoZL+C8BTl1epUkAFodN62W4B0LdWpgjwSiYM+k95JU3T
        OPM0HLp+MGDjzC54qbuZknkPgLMjZZjMPwtL3beCtQpmJ1yr6AvOQDJRsH9hJjjDemY7nPT7
        QEBvZPZDV82D4EPhjCME2leacLlDNYDFnaZA4w1MKqxfDg/YIYwOfnrErgjwkJml4djdFVxe
        ci8sdPZgst4Af73SQcl6K5xvbAVyQQmAJb1ncfniBHBk2vuoQgvnz5dicud10DEYSIWWfCV0
        FKtkhINtLQuP8CRYt9RCyuu3A/idw0ucANuqHkus6v/Eqh5L7BzAG8EmIU/MzRZETZ4mRuRz
        xXxzdkymJbcNBD9PVEonqB9JGwAMDdinlPrzs+kqgj8kFuQOAEjjbLhyf5lkKbP4gsOC1WKw
        5psEcQDopMA/wSM2Zlqkr2i2GdQ6jVarRbr4BG1sArtZaX/1WrqKyeZtwkFByBOs/9VhdEiE
        HbwWOvG280Df8WrXxXXJV5cKjNuoUXpf/kL2Vw0u8qNNqG1t85OeWj/0RJDPHN1S7tyX8o9/
        NqzSk3TTE7HkfeIte/S5Mfvu31J//CHO6DvqGl7tvvRORlKyg9ruXlSoMmp+dh3b0WD6UpcC
        yJmt85iiKWP08N/dxbEP3kt9/XLyFgOrEHN4dRRuFfl/AXeGX6ZSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH973f490c3074is3chCWhsX02Zv5pvja2/skIy42fSnfV7oT8
        QWWJ9EDk6qTQJW6Rysjpwe5O2TGpc5WHizob0jw/tOth7jxM/70/r89778/7j4/IqCq5EDEx
        eY+kT9Zo1byCfTDuDVpsC+2PXVpSNRsqh9/IYKyoTYC6kloOivtf81DheMRBxZNuDg5X1vIw
        1G6UQa/vCAeF3vcMdHRcF+D0aLUM6r1+y+e8Pg4aKkYRHB37hqCtcUAGLmsZD1/zHQhKOlpk
        kPn5qQAXL2UzYCtuRnDV4RGgqqdTBp3OKHD2fOXh4YMuDrKbHQK87i/gwT6Uw8F4dx0LJ0Ye
        8+CrvofAYvWfqPtO18yjNeU1iLq6Oxk64itC9GNvtkB7zF8YetvkEWhl0zsZrbcc4+mL7iae
        tp6rEWiD+RB9cj+Lox9b3Dy94c5h6VnPMKIFNywoOihWsWqnpE3cK+mXrN6uSBjzlDKpBcJ+
        l7OKz0BWLhcJIsHLiTE6FylEFb6GyBnfkB/LRSUOIsOn+thcJIoMnkMcXUkBzOAFpKj8IvPH
        /xIRY+anv/6FJNc5wAY0i0PJeHHLb87jMNL6tpcP6Cl4LnEPe1EgcxreRI7fTw/kBOM8Obnp
        sPKBgcGliDQ8HuADpql4LTH7gv8ca0DE7B38HSrHK8iZzAz2BMKmCV1N/7uaJnQ9jxgLmiml
        GnTxOkNkamSytC/CoNEZ0pLjI3ak6OqR/3Vu2sMKG5HXHGdDWETqScroC69iVZxmryFdZ0NE
        ZNTByk35fqTcqUk/IOlT4vRpWslgQ7NEVj1DOSWlbbMKx2v2SEmSlCrp/21lojwkA7WXPd8S
        RNxJKetv7ecKExMPv9Q9a9ptX65lsqtLRmPkCdO160IrQj6UhnlO/jQ6VaePXF006IrTDFbF
        7Cq09MK2yVsv1/4syhIa055NxjnOmVey3h98xfzowitjFBujLIf0pj5j+Tuasa56xqen86/Z
        I+/eaVd9s2z4kmNjwsP3qVlDgmZZGKM3aH4BxJ1jPzYDAAA=
X-CMS-MailID: 20180426010506epcas2p22ea754331e0317cc342e1788382c57ca
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424203335epcas5p3bfd2172f68574b67818c1d2bc74041bb
X-RootMTR: 20180424203335epcas5p3bfd2172f68574b67818c1d2bc74041bb
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203335epcas5p3bfd2172f68574b67818c1d2bc74041bb@epcas5p3.samsung.com>
        <20180424203239.21885-4-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Krzysztof,

On 2018년 04월 25일 05:32, Krzysztof Kozlowski wrote:
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
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
