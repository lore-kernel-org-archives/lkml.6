Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1928353-1520388759-2-471351955842522997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520388759; b=An3kaPlUTHJOSbW1U/eeG1u6CcW9qhXsGddjj4IxPgRICzU
    GImVrhj+TB9E7XIO413xHGDgffTFk/+Yzs0hr9s5MbJIPFZqBOuOrZqTjmilzNsi
    SfMO2nVLWzJJP4cDOabe3fPoUGIfmlNvDR0UE/vHBKGEoW+zXeOeEVaxU0yQYw4/
    wVbnx5/hUXB8hc3PsVGzs5s3o6FVu533wj0tRglh09Qo6gJWZac556uRBIuBppOV
    8rfRbQ469+slv5YrNNZbeB5/APRsVbp4VfBqFntnFUZ0G2iQEaVo1YKdNCZrTfof
    ALmGy2zYn8eyF9QhaBQKA2ARIF4PA2JJbv+2WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1520388759; bh=jQytA65c
    YruceMR0b1qwA2DbmZ+q1K7LogWARTldj10=; b=OHbsvzu4eFeNY1TTwIzHHmAh
    WikBU1vpDqhvs7yHfLT2cjSkFwDLIaC1mnrx2Q258tSPb6LpZekySAIRg6JsDt8l
    TtGlyS1rruiS8AzzMdM7lQJ25EPR39eg6sp7rDrZOuKxZrVHiSC/UiIfX6xxXAtG
    7BPOTxxRp5p9/Iu9yQr5Rih3OyeU30A5XkCscILdzCsLUuKuxU47SUdR3veSrDHl
    izLKRaWfp63h5W9yKwcHG4MdY5DeyKpMKTyo0pm479MGxecoGLO7WgT2pgVZoR8m
    3Vwr/WCKEqFUc6ONg6w+pyN7nBXzoRL/sDdQdbPalJiDiSPRh1EH51rEV7kW/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=BDR5Zeuc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=BDR5Zeuc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeCGCMT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 21:12:19 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46514 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbeCGCMR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 21:12:17 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180307021214epoutp02c3002ada8f38369decf5bc2ef654285a~ZgX-EDOv01974119741epoutp02x
X-AuditID: b6c32a36-ca9ff70000001028-24-5a9f4a7e3c6b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A9F4A7D.9020409@samsung.com>
Date: Wed, 07 Mar 2018 11:12:13 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
In-reply-to: <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmvm6d1/wog1t/xS1urTvHatHU8ZbV
        YuOM9awW848AuVe+vmezmHR/AovF+fMb2C06Jy5ht9j0+BqrxeVdc9gsZpzfx2SxaFkrs8Xa
        I3fZLZZev8hk0br3CLsDv8eaeWsYPS739TJ5zO6YyeqxaVUnm8f97uNMHpuX1Hv0bVnF6PF5
        k1wAR1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        8UoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoQ0MjPUMDcz0jIyM9E+NYKyNToJKE1Ixp
        h/vYCubxV8zsjGtgbObpYuTgkBAwkfg+NbmLkYtDSGAHo8TxW/fYIZzvjBKXPy8CcjjBilZ2
        HWaBSGxglNi8ajYbSIJXQFDix+R7LCCTmAXkJY5cygYJMwtoSrz4MokFxBYSuMsocalZEqJc
        S2LGlStMIDaLgKrE7flHwWw2oPj+FzfARvILKEpc/fGYEcQWFYiQ2Dn/G9gNIgJFEmee32AG
        uYFZYCqLxJ3nr8EWCAsESSxpOgxWxClgL/FwwyI2kCIJgXnsEqtuzGWG+MBFouM2xDYJAWGJ
        V8e3sEO8Ly1x6agtRH07o0T73nnMEM4URolz1+9BNRhLPFvYxQTxGp/Eu689rBDNvBIdbUIQ
        JR4Sl7dehYaWo0THtQfMEN8fZJRYcztqAqPcLKTwmoUIr1lI4bWAkXkVo1hqQXFuemqxYYGR
        XnFibnFpXrpecn7uJkZwYtUy28G46JzPIUYBDkYlHt6IvfOihFgTy4orcw8xSnAwK4nw/mec
        HyXEm5JYWZValB9fVJqTWnyI0RQY3hOZpUST84FJP68k3tDE0sDEzAiYuCwNDZXEeQMCXKKE
        BNITS1KzU1MLUotg+pg4OKUaGLN0PJJXHLPcumHSjB0fnq7zvhnc9CSrULB+ypzK8NwbE0KO
        RXsE+r6b/oz5zIxd7mu583ivzVwqJH6ztdL6dHC26Lqfqlevq9mXaF52rzFYklXywr70b+uJ
        vTslCpKXNc3WbY5ZyjSD4aHsjlkuFxdlxSq9Tvgn4sP+qfj2zQmF3MY+rh29pkosxRmJhlrM
        RcWJAIHpDcvCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t9jQd06r/lRBmf/clrcWneO1aKp4y2r
        xcYZ61kt5h8Bcq98fc9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZzDi/j8li0bJWZou1
        R+6yWyy9fpHJonXvEXYHfo8189Ywelzu62XymN0xk9Vj06pONo/73ceZPDYvqffo27KK0ePz
        JrkAjigum5TUnMyy1CJ9uwSujGmH+9gK5vFXzOyMa2Bs5uli5OSQEDCRWNl1mKWLkYtDSGAd
        o8TKY9+YQRK8AoISPybfA0pwcDALyEscuZQNYapLTJmSC1F+n1Gi+ehEFohyLYkZV64wgdgs
        AqoSt+cfBbPZgOL7X9xgA7H5BRQlrv54zAgyR1QgQqL7RCVIWESgSGLZrwfMIDOZBaazSLw9
        0M0OkhAWCJD48n8KE8Syw4wSi6c3s4IkOAXsJR5uWMQ2gVFgFpJTZyGcOgvh1AWMzKsYJVML
        inPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQJjatthrb4djPeXxB9iFOBgVOLhjdg7L0qINbGs
        uDL3EKMEB7OSCO9/xvlRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgt
        gskycXBKNTDGyc30u7BJr0ri9xO/yF3X35+VS3bo71zl41H0+oT18Tnvf5UcSAurs2bhZrxo
        zhX5sz+Ld9rqxe4p28SjHTrX/md+tlf2h5DVS44jvLr2PJbCP05fzLll8OfC0iYtbuYj/Zz6
        1zlXpvKcnrRitdpnVeVF+Q9Xpydf/R6ZE1Vy16jz8aHQ5PlKLMUZiYZazEXFiQASYANupQIA
        AA==
X-CMS-MailID: 20180307021214epcas1p29d1abbca7f196eaaa6adfc3d25132fc7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob and Andrzej,

On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
> Hi Rob, Chanwoo, Krzysztof,
> 
> 
> On 27.02.2018 08:11, Andrzej Hajda wrote:
>> Hi,
>>
>> Thanks for reviews of previous iterations.
>>
>> This patchset introduces USB physical connector bindings, together with
>> working example.
>> I have removed RFC prefix - the patchset seems to be heading
>> to a happy end :)
>>
>> v5: fixed extra parenthesis in dts, renamed extcon function.
>> v4: improved binding descriptions, added missing reg in dts.
>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>     example.
>> v2: I have addressed comments by Rob and Laurent, thanks 
>>
>> Changes in datail are described in the patches.
>>
>> Regards
>> Andrzej
>>
>>
>> Andrzej Hajda (5):
>>   dt-bindings: add bindings for USB physical connector
>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>   extcon: add possibility to get extcon device by OF node
>>
>> Maciej Purski (1):
>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
> 
> It looks like all patches received R-B or acks (I forgot add Krzysztof's
> acks for dts part).
> Now I have a question how to merge them.
> The only functional dependency is between bridge and extcon, and from
> the formal PoV bindings should be merged 1st.
> I can merge it:
> 1. All patches via drm-misc tree.
> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
> samsung-soc tree.
> 
> Is it OK, for all? Better ideas?

Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
