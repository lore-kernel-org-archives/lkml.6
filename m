Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3032166-1520422867-2-11239314103079847975
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
    t=1520422866; b=E/Rur4+3onBybjEJXb99aKb6Ckc7/47W7Xf1Tk0jSPtd1UV
    NrqYCvN6Ag9Yzt2IdR1yBwlnTzwI2MuVtzMdObopuUL6cOMyjN0uUtfxG3YOtxBZ
    Y2CGXeCMptKqNwfmkZPiuvAkaQbGt1zoGO4Fn8Cbk66Fo3r3Gs9z9q8+6HKxI6BH
    KiPqz4kcFbthNRz0tXpeG4+IdBKDjPsgwjjSfgak0WQbTQ2sGI/y8ByjObVC72LY
    dgE72mQTd7DLu+gcaDDUbRAWaqIe0YKDYIC603rMShtsCNGkSXWrrWqtR2Cw1c7G
    sQFwBOfoXcnCd4cY27MPRyhtGQCCCAigoDgS3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520422866; bh=uZpZsBe3
    HvbbReeR2XdBr2aFnY6Jw1o+f+iK82XYZWQ=; b=nLQDk9pTgwUf8du/JoHHPn7n
    b3EUfa7L+0kUx0spKOycUQHQ4vytKSXBuSdQI122BRA+BAYdHfu8xBurIzY7nuqx
    CfYuugNGIgFYbSsGLHhPQaZjTLWPdRg5CO/JUp7ikium0KqcPyJ3OtkVLaX/2394
    FmwcaB1TOel2ZW05mp1PAKMfUlyhR1j6K//AvOKqkUR5hzoZdEkq36oYyR73gbjU
    pnxRkxep0BUxao3MEt171w5YMwXvb21Y/oax+9aVtyf1Vd42/uOfidQUkTdA/OBh
    LP3CLasaR7B/9uJDbZB64U7oGggQkWapM1o4GYk+LSFzyXzdS63n8/UkPWaMoQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=bNTam5M1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=bNTam5M1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933128AbeCGLkz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 06:40:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51908 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeCGLkt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 06:40:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180307114046euoutp02a55a6d2856218442fa8ac9754bf74764~ZoIX76FOO1008410084euoutp020
X-AuditID: cbfec7f5-b45ff700000028a9-88-5a9fcfbbe17f
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
To: Krzysztof Kozlowski <krzk@kernel.org>
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
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9778a303-36b0-2acb-5d15-766ae9f45727@samsung.com>
Date: Wed, 7 Mar 2018 12:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfWwD-wYOzYacH4j7gfgDGh5MPAhXTR46wbYU=pw3zEhg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7q7z8+PMji80caiqeMtq8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lMuj+BxeL8+Q3sFp0Tl7BbbHp8jdXi8q45bBYzzu9jsli0rJXZ
        Yu2Ru+wWS69fZLJo3XuE3YHfY828NYwel/t6mTxmd8xk9di0qpPN4373cSaPzUvqPfq2rGL0
        +LxJLoAjissmJTUnsyy1SN8ugSvj24OrrAXHxCs+tvSyNDBOFO5i5OSQEDCReHv+ODOILSSw
        glHi3croLkYuIPsLo8S5JUtYIRKfGSUerqrsYuQAa3g3TwKiZjmjxJT/V5ggnLeMEu/fXgRr
        EBYIkljSdJgdxBYR0JS4/vc7K0gRs8B9Fombtz4xgSTYgBJ/N99kA7F5BewkWvfPAWtmEVCR
        aHywB+wkUYEIiYVTnzJC1AhKnJz5hAXE5hQIlLj64zhYL7OAvETz1tnMELa4xK0n88EukhBo
        5ZA49WMBM8SfLhJHz75ig7CFJV4d38IOYctI/N85nwnCrpa4+aKJBaK5g1Hi/u92qAZricPH
        QV7jANqgKbF+lz5E2FbizJleZkiw8EnceCsIcQOfxKRt06HCvBIdbUIQ1YoS989uhbpGXGLp
        ha9sExiVZyH5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxApPd
        6X/Hv+5g3Pcn6RCjAAejEg/vhv3zooRYE8uKK3MPMUpwMCuJ8E4umR8lxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwCi1oTomgWGnwVcTWRsT7rRc6fN/
        v98zq2PXk3J9mnuAa6Xwjy0/YmY9D3CVE0z/3ta349QpS77i6KsZi7esMvqkkdG7ad7S92c/
        10ev/VfXLWp9eomxGWPPB4f73bploq+1lz9NvNd3IiQ3QFqs52xTVkxE8be6m7ebOgwtlGr4
        lqUtbjyhqcRSnJFoqMVcVJwIAKwGgaNyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7q7zs+PMph0R8iiqeMtq8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lMuj+BxeL8+Q3sFp0Tl7BbbHp8jdXi8q45bBYzzu9jsli0rJXZ
        Yu2Ru+wWS69fZLJo3XuE3YHfY828NYwel/t6mTxmd8xk9di0qpPN4373cSaPzUvqPfq2rGL0
        +LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
        QS/j24OrrAXHxCs+tvSyNDBOFO5i5OCQEDCReDdPoouRi0NIYCmjxKWvpxm7GDmB4uISu+e/
        ZYawhSX+XOtigyh6zSgx4cl2dpCEsECQxJKmw2C2iICmxPW/31lBipgFHrNIfPl3hhWi4y+T
        xOwPbWBVbEBVfzffZAOxeQXsJFr3z2EFsVkEVCQaH+wBWycqECHRuXI+C0SNoMTJmU/AbE6B
        QImrP46D9TILqEv8mXeJGcKWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVS
        S4tz03OLDfWKE3OLS/PS9ZLzczcxAmN827Gfm3cwXtoYfIhRgINRiYd3w/55UUKsiWXFlbmH
        GCU4mJVEeCeXzI8S4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5Hxg+skriTc0NTS3sDQ0NzY3
        NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cDYylIenXn215pLH/nWxj6+4BHPIad+0Idr
        kmTp+hS7qMLJb48cEfStqVtj9CpxhW+/j/kfN+G+hXxT2Xfe4GCw0Hv1+MX5a+pnPVulDD5P
        dp4tpRW9P/rNh3zep4+lnv/NSDWcqODC849BcIag9Jmovo6vd3TvlKixH5h01fNZQeti/eoj
        8hJKLMUZiYZazEXFiQBX06UgBwMAAA==
X-CMS-MailID: 20180307114043eucas1p1a872618a7efa88f9b1c333f282d4960a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180307114043eucas1p1a872618a7efa88f9b1c333f282d4960a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
        <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
        <CAJKOXPfWwD-wYOzYacH4j7gfgDGh5MPAhXTR46wbYU=pw3zEhg@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07.03.2018 12:22, Krzysztof Kozlowski wrote:
> On Wed, Mar 7, 2018 at 12:13 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Hi Chanwoo, Archit,
>>
>> On 07.03.2018 05:48, Chanwoo Choi wrote:
>>> On 2018년 03월 07일 11:12, Chanwoo Choi wrote:
>>>> Hi Rob and Andrzej,
>>>>
>>>> On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
>>>>> Hi Rob, Chanwoo, Krzysztof,
>>>>>
>>>>>
>>>>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Thanks for reviews of previous iterations.
>>>>>>
>>>>>> This patchset introduces USB physical connector bindings, together with
>>>>>> working example.
>>>>>> I have removed RFC prefix - the patchset seems to be heading
>>>>>> to a happy end :)
>>>>>>
>>>>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>>>>> v4: improved binding descriptions, added missing reg in dts.
>>>>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>>>>     example.
>>>>>> v2: I have addressed comments by Rob and Laurent, thanks
>>>>>>
>>>>>> Changes in datail are described in the patches.
>>>>>>
>>>>>> Regards
>>>>>> Andrzej
>>>>>>
>>>>>>
>>>>>> Andrzej Hajda (5):
>>>>>>   dt-bindings: add bindings for USB physical connector
>>>>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>>>>   extcon: add possibility to get extcon device by OF node
>>>>>>
>>>>>> Maciej Purski (1):
>>>>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>>>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>>>>> acks for dts part).
>>>>> Now I have a question how to merge them.
>>>>> The only functional dependency is between bridge and extcon, and from
>>>>> the formal PoV bindings should be merged 1st.
>>>>> I can merge it:
>>>>> 1. All patches via drm-misc tree.
>>>>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>>>>> samsung-soc tree.
>>>>>
>>>>> Is it OK, for all? Better ideas?
>>>> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
>>>> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
>>>>
>>>>
>>> I made the immutable branch[1] as following: If you agree, I'll send pull request.
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17
>>>
>>> Or you can make the immutable branch and send pull request to Rob and me.
>>>
>> It seems you took v5 instead of v6 version of extcon patch.
> I also took v5:
> https://patchwork.kernel.org/patch/10244407/
> https://patchwork.kernel.org/patch/10244431/
>
> There was no v6 in samsung-soc patchwork. Is it a problem for DTS?

No, v6 was only typo fix in comment, and only extcon patch has v6.

Regards
Andrzej

>
> BR,
> Krzysztof
>
>
>

