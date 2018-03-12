Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3227934-1520818215-2-9434116741172461108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1520818214; b=mHOdV2IN3f/UhRGyQT4iHuIG3ARp/R0f5XRo5jfsEZLy4Wt
    3mSA1H00+C77+pRqwLnOGf6cRG8PBPQD6QsgrBga8WUj4EMxg32kylB65NnKAirV
    tfCs523UKLCGku3tTu44PjzNv/zyW6VP4pXBTywonFtxkN7IsWh0XSXXjso8BNnl
    bNwkXNkwIKVlam+8f4UP6Vta/MilQsx9O9dkBOi7n+IhIFlnX+DnKjgaBqoViJZI
    dx+sTViEWrKqOx/QZKbjD+k2gi6ZsgUTZeajRqtsG7B6GwDQGvVam6p1PCxKIeeL
    COTqK96o1L48KuaRe0hCsgXxmjk2Ku/mEVAnzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1520818214; bh=z0/1ZYAM
    nqykqsKP5PrG2GtRt4UZNOb/20j5QIGPkdc=; b=LjH93/ONT8asNqMnoX9qh9IW
    XkxEbebaMPblYPGT45nK5hR9TSKdEotDqhKVZ99QM+5IIK+yK7oKmXLd2RRTTjbv
    PQUrZ3F/d2R7Z558tbZRvHvPkyuths5EPs+rbD0Rzy9ftEZgaW3UcqQg5wfLAjp2
    YJpCMBL44xG+9SZ3NkmeGMRAgXJr2vySGH2r3gJFhcEsrlQASRlYYmoRve/7o2e1
    JwDIsOjVNuUj/Mu8DQmV7NEvxa3BEWBdY31Dr2VpGyOCBmVh6+awNRuRFhnaYucl
    QlDnYatIRP/51W3pOGpUBzhKs2tL6LAZ1dqxhCfSGQxCZtY1JyWf1BcZ4I5G+g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=iPYGsAKo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=iPYGsAKo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCLB35 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 21:29:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24043 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeCLB3z (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 11 Mar 2018 21:29:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180312012952epoutp038baa9cf3456c77b4f89aae815556b0f5~bCBacQJxO2531225312epoutp03E
X-AuditID: b6c32a46-3c1ff70000001029-b7-5aa5d80e659d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AA5D80D.3050104@samsung.com>
Date: Mon, 12 Mar 2018 10:29:49 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
In-reply-to: <984d5c86-f647-5228-7494-63faf4dec3d3@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmuS7fjaVRBoebbC1urTvHatHU8ZbV
        YuOM9awW/7dNZLaYfwQoduXrezaLSfcnsFicP7+B3aJz4hJ2i02Pr7FaXN41h81ixvl9TBaL
        lrUyW6w9cpfdYun1i0wWrXuPsFvc3XCW0UHQY828NYwesxsusnhc7utl8tj7bQGLx+yOmawe
        m1Z1snnc7z7O5LF5Sb1H35ZVjB6fN8kFcEWl2mSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaSkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWKNjQ0
        0jM0MNczMjLSMzGOtTIyBSpJSM3Y8/wGS0G/WsXWzl+sDYwf5LoYOTkkBEwkjj/ex9jFyMUh
        JLCDUWLz13fMEM53RokLb38zwVSd37UdKrGBUaJryUtWkASvgKDEj8n3WLoYOTiYBeQljlzK
        BgkzC2hKvPgyiQWi/i7Q1IOPmSDqtSQuTlzBDGKzCKhKzJh8jgXEZgOK739xgw3E5hdQlLj6
        4zEjiC0qECGxc/43dpBBIgJzGCWe7tjNBOIwC2xmkfh8uAesQ1ggSGJJ02F2EJtTwF5i7u8Z
        YEUSArvYJe60PmKB+MFF4viSw4wQtrDEq+Nb2CFsaYlnqzYyQjS0M0q0753HDOFMYZQ4d/0e
        NASMJZ4t7GKC+I5PouPwX3aQpyUEeCU62oQgSjwkLm+9CjXUUaLj2gNogPUwSzxqucU0gVFu
        FlKYzUKE2SykMFvAyLyKUSy1oDg3PbXYqMBIrzgxt7g0L10vOT93EyM4GWu57WBccs7nEKMA
        B6MSD++MTUujhFgTy4orcw8xSnAwK4nwdgYBhXhTEiurUovy44tKc1KLDzGaAoN8IrOUaHI+
        MFPklcQbmlgamJiZGZmbWQATmThva4BLlJBAemJJanZqakFqEUwfEwenVAPj9p9ts21aOGOV
        W+p4dqZu5BX5lfXi1PSM1G9aEwU/CXL9bNY4m8r5Kb3DVCj4ZueXlV+v+jHw1WS93HElcqdt
        8eddZ6/oywR6fxXeLSLxPkXb+/g9IZ3qHLH0/57b3/5fmTP/+Jz7Zr83M1Y4Bb5MeandzDZ3
        +XqdbzZZgVLZriZn3X8//LpAiaU4I9FQi7moOBEAydPemNwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t9jQV3eG0ujDD43m1ncWneO1aKp4y2r
        xcYZ61kt/m+byGwx/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYbe4u+Eso4Ogx5p5axg9ZjdcZPG43NfL5LH32wIWj9kdM1k9
        Nq3qZPO4332cyWPzknqPvi2rGD0+b5IL4IrisklJzcksSy3St0vgytjz/AZLQb9axdbOX6wN
        jB/kuhg5OSQETCTO79rO3MXIxSEksI5RomnjaRaQBK+AoMSPyfeAbA4OZgF5iSOXsiFMdYkp
        U3Ihyu8zSjzecBWqXEvi4sQVzCA2i4CqxIzJ58DibEDx/S9usIHY/AKKEld/PGYEmSMqECHR
        faISZI6IwCxGifmtz9hAHGaBzSwSlycvZQJpEBYIkPjyfwoTxLY+Zon57z+ygiQ4Bewl5v6e
        wTSBEagX4dZZCLfOQrh1ASPzKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwPjbdlir
        fwfj4yXxhxgFOBiVeHhnbFoaJcSaWFZcmXuIUYKDWUmEtzMIKMSbklhZlVqUH19UmpNafIhR
        moNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoFxNsfvmz+rmzX3fVHQv5d7L9S6VqbqZ9ln
        26T3m9bW/DiR4TQ7yPlz4cTc1neSHT5zferXPvPae624M//LzFQZdpe6Tc8tFcKeXW63uxX3
        Uvhrw8vHVj/CG89+0pitpHS5UPnhg2rP6mkJVj73l8vqKmRlsS9bnmzYJux7Ma3ZLtfwR3Dt
        869KLMUZiYZazEXFiQAgQCGYuwIAAA==
X-CMS-MailID: 20180312012949epcas2p3c6438f608204e644fac5c87ad797875e
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
        <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
        <5AA09753.7060308@samsung.com>
        <984d5c86-f647-5228-7494-63faf4dec3d3@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrzej and Rob,

On 2018년 03월 09일 18:20, Andrzej Hajda wrote:
> Hi Chanwoo,
> 
> On 08.03.2018 02:52, Chanwoo Choi wrote:
>> Hi Andrzej, Archit,
>>
>> On 2018년 03월 07일 20:13, Andrzej Hajda wrote:
>>> Hi Chanwoo, Archit,
>>>
>>> On 07.03.2018 05:48, Chanwoo Choi wrote:
>>>> On 2018년 03월 07일 11:12, Chanwoo Choi wrote:
>>>>> Hi Rob and Andrzej,
>>>>>
>>>>> On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
>>>>>> Hi Rob, Chanwoo, Krzysztof,
>>>>>>
>>>>>>
>>>>>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thanks for reviews of previous iterations.
>>>>>>>
>>>>>>> This patchset introduces USB physical connector bindings, together with
>>>>>>> working example.
>>>>>>> I have removed RFC prefix - the patchset seems to be heading
>>>>>>> to a happy end :)
>>>>>>>
>>>>>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>>>>>> v4: improved binding descriptions, added missing reg in dts.
>>>>>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>>>>>     example.
>>>>>>> v2: I have addressed comments by Rob and Laurent, thanks 
>>>>>>>
>>>>>>> Changes in datail are described in the patches.
>>>>>>>
>>>>>>> Regards
>>>>>>> Andrzej
>>>>>>>
>>>>>>>
>>>>>>> Andrzej Hajda (5):
>>>>>>>   dt-bindings: add bindings for USB physical connector
>>>>>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>>>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>>>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>>>>>   extcon: add possibility to get extcon device by OF node
>>>>>>>
>>>>>>> Maciej Purski (1):
>>>>>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>>>>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>>>>>> acks for dts part).
>>>>>> Now I have a question how to merge them.
>>>>>> The only functional dependency is between bridge and extcon, and from
>>>>>> the formal PoV bindings should be merged 1st.
>>>>>> I can merge it:
>>>>>> 1. All patches via drm-misc tree.
>>>>>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>>>>>> samsung-soc tree.
>>>>>>
>>>>>> Is it OK, for all? Better ideas?
>>>>> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
>>>>> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
>>>>>
>>>>>
>>>> I made the immutable branch[1] as following: If you agree, I'll send pull request.
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17
>>>>
>>>> Or you can make the immutable branch and send pull request to Rob and me.
>>>>
>>> It seems you took v5 instead of v6 version of extcon patch.
>> My mistake. I picked v6 and made the new immutable branch.
>> After Archit confirm it, I'll send pull request.
>>
> 
> 
> Lets just queue all patches (except dts) via extcon branch (thanks
> Daniel for advice), without making immutable branch.
> It seems to be a simplest acceptable approach.
> 
> You can add my ack to sii8620 bridge patch (as bridge maintainer), to
> fulfill process requirements.

I added your ack to sii8620 bridge patch and
send pull request for extcon, drm bridge and device-tree.

-----------------------

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-drm-dt-v4.17

for you to fetch changes up to 688838442147d9dd94c2ef7c2c31a35cf150c5fa:

  drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL (2018-03-12 10:18:26 +0900)

----------------------------------------------------------------
Andrzej Hajda (3):
      dt-bindings: add bindings for USB physical connector
      dt-bindings: add bindings for Samsung micro-USB 11-pin connector
      extcon: add possibility to get extcon device by OF node

Maciej Purski (1):
      drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../connector/samsung,usb-connector-11pin.txt      | 49 +++++++++++
 .../bindings/connector/usb-connector.txt           | 75 +++++++++++++++++
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 5 files changed, 258 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
