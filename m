Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619581-1524704354-3-3488273090978401110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524704353; b=psk2PPRowCycbk+dqLngaZw9QT7aJPD4KDkwdOO8t1lXq7YyMm
    4vVGfAzhTafLLDJFUjW0QfsHDcqmst4N/1ReiVsGVjwDc4/nu+qSqVTkpq/ACxxS
    zIoiAECx1MGbqRNZPrKM6EuZm6I9zAx+pgWtXHcBPxoc5KHcfdnSHu/RB+Ke+r/T
    6BiOmdnzBJjkFKa6h4RH2cO84HHDb8Geu3dAPE/FGgijE/kdD7NKJBwTkHunO/JC
    4xEH2kk2mm2bxJPa+CopUBcYlTCUDwBRLd6sbYGJvH99wFrTd/RrBr85JGfMzIst
    TzCrdvCrqIUJCPAxMwyHRLXud+5L6LgjDEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=fm2; t=1524704353; bh=Zz0nrN2SzkXz
    XxGpE6t6Y/PjYcSQUNcqAGVasJz5Zxc=; b=JsbIyG8hrAd9lUAKnYXXjRKVJ5ky
    bECJg058Oi3krmYDCwVjeQhioMQ0cqPP9pmaNBeT7KT7gFTdlKkgFl0QgIze4tkS
    aUkxt+wOoBOYPFsyLlooJashBHBweqPSYPqlUUOv29PGT1NzcEgDHO2o9OmISgNq
    g02cDtWBWL4lAQi7rH6pxHcKXTZbGUA8b7ahwXZigsa0EWTT4ULTt2syDbhOU2tZ
    fbdSDGhExg0kVTHY9QTJj3Sf3P7qY1UBJKLWRe7VtKNMD5MD6JsprVC4QYeVP4SE
    ajf2ApCoFg8NOC5jFH9fA7L0crPBGo90L5B1rsLFTm8tL7XN5KR5KtP1Ng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=GwElLDcg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=GwElLDcg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI+BXuPzhpMFQWhAgDy9G128kRvUwHzbdbXW0NVswGx7R5qa5rw83Fh/r42T2poh68GLo/K54d0OPhjMekRTT+6h4CpamYcQfQ6cfppRVYWEFZ73GYaI
    vhsQBgP4Hl+8gTK11Ul3vAsb8BS2HnQjYv+mqb3JK3LuxaIz0cRsKdLD4CXrqY8iMXezxFh9HrdBM2icGZPjeoRPjw3krmsb4S9PQY/JaZbyx5NOUBNRVYCI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=KXQFBCsgnY3szuWKRloA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeDZA66 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 20:58:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28213 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeDZA6s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 20:58:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426005845epoutp02a679b39777463882ff146fb6850879b8~o1oGKhiEB1840018400epoutp02C
X-AuditID: b6c32a39-8bdff70000000fed-88-5ae12442823e
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AE12441.2090506@samsung.com>
Date: Thu, 26 Apr 2018 09:58:41 +0900
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
Subject: Re: [RFC 04/10] clk: samsung: Remove support for Exynos5440
In-reply-to: <20180424203239.21885-5-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjO6e29tyCdl25zJxgd3kwNTWDcQrfDQhd1zNwpxibzx4aaegM3
        QEZb7G0XcCrMCUU22ESQCUiZTNGGDyloCoOxQVcWQJAyvlRwCG7ObTCGY4QP56Xt4n6d5zzv
        87zvOU/yyjBFFxkiSzWYeZOBS6OJQOmPXWHbw1/aNpUQefO7WFS9dF2C1orcJGo83YCjkqkZ
        Atlc/TiyXRnB0bHqBgLd6i6VoLHlXBydnL6JoYGB70lUvFojQY5pUTJ/YhJHTbZVgPLW/gHI
        7fxDgoZaKwi0UOAC6PTAeQk6Oj9Ooq++ycFQZ0k7QHWuCRJ9PTooQYM9e1HP6AKB+no9OMpp
        d5FoZqqQQF23rDj6d6RRik6t/Eyg5ZpLANlbxRGN99gXtrG1lbWAHRoZxNiV5SLAzo3lkOzo
        2bsY21I2QbLVbTckrMP+CcH+NtJGsB1f1pJs09ks9srlj3B27vwwwTYPW6Vs+cQSYAub7UAb
        nMDHpvBcEm8K5Q2JxqRUQ7KGfnW/bo9OvSOSCWdi0E461MDpeQ0dF68Nfzk1TQyTDj3MpVlE
        SssJAr19d6zJaDHzoSlGwayh32QYVQQTuTNCpRLPqLd3qdSi5B0+ZXaoSpp+ncy42F8vzQYV
        RD4IkEEqGo67x8l8EChTUE4Aj9YXEb7LfQBrjs/hD1Vf9N2W+grnAHxwZ8Jrl1PBcOmzSbEg
        k2HUVujyHFqnMSoM/nCuwd91AsAZz2W/XgkLl0q9WEo9C61ruV5MiHzHX2Ne/Dj1DBxemgbr
        eDN1ALbYFr2NNlF5ATB7tRbzTSgHMNeZto43UnHwzn2r1xxAqeFy40Vs3QCpqzJYcW0I830h
        DrYUH/fjjfDv7mZy/dWQehJ6Lml8eiuA1vZKv7kYwP7RSYnPEAWvncmX+CZvgLP3TuA+sxzm
        5Sp8EhbWNfX6+78IqwoW/HE1AegosYFT4OmyRxIr+z+xskcSqwKYHTzBpwv6ZF5g0tURAqcX
        LIbkiESj3gG8C6SMcQJ3f3wnoGSADpJrz1xNUODcYSFT3wmgDKM3yQ8UiJQ8ict8jzcZdSZL
        Gi90ArUY+KdYyOZEo7iOBrOOUauioqJQNLNDzTD0Fvmf8X0JCiqZM/OHeD6dNz30SWQBIdkg
        ZsPBLd+W75utP6gLu220OBxre92lQcdai44ERy8GOUMqFlYutNnr50qmLihec2oTpR+88Zjm
        wS+/v9W9vy7rw93Rixl1vUrpYE3H5x8bMwsjT4YM95Xkm7uf73qq3Dr0XOTyu5VH5m/osl73
        BL5yd08waNYo+/t+3ZrR8749edfAT9MsLRVSOEaJmQTuP5kLKaZWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjl3XedtPpchm+FVKNQrCyl4PkRUVH5UhkGESaVjfxQ0U3b7GIE
        WTGXWStM0ay8lzI105moaN6WdhHvTsWsdIZFlpldxlJpM6L+neec85zn/Hh4Sn6fWcZHqGNF
        jVoZpWBd6JdzVmH9jtUjwRsLRz0gzzYugdnkFg7K0ksZSB0ZYyHL3M5AVq+Fgct5pSxMtKZJ
        YMCewMAN60cKOjoecZAyUyCBcqvDMnXtNQOmrBkEV2a/IWipGpVAT81dFqavmxGkdzyRwMWp
        QQ5yH+goaEqtQ1BiHubgfn+XBLpe7IIX/dMstL3sZkBXZ+ZgbMTAQvOEnoE5SxkNN391smAv
        eIrAWOM4UfadbFtNijOLEemxdFHklz0ZkckBHUf6879SpDpjmCN5tR8kpNyYyJJXllqW1N8r
        5ogp/wLpfXaJIZNP+lhS0aenyZ1hGyKGCiMKdA122RIqRkWcFjUbth53Cf/ck03HjHNnG9sf
        0vHoLnsVSXksbMK32z7RTiwXqhF+YPVwYpngim23Xjt4nqeEFdjcHemkKcETJ2fmUleRi8P+
        BmFrdj39x++NDba0+UxaWIP1swnzmHXw9e8H5vEiYRXus1mRM3OJEISTnsU5c9yEa1Jcaa5h
        nQMl3EbY1Dk6v7BY2Im//NSzf66ZHMIlPXIKUmEztpc1UjeRkPFf2Yx/ZTP+K5uNKCNaKsZo
        VWEqrV+Mr1o846NVqrSn1GE+J6JV5cjxPJXN3oYq9CY/pAkJPFIskAXmvA2WM8rT2jhVE8I8
        pXCTBV13ULJQZdw5URMdojkVJWqb0HKeVrjLhtQth+VCmDJWjBTFGFHzV5Xw0mXxKOWY1D/2
        3baWBJNl8nm+l31m1Ul304+AhnWuZv/H55dWkobtRR8G56aXdOLxqa3DPbXpxjpqf+D3qoOt
        JupQyvIjQ3sXjnoNqouONgddPJDkmSP324NSdP66NPfI8USPJGvlAY+Gt/syEwOydqPQ2onU
        tQHx91ZWjfmVnMCGwu6fClobrvT1pjRa5W8yvnVSOAMAAA==
X-CMS-MailID: 20180426005842epcas1p1e0a79b60507d80858aec7857f390492e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41
X-RootMTR: 20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41@epcas5p3.samsung.com>
        <20180424203239.21885-5-krzk@kernel.org>
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
>  .../devicetree/bindings/clock/exynos5440-clock.txt |  28 ----
>  drivers/clk/samsung/Makefile                       |   1 -
>  drivers/clk/samsung/clk-exynos5440.c               | 167 ---------------------
>  include/dt-bindings/clock/exynos5440.h             |  44 ------
>  4 files changed, 240 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
>  delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
>  delete mode 100644 include/dt-bindings/clock/exynos5440.h
> 

Looks good to me. Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
