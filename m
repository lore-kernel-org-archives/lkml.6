Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650796-1524660624-2-5279201907848257823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524660624; b=J6wHos9WzZDcAzzCIvEzCgIPlFDIHghgShHKsI/ZTnmzKH6icE
    QOVVJ1gG9GE4YtuaRQ3wgUL931FBsMZxDSraEnzU713ObQeufuyYZtlcF2R3nkPZ
    g56Wp0B0KQrOimT1R3sGwfSHbu2XSJjKsErf7lX4v/CAAk+OWo7Yk6hquI3SM5IO
    X9zolkD92hF6JmO2uA8usnT0HMJgaIl33+LhzHvarJH9smQtD53PACVo0TYdCz6/
    j8SJ6NkQkAtJ7evRwx/JUx/7eBvMc4U1glN4bwM5+4d4afheD6YcGJoj0+bM8IWQ
    93GPt8mgOJhT7Hyk3KgWgpf8GvZZKbsM7aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=fm2; t=1524660624; bh=RmQX3BFMqZP+
    GtO+xMnWBXWE69lAYo3UqIprtlNVS1k=; b=JHjCWtiDKNPc1b79Ees65xq+ZBMs
    MH9PbmQTX3Att6a5Byrchulp4LFB9hZf+coS9Yw4lbR0prVhQGCnjUBFW6WTSIFl
    vZqXZLNx4nVDB/b0Dthpl5M/OwdMQhdP8cdolBHdMuaVfJTfYWaUbu2sqWMguVX8
    B7hmRAtqcGNWqKaChyAYBbx+psouuftTQEbIoWoFNmNtMY5v4cUYDYZr8JhJXT06
    SiqOyz6M/+nq5sisAk0zM4FY7rVfhJ/bX/pY/+XS1SK9qzISqAD8bE0unUp+egR8
    6BxcMDgkWkvK2xBZG+Xgh87oufIESWzkzVm13XdROFNUE8bNaMywfw/CWA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ml+/J/n2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ml+/J/n2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOUnUMmbqtWmV+QZmE2Xe38ZFma4IIsOagpwzJM3lQs2iDIapRA6GhRpaX41/5KBx3+EyAWfUh29x1XbT1P89Thl/2MY/QbqmpQz4N+0KhMpifsWazjV
    Cv3OALIsfm+3lkRgP8tToh4kilH1+bFZFu5QLUFxEQb3I169t9uqQnC6s5Gt218ErZeudfYAVAU21Y2tFq8LiikNE+rPsuC3c1R0hmBFEbg95yjdHFcXnFOm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeDYMuU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:50:20 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16707 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbeDYMuB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 08:50:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180425124958epoutp0409cfd685fb546aba4b457c9083453a99~orrx2l7WL1901419014epoutp04a
X-AuditID: b6c32a37-4f9ff70000001030-44-5ae0797595ab
Subject: Re: [RFC 08/10] spi: s3c64xx: samsung: Remove support for
 Exynos5440
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
Date: Wed, 25 Apr 2018 14:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180424203239.21885-9-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG853TcylZzeGUjS+6aGxmlpIo1NvexJVggtv3h8ncliyzxmAz
        TtCMawsKmkxgtiKRUlGmdlOMoGZNvRTIAgpeKpdNWSkorTi5KGy4i6KAA6EQ2x5M+Ofkd77n
        ed8nz5ePp8UAu5jflZkrmTKN6Ro2SvHLbW38yryCQUNC/S0tVE+NUDBb0caB+8RlBiofD7MQ
        mBhhoKrFG/rc9zPwffVlFv5rP07Bg2krA+VD/9LQ2XmFg2PBCxTUDoUsLw/3M1BXFURQMjuB
        oK3hCQX3rv7EwnhZC4ITndcpKHrZy8HZ8xYaPJXNCC629HFwLtBFQdedTXAnMM5Cx91uBizN
        LRwMP7axMOd3K8A+42Nh+kIrAufV0Hb3K5L0AXGddiFyz99Fk5npCkRGH1g4EqgZo0mjo48j
        1U1/U6TWeYglj/xNLLlxysWRupr95P6vxQwZvd7DkvqegwryY98UIrZ6J9oSbYj6OFVK37Vb
        MsUn7ojaeaYoPvsRnX/ec40tROV0KVLyWFiLg20zqBRF8aLQgLD15B+M/DOJ8MmxSfTW1XHx
        IRVmUbgWEopyZNMAwk3nfGxYUAufYe//v0dMMYIWB2YnI5toYVyJ5/4aZcICK+hwWastslUl
        JGKf/QUXZoWwAhcfORXhd4WvcfHIa072ROOpo/2KMCuFddjyYjjCdCjg6UTFPMfitoFeJPMy
        XOd6RoeDsTDI47HqQVaukIzLO57N11Hjf9rrQwF8iJfg7la9fLwPH7KWcvLsAYSDP3TPz27A
        t9u7GDlgEX7+6jAjz6pwiVWUkeCSsvdl3IhvvP5Qvp86hAdvBik7WupY0MaxoIFjQQPHggZn
        kMKJ3pOyzRlpklmXvWaV2ZhhzstMW/VNVkYtijz3uI8a0BXvZg8SeKR5R5WwdcAgMsbd5oIM
        D8I8rYlRNS/tN4iqVGPBXsmUlWLKS5fMHrSEV2hiVX9u7jCIQpoxV/pWkrIl01uV4pWLC9ER
        dXlqDpOTn6/WeQ/kKj85253Vtyg+YYXWV1l2a/0eUdieu81l+1S65MaNxR5vlWtbY77/q+Wx
        MTZHnEafVJUoFK22p1hT9uhuRhPL8WCP9pgLq59v3G/5XG89PaPf+mWv3u7eYnMmzT39YvVQ
        Y3C88Ltl4qbfapJ/VvtSkp0ahXmnURdHm8zGN3yJiY3qAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMYRzAPb/3juNxmEded2MmUzK276wXm9meNiab1/MHN34r0512F8qY
        yg41nSs1HAm9kVovZySOdc55qUl6uaIXqU3EvESSy9zVTP88+zzP8/l8n38eiVWV8/7SHn2c
        bNBrY9SCgqv5042XxCW80SwtbVNC7uA7BoYzXCKUnyvlIaurRwD393c85Dife5fGZh6O5ZYK
        8PHxWQZaho7zcLq7j4W6ujIRMj2FDFR0e5Wvpzp4sOV4EJwc/o7AVfmWgYaqiwL0pzkRnKu7
        z0DS11YRrhaYWHBk2RGUONtFyHfXM1D/bA08c/cLUFvzkgeT3SlCT5dZgD/N5RxYfr8QYKjw
        EYKiKu/08h901XxafKkY0Ybmepb+HspA9HOLSaTuvG8svWNtF2nuvfcMrShKEWhb8z2BPsgu
        Fqkt7yhtfJLM08/3mwR6s+kERy+0DyJqvlmEIidrFCG75Zg9B2RDUNhORfTlpKDYNja+wHFX
        SESn2VTkJxG8nNSWvGJSkUJS4TuIXDH386ObLkTe2KsFnzUFryN3j6WOFFPxIuIe/jkisfiH
        H8nvHUCjhQ2R7F85nM8ScDBJe2RGPlbiMPLC8kX0MYcXkOT07BGehreSjrpvwqgzmQye6Rhp
        /fAKYvrS42XJ+8JCkpmp8x2zeDpxdbaiUZ5LbMWfWAvC1jG19X9hHVNYxxSXEVeEZsixRl2U
        zrgsNlgvHww0anXG/fqowF37dBXI+5FuPQwwV6LOvB0OhCWknqBs2dypUfHaA8YEnQMRiVVP
        VdrndGhUyt3ahEOyYd8Ow/4Y2ehAMyVOPV35Wu/apsJR2jh5ryzHyoZ/t4zk55+IVlRXzeod
        j2evxTjebnI+LHNcv9Xj71m9fQO9XViWf74t3bbxmn62e0KBxu76dYEctlxdgjKYNC6i0zyx
        dtPFgLCgFP3cyL4nDVyJpW9LyNuIodoj82IGTjKLP3kmxVdWKeSsp+FRA6Hjfo5Xh89fufdj
        qGfK7f4bkUs/vJJC561Xc8ZobXAAazBq/wJR/3ErRAMAAA==
X-CMS-MailID: 20180425124956epcas1p35ef90099a760b56ce252077f2f1fe603
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0
X-RootMTR: 20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0@epcas2p4.samsung.com>
        <20180424203239.21885-9-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It's good you didn't remove S3C64XX_SPI_QUIRK_POLL entirely as it will
be needed for Exynos5433 ISP SPI controllers.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
