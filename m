Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D582C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AA222507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TeWwL31q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AA222507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeKMRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:53:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60858 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbeKMRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:53:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113075613euoutp015a1e6e966428a4891a973750d305e65d~mn_9pAJpz1538015380euoutp01Y
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:56:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113075613euoutp015a1e6e966428a4891a973750d305e65d~mn_9pAJpz1538015380euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542095773;
        bh=WJwZ5EypfGrtUskfSTKlRC/vh4lltDJPs9W8bijAGyM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TeWwL31q9Q0XjDl46ipLUofRNkYAS1wVHzrr6ferWO3ysyqRpc/+L0Agsur4Fc5VP
         e1pbBIWlbbrpvYLpSqswLcPfYGatMmFHW81R1/hOG1a8EDXrDQ916gxOwIMRoAaYO5
         tvu7x3VlWMGAVri6Fomawt35rP5+fv+G89slVHjI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113075611eucas1p1613868ea7eb58b81b84b7b655ea01e17~mn_8g67P-0328003280eucas1p1T;
        Tue, 13 Nov 2018 07:56:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.1E.04441.B938AEB5; Tue, 13
        Nov 2018 07:56:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181113075610eucas1p219d70ccaefd2013d24a27743ed7978bb~mn_7glRUx1597615976eucas1p2H;
        Tue, 13 Nov 2018 07:56:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181113075610eusmtrp2991d57b3e857cd33f59ac6a8647e3a45~mn_7QV_E72591325913eusmtrp2B;
        Tue, 13 Nov 2018 07:56:10 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-36-5bea839bf8ce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.24.04128.A938AEB5; Tue, 13
        Nov 2018 07:56:10 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181113075609eusmtip1f18d99dac860b1957f4f16885cceb008~mn_6YChXu0839608396eusmtip1Y;
        Tue, 13 Nov 2018 07:56:09 +0000 (GMT)
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
Date:   Tue, 13 Nov 2018 08:56:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMty3ZDTAiW=Lx2H4WvdsdJRYsVe1CpCJx7D0f7yANx7Lx25PA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe97bXqXZ41Q8WRQOIkqyJIuHEqkoeLtSH6JIuqx6scjN2tJu
        H7JiYk6zCyEucdayWlPT5TWSYtmmk8xpmRamlUQzxLtmmeV8jfz2O//zP885f3h4WnGTC+GP
        ak6KWo0qTsn5MmWO0folty51xSzrtISS9PpaiugdXxHpuZeGiKm6niVvhno4MnD7I0UGbVc5
        8nbEQxPbl2aW9KV9ZEnTk2yO/PrskJG8d26KdHieIeK6oGeI27WB6KuqZWS8uZgho/bXFPH0
        1TBrAoWCvnZWMI+OU0J+Tj4Selr0MiEn/5xQ9NnKCpXGNpnw9FotJ9geXuaE8uEOVmg3OCnh
        8d3zwvP0G4wwYJu33W+Pb9RhMe5ooqhdGn3A90hF5S3qeMOi04Y2K52EjMpU5MMDjoRv2VY2
        FfnyCvwAwZjZQkvFIAL9cDIjFQMIhj9VcP9G3MlfZV5W4PsIqn4ulkzdCIr05ZS3EYDVYGkZ
        nTQF4jAYzvrOeU00NnBgKc6dNHF4Efx+3Dr5qhxHg8lqpr3M4AVQ4ipkvByEd0NKu3XK4w+1
        WZ0TOs/74B3QUrTXK9N4PpR3Z9MSB8P7ThPl3QW4gYfk/AGZdPV6sLpvTnEAdDlLpngu/Kk0
        URKfh4tZb2hpOAVBjfn+VOTV8MLpZr2L6YmjHz1ZKslrwfKhalIG7Act3f7SDX5wvSyTlmQ5
        pCQrJHcotL8qpSUOhryGIe4qUhqnBTNOS2Oclsb4f28uYh6iYDFBp44VdREa8VS4TqXWJWhi
        ww/Fq21o4rPWjTv7K9BQ40E7wjxSzpTXZHpiFKwqUXdGbUfA08pAeWVkV4xCflh15qyojd+v
        TYgTdXY0h2eUwfJzMzpiFDhWdVI8JorHRe2/LsX7hCShtZFjhUNjm+Kqb2Rs2qptC08Un9k+
        OeLVTO9r5xfXwlnhFnNSdUZYmjm3ZtuYv+GlceOJ50XUHWrh2fiAnBUZv0s372seMdk9QRGp
        EVuuNNb9KGil+0N7qzJ7+9Kv1YXswtaMXXuWi1EzPVs2X1k3u6x/pWbVziaH4VtYQf2pTpdN
        yeiOqCIW01qd6i9nHUe8qAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9tx9HiNBVf/GCxqNBqtunaq5b0oehAfSiKLhsyRx7U3EV2
        tkiTsmLFvJRdIJoxK7OYs4tTUruzzCs5L2UWWLHMmGKmljEyy7kCv/14nv+Phwf+NC52ktF0
        tsHMmQxanYQSEp2zrYNr7SdH1Ov6mhlU2tWOIWvLMEDjN0sAqmjuItGrH+MUmrr2HkPf3WUU
        ev3TjyP3p34STZS8J1HfgysU+uVrEaCqNz0Y+uh/ClDHcSuBejq2IOvjZgGa7a8lUMDjxZB/
        oo3YFMHenvhAspWBWYytcdQAdnzAKmAdNUfYez4XyTbZBwXso3PtFOuutlFsw/RHkv1Q3Iqx
        dTeOsc9KLxDslDtmx2KVdIPJaDFzy7KMvHmjRC1DcqksCUnliUlSWYIyLVmukMSnbsjgdNmH
        OFN8aro0q7GpHMvtjj1cPOjCC4FdUgTCaMgkwp5Tw4IiIKTFTBWAFz2/sNAiCj6sGMNDHA5n
        +ouoUGgUwC+TLVRwEc7ooXMgIAhyBLMaTl8enQ/hTCkFa6+W4iHjCQFPvz1FBlMUEwt/172d
        t0VMKqxwVc6fIJgVsL7jDhHkSGYffOm/A0KZJbD98tDcnKbDmJ1w4F5acIwzq+CMoxcP8VLY
        MHblH0fBd0MVWBkQ2xfY9gWKfYFiX6BcBUQ1iOAsvD5Tz8ulvFbPWwyZ0gNGvRvM1eR+S6C+
        ERR93eUBDA0ki0Rtl/xqMak9xOfpPQDSuCRC1JQ4ohaLMrR5+ZzJqDFZdBzvAYq5387h0ZEH
        jHOlM5g1MoVMiZJkygRlwnokiRJ51+WpxEym1szlcFwuZ/rvYXRYdCGoL45MMebTn526PuJg
        g3BSW97sTTv+E1nSe4HtBfBzKg5z3j3Recs7nLL329BRgcN1KW+J43x+oe+kufv1D8P+MtUf
        hWp7t29GqdtqWr4H330mqlATs6lbvTKl4Kwi9lWytWBN6zb59c1P2nMfTNniNDm+5xqbrUTY
        5SnXXZAQfJZWFoebeO1fhulsrDwDAAA=
X-CMS-MailID: 20181113075610eucas1p219d70ccaefd2013d24a27743ed7978bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
        <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
        <20181026144344.27778-18-jagan@amarulasolutions.com>
        <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
        <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
        <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com>
        <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
        <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
        <CAMty3ZDTAiW=Lx2H4WvdsdJRYsVe1CpCJx7D0f7yANx7Lx25PA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.2018 08:32, Jagan Teki wrote:
> On Wed, Nov 7, 2018 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 06.11.2018 19:08, Jagan Teki wrote:
>>> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
>>>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>> On 26.10.2018 16:43, Jagan Teki wrote:
>>>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
>>>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
>>>>>>>
>>>>>>> So, this patch adds DSI specific binding details on existing
>>>>>>> dt-bindings file.
>>>>>>>
>>>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>>>> ---
>>>>>>> Changes for v3:
>>>>>>> - Use existing binding doc and update dsi details
>>>>>>> Changes for v2:
>>>>>>> - none
>>>>>>>
>>>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>> index 35bc0c839f49..b7855dc7c66f 100644
>>>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>> @@ -1,12 +1,39 @@
>>>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>>>>>
>>>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
>>>>>>> +
>>>>>>> +Depending on the variant, the PCB attached to the panel module either
>>>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
>>>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
>>>>>>> +itself
>>>>>> As I understand this is display board, which contains 'pure' RGB panel
>>>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
>>>>>> These are separate devices, just connected by vendor to simplify its
>>>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
>>>>>> panel driver for S070WV20-CT16 - it looks more generic.
>>>>>> Then you can describe both in dts and voila.
>>>>>> Creating drivers for every combo of devices (panel + bridge), just
>>>>>> because some vendor sells them together seems incorrect - we have
>>>>>> devicetree for it.
>>>>> Rob suggested this, and also the opposite: using the same
>>>>> "bananapi,s070wv20-ct16"
>>>>> compatible string for both types of connections, and have the driver deal with
>>>>> detecting the bus type.
>>>>>
>>>>> The thing about the bridge chip is that there's no available datasheet that
>>>>> describes all the parts of the init sequence, in fact none at all. I managed
>>>>> to work out some bits, but the others remain a mystery and must be hard-coded
>>>>> to match the panel. That would work against having a generic bridge driver.
>>>> But it is common for many chips - 1st version of the driver is developed
>>>> on one platform and it supports only one configuration, if next platform
>>>> with the same cheap appears the driver is augmented if necessary.
>>> At-least few of the commands from panel initialization code, the
>>> respective opcode data values are based on panel timings and even
>>> clock value is different in DSI. I think it look hard to try bridge
>>> driver for these restrictions, do you have any suggestions?
>>
>> Where do you see an issue? Since panel is RGB it should have no
>> initialization sequence (beside regulator/gpio power on/off), so the
>> only thing to do is to figure out which regulators/gpios belongs to
>> which component - with publicly available specs it should be doable.
>>
>> The whole initialization sequence is for the bridge, so you put it into
>> bridge driver, for starters it can be hardcoded.
> Yes, I understand we can move regulators/gpio setup separately and
> though we hardcode the init sequence there is difference  in clock for
> DSI(which I mentioned in previous mail). DSI panel can't work with
> clock used by RGB panel-simple.


If you mean pixel clock from timings in next patch it seems incorrect.
Pixel clock should be always

htotal * vtotal * vrefresh, in case of drm_display_mode result should be
divided by 1000 (as .clock is in kHz).

With timings provided there you have: 928*525*60 = 29232000

So pixel clock should be 29232, if other timings are correct. DSI clock
is a different thing and it is private thing of DSI bridge/panel it
should not be exposed via drm_display_mode.


Regards

Andrzej


>
>> Then you can:
>>
>> 1. Try to find other users of this ICN6211 chip and compare
>> initialization sequences to guess purpose of registers.
>>
>> 2. Try to get specs of the chip (ask vendor, distributor, grep Internet).
> As we mentioned (even Chen-Yu), we are unable to find the proper spec
> for this panel, all we taken reference from AW BSP code.
>
>> 3. Do nothing - if there will be other users of the bridge they will do
>> this work.
> Don't know how we can go with generic bridge driver irrespective of
> these particular wrinkles, let me know if you have any suggestions.
>
>

