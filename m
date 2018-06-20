Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB64C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBCE20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kTFjftlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBCE20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFTJH7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:07:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44285 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFTJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:07:55 -0400
Received: by mail-io0-f194.google.com with SMTP id g7-v6so2792464ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=C+7VWrGeouX+nPJiTW38kia043Y+QwcRmY6s995DeCM=;
        b=kTFjftlqflzExMdnY5zO6azrYe4xUxYLizFH0QnAxfMX1cXMyAF830LcYnH/ms9Sbo
         9ZKZ5v5Li6I02qcStAo8udRCHeDR9vtjuzA8gH1Y2SKBxCsDWmkXt4Sg0reGNKg2LXP2
         O45fwmVjOXHKRv7XnPJiZizDNgbdqaVTpxbWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=C+7VWrGeouX+nPJiTW38kia043Y+QwcRmY6s995DeCM=;
        b=QECFq37t3nWwL+vUTex91r9T5+9GtCBaL8f/8DbD82aSPYdx7OycifnNdluay0xjOU
         0tciFjJ+r43GcmIsMnMyYWdPAFqbJ8Z16D0+zr9W7Ur3Idn8q/YXoKhlIJjafJDJJvHJ
         W72TvgYDoiGKcrx5+qdK/ID2pcAAqf39gPG+6H6FlJD8amCBDsLdg7Usad/xKyiNkYoJ
         gJpwz1G11blpIw0nUrBiWN/HP6ssEEOdHK6b43i+aFV9uWDHkrgQ+IHqj6NmnT7QVJQa
         W/gxoCseYqZJ93CHAwTwSocQis7k/L0aRMJE3TFrtxI/Ow9lyEw2mNRfvPVDLD6W/FIV
         Fgsg==
X-Gm-Message-State: APt69E38mWgWbNCIJZxKH1hSiP/8tzvf813BiBrc4tEU96JrWqM4W6CY
        EArA3gBonFDFrmaNf/wy73H0Eep2ddOlJpkjgA7knQ==
X-Google-Smtp-Source: ADUXVKIQeInih5OZEZf878dIvtO9cbFiHPAtuDNxoAtn9lWb8iOuZO/l3YfPrfXraXEks/Fvf5wwverikh5gU7Q7Puk=
X-Received: by 2002:a6b:c544:: with SMTP id v65-v6mr16108836iof.278.1529485674420;
 Wed, 20 Jun 2018 02:07:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 02:07:53
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:9802:bb08:74d1:12e1]
In-Reply-To: <5a2bc4e7-c6cd-b270-61d3-61bfa5d9e90d@tronnes.org>
References: <20180525193623.15533-1-david@lechnology.com> <8840212b-fd46-e700-58a1-cb1b882c5771@tronnes.org>
 <d5297fc5-94f2-edcd-5a11-95d7a9dca78d@lechnology.com> <ecd75b89-14a6-12f7-0ec4-222b1f984e49@tronnes.org>
 <5a2bc4e7-c6cd-b270-61d3-61bfa5d9e90d@tronnes.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jun 2018 11:07:53 +0200
X-Google-Sender-Auth: ZVr7_bUUjQAjx23YXvHi9owKqqU
Message-ID: <CAKMK7uF-hBjqnRG28fX7NXOJDc5YEWhq+G6s0M8usA+TXM1BKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/tinydrm: new dirver for ILI9341 displays
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     David Lechner <david@lechnology.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nitin Patil <nitin@mindsensors.com>, limor@ladyada.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:36 PM, Noralf Tr=C3=B8nnes <noralf@tronnes.org> w=
rote:
>
> Den 05.06.2018 17.49, skrev Noralf Tr=C3=B8nnes:
>>
>> (cc: drm-misc maintainers)
>>
>>
>> Den 04.06.2018 03.21, skrev David Lechner:
>>>
>>>
>>>
>>> On 6/3/18 5:00 PM, Noralf Tr=C3=B8nnes wrote:
>>>>
>>>>
>>>> Den 25.05.2018 21.36, skrev David Lechner:
>>>>>
>>>>> This series adds a new tinydrm driver for the Ilitek ILI9341 controll=
er
>>>>> and
>>>>> a 2.4" display panel that uses this controller.
>>>>
>>>>
>>>> David, do you have commit rights now?
>>>
>>>
>>> No. Opened a bug a while back to request access, but I guess the
>>> right person didn't see it.
>>>
>>> https://bugs.freedesktop.org/show_bug.cgi?id=3D105166
>>>
>>
>> Could someone please look at this?
>>
>
> David, let's not stall this, if you resend with fixed up commit message a=
nd
> acks/rbs, I'll apply it.

I acked and forwarded the account request, sorry for the delay. Next
time around, poking maintainers on irc helps if this stuff is stuck.
-Daniel

>
> Noralf.
>
>
>> Noralf.
>>
>>>>
>>>> Noralf.
>>>>
>>>>> A few things to note here:
>>>>> * The datasheet for this display[1] doesn't have a vendor mentioned o=
n
>>>>> it
>>>>>    anywhere, so I have used "adafruit" as the vendor prefix. If someo=
ne
>>>>> has a
>>>>>    better suggestion, please speak up.
>>>>> * The MAINTAINERS patch for ili9225 is included so we don't end up wi=
th
>>>>> a merge
>>>>>    conflict later on.
>>>>>
>>>>> v2 changes:
>>>>> * change vendor prefix from "noname" to "adafruit"
>>>>> * new patch for "adafruit" vendor prefix
>>>>> * minor style changes
>>>>> * drop regulator from driver (instead of adding to DT bindings)
>>>>>
>>>>> [1]:
>>>>> https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPE=
C-YX240QV29-T_Rev.A__1_.pdf
>>>>>
>>>>>
>>>>> David Lechner (4):
>>>>>    MAINTAINERS: fix path to ilitek,ili9225 device tree bindings
>>>>>    dt-bindings: Add vendor prefix for Adafruit
>>>>>    dt-bindings: new binding for Ilitek ILI9341 display panels
>>>>>    drm/tinydrm: new driver for ILI9341 display panels
>>>>>
>>>>>   .../bindings/display/ilitek,ili9341.txt       |  27 ++
>>>>>   .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>>>>>   MAINTAINERS                                   |   8 +-
>>>>>   drivers/gpu/drm/tinydrm/Kconfig               |  10 +
>>>>>   drivers/gpu/drm/tinydrm/Makefile              |   1 +
>>>>>   drivers/gpu/drm/tinydrm/ili9341.c             | 233
>>>>> ++++++++++++++++++
>>>>>   6 files changed, 279 insertions(+), 1 deletion(-)
>>>>>   create mode 100644
>>>>> Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>>>>>   create mode 100644 drivers/gpu/drm/tinydrm/ili9341.c
>>>>>
>>>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
