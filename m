Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1632850-1524705354-2-17065398049695560380
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
    1524705354; b=XvkBRmFXVyiZLqkvvEZAJwtRPTYeD5MchpPAo7V0+eNtzBv2//
    xbX0V8HNWJQImfO1gSvnN890ZVPusrEplt1uFD2H92oJXbw+tNMkUjgIBOEzPnpB
    VhjQjhxaFNhSkEt0tSKh5EbI0J6D+HoGv9KKtUYJXxgL503hmivhJcgWvkfJv1CU
    szy3bUqXt1Ge7o/fRdPxw4Oi+wvNQcuTFKxtvx8w7Yqp1CCX6fYm3PhnJeHNO75G
    4kyGItnrEPbEKxrWhrgvDn5G0opRZl/4dqN4GLA3HScCPQ/iDAlpw/oK6ubXtuhI
    wvPHJ0iAimFqaDjv4FPOTXF0TqAzJL+sXXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1524705354; bh=a7v8r7rQLdzS
    ouCZ0kOMvc0Bm5MAvaD+DghNZkC86CA=; b=cYTJLmlVT/ar0OFcQIE0r9uJQwtL
    FV+BbBYqzJRhRGws61xAGPk4CWKQZmtpLXv4crQqJVldqEfzbQaDiacoFeJuc6O2
    CNTgECp7BUs3VowRRjEysxsMXuU7t5Sog85pKjONUtwONIGMPiLGIvRtMZ7lTgqz
    aTUcPMHFMoFpwnquGFLC6Qb4/jPPIyye7u2xFNIXZaTrRbg4/WH0WWZbPhLeV8jj
    2Tt/hPL6o0KkgAmToNnQx2E02X7t1g2f/oBd8Ues1qXKelsR97inmG4Eamo0vzTs
    PBeMVE6oIkkLMDUThG+8SxSn1d450PJ0CaghgUtqtA/kWdqx9u6TuzoPCw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ONZ+GO4r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ONZ+GO4r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9Vr0McNVI+V+BXk+HJVXo4gtVlCTBHiZFaS634ORUG8Dlj6swfMFlr5PEfk9YYR4yiwkthju0ZWXLojgGJfsUb+imO5dfPuuvsFJ87vQORtBoFwE6E
    4MWHkYmSUU57KDX3h4O0gSxWYJPnC//ye8TXzIo4DRD37hYXijom1kE4P1zm7lV0nNRJd8UfqY6d5DOxxZBY/onXA4ffyiFx8GqtzVHLxLfp9tAGlbt3lUco
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeDZBPk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 21:15:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59661 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDZBPb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 21:15:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180426011528epoutp04d8d834fb7b638809247ba4fe75495ce9~o12r7Fiyn2933629336epoutp04f
X-AuditID: b6c32a48-c31ff70000000fef-8b-5ae1282ac159
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AE12829.4090607@samsung.com>
Date: Thu, 26 Apr 2018 10:15:21 +0900
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
Subject: Re: [RFC 07/10] pinctrl: samsung: Remove support for Exynos5440
In-reply-to: <20180424203239.21885-8-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc99r3ytmZc+K7oZlE54s0SqMttRejBgXnXmLLJIsSwibYS/w
        AkTakj4gc8limQM6N5k4iK4MOkadWYdhhW6rAoJQfkwYCBVaxygwGBtKNChqx49lr31u86/7
        ved87jn3fJMjwxXdZLQsz1DImQxsPk1skPzQvWN3vHL7TEbizK1dqCH4B4bWz/aSyHm+SYqq
        Z+YIZPMMSZHt5rgUnWxoItBi3zkM+VfKpOjT2Ts4Gh7+jkRVaxcx1DwrIEufBKSoxbYGkGV9
        GaBe928Y8l75gkAPTnsAOj98FUMlS7dI9NXXpTjqqm4H6JJnkkQXfCMYGrn+Krrue0CgwYFR
        KSpt95BobqaCQN2L5VL097hTgs6s3iDQysUegBxXhBbOh8z+OKaxrhEw3vERnFldOQuYe/5S
        kvHZ7+PMZeskyTS0LWBMs+Mjgvl1vI1gOmobSabFfoK52f+BlLl3dYxgXGPlEqZmMgiYCpcD
        pG3M4Pbmcmw2Z4rhDFnG7DxDTgp9+I3MA5na3YmqeFUy0tExBlbPpdAHU9PiD+XlC2bSMcVs
        fpEQSmN5nn55316TsaiQi8k18oUp9FsqlTpBlahLUKuFU3N0j1orIO9wuZ6SAbLATLx7YeIu
        YQYLklMgQgapJPiX1SLoDTIF5Qawzz5PipfHAJrvlPxHzZ+89IRqBXDR1wVCCTm1EQY/CwgJ
        mQyntkLP6LFQGKd2wO9bm54UmgRwpn6VEHkl/Hb0Y2lIS6iXYO1cT1gTQrzjT3+YeZaKhWPB
        2XD9zVQ6vGx7FC4URVkioHmtERc71ABY5s4P6U0UAz//0A5Cn4igtLDkdmyIh9S0DD4sfwTE
        CQ7CheEpXNSb4O0+Fynq5+G8wwnEB+UAlrfX4eKlCsAhXwATKQ2crz+FiZ0joaV7nQx1g5Qc
        WsoUIsLAzp/6CVG/AtseL+Pi+C0A/jhYg50BL1qfcsz6v2PWpxz7EuAOsIUr4PU5HK8uSErg
        WT1fZMhJyDLqm0F4gZSMG3QOpXYBSgboZ+Rp9dMZCilbzB/XdwEow+koefppISTPZo+/x5mM
        maaifI7vAlrB8Eo8enOWUVhHQ2GmSqvWaDRIq0vWJCbTz8nNrw9mKKgctpA7xnEFnOnfd5gs
        ItoM9HG55NsnjsTX/r7Ve2CAch9Jj4nybylW9C/cPTyte8G/cyKt8ucbbb020/5rSVGpRGSk
        Yyoybk99oOKb7a5ty/b1qV3eo22u4JxudaJHGdhWhY92tBZc003qqnTFa7906qr3ve9dcr5m
        MLSXNt5vqFyOPTdLaN909mZV1x1aYnfSEj6XVSlxE8/+A+J3qTFWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA01SW0hUURTl3Dv3MdLUdVI8vQiHwpDSkordg+onOv0F9aFTYUNeVHR0mDFN
        CdTKymdmajmlZmqPyUc6JilmaDc1FV/paJSajmSmZGbB4ItmlKi/tddae6/1sXlaWcys54PD
        IkR9mCZUxTrJ2paswg7PbSPqnRMpblBoG6dgMaOJg4q75QxkjYyxkC91MJDfa2HgSmE5C1PN
        dygYmLvGwE3rJA2dnc85yFx4TEGl1W6ZSRliwJy/gODG4i8ETS9HKXhfe5+F2VQJwd3Oegri
        Zz5w8PBRAg2NWa8QlEqDHBT3d1PQ3XoUWvtnWWhv62Eg4ZXEwdhIGgtvpq4zsGSpkEH6fBcL
        c4/fIjDV2iMqfpMjW0hJXgki7y3dNJmfy0BkeiCBI/1FP2lSYxzkSGHdBEUqTYks+WSpY8nr
        3BKOmItiSW/LZYZM1/expKrvuozcG7QhklZlQiec1U4HA8TQ4EhR733onFOQFN/G6eLYi8Uf
        v7NxaEKWhOQ8FnbjL1dK7diJVwo1CP+WLJxDUAjO2HZ7yC7wPC1sxlJPiIOmBQ+ckfeQXvEP
        I5xW0Muu+D3xs55kxoFlwlacO/Z2GbN2/vXXgWXPGsEd99msyHHTVfDFyS3RjjsuQoocV0u1
        rGOghRyEzV2jywtrBYJzrhahlTQzwtLsMOvYlgt7cPw393QkGP/ravzX1fhf1weINqF1os6g
        DdQafHQ+YWKUl0GjNVwIC/Q6H66tRPbnqX7jefMlshb5NyKBR6pVihMFn9VKRhNpiNY2IszT
        KheFb6qdUgRoomNEfbi//kKoaGhEG3iZyk2xJrzJTykEaiLEEFHUifq/KsXL18ehqMsnp3xb
        QmbeBT3RyZfGtqRYtrlP2hIPnPn6ohfX7Vc/PcyEzwy6Zvebs4zpHvu2u6kv6cqmcg4eJyiz
        MtF7oy0xeM4ntrD59G2tNiaty3xq3Y9jVHL9s/Zbm/KC8kzOfnuPFGS3ljVtPLq6oSb/SezZ
        nuTxDs0OpXeXMqlvfrxBJTMEaXZ50nqD5g95wAdrOAMAAA==
X-CMS-MailID: 20180426011522epcas2p1aec8cd55df8a5a4ba37a4ba1acd3eb56
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424203539epcas2p4e099df5797adb9a49c0d49bbfc829543
X-RootMTR: 20180424203539epcas2p4e099df5797adb9a49c0d49bbfc829543
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203539epcas2p4e099df5797adb9a49c0d49bbfc829543@epcas2p4.samsung.com>
        <20180424203239.21885-8-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 04월 25일 05:32, Krzysztof Kozlowski wrote:
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

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
