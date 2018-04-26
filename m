Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619581-1524706920-2-16937840156133902470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524706920; b=GRzJnyzAadP6iIpaM//NfAZKra95YABgULsxwaWu4oaAcuI5DV
    szbQ1tJLul1s43kZxSI2fyejz4F81In/Lxdz3j4d0kvobccpRNMwvb7wKCx1E6Lk
    eLyWp5zBwo/m5EoUPPAr4fxeRHOA7I9qku++KYnKzdU3sAZnc7aA7vPVNiKWKEPT
    PAch7iY2xm1a8jTe9jQETg9qXtpIyNF+kgb57zbSRJQoaeQgOIDI0zwFRgX7lyXC
    xbarUwnnGf8LETW+OfNChyNf3EKnvsKsj8U1+6M8HkFmLeX66jaWN9dAZ0W2D3uG
    EleSERT3APPlJE+5YmvpHzj8/R1Cw7JMdqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1524706920; bh=kFe5Tgma20fj
    Cwq0FZs9X6LmfRExpRCMmXWJAiS/lmY=; b=tiQbUeKItdNixMcm5wEyOiwcSn+y
    IwjAlnhPdPaQgNTYd0S3u1eYNGP1fmdI4a5e+LSO/u4JdEsA8LT6I379gMRxLIlj
    XogKC0a7ikQ49uP9CIM8v9jlolW+Yb5SlmSETUTyIZsZjWNj+yFYxa40O+4qikbI
    xoiFyVY46t9QX8FkJsb6GEm73HqPaLQRmXw5CSx7WfkRNw5fzffI/Y6OR+zHo7M6
    cS7mNcOoOQSkuGo0XOLDvjkyw2JOlvtPxj587oO+WiQ1r3ZMNBrAYXVwvzAFlWEH
    HZO8PPcpJHHW0/zu1C7dMRm/iNxI4V7ZM0yB9E/aIT3JyLh2PyLiqM96Yw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=moz1rQMe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=moz1rQMe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFb+J5SJXXINYomcMDiEIDIf4UEG2zELJ5pbh3HCoK6EyjcB28Rr6R+ErBtR84xp1+b9J06xBPOywYvSliung/hlwkDOJqynp9CupHHjPWFbjeFFrjUu
    OKdjuETsh9vNFdmTx/VANti9syGYSDG/KHhtwYSJhLNBKTO5IEF4bmAPMV21GME4XUbdtL379btTi1Cl0c4O1fw/5d3ZDN/YjDV4C/cqg+PzcDu0MFwv4LAu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=KXQFBCsgnY3szuWKRloA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeDZBlr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 21:41:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53108 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeDZBlh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 21:41:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426014134epoutp02f31d6a5181a304928b2e60ff42635c08~o2NeJmcQw1794917949epoutp02Q
X-AuditID: b6c32a48-c49ff70000000fef-e6-5ae12e4b26bd
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AE12E4A.90907@samsung.com>
Date: Thu, 26 Apr 2018 10:41:30 +0900
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
Subject: Re: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
In-reply-to: <20180424203239.21885-7-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tb0xTVxjGc+7t/VNit2uV7YSxrd5sCZBRaGvH6QLLFtlyM9xC4j50OMKu
        cAMIbUlvIcN9kG2BsmYqIgaCAjpgJg2KFOSfIgt0gMLAKgXMVgaDOBUThwxlSNnaXsn8dH7n
        zfO+z3mf5NC4cpCKoHPNNsFq5vNZMkzWORidEJuink+L77kdiRrX/sSQv3KIQm01rQQ6Ob9I
        ogb3OIEaJqcI9G1jK4keDFdjaGa9jEDHFpZwNDFxkUJVG+cw5FoISJa/nyVQe8MGQOX+vwEa
        6v4DQ7d6T5No5YgboJqJqxj6evk2hX74sRRHAyf7ADrv9lGoedqDIc/1D9D16RUSjY3eJFBp
        n5tCi/NHSTT4wE6gzak2Gap4eoNE6+d+BsjZG7BoW+Xee4NrqW8B3K0pD849Xa8E3MOZUoqb
        bnqEcz21PoprvHIP41zO70jut6krJNdf10Jx7U2HucmRbwju4VUvyXV47TLulG8NcEc7nCB1
        e5qQmCPwWYJVJZgzLVm55uwkNmVfxp4M/dvxmliNASWwKjNvEpLY5L2psR/m5gfCZFVFfH5h
        oJTKiyIb926i1VJoE1Q5FtGWxO7XaLRqTXyCWqsNnLr0d7T6gOQLIWdstE5W8Ne2LzfvLhMl
        oDHMAeQ0ZHZD79AC7gBhtJLpBnBk9hohXZ4AeHnuCb6l6mu2Y0FWMhcB/MUVGWQFsx2unZiV
        OQBN48zr0H0zL1jGmWh46XIrJc3xAfjP6hCQ9FHw9OKj0EwZ8yaceFxLBplkYmD/3ZkQv8js
        gt61hZA+nDHCnobHoUE7mXI5LNlowSWHUwCWdecHeQfDwRFv8NVyWs7o4Qn/TGgdyMzRsOR4
        BSltkAxXrrkIiXfA+8MdlMSvwDvONiA12AG099U/664CcHx6FpNUOnjnrAOTrF+A5YN+Krgz
        ZBSwvEwpSThYNb9l8D7sGqx8Fmo7gMNjnVQFeK32uchq/4+s9rnIzgDcCV4SCkRTtiBqC3ar
        Rd4kFpqz1ZkWkwuEPlAM1w1+Gt87ABgasNsUqWfn0pQEXyQWmwYApHF2p8J4JFBSZPHFhwSr
        JcNamC+IA0AfSPw4HhGeaQl8R7MtQ6PX6nQ6pE8w6OIN7MuKko/H0pRMNm8T8gShQLBu9WG0
        PKIE5OYdNjaj8P37Eugb8PP033MNm8mtYWr/aFw77Px0mvqKtJtcMV11/0bKmthPmhIvLMf1
        uusP3TOUJTYW23YZD6R7TL/OK2qES+HjSyMO5gxd7bn/VnS/mT6wmFetMn50bM5zYYnq0ruL
        ZjrbX40CUdUjhpXJlM9Wzx/0Je45yMrEHF4Tg1tF/j/2NMhKVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUiUURTlfbtTk5+a9DJImpRC0EoKLhRhUPloIf8INQQ52IeVjk4zahlm
        m2aLW2rb5FKNJphZLoiJC+jkktG4jhapjWOkGeRSMrjVjBL179xzzr3n/LgC7fqM9RBOR0ZL
        2khVhIKTMe2LVhffA34W5dZ7lQAG21cKFjKbeSh78JKFu5YRDvKN71nI7zGzcM3wkoPvLfcp
        6J+9zkK6dZwGk+kVD9nzRRSUW+2WyZRBFiry5xHcWPiJoLl6mILumhwOplONCB6Y6im4MvmB
        h6fPkmhovFuH4IVxgIfCvk4KOt/ug7d90xy8a+9iIanOyMOIJY2Dpu/JLCyayxjImOvgYLbo
        DYLiGntE2S8S4EVK8koQ6TZ30mRuNhORH/1JPOkrmKLJa/0ATwy1YxQpL77JkU/mWo405Jbw
        pKLgEulpvcqSH/W9HKnsTWbIowEbImmVxSjIRSnbdVKKOB0rabfsDpGdeteey2gmVp5fHJ1k
        LyOD7BZyErC4HdcVJlO3kExwFUsRvvPtN+MQ5KILtmUN2rEg0KInNnaFO2ha3IQz857Sy/4h
        hFuqDPyyfzPOGZmiHZgRvbFpRs85MCf64IbR/iXsLG7AvTYrctx0F4/i261xjjurxRQnXGWs
        4RwDLT5EuKJjeGnBTSS4tbeNXU6rQNhqHFpq5yTuwFkL/XQGEvX/ldX/K6v/r+xjRBejtZJG
        pw5T6/w1/pHSOT+dSq2LiQzzC41SlyP791Q1+aRXI2vBiUYkCkixUh705LPSlVXF6uLUjQgL
        tGK1/GiqnZKfVMVdkLRRJ7QxEZKuEa0TGMUauXNU8zFXMUwVLYVLkkbS/lUpwcnjMpK+3TOP
        BR9SfdEc2d+yPtG3weYefDEx5Oz17XvnfaQz8Xn1Kdvo2z2+aQkJ8Z07s72l34Hj40Frb8bP
        Ve4Z4tx2jXmlpx4u/bjieIvy+USErX39qjaL4Zyvn6TUB1hCQwpjPTfOrOo4SLJCme79Q1/T
        uWnpF3afqM5q/WjyuBYYrmB0p1TbfGitTvUH/IaY+zkDAAA=
X-CMS-MailID: 20180426014131epcas2p3da2392f5a4c95c27bbe1dfeef5526a0b
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424203603epcas5p4cdd2039eabe7039e4daf286ed4c1ecc0
X-RootMTR: 20180424203603epcas5p4cdd2039eabe7039e4daf286ed4c1ecc0
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203603epcas5p4cdd2039eabe7039e4daf286ed4c1ecc0@epcas5p4.samsung.com>
        <20180424203239.21885-7-krzk@kernel.org>
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
>  .../devicetree/bindings/thermal/exynos-thermal.txt |  14 +-
>  drivers/thermal/samsung/exynos_tmu.c               | 155 +--------------------
>  drivers/thermal/samsung/exynos_tmu.h               |   1 -
>  3 files changed, 4 insertions(+), 166 deletions(-)


After applied this patch, I tested the build and found out
'exynos5440' keyword. There is one comment including 'exynos5440' as following:

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f92f470bce21..cb525228cfe1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -943,7 +943,7 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
         * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
         * states that INTCLEAR register has a different placing of bits
         * responsible for FALL IRQs than INTSTAT register.  Exynos5420
-        * and Exynos5440 documentation is correct (Exynos4210 doesn't
+        * documentation is correct (Exynos4210 doesn't
         * support FALL IRQs at all).
         */
        writel(val_irq, data->base + tmu_intclear);

After removing it, looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
