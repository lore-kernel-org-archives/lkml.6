Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343908-1520341721-2-10492528025757831216
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
    t=1520341721; b=FjbfnkWZYHRQpcOOjTv125PlIaQR/twmxxS4J9bIzMxpt6+
    uloHNKiLSODvjCt1DKJ5rgNOHUEq+lAPLjO9GI+xHGfw5IOpIoAUD1bhu3AjP1J+
    PR/x52wPMmzgFXSynxqc8JkjovaXiqMXQgyCV7Mx2Pkadof8bzYhkjIdonDHGMvW
    uuWFUBgwZiBWh7JK4YXeQqOu5vykbdBuSu218olMglJigsIK4XFxTA6UCQ5gsFzB
    RvMSHcmZidWXsl9c9ULIqxcPOjdTLyMpRa3EF6XOAdmgi+a7vifvt9LXZUQxBui2
    rPT0Z18lPEeKRDtmMXPOCKZM7+E5roz5CmbJrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520341721; bh=iV2RrCXFVAbcfddz59hv1mqCWC2pZoqU4ncRHI
    YRTkM=; b=aQkPbhnR1wLwgOPBAGY2jgdYtWUxtjKGmgM3eGLXFkEiRJjtaXo+I4
    5BOKjJ8j0GAgxNHwILmpcZO6oxMteJlBobeQEpRohYZhOcf3CKgC7QWD5Z9P5u2p
    qmj2kyol036kfVCBd1mkelnMtUY9II1cC+U4GmNJSuX+pb2Xvgfd1eMUCN7sMMHV
    /aIRJlk66HlCyEraMHj3MNvWFva+W0cK8y//bgd+3oqyNAk3bTLp0Xl/RyLUDSwh
    rFarC/RteL4RQUF44ku71NGmjWg5ee427/JlnEP0FDnEkOkpA9RugNFC02XAvCLz
    cYHTzzIQ9Z1kGDXpFkNfOtHt1JIMZAPw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1753663AbeCFNI2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 08:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753454AbeCFNI1 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Mar 2018 08:08:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2AA2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AG47ELtcLs8uiBR05DJq4Ek+MZ5SFaMHENEYdTKK5GrraQvkho5fvjBNpYwCUbtTQvCgvuBoyDYbaMAQDjHKlSDDHt0=
MIME-Version: 1.0
In-Reply-To: <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
 <20180227071134.28063-1-a.hajda@samsung.com> <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Mar 2018 14:08:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdne8ETZWg2Grv81E19Hsxt3bCHLpbsTdfKafwy0XNsyw@mail.gmail.com>
Message-ID: <CAJKOXPdne8ETZWg2Grv81E19Hsxt3bCHLpbsTdfKafwy0XNsyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical connector
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:53 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
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

2) option please. The DTS should always go through arm-soc because it
is independent of driver code. I'll take the DTS today.

Best regards,
Krzysztof
