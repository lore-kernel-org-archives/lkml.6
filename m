Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343908-1520340845-2-14587909098370651222
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
    t=1520340844; b=ve3a7o0ZxlqXT3YW7QvZADFOEt0LKtuKZ+0C50oux7rJeSc
    KgLTlL2m27inUHhiPc388pRpDTtduazWEcxxtF5WC4JPYut3qjw1f8vqegTQWA3Y
    z4/PlK2CPRp2HjRe2T3QmYK0KYOOqHdrNHOX0XgHtZhckQ+53OXo9QZqIwFw2d82
    gZ6sEZGotb8lsXtFHE6PhD+9pgGLroO0/iO6IZkRINDAAAL+wdb59MrJ3AJx/PYo
    MTgKrdbMRvUB22PoWWRk3e98kdUg4R/FjGNOxyRJEdpcEtbC8xh3qMZrmmFWjnN7
    tzWjYl2vrzCOvSvFRPcDcP+mgEFdKtQlkKkHZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520340844; bh=YgWIs3pm
    jIrVZNVwf8Aj6Hc/TM1TKIAJHwhdmy6NlKg=; b=q6jj9CzPwKdcALy2iAqCZiiV
    f2igeqqb9njmE19cHTzf6oeXBA14Q7gGfkR/zXZKxIo3JdSjcEglTJTm25Jezkxw
    qHcWL2MscuN7S7Aof5+FtvSTXxfJn8poUrM97ErAsa6w92a3tXRiF1nhLwzZTGwU
    +HnI2ZTokEdszyVRJohqz5SgAL7R804GX6cxj27JuGUFy/nU07XDfx95Z6/FSkGh
    htCXkVycO+EI4XHzZrnbuybU3YOsp1/MU6X0JbWc8lGou5Jc0xPHLrRHOYcnT/4J
    Umzz4e0FqeQOXXPxNlIAB5fHhjcgBwSusAyqr599YioovJEyQJNZyiHQUfRWDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=TMO8TiFX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=TMO8TiFX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeCFMxr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 07:53:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45253 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeCFMxp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 07:53:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180306125343euoutp01addb7f1cfd6397144838d17d63759670~ZVeyKbWZN1912219122euoutp01e
X-AuditID: cbfec7f4-6f9ff700000043e4-98-5a9e8f549239
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
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
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
Date: Tue, 6 Mar 2018 13:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227071134.28063-1-a.hajda@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsaM2Os/DVpGgVuCCt6Mfpoqn440R/ooJqP6pTHbR0U3fU
        LlLaaDlzXlLyMm1qzJJhWHOtFC1z1pAoW1ppVBZaljHCvGAXI7dj5L/nfd7n+Z73gY/C5B+I
        UOqYJp3XarhkBemPOx796Fm7p8isWjfWsIDRGTwEc6uiiWBeTYwQTE3XU4Lpm/xGMiWDxTjT
        03NTyuRdskgZ29BLgultrSaZip57EubqNT3G3Oh6K2XqX7kljL69SxqziG00NyK2t7BAwlYZ
        KgnWZs0j2cF8l4RttmSzhXYrYsdty3ZSKv+tR/nkY5m8NjL6kH/icEEznjoaeNLYWCPNQVOy
        i8iPAnoj2EwtxEXkT8npBgT5bxykOEwgmOlrw8RhHMGLskfSf5bXxR2EF8vp6wgcljhR5EEw
        9vOcTxRE7wKLzunDi2kBqu7rfC9h9GUc3ox8xb0LklbCTPMA6cUyOhrKn7uRF+P0Kmh2t/sS
        ltD7oO7yRyRqAqG7ctjn9aM3Qen7Sh+P0cvhjqcaE3EwvB6ukXjDgNZTYC93kOLZ8eB0lsxV
        CIJRl30Oh8HjUiMu4iwY+KzDRbMBweCv3DnzFnC63LMXUbMJSmhqjRTpKNB/GEZeGugA6PcE
        ijcEQImjHBNpGRguyEX1Chh8chsTcTDUP5ski9FK07xmpnltTPPamP7n1iLcioL5DEGdwAsb
        NPyJCIFTCxmahIgjKWobmv14j/+4Ju6i1t+HOxFNIcVCGbXjikpOcJnCKXUnAgpTLJbtizSr
        5LKj3KnTvDbloDYjmRc60VIKVwTLDoSfVcnpBC6dT+L5VF77byuh/EJzkDWto/T7O4GPP9/v
        Lhvdf33KopmoPJNVaHxo2B6aVDe9Osxo13zJPhS+Oa7jQZNOX5GlYNs+ak6fbeidTpmJrWP9
        jocvWvgpN2wob+NDrr7BkZqyOrE7zRyiDCvtqA1XbrFZy0MedPfHWHhnVEtL2rama0HGyN3G
        2JOXNuzVFjEKXEjk1q/BtAL3F3uk1Rp0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7qB/fOiDA6dtLZo6njLarFxxnpW
        i+tfnrNazD9yjtXiytf3bBaT7k9gsTh/fgO7RefEJewWmx5fY7W4vGsOm8WM8/uYLBYta2W2
        WHvkLrvF0usXmSxa9x5hd+D3WDNvDaPH5b5eJo/ZHTNZPTat6mTzuN99nMlj85J6j74tqxg9
        Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Mt40ruZpeCVYEXPmvnsDYzfeLsYOTkkBEwkbk04wNrFyMUhJLCUUeL63i9sEAlxid3z3zJD
        2MISf651gcWFBF4zSlzrKwGxhQWCJJY0HWYHsUUEiiVu/77BDjKIWWA6i8StY99YIKb2MEqc
        29APNolNQFPi7+abYJN4Bewkpl+6yAhiswioSGy+uJcVxBYViJDoXDmfBaJGUOLkzCdgNqeA
        pcTkBzPB6pkF1CX+zLvEDGHLS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAmN827GfW3Ywdr0LPsQowMGoxMO7wWNulBBrYllxZe4h
        RgkOZiUR3gj9eVFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MP3kl8YamhuYWlobmxubG
        ZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhj7dvJIe25i0b8WYqpqeHLfRRHuJekaHCY8
        q4viX69cpGG2+Ovyi7o+l9lFPULZHir4XXoxi5lL6Pn+7EsVvZtOGrtvUJ+RV+yYekegZeuN
        oNOmp9aYP8ne9EGyyUNmonsy2//Fer7ZfgaNhmuaTnTKiy5UPbhkoZLQep0JZdtL7tbv/bK6
        ykaJpTgj0VCLuag4EQBQn+qqBwMAAA==
X-CMS-MailID: 20180306125339eucas1p199bde9709cff675b28a4811b2469f96b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180306125339eucas1p199bde9709cff675b28a4811b2469f96b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob, Chanwoo, Krzysztof,


On 27.02.2018 08:11, Andrzej Hajda wrote:
> Hi,
>
> Thanks for reviews of previous iterations.
>
> This patchset introduces USB physical connector bindings, together with
> working example.
> I have removed RFC prefix - the patchset seems to be heading
> to a happy end :)
>
> v5: fixed extra parenthesis in dts, renamed extcon function.
> v4: improved binding descriptions, added missing reg in dts.
> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>     example.
> v2: I have addressed comments by Rob and Laurent, thanks 
>
> Changes in datail are described in the patches.
>
> Regards
> Andrzej
>
>
> Andrzej Hajda (5):
>   dt-bindings: add bindings for USB physical connector
>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>   arm64: dts: exynos: add OF graph between MHL and USB connector
>   extcon: add possibility to get extcon device by OF node
>
> Maciej Purski (1):
>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

It looks like all patches received R-B or acks (I forgot add Krzysztof's
acks for dts part).
Now I have a question how to merge them.
The only functional dependency is between bridge and extcon, and from
the formal PoV bindings should be merged 1st.
I can merge it:
1. All patches via drm-misc tree.
2. All patches except dts via drm-misc, and Krzysztof will merge dts via
samsung-soc tree.

Is it OK, for all? Better ideas?

Regards
Andrzej


>
>  .../connector/samsung,usb-connector-11pin.txt      | 49 +++++++++++
>  .../bindings/connector/usb-connector.txt           | 75 +++++++++++++++++
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 38 ++++++++-
>  drivers/extcon/extcon.c                            | 44 +++++++---
>  drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
>  include/linux/extcon.h                             |  6 ++
>  6 files changed, 293 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>

