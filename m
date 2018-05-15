Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526386464-2-14378526950923113749
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386464; b=I9fOm8ykO8NSuWhYAXHI6RCRHaMp8Nn8yyrOQR5Gixzjd/VLst
    tYodS4W9g7SrFoBOITqOQgByN0yYMXy442mg9BGzjj2Tg4j4LEtE4sEuHCINtiiY
    9Au6gRe5OjZEQj1quavbLP03Z99ijqKFbpVgEWP2blT5LAru+hY7JbGhv5tZrLdu
    at23EJ9al1fFDRVUIn9pTAxmb6eRNqCu23x2vdBeuKKFt+ksv3mzD4gDztLdiJ0W
    d5nmb84LKMjMNLVMNFk4SgKHN9zKSiqvG88WmKw8exxeXBcXJDPboCszzYuXX15s
    ctjXQONGDVCg/kvXejQkSoYaS6sBXdoRVOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:sender:list-id; s=fm2; t=1526386464; bh=8Vu1fQObYolv
    TbxJ2rz/3Z5Btx0w9RYpSG5qY9E0wqI=; b=QsUBsqTkljcS2usqnySazCaQVKxP
    k3u6cuigBXLt4lPu2yMRokKrO1B4wKpikHEB1Ua12fbW4uSFnZ9WkNY4FrMweChJ
    yYY2rvbHzk4iJqlsoTL91FNx67cyzcOVrPbfNAqFlUbNLnLX1SR6GU3qcgbWc9Vh
    O+N4Z5Ch7D91/ooFiKAHlLVeiqwoh3B6xK5hDGFMIvhV7H6GVCNBh0ke+yFOAt/N
    iogQBnUYi76EqFDA7yVyAc7TrEW2MC0yGvOKvkXXYqvOdSoBTiuDw28wLvQUKxEf
    hKZpFKdQl+TGRxzRa/FbsBWZZJdJBdBsXpSqxVqmat95P6SR8UkzYAqcGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=C1c0TAAj
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=C1c0TAAj
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEUPGlUJXuU2fxvf2MXap1ZQBQX6SzXQ81nNJk2MCpHdcG6c2wq21g8/XsgI9fp/8KBGccRnz4/FnI3zGS45K53xCwufhjtVvZeyRSfMASUHntncvs49
    FmM/zINemO1eqZzM1yYbw8W+TtB6wwpdh7Byw5Cfy3mCePAAEL4kBZCHpyb5zqXT1nn6TwfdRxOyC9ywUaXqLvJfvu4vg3xn+Yjl9Ovf2fSdoX8gIfUUKQEX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gu6fZOg2AAAA:8
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=mQz30floa5LILlri1sQA:9 a=x8gzFH9gYPwA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeEOMM5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 08:12:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60667 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeEOMMz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 08:12:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180515121252euoutp02c9e2e9502c5c4a96723022d41b824864~u0FGai2wS0940509405euoutp02s
X-AuditID: cbfec7f5-b5fff700000028a9-5f-5afacec34f9a
From: Andrzej Hajda <a.hajda@samsung.com>
To: linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/2] USB: dwc3: get extcon device by OF graph bindings
Date: Tue, 15 May 2018 14:12:37 +0200
Message-id: <20180515121239.18192-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7djP87qHz/2KMti+lc/i1rpzrBYbZ6xn
        tTjW9oTd4vqX56wW848AxZoXr2ezmHR/AovF+fMb2C06Jy5ht7i8aw6bxYzz+5gsFi1rZbZY
        e+Quu8XS6xeZLFr3HmF34PdYM28No8fsjpmsHptWdbJ57J+7ht2jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4Mk6+kin4wVGxao9AA+N7ti5GTg4JAROJ/d3XWboYuTiEBFYwSvRvfQzlfGaU
        mNM5kQWm6veiz8wgtpDAMkaJXxejIez/jBLnjmiD2GwCmhJ/N98Emyoi4C6xbPk1VpBBzAIf
        WSRauj4CJTg4hAU8JfrfqYLUsAioSkzdfwFsJq+AhUTj4uXMELvkJZ5Nn8cO0ishsIZN4vva
        y4wQCReJCb3TmCBsYYlXx7ewQ9gyEp0dB6Hi1RI3XzSxQDR3MErc/90O9ae1xOHjF1lBbGYB
        PolJ26YzgxwkIcAr0dEmBFHiIfH62iuoIxwlVk3tYId4Mlbi9uqTTBMYJRcwMqxiFE8tLc5N
        Ty02zkst1ytOzC0uzUvXS87P3cQIjOnT/45/3cG470/SIUYBDkYlHt4dM35GCbEmlhVX5h5i
        lOBgVhLh3W0EFOJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCU
        amDUXLMqaKtJbqg+l2DZ+XC+8KikNzVM/6TE2ruFzB9MVE62k7frZ+Bt1puUfHvWfs4ItUsz
        zt+cqcpe4ty7XGTLZgHXoyvYta4cmH//v17ubuN7Mtk33u6Ner5l1UXBmGsmvvLmXTOerpGY
        XmF13tH86+n+TXvfxfY2fPwi63lDYLHhXJUbH42UWIozEg21mIuKEwHblY8i5QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t/xa7qHzv2KMjiyTdzi1rpzrBYbZ6xn
        tTjW9oTd4vqX56wW848AxZoXr2ezmHR/AovF+fMb2C06Jy5ht7i8aw6bxYzz+5gsFi1rZbZY
        e+Quu8XS6xeZLFr3HmF34PdYM28No8fsjpmsHptWdbJ57J+7ht2jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4Mk6+kin4wVGxao9AA+N7ti5GTg4JAROJ34s+M3cxcnEICSxhlPjxfw4bhNPI
        JHF94gZ2kCo2AU2Jv5tvgnWICLhLLFt+jRWkiFngK4vEpO8vgYo4OIQFPCX636mC1LAIqEpM
        3X+BGcTmFbCQaFy8nBlim7zEs+nz2Ccwci1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GGLbjv3cvIPx0sbgQ4wCHIxKPLw7ZvyMEmJNLCuuzD3EKMHBrCTCu9sIKMSbklhZlVqUH19U
        mpNafIhRmoNFSZz3vEFllJBAemJJanZqakFqEUyWiYNTqoFxxnZVpxXpZ9bf7tu3jCtFdF6U
        7ybF1BVPao6m3Nr+becsndiYV56SKyqTC+bWB6TmdMotvRMhURIvmJCbfak+71TLzXv1Mofu
        rL3oebKCYbPrDLvcP682fQjYeWmn2c+VLz6ozTGqX2XI/l6KY07OVfWbPndX7Nx6o+3mYp4X
        C4sO88Xu/LbEW4mlOCPRUIu5qDgRAMiLgHwtAgAA
X-CMS-MailID: 20180515121250eucas1p115e0ee3cefb47faacbd4e4583b11f6e8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515121250eucas1p115e0ee3cefb47faacbd4e4583b11f6e8
X-RootMTR: 20180515121250eucas1p115e0ee3cefb47faacbd4e4583b11f6e8
References: <CGME20180515121250eucas1p115e0ee3cefb47faacbd4e4583b11f6e8@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This small patchset tries to address issue with broken DT extcon property
in case of USB controller - DWC3. It exposes similar problem as in proposed
USB connector bindings[1] - extcon device is required by devices not always
connected directly to extcon device. Here we have:
DWC3 -> USB-PHY -> MUIC -> USB-connector
                               ^
MHL-bridge---------------------^

More details and proposition of generic solution in first patch 

v2:
- rebased on latest linux-next,
- since recently dwc3 fallbacks to ID detection using internal OTG block if
  extcon property is not present, added code allowing to fallback to OTG
  block also in case of graph is not present

[1]: https://marc.info/?i=20180131134435.12216-1-a.hajda%40samsung.com

Regards
Andrzej


Andrzej Hajda (2):
  USB: dwc3: get extcon device by OF graph bindings
  arm64: dts: exynos: add OF graph between USB-PHY and MUIC

 .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++-
 drivers/usb/dwc3/drd.c                        | 34 +++++++++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.17.0

