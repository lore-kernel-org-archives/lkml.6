Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-529228-1520473952-2-1597894162724641227
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
    t=1520473951; b=Xz/aM5y3Y2kkNOH6w7pSi7zOFVL7FHKaD0SwkwDlHJbZPC+
    OWDqULYvnV+omaD9E/BQ2YJhx5ySnionnMgPeN569Fk/WlLurIwMRiqX4tsZ+zj6
    TcpRUAKoqgwdGFbGdhISDe8zkPv7Lx/5wSD+Zen604Nx5/QVrVTXBm5Pz4x3sXOn
    Rh2tbRYP2wSkfTjnKS5WY/QNGEhPayJ+Jq65UW1Z1dSPz0shUrgf2VHqjHvEZJ76
    PiQwCp9xM5VkJk4beHwSelZP9v/LSRnzeD3BBy9B34mlWlSBt+28yf/rqlR/7A1V
    ov3B8YcMd8lws4FmvV3AVeSrHvx94pT+JLbiwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1520473951; bh=8VX/CCD0
    dQLEmFJnVPzwzX6G2Y29kKhBj6tuaWAkC3o=; b=Og0I1upj80Pus4mYdsCSLxxT
    Dg1/QGHfLg2HuKLwGe2ysN1PgRiEVF0UvDjtDK96bxWnDZ989rM7e1szTha/4amk
    9G92UDfO0RWAiFfnhTKmMgDe4yMwygYBlEYQTN1UDslsY4FVhwhvgNtS5rIyJw+p
    VjQiSQUjnvDfSDKEStRaLmuzfnaM6gpUrmYydsa9ZV3RqcjoxZKdrd7k+lZhTcgp
    5WIDGrGyq6lcJsIm83diqQ38/SFNnJypvC7eejCNaq9XtwSuHkFNtNOTD63FIq92
    REiZhs1fyLEMRORhDcMV7ok7ecIXNx7tPApOStgiKceTIoeV+0jNb2zz9BkhzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=h3IbsE1x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=h3IbsE1x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934653AbeCHBw1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 20:52:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36610 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHBwY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 20:52:24 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180308015222epoutp03a647dd4da13048e49c06007dbdb5814e~Zzv68WRsR2795627956epoutp03Y
X-AuditID: b6c32a39-467ff70000000fc5-1c-5aa09754c51b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AA09753.7060308@samsung.com>
Date: Thu, 08 Mar 2018 10:52:19 +0900
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
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
In-reply-to: <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmrm7I9AVRBl0rFC1urTvHatHU8ZbV
        YuOM9awW848AuVe+vmezmHR/AovF+fMb2C06Jy5ht9j0+BqrxeVdc9gsZpzfx2SxaFkrs8Xa
        I3fZLZZev8hk0br3CLsDv8eaeWsYPS739TJ5zO6YyeqxaVUnm8f97uNMHpuX1Hv0bVnF6PF5
        k1wAR1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        8UoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoQ0MjPUMDcz0jIyM9E+NYKyNToJKE1IzF
        5y4zFhySqHhx/xlrA+M54S5GTg4JAROJKb1dLF2MXBxCAjsYJeZN62SFcL4zSjx+cYAdpurS
        hAlQVbsZJfZduMsGkuAVEJT4MfkeUIKDg1lAXuLIpWyQMLOApsSLL5Og6u8ySix4fZIVol5L
        YteSm2D1LAKqEj2nBEHCbEDh/S9ugI3kF1CUuPrjMSOILSoQIbFz/jd2kDkiAnMYJZ7u2M0E
        4jALvGWWuDRvNthQYYEgiSVNh8Eu5RSwl2iasxhss4TAPHaJhjP3oV5wkbh35ggThC0s8er4
        FnaQKyQEpCUuHbWFqG9nlGjfO48ZwpnCKHHu+j2oBmOJZwu7mCB+45N497WHFaKZV6KjTQii
        xEPi8tarULscJTquPWCGeH8bk8SDf09ZJzDKzUIKsVmIEJuFFGILGJlXMYqlFhTnpqcWGxaY
        6hUn5haX5qXrJefnbmIEJ1gtyx2Mx875HGIU4GBU4uE98HN+lBBrYllxZe4hRgkOZiUR3ni/
        BVFCvCmJlVWpRfnxRaU5qcWHGE2BAT6RWUo0OR+Y/PNK4g1NLA1MzIyACczS0FBJnDcgwCVK
        SCA9sSQ1OzW1ILUIpo+Jg1OqgXGSxoqJG/a/mfDu9alW2epS57QNG87ULo+Q2czbcOWJf9l6
        w96Jogwv/q5cu9ek2bTHNYOZd9kt8Z2rPeXMP+pKOGZ6Pp64ZpnChK8+icUOb9as2943ietW
        5Q4H73lhtVfy/E/INtbpzpTPPcWQsrlNdwP/vokscyu/Bc+J+6Lgc/3EzT1fNQ4osRRnJBpq
        MRcVJwIA3tPwrMYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t9jAd2Q6QuiDCbdY7W4te4cq0VTx1tW
        i40z1rNazD8C5F75+p7NYtL9CSwW589vYLfonLiE3WLT42usFpd3zWGzmHF+H5PFomWtzBZr
        j9xlt1h6/SKTReveI+wO/B5r5q1h9Ljc18vkMbtjJqvHplWdbB73u48zeWxeUu/Rt2UVo8fn
        TXIBHFFcNimpOZllqUX6dglcGYvPXWYsOCRR8eL+M9YGxnPCXYycHBICJhKXJkxg6WLk4hAS
        2Mko8enuFyaQBK+AoMSPyfeAEhwczALyEkcuZUOY6hJTpuRClN9nlDiy7BIbRLmWxK4lN8HK
        WQRUJXpOCYKE2YDC+1/cACvhF1CUuPrjMSNIiahAhET3iUqQMSICsxgl5rc+YwNxmAXeMkt0
        ftnLDtIgLBAg8eX/FCaIZTuYJGbdugM2iVPAXqJpzmKWCYxAvQinzkI4dRbCqQsYmVcxSqYW
        FOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgRG1bbDWn07GO8viT/EKMDBqMTDK/FnfpQQa2JZ
        cWXuIUYJDmYlEd54vwVRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgt
        gskycXBKNTCGfH5qF3fyz/Nph2RWLVjyVvHC2sknzN4bfvyquDIz45f4qZ/zfB7KXeG89LqL
        rfHetkcbijzzC2T+H9c+qWywpSl4rvHWUPcja1ST5i/iPM7r2zXjXXrZ37VVIbe38G4/d/TZ
        6cXZ9au1Ctk5xF4vOWdr47tl0ST70hMcP0SzFZ9lCljLz4o8pMRSnJFoqMVcVJwIALxCfmWm
        AgAA
X-CMS-MailID: 20180308015220epcas1p3d275ebcd98da2da14590798a798bd0f3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
        <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrzej, Archit,

On 2018년 03월 07일 20:13, Andrzej Hajda wrote:
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

My mistake. I picked v6 and made the new immutable branch.
After Archit confirm it, I'll send pull request.

> 
> Beside it I am OK with your immutable branch, Archit is it OK to do it
> this way in drm-misc?
> 
> 
> Regards
> 
> Andrzej
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
