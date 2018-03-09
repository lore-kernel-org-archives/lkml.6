Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-123275-1520587253-2-15053699359615229718
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
    t=1520587252; b=OXXQB4SB3p/bMIRrKVja/j9jZriM/7PVRr04cBGR5zpMFyU
    s7jxrUA6kpOCR3CJux+ATNzUf7Zs82HryY2taL3uAppC/efV5WZ8qnXyjSzmC0Jv
    zW2p4c8HMEYw2ZJ6E6H8d7kLZivLpiIZuL6Je3B4CJJ7mFouMPwxLde9CZQP1Vn5
    xh0Rjol1uBxNrfNfrILlPDF6flN9X0q9FgnUDs306WoudnWowAqNzFSNv6jZnN/2
    fWKBW99d7+fuf4sFIL5Uph8Rf+khKWLFaazQBrJ/nUTX8KEd4qMlrbUKTLdm17Ff
    4qAxvMTVxlO3icPfp5OmRCSFTn0yXzfqZhjZzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520587252; bh=/SbvqVl9
    ca1J4m0NXgh20I5r1pv1ML3wMChRnbXQeIw=; b=aHoGqG4fVgEdahQogozdK54s
    2YYvlCsUavAx7ghx12LC8X84m8Tl00I/WjCFaNi3ggojlV55/ow3IA+BiRjXa17B
    fEpwjSv+0dLsKX9YatilP4H3VqJUWwW4bmLrH1cYEKYJ8VVpSVvX+mvJiDkkJf4M
    aWJ2LT7exX3OCV0vxeKDKlJTLrUuUnHis319tGGelkxtdR2lLwUQSJH15G33jija
    eHpxK/S025JZdTgznlKRvQ+7aq/cZ4f4Oy6rgwYg30LDHx0YaZNrr5hyhsI5x8G3
    +UKyqknktSKpqyC+2FgiOpVrwnZlf3l4BJsTZG1vwPbW+TDGDzvq0+T3X+6a3Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=APLmcXHC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=APLmcXHC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeCIJUb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:20:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59336 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCIJU1 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 04:20:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309092025euoutp01fc42ffaeb1507fee5a24a2abe6868353~aNgZwQtjw3074930749euoutp01B
X-AuditID: cbfec7f2-1c1ff70000011644-4e-5aa251d76fb8
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
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <984d5c86-f647-5228-7494-63faf4dec3d3@samsung.com>
Date: Fri, 9 Mar 2018 10:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5AA09753.7060308@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH973fY8e1X1fWR6zWYfMwkTHfDanW7GfzB5qkP3D0U+jxfhVh
        tKxUSA9DdUjtKrVwrgdpalynI0vl0MVatjzEHNYVi5Tufpr+e33e3/fn4b19WUI5SnmxB+OS
        BE2cOkZFy8nG9rGu5b3byiNWPmqai9OzbBS+U3Sbwr0jHyk82ZhP4FLTMwq/GP1G44KBPBJ3
        dekZnJ2vY7Bh8BWFLc1XaFzU1SrD5ZUZBL5p6mdwRW+PDGe0mBjcr+9EgW587bVaxGvTekje
        kntexrf8uE7y2qxiijfUZNP8wFmzjK/TneJz62sQbzd4b5VHyNdHCjEHUwTNioC98uiq7mIm
        4S4cfXStlUhDn9xzkAsL3GoY67vB5CA5q+RuIBivfyCTihEEP63ttMOl5OwIWhpCpzvSv1so
        yVSFILsjUyaZbAhKJ/0d7M5tB116m3OsB3cVgbnxA+EoCK6OBHvbOedYmlsCf+r6nKzgAqD9
        ZwfpYJJbCLaJq059DhcOZRffI8njBk+K3zk9Ltwy0F0aZhxMcD5wukFLSOwJr9+VOjMAV8bC
        yMNaJN0dAoZhIy2xO3w21zMSz4fJe6UyiY9D31A6KTVnIRj4feZfwzpoM/dMhWanNiyB280r
        JHkDaN+/pB0ycK5gtblJN7hCQeNlQpIVkJWplNy+MNDZQEjsCRXdo3QeWlAyI1nJjDQlM9KU
        /N97HZE1yFNIFmOjBNE/TjjiJ6pjxeS4KL/98bEGNPUZn06Yh5vQ6PN9RsSxSDVb8TaoLEJJ
        qVPE1FgjApZQeSg6qqckRaQ69Zigid+jSY4RRCOax5IqT8XuxScjlFyUOkk4LAgJgmb6Vca6
        eKWhTTsK18yyVj884LslMXhs2VprkotWZ0wJditQ78l9dT8jxzoRMBi+UZzMsMij78612LVa
        /eChE5vf+tfyiYv8+kM0vbbBnaGqb9U+tyYih47qb+UzhZWBY0HeYRc2/npsOvGmHJIIap29
        mQyr3IUSFozvpYvJr/pfX5pmM6tS/VSkGK32X0poRPVfgEqNrIgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Pd2rgYuiDHqnWlg0dbxltdg4Yz2r
        xfUvz1kt/m+byGwx/8g5VosrX9+zWUy6P4HF4vz5DewWnROXsFtsenyN1eLyrjlsFjPO72Oy
        WLSsldli7ZG77BZLr19ksmjde4Td4u6Gs4wOgh5r5q1h9JjdcJHF43JfL5PH3m8LWDxmd8xk
        9di0qpPN4373cSaPzUvqPfq2rGL0+LxJLoArSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j+YWZ7AXbJSqOztvH3MD4UriLkZNDQsBEounDZdYu
        Ri4OIYGljBLzX55mh0iIS+ye/5YZwhaW+HOtiw2i6DWjxK2zmxhBEsICQRJLmg6zgyREBGYz
        SnyeexVsFLPAVhaJdye+QLVcZ5KYd7CdFaSFTUBT4u/mm2wgNq+AncSx76dYQGwWARWJt//m
        gsVFBSIkOlfOZ4GoEZQ4OfMJmM0poC2xZNonsPuYBdQl/sy7xAxhy0s0b50NZYtL3Hoyn2kC
        o9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHpYNuxn1t2MHa9
        Cz7EKMDBqMTD+8BxYZQQa2JZcWXuIUYJDmYlEd5TK4FCvCmJlVWpRfnxRaU5qcWHGE2BnpvI
        LCWanA9MVXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhjXhF9X
        eSSt3rSG7eL9jtvbmt2NT8RVLL94JOPlQ9u6dts3NiXK3+X+1dSK/13S1RHBZbJks3TUlMdM
        zN8080/5rFzP8749c0aewHHt6rt6FcKLvzi+1kkqXOJx42bs6di6kiXZb291LktZrlNTc9vy
        7ELxibGP43/sZf/krvxj6p6ly+2ncq9QYinOSDTUYi4qTgQA+Q7nKR0DAAA=
X-CMS-MailID: 20180309092022eucas1p2c6cb3c350a47a640278247f26d02263a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180309092022eucas1p2c6cb3c350a47a640278247f26d02263a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
        <20180227071134.28063-1-a.hajda@samsung.com>
        <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
        <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
        <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
        <5AA09753.7060308@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chanwoo,

On 08.03.2018 02:52, Chanwoo Choi wrote:
> Hi Andrzej, Archit,
>
> On 2018년 03월 07일 20:13, Andrzej Hajda wrote:
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
> My mistake. I picked v6 and made the new immutable branch.
> After Archit confirm it, I'll send pull request.
>


Lets just queue all patches (except dts) via extcon branch (thanks
Daniel for advice), without making immutable branch.
It seems to be a simplest acceptable approach.

You can add my ack to sii8620 bridge patch (as bridge maintainer), to
fulfill process requirements.

Regards
Andrzej

