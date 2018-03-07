Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3032166-1520421247-2-1922312229666283771
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
    t=1520421247; b=dO7vF0eMo9rNYGSoFA041GDtTfrbM5Rv/dvMRCjMGcL/4x0
    Xty48PzqNKi7R0yVdlgu53q2MSzysUuXO2hylt3wdwG/Iz+ZedYJjZr2p8iMpKpy
    swR0GDgSS+qaC+iEOq0muh84LTzrTsNtbUqGBTBGGM8rI49tayvOcpTyP7EkU41M
    iYSegfCVyuDzO0xE1lB7PPOLCN2AuNCYl0vtgGRebrWRyBJ8tFELi4C3B+4iHVG9
    DBY+xBdxbexeH+HEoUiuaDadBGRBDFUM+pTABS3/2PER0TliY1upvrFyeH61BD9H
    ay5q248DjRgpC94ZmMaifQoO67V9k7Am9cEc4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520421247; bh=En049ai0
    Tz6/qSeurYzGx+wq3TnmwxuboDt0NqketOw=; b=TgPvp3U7aw3VuUzLwkSjVf38
    lAkeryXI+D/wKiurpr9PuCzJXSx7sdMHSc92MM4mM4fK3s2ouD0XS0/ieRYmoNoz
    1IG+0/C9FsPYyEn0dM35LdJUNVsSVnGQYOg/IKaUM7hPIFf6HMo73NfwWlIUS/Hj
    F8Emo4cUO6IlBFnPdZIVU4uIIYy0gSwSS8Y7PVSkmXnOEHh1C+kctayvxT5l50Wk
    0eljLfDEELtXW+hTRBpNs5/fyfk9Lr5Hm8a0xOKYRteIKrm9OYLHGWr+6Jb219nK
    855QEvjwcW72eQG/iYvFfggvFULT4RkbNfTjHqn5B755s4PI/Yhv3ZX+mTWdMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=cKwlLwx7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=cKwlLwx7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeCGLNw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 06:13:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44803 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeCGLNt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 06:13:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180307111347euoutp02bf0899fcef3e7e09ade52bd92c60b7bf~ZnwzwG6Ui2951829518euoutp02_
X-AuditID: cbfec7f2-1dbff70000011644-bd-5a9fc969055f
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
To: Chanwoo Choi <cw00.choi@samsung.com>,
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
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
Date: Wed, 7 Mar 2018 12:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A9F6F29.5020501@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUhUYRTmn7vMVRy9jsocVKwmg6zUpKA/MpHo4QahIWQ2D9VUl1FyY67m
        BhWGubW4oo7LaGmFC+aSS1HguExlNWnRaFHimomT4PLQYuZ4lXz7tsP5DhyGkI9RrkxEdByv
        jVZHKmlbsq3vp8k74qVetfdr0XacmmGhcFNxI4XNi98orO95S+EPS3M0zhvJIbHJ9EiKM3Or
        pbh5/COF3z8po3Gx6bkE372fRuCGni9SXGMekOC0Zz3SQAeuvqIece9v35JwpRklFNdcm0lz
        I9lGCddSfZW73VqLuIVmjxOMytb/Ih8ZcZnX+gacsw3/0ptGxd5xTnw4G3QN3WKzkA0D7H6Y
        KGinspAtI2cfIuiyZElEsohgsrF/nSwgmJsrRBsjC53ztGg8QNDx/JdUJBYErwfNUmvKiQ2B
        6tTuNcOZLUdgbJsirIRgLQQMVpRS1hTNesFyyzBtxTI2AIZmpyRWTLKe8KruJmHFLmwYVBVO
        IjHjCC9LJkgrtmF3w/LK8FqeYLfA9celhIgV8GlCv1Yc2DQGepbypGLxo/D9ZrpExE4wY2xd
        191hpVO/rqfA8HQqKQ5nIBj5nU6LxiHoNg6stmZWN3hB4xNfUT4Mul4DbZWBtYchi6PYwR7y
        2ooIUZZBxg25mN4GI28eEyJWQM27JToHbddtuky36Rrdpmt0//dWIrIWKfh4IUrDC37RfIKP
        oI4S4qM1PhdioprR6uf1/zXOd6ClwfMGxDJIaScLe1ahklPqy0JSlAEBQyidZflxepVcdlGd
        lMxrY85q4yN5wYDcGFKpkJ3ZeUUlZzXqOP4Sz8fy2g1Xwti4XkM+sd4HNCUz4/M7cuz1rnxC
        V673jb4xSx2eLAo5uid7vFqovPf56YfYjqBT+T88bY73hSY3hYa2c25X8bHg4D8pZQ0uK4vl
        /qb2XS883I9MkL5d38cDPxdVuS1OB4Y1NhxKlO/LfRDX9EqTrQgfLStYPmhnMadvNQf9HXUw
        njacrFSSQrjabxehFdT/AC6a8IJ1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xu7oZJ+dHGTzey27R1PGW1WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Swm3Z/AYnH+/AZ2i86JS9gtNj2+xmpxedccNosZ5/cxWSxa1sps
        sfbIXXaLpdcvMlm07j3C7sDvsWbeGkaPy329TB6zO2ayemxa1cnmcb/7OJPH5iX1Hn1bVjF6
        fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJdx92gra0G/SMWKN34NjL0CXYycHBICJhKfd35i62Lk4hASWMoo8e/kYUaIhLjE7vlvmSFs
        YYk/17qgil4zSrT1X2ICSQgLBEksaTrMDpIQEZjNKPF57lVWkASzwHtmiX8r5CE6GpkkHh6b
        wA6SYBPQlPi7+SYbiM0rYCdx480zsEksAioSp1b3gK0TFYiQ6Fw5nwWiRlDi5MwnYDangLbE
        3/83mSAWqEv8mXeJGcKWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAmN827GfW3Ywdr0LPsQowMGoxMO7Yf+8KCHWxLLiytxDjBIc
        zEoivJNL5kcJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w/eSVxBuaGppbWBqaG5sbm1ko
        ifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCUX7jFjKOW50PA/p5nL9dE3f11JUXj1jqD1d9X
        X0x/zJIweePqiOs2c29/eWcya9H5Q2dUubbO385vODUgvXre2wflD3JYN6/J0M7cKiGaLpDs
        dHqp8uKDEVYGPB6LF987cb5R/tOp2M3pn5dv165+cP1R5NN779Taqhc+28G7cGG34NrnG0Ku
        71diKc5INNRiLipOBABJvmp+BwMAAA==
X-CMS-MailID: 20180307111344eucas1p173b5d45d4e5e8aee823c5a6188ad9d5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180307111344eucas1p173b5d45d4e5e8aee823c5a6188ad9d5a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chanwoo, Archit,

On 07.03.2018 05:48, Chanwoo Choi wrote:
> On 2018년 03월 07일 11:12, Chanwoo Choi wrote:
>> Hi Rob and Andrzej,
>>
>> On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
>>> Hi Rob, Chanwoo, Krzysztof,
>>>
>>>
>>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>>> Hi,
>>>>
>>>> Thanks for reviews of previous iterations.
>>>>
>>>> This patchset introduces USB physical connector bindings, together with
>>>> working example.
>>>> I have removed RFC prefix - the patchset seems to be heading
>>>> to a happy end :)
>>>>
>>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>>> v4: improved binding descriptions, added missing reg in dts.
>>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>>     example.
>>>> v2: I have addressed comments by Rob and Laurent, thanks 
>>>>
>>>> Changes in datail are described in the patches.
>>>>
>>>> Regards
>>>> Andrzej
>>>>
>>>>
>>>> Andrzej Hajda (5):
>>>>   dt-bindings: add bindings for USB physical connector
>>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>>   extcon: add possibility to get extcon device by OF node
>>>>
>>>> Maciej Purski (1):
>>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>>> acks for dts part).
>>> Now I have a question how to merge them.
>>> The only functional dependency is between bridge and extcon, and from
>>> the formal PoV bindings should be merged 1st.
>>> I can merge it:
>>> 1. All patches via drm-misc tree.
>>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>>> samsung-soc tree.
>>>
>>> Is it OK, for all? Better ideas?
>> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
>> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
>>
>>
> I made the immutable branch[1] as following: If you agree, I'll send pull request.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17
>
> Or you can make the immutable branch and send pull request to Rob and me.
>

It seems you took v5 instead of v6 version of extcon patch.

Beside it I am OK with your immutable branch, Archit is it OK to do it
this way in drm-misc?


Regards

Andrzej



