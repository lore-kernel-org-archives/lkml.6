Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715214-2-11463866043689717386
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
    t=1519715213; b=rx2BPy1fqLkNhpuhUPVRDYbbM3cVlYsjM11bPrhifsPER8z
    6ukoOmvtwMrXWEPfqg6eW5nRmQe7PtnQBpqv/kDywvykuDorN5+I1B941a4Af5j5
    Q+2QXgAXhR2JWRiPlM+0BB02zwU6KDMBqz3+SQWWTtdP+3c53Q9H75t/rVW8l6Eo
    igdr2GD19VZA0lF3IhzdxsSjgnYQMhJ2zIatyYhY/Sj966f0g6zkt3lQFZ49INwJ
    iNRzLGo0jkSAZ5KLiVecYUB20T680JO8r8UCaUg75dBkq3NrMQbHWD9+ya4uDLtY
    Uao4GRaPa9NK3dnNIgFC+/SQQ3gMq6aDco3c5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519715213; bh=cCLaUH8K
    X7my+1MG11+nHzFcSRqylmHIulfFa8oJrK4=; b=Kk/rMYDRcArlA4wTjkgBKPS3
    3kzkFheRd007U5OBkj01uTlI/GVRBskzPQsvxtAhQUFRFaaUrsUWy8bxnxooYKgE
    cDisu93g4xavVzfpG8hhd3C12xRb5wEpj0N7YzDhIQNOsqsMgr14kS4cj8zaImTW
    SjYcG4DVLT7wtzU5mNt5iVl+0jZ7QC5thMG++hhYidIX9bDNQH2T0JP3uMtAuCqM
    ubFLBkoQu40WSfLeMMBrDuLBvQfIIjiUVbfjhnyfrQuUC0lqzcCS6sV1D0WKi1DB
    f74wP1CWeZyW2OsKdWKt7Yb+pU7miFzfbZTt+B5ijG/xKsVIFpdbRbhbcRrYVw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=udYl7Itz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=udYl7Itz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeB0HGk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:06:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49011 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeB0HGh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:06:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227070635euoutp020ff411cf7b76987b8735824015840603~XHOsQNpe42361923619euoutp022
X-AuditID: cbfec7f4-713ff700000043e4-8f-5a9503789e8c
Subject: Re: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <513ee866-a44e-5969-4584-0385029e0356@samsung.com>
Date: Tue, 27 Feb 2018 08:06:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87qVzFOjDFY1MVo0dbxltdg4Yz2r
        xfUvz1kt5h85x2px5et7NotJ9yewWJw/v4HdonPiEnaLTY+vsVpc3jWHzWLG+X1MFouWtTJb
        rD1yl91i6fWLTBate4+wO/B7rJm3htHjcl8vk8fsjpmsHptWdbJ53O8+zuSxeUm9R9+WVYwe
        nzfJBXBEcdmkpOZklqUW6dslcGU8/NHLVLCas2LKkyamBsYj7F2MnBwSAiYSLx88Y+1i5OIQ
        EljBKLG1dx2U84VRYvayaWwQzmdGiXNTVsG1nDqymBEisZxR4sCOM1AtbxklbmydzQRSJSwQ
        I7HxwlkWEFtEQFPi+t/vYEXMAvdZJA7/XAhWxAaU+Lv5JhuIzStgJ7G9bzbYChYBVYl3+/rB
        akQFIiQWTn3KCFEjKHFy5hOwoZwCgRL3vqwBq2EWkJfY/nYOM4QtLnHryXwmkGUSAo0cEi1n
        YF51kZjZtB7KFpZ4dXwLlC0j8X8nTEM3o8SpfZ3MEM4URonzry4zQVRZSxw+fhHoBw6gFZoS
        63fpQ4RtJXa1zGIECUsI8EnceCsIcQSfxKRt05khwrwSHW1CENWKEvfPbmWGsMUlll74yjaB
        UXkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMw6Z3+d/zL
        DsZdf5IOMQpwMCrx8DrITIkSYk0sK67MPcQowcGsJMK7cvHkKCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQZGN10O51XmFzj6F3yOnN48/W6aoKuU3kah
        LJ3pOSZrmbhcgzN+ly/7N1E4bnem6OkJDxed8v3z4klHQat90pa40t3LTfZf199mtEHGVJT5
        KsPa+L9vf569LcmfkS8dPntWh7/nf4Gr1gzxr5Set5fOt3n5NiE+hCOveyrXvGyDE96/bi4O
        fTpXiaU4I9FQi7moOBEAWfyDVnYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xe7rlzFOjDKa+tLRo6njLarFxxnpW
        i+tfnrNazD9yjtXiytf3bBaT7k9gsTh/fgO7RefEJewWmx5fY7W4vGsOm8WM8/uYLBYta2W2
        WHvkLrvF0usXmSxa9x5hd+D3WDNvDaPH5b5eJo/ZHTNZPTat6mTzuN99nMlj85J6j74tqxg9
        Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Mt4+KOXqWA1Z8WUJ01MDYxH2LsYOTkkBEwkTh1ZzNjFyMUhJLCUUeLSsm6ohLjE7vlvmSFs
        YYk/17rYIIpeM0rsW3aGDSQhLBAjsfHCWRYQW0RAU+L63++sIEXMAo9ZJFqPHGGC6Ghikmj6
        8Rusgw2o6u/mm2A2r4CdxPa+2WDrWARUJd7t62cCsUUFIiQ6V85ngagRlDg58wmYzSkQKHHv
        yxqwGmYBdYk/8y4xQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwCjfduznlh2MXe+CDzEKcDAq8fDOkJsSJcSaWFZcmXuIUYKD
        WUmEd+XiyVFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MQHkl8YamhuYWlobmxubGZhZK
        4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhiZKi8uFVJPvOqrXKn71/Nld5XD+/sCt2Iy/9ky
        Kqgdbvv783Ciqf9nO+E/DaJyhtvMwp2Kzr7rjrxzmaPiwqnQBRt8Vd/0vDO/onjjrAj3UpY3
        U3tClh34cPgZm0jrf8u7ja+7oo4k1AdMYLtyY8pB848eu8y2nmMJ/jTTVWaVOpek8MUS4Sgl
        luKMREMt5qLiRAALMDjpCAMAAA==
X-CMS-MailID: 20180227070632eucas1p2e4759acb8b7eef31cb43ec36d909c61a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180227070632eucas1p2e4759acb8b7eef31cb43ec36d909c61a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
X-RootMTR: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
        <20180221085541.14556-1-a.hajda@samsung.com>
        <20180221085541.14556-5-a.hajda@samsung.com>
        <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26.02.2018 16:21, Krzysztof Kozlowski wrote:
> On Wed, Feb 21, 2018 at 9:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> OF graph describes MHL data lanes between MHL and respective USB
>> connector.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v4:
>> - added missing reg property in connector's port node (Krzysztof)
>> ---
>>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 3 deletions(-)
> You have a duplicated '};' so kbuild complains so I assume there will
> be next iteration of this. Beside that I am okay with both, so I will
> take next version when your bindings and driver changes get
> acked/accepted.

Yes, test robot already reported it, thanks for looking at it.
I have postponed next iteration in case anything new is spotted, but
since it is calm I will send it in few minutes.

Regards
Andrzej

>
> Best Regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

