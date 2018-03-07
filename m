Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3083806-1520421756-2-11608535493568997285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520421756; b=hlNcKUk3bV8BdUWuAbNJ1GZDJVW+JMyqWUjDz7w4KPIEuNc
    0+A9zpvApll016gvOcm+ThAlMQp0XAPT+mFaqnT9kUohYCby05dlbrMMVzn3En6o
    BfPPjC2mFiiLJmhpiRPKLp7b67JIBOvfL+Ph0FsJ1dV40LjQ1avvnd34lVeD7lE/
    ikNMfphHcbDHG2+zezf9XGLUIocxFeeaT6SRJjED/wDFCDKo0sMpRR5nM4K2k8Nk
    7B9YDIQ5H4sUWefbCzDF4hvj0ygP5XB4kU6JfhkTl6RAw/kvQaxwn1XGrBGrr76Q
    NfHc0hs1ItEd5QkG8iglQckDkmwgx0dpgzYS3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520421756; bh=FBSYBs8vtWvba7Q/yNlh7KMLLHzomVh4ZpPpwq7tt6k=; b=m
    Zw5xTrGNMNES79P7v+3Z1zXC8HLIUKRizGwv4Xe0QQr0cyNp+yKcRz1ZdDgGSYox
    BV7W+PePWHip1Y24XmZjVFHlSDOUO3jqhagCtjaafyzJC7fg6+C7lrE5b+OXRK+P
    5fHMINpchXWzhJGPvmbeL20avJzlQ0x6vlkW+Mwk9t1oSAso50N+7FM7wiB9zTo3
    faN2/URFdWUIbIsXxKvZ0jvEqtwUKf0uh3ks6K9Ij419ONJgFS2ewaZQBesEzvRT
    PiRRZL34mKbrQTsTYfchLeJsr2ApuqrGN/kB14aOBg6xN9a7780/ZZk8Uk4AFDL1
    XmNCDo+c8V/Vl1moS4RSA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754286AbeCGLWU convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 7 Mar 2018 06:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeCGLWS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 06:22:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A272177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AG47ELvCc1Q1JmVmiL1SvyK9MlMxdd7vlUXTf8KGTOMAc1lq5lOL6c03yFCKIgwCeeQseOOg4y0tfGrrBJLjS4uE4Wg=
MIME-Version: 1.0
In-Reply-To: <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
 <20180227071134.28063-1-a.hajda@samsung.com> <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
 <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com> <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 7 Mar 2018 12:22:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfWwD-wYOzYacH4j7gfgDGh5MPAhXTR46wbYU=pw3zEhg@mail.gmail.com>
Message-ID: <CAJKOXPfWwD-wYOzYacH4j7gfgDGh5MPAhXTR46wbYU=pw3zEhg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical connector
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 12:13 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> Hi Chanwoo, Archit,
>
> On 07.03.2018 05:48, Chanwoo Choi wrote:
>> On 2018년 03월 07일 11:12, Chanwoo Choi wrote:
>>> Hi Rob and Andrzej,
>>>
>>> On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
>>>> Hi Rob, Chanwoo, Krzysztof,
>>>>
>>>>
>>>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>>>> Hi,
>>>>>
>>>>> Thanks for reviews of previous iterations.
>>>>>
>>>>> This patchset introduces USB physical connector bindings, together with
>>>>> working example.
>>>>> I have removed RFC prefix - the patchset seems to be heading
>>>>> to a happy end :)
>>>>>
>>>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>>>> v4: improved binding descriptions, added missing reg in dts.
>>>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>>>     example.
>>>>> v2: I have addressed comments by Rob and Laurent, thanks
>>>>>
>>>>> Changes in datail are described in the patches.
>>>>>
>>>>> Regards
>>>>> Andrzej
>>>>>
>>>>>
>>>>> Andrzej Hajda (5):
>>>>>   dt-bindings: add bindings for USB physical connector
>>>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>>>   extcon: add possibility to get extcon device by OF node
>>>>>
>>>>> Maciej Purski (1):
>>>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>>>> acks for dts part).
>>>> Now I have a question how to merge them.
>>>> The only functional dependency is between bridge and extcon, and from
>>>> the formal PoV bindings should be merged 1st.
>>>> I can merge it:
>>>> 1. All patches via drm-misc tree.
>>>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>>>> samsung-soc tree.
>>>>
>>>> Is it OK, for all? Better ideas?
>>> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
>>> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
>>>
>>>
>> I made the immutable branch[1] as following: If you agree, I'll send pull request.
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17
>>
>> Or you can make the immutable branch and send pull request to Rob and me.
>>
>
> It seems you took v5 instead of v6 version of extcon patch.

I also took v5:
https://patchwork.kernel.org/patch/10244407/
https://patchwork.kernel.org/patch/10244431/

There was no v6 in samsung-soc patchwork. Is it a problem for DTS?

BR,
Krzysztof
