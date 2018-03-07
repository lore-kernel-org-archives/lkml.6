Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2219703-1520398142-2-13522068866732210723
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
    t=1520398142; b=EumTrjbL6r2tk28+GbNnb4uJcG1EUET+Q28TQACsc8CQWco
    JDYbYwtvSP9lE5WtjGmzmiETPRmT9CHNQQAcwoH8vJWkgQrCWjsFWb7LIpoRCuRo
    zAbtNKcV4sjDVtqtdZB9/7K6aU2e20KAKTQp7Z4QdhmLLf+gqqIUPaJBY4omuPQ2
    ZekDTZJ/nKbV5/Z7CO5HXOSL2fQGoQgcpK0l5zoP5OSAhE3XLgU+vPvXPo1IuTER
    IJVmD2VFfr7OKAAFJFYUL3JDROb115iAaUrZG+3L3cqBowc6zdJv+lwsEfobpS2m
    a5pYaVpnVttHD3UZtSZNyw94LB9rMjHt09kPMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1520398142; bh=CoUveYEB
    7iJybfnPn6v0f+MsMLs7AbzLQEhgi2ZeIXc=; b=h7+kBc7+KkwR6cbofHAH4Vsa
    dzJcyabl6eS2T7RFpOeyQB8RA4RZDFda/87tOo8sRir6ObvIFnoEoCCv09dAEecl
    9nLfiEehaPtuA+dPBBofFKh/6iUNgvpWKQt+IDTnEGizzqxaXEfKnCuVy5an2JkQ
    Q5oVYYQkJtU2TGeSi9QfdlnW2EU6tbPqionGjkYKUwlQFawafTQxLIHenPTLLzlk
    +F8agIFtoBqM16PFmz4RvPlMC+T9kejx1QC7hAhxE8zTpC5jr3VbkIH/qDKnW48G
    lGdw2gB5si73TNXETpx50uhMsZ1rGieub59sciFnBr7NPFuYmWQqU+TR/lFMuQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pRHVFEcA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pRHVFEcA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCGEsr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 23:48:47 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:17026 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753978AbeCGEsp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 23:48:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180307044843epoutp020c682a52a1b2892d5f45f3cab922539c~ZigmbOL-n1427614276epoutp02H
X-AuditID: b6c32a47-187ff7000000100c-95-5a9f6f2a48da
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A9F6F29.5020501@samsung.com>
Date: Wed, 07 Mar 2018 13:48:41 +0900
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
In-reply-to: <5A9F4A7D.9020409@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmua5W/vwog+Od2ha31p1jtWjqeMtq
        sXHGelaL+UeA3Ctf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JYtKyV2WLt
        kbvsFkuvX2SyaN17hN2B32PNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36tqxi9Pi8
        SS6AIyrVJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfo
        eCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0oaGRnqGBuZ6RkZGeiXGslZEpUElCasab
        M69YCqYJVbx78oGpgfEYXxcjJ4eEgIlE85FVbF2MXBxCAjsYJU7tecME4XxnlGg4tpcdpmr1
        ssksEIkNjBJP3v5lA0nwCghK/Jh8DyjBwcEsIC9x5FI2SJhZQFPixZdJUPV3gepP9DJC1GtJ
        TPs6E2woi4CqxK9HF1hAbDag+P4XN8Bm8gsoSlz98RisXlQgQmLn/G9g9SICRRJnnt9gBhnK
        LDCVReLO89dgzcICQRJLmg6DFXEKaEucXnEd7AUJgXnsEq/nn2WDeMFF4vzymVDvCEu8Or4F
        ypaWeLZqIyNEQzujRPveecwQzhRGiXPX7zFBVBlLPFvYxQTxHJ9Ex+G/7CA/SwjwSnS0CUGU
        eEhc3noVaqijRMe1B8wQ/z9ilOi8uol5AqPcLKQgm4UIsllIQbaAkXkVo1hqQXFuemqxUYGx
        XnFibnFpXrpecn7uJkZwitVy38G47ZzPIUYBDkYlHt6IvfOihFgTy4orcw8xSnAwK4nw5gfM
        jxLiTUmsrEotyo8vKs1JLT7EaAoM8YnMUqLJ+cD0n1cSb2hiaWBiZmZkbmYBTGPivK0BLlFC
        AumJJanZqakFqUUwfUwcnFINjB79YdHm718fcjZvF7jR6tancIxx1vlThu3pD8y85Dez1xfG
        reGcLnHs4UKl+xuuKV73Xf/pyJafT1k/NT7ecl9OmlHkdcAOu/13nrbey/h9bLt4r/cBieAL
        wf9enA9uLNPQvav3892bK307RFfub+i88mRyn410XtzphCNXApRucN8v+O1SMVeJpTgj0VCL
        uag4EQCmA+CGxwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t9jQV2t/PlRBrcX81jcWneO1aKp4y2r
        xcYZ61kt5h8Bcq98fc9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZzDi/j8li0bJWZou1
        R+6yWyy9fpHJonXvEXYHfo8189Ywelzu62XymN0xk9Vj06pONo/73ceZPDYvqffo27KK0ePz
        JrkAjigum5TUnMyy1CJ9uwSujDdnXrEUTBOqePfkA1MD4zG+LkZODgkBE4nVyyazdDFycQgJ
        rGOUOHvhOitIgldAUOLH5HtACQ4OZgF5iSOXsiFMdYkpU3Ihyu8zSvzdcZgJolxLYtrXmewg
        NouAqsSvRxdYQGw2oPj+FzfYQGx+AUWJqz8eM4LMERWIkOg+UQkSFhEoklj26wEzyExmgeks
        Em8PdIPNERYIkPjyfwoTxLInjBJPXm0EW8YpoC1xesV1pgmMArOQnDoL4dRZCKcuYGRexSiZ
        WlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGFXbDmv172B8vCT+EKMAB6MSD2/E3nlRQqyJ
        ZcWVuYcYJTiYlUR48wPmRwnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQ
        WgSTZeLglGpglGTlYC624PF5E3mg/wjT7r8bmtqPdj/b+tygu2bL4/nqCy4G5H5Zte/Zvg0F
        jo/iTbWnZfas+fJEoWQ9m52JvfTMFSstWVe1/3Gb8UFDTHXZa2u/vvodetzPuS6svyVSHb4+
        8vm/wpuPegI7dP9euDah1rLRM7su9kPLdt9azr8Be+bWFMlmKLEUZyQaajEXFScCALIWnlOm
        AgAA
X-CMS-MailID: 20180307044842epcas2p4c162710e37fc36df1a20d6586703f6f2
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 03월 07일 11:12, Chanwoo Choi wrote:
> Hi Rob and Andrzej,
> 
> On 2018년 03월 06일 21:53, Andrzej Hajda wrote:
>> Hi Rob, Chanwoo, Krzysztof,
>>
>>
>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>> Hi,
>>>
>>> Thanks for reviews of previous iterations.
>>>
>>> This patchset introduces USB physical connector bindings, together with
>>> working example.
>>> I have removed RFC prefix - the patchset seems to be heading
>>> to a happy end :)
>>>
>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>> v4: improved binding descriptions, added missing reg in dts.
>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>     example.
>>> v2: I have addressed comments by Rob and Laurent, thanks 
>>>
>>> Changes in datail are described in the patches.
>>>
>>> Regards
>>> Andrzej
>>>
>>>
>>> Andrzej Hajda (5):
>>>   dt-bindings: add bindings for USB physical connector
>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>   extcon: add possibility to get extcon device by OF node
>>>
>>> Maciej Purski (1):
>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>
>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>> acks for dts part).
>> Now I have a question how to merge them.
>> The only functional dependency is between bridge and extcon, and from
>> the formal PoV bindings should be merged 1st.
>> I can merge it:
>> 1. All patches via drm-misc tree.
>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>> samsung-soc tree.
>>
>> Is it OK, for all? Better ideas?
> 
> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
> 
> 

I made the immutable branch[1] as following: If you agree, I'll send pull request.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17

Or you can make the immutable branch and send pull request to Rob and me.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
