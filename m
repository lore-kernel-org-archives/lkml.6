Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-721450-1524662354-2-15345564233780005525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524662354; b=eUfGp5YikeeRURfBnXFnKUa3fgV0PuCoXRVrvII7C3AazcG3x+
    AUyAGe7xMPUGsFmPJBU8V+Wr8xyWssGEmmqpEpcctIME8rmqNnStvdjHvb2kBaSk
    kxY2LLdzFbs2973G/EQ3QkGfkXnMWsrh6qmtxaR8D4+Nry54JTpLM+Ww8iPOuuKr
    YK/8sO5FMFVjmTnQF5QJ6ClzY4RK5h/+q8u5ZMVlpxoHANJ00xiQh4AnHL7VD92C
    A7TEWfFUxTOMaO/BIicf/Y1Zfmwkx9EtOcqr4RpeUKypRmUc6VRPp/y64YDDJWpR
    kXF18x95YcBNo9fWpZvN5SKeg27BySMj96WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:mime-version:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1524662354; bh=HdychpixaT6p
    Swq2oZkMoqL6msbkd7lj7uWiroA8Urg=; b=srVJGaFKHcJLfcNFA2Vll9dgygxW
    4Z6XFckcdXmhl3OXEDifnqosyvEKrpVaVslZm3MHxDVDIiPuUys/m8qhYsjqOZZj
    OISI/Kr2rqN3XnIZL792O5Zf4osmafRdrec/DYnBQeD6YD4ZRCiOEpHnBUlcqSlj
    akTS8r4ctcxrtt1t9ceLrZuemRumujXBZSJqaP1B00TfZv/Grnw5GfVXIva+mc61
    6wHlePVXN9oIR5muD9qG9GybH5PQuDqwQZ2w5eHBNLueuLJSbOy6obkJ4dD6NgLc
    LXfUtyi7nh/5LvDwvvoFEsGl1LP6H8G0hffG9U6FfqNenY7m0okY5jtEGQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Pbv6mtm/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Pbv6mtm/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAursqmvPVti5nlgsGbF0RGVXVyCl/qyKZ/rq5nNfJAarvTnE4qejpWPoaEX1AKGDxjzPdFM20eDGBzoo0BWeQzzf5Rlo4bLKmX7P0zET6FTTZmkoBQX
    wRDXGP+7RXAgr3zkYKBU9cDNkUteemff/1SC2Xhw8iz5yl7nZ0Z2ul+JtBpldKKJ3zMmIi1eK7k3CdpaAWy3Aneon1dNoYw3AU1FxNvtvRd8n/rTC1JXmL5H
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xQMrlssy50Kn4cZdMiUU9ANOUCQ=:19
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
    a=bFUnhJpB9Z3-8uSK8OwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeDYNTI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 09:19:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34119 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDYNS7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 09:18:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180425131854euoutp010bfe438c9edf60f6064154ab4eb5fb3c~osFDMTTMq2424624246euoutp01z
X-AuditID: cbfec7f4-6f9ff700000043e4-e9-5ae0803ca67f
Sun-Java-System-SMTP-Warning: Lines longer than SMTP allows found and
        wrapped.
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
Subject: Re: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
Date: Wed, 25 Apr 2018 15:18:51 +0200
Message-id: <1951102.VLysaozMLK@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180424203239.21885-7-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUyTVxTHc5/3Ero8VpQ7XSBpcOoykRmNJ0rm5jS5zCzBD/tgNWqZj/gC
        lbTC1CUb0yHOTWBUgmNTVLRKgzJaooAUTC1U0Qm10IIREDVREcOwIBUorPSpCV9u/vec3znn
        f26uQKtauXnCbt1+Sa/Tpqm5COZa87v7SxKzH2sSps6thjL/cwoChc08FPU948A7/JyFUsf9
        4NHuYeFIWSUHA85iCjrHjrKQ//QVDa2t//BwcuISBZanQWTo9x4WrKUTCI4FhhE01zyhwF33
        Nwe+Ew4Ep1obKPh5qIuH86YcGuxFNgRXHN08XPS6KHC1rIcWr4+De3cfsJBjc/DwrC+Pg1sD
        uSxMeqoYKBhv42DsUhMCc11wRNUI+SKOVJypQMTtcdFkfKwQkcHOHJ54L7yhSW1JN0/K6l9S
        xGL+lSOPPPUcaTxdwRPrhZ9I++3DLBls6OBIdUcuQ/7q9iOSV21GybM0EYk7pLTdWZJ+6efb
        I3ZVTY1QGT76wMkWRTY6Sx9HCgGLy7HL0hLUEYJKvIywu6mLlS8+hJsmrOg9dbVjmJMTJoTv
        5bvDJeMI9xY7uGlqtpiMC9tMoQpOXIX/yDWHdJS4GHsDo+y0psV+BfY4F8k8wbc77oTijLgA
        +15WhrQyyL/Oz6Om9Rzxa1zdkBvSCnEFNgY6aZmZhf3GHkbuGYsbGovC/T/F/zZfRdPmsNgm
        4O6aKU5eYR3uLb0RXmc27ndW87L+CLuNvzFywRGE39bUh1+mAOH6SpWsV+NbTld4wge48Fpx
        kBGCcSU+djSMEJz/8EG455e4ztgffi4rwpYXA1QBiimZYbxkhvGSGcbPItqMoqVMQ3qqZFim
        k76PN2jTDZm61Pjv9qVbUPCb3510DteguokUOxIFpI5UJmzq1ahYbZbhYLodYYFWRyltMT0a
        lXKH9uAhSb9vmz4zTTLY0XyBUUcrty76UaMSU7X7pb2SlCHp32cpQTEvG51z9O1k2+mor86P
        pux8vcr6TZxojUbHr//izrxZsXmENbtsfzYllZsm4/+zr4yMaTwwZOzanvRiz2mjce27lLRk
        k/9D5tu1D+PLl8+l1llujJgOuxJstf495VGvSmPnOH+Iq/1Ym5yVOBq7IWlBxpPAwjXmLbqN
        46PeuTC4eFtkIEfNGHZpP/uE1hu0/wNujPu04gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+7dvXeTFrdl9GBUMCxKyCyKjmFRUPTkhwqKqEXUqIuTnMVu
        mvYhzbKVmDNfKNaLK+2F4es2I8uXsqWlkS2dU0qzMqZkSU3RptPmLPDL4cf5/w7/L0dKK0xM
        iDQ2/pSgi1fHKdkgSfNEY+vKqNQeVcSEl4bCUTcFvpwGDvI/97LgGnIzUGB/6x9t7QycLyxj
        YaDxGgUd3osMGL5+p6GlpZyDvPEHFFi++pVfmd0MWAvGEVzyDSFoePyFgtYnN1nwXLEjuN5S
        S8G5X50c3L2fTkN9fg2CEnsXB/dcDgocTdugyeVh4U3zewbSa+wc9H7OYuHFgJ6BifYKCWSP
        vWPB++AlAvMTf0XFMNkcSopvFyPS2u6gyZg3B5HBjnSOuIp+06TK2MWRwup+iljMl1nysb2a
        JXW3ijliLUohba/SGDJY62SJzamXkBtdo4hk2cxo91xVUNQxIS42UdCt2nQkSFMxOUyd9NBJ
        eU2yVGSiM5BMivm1uNQ5xE6xgi9CuK0jOQMF+dmHsLXEEgjm8Ttx2s2cwAHLb8BX9WY0xcH8
        CuzyjTBTTPMDMlxXMm/aJ/iV83VgL+GXYk9/WYDlfv+HIYua4vl8NLbV6gMs49fhXF8HPV1s
        Rbja65BMH8zFo7ndkumCJbi2Lv9fWRguq2qkshFvnKEZZ2jGGZoJ0WYULCSI2hituCZcVGvF
        hPiY8KMntBbk/5tHDX9sj1HGzz31iJci5Wx5xIFPKgWjThSTtfUIS2llsLxmcbdKIT+mTj4j
        6E4c1iXECWI9WiiVKBfIWyKSVQo+Rn1KOC4IJwXd/5SSykJSUeXeiMpnpSmbNmZGvWvQRBrK
        RvctN8y5NLm/i8kUqtb/GRfjd5RvTfiQfTpJsJnWahaE3VE0TbQ93RV61mOfdeib+3mPafBt
        f2KoVQyf7WiMds8ajusreP282zZmiH3Yd//9oOZimJPbvmzLzpCRtJRF60f2d5ouMAc9br2x
        uTzSopSIGvXqMFonqv8C39lbATMDAAA=
X-CMS-MailID: 20180425131852eucas1p26edf49ec360f7afe2e0fd96b055f79dd
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11
X-RootMTR: 20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203356epcas4p44b884a8d409d0faa188a0ecdf4945c11@epcas4p4.samsung.com>
        <20180424203239.21885-7-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, April 24, 2018 10:32:35 PM Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.

Thanks for doing this.

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
