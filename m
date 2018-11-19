Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE1D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TGGztbG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKSUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:12:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54599 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:12:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181119094944euoutp01f2bc50a71a0ce7b350a97e74e4643a6c~ofZylK7p71699816998euoutp01q
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181119094944euoutp01f2bc50a71a0ce7b350a97e74e4643a6c~ofZylK7p71699816998euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542620984;
        bh=hz03rTk2DwEeV1NrRodh61I//NknTFP35F5UIJMKSQg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TGGztbG+m5+rP5hsz/4C1gR0sNg+Wpjmg9LFNRWVbDO6eLdvjYvg1NEmojgu8RcbE
         3f+aAzGtnlhyTQEEEdCrhferSym67O5XSoXFTGN6dswqzpqZORdo0dIXV46/Lfuh2t
         E2xMvRK2tbfjit98lOWd4IbCYCRYG52iRxZyCs0U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181119094942eucas1p27100c21b0eac2ebbdeee74ecae4fe741~ofZxgOvGM1536115361eucas1p2s;
        Mon, 19 Nov 2018 09:49:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.E8.04806.63782FB5; Mon, 19
        Nov 2018 09:49:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181119094941eucas1p1dae153178512b6c9ef5f83678525c4e8~ofZwmLFW21195511955eucas1p1_;
        Mon, 19 Nov 2018 09:49:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181119094941eusmtrp2d1dd48eed31d829059a64b9545fc1a65~ofZwU_Io30633406334eusmtrp2i;
        Mon, 19 Nov 2018 09:49:41 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-be-5bf28736cb12
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.50.04128.53782FB5; Mon, 19
        Nov 2018 09:49:41 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181119094940eusmtip1e79f6b73d950046be87e9e52d3bae9a6~ofZvQ8J2-0562005620eusmtip1a;
        Mon, 19 Nov 2018 09:49:40 +0000 (GMT)
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
Message-ID: <29a2d527-f1cf-208f-b117-086225ee3cd1@samsung.com>
Date:   Mon, 19 Nov 2018 10:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMty3ZD8wOyKJ32-itxshXmNbPs-_yf-S4_AmKcV4YuVX_gHGQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/c5tx9XWcSl7U8kaFl1IiyI+VLpRdCqI7jf/sFUnk9ySLU0L
        siLLbmB2dZqamuali6u0mVasoalozZzZzTulhYnZipVpzmPkf7/3e5738sDHkopLjCcbpt0v
        6LTqcBUjpYrKHbWz5p/8Fjy78tE0fK62ksBx5R8R7sk+i3CapZbG9fYeBvddbyLwd2MCg20/
        u0hsbG+gce/ZJhq/Kklh8O+2cgm+8dpK4JauJwhXHY2jsLVqGY4rs0jwQEMhhR3mFwTu6n1O
        LXLnb/U203ymY4DgC1ILEN/TGCfhUwsO8Xfb8mneZPgg4UvPVzK8Me8Uwxf/aKH55jMVBH8v
        K5Z/eu4CxfcZJ66Rb5MG7RLCw6IEnf+C7dI9Zf1tkojjc6MTLcnEEeSYfhq5ssDNg9J3SdRp
        JGUV3E0ENdarlFNQcN8RpNncRKEPQUPDL+ZfR2Z6Py0KOQjS+00SsehGkP2iCjld4zkN5DY6
        JE5252bCj6QvjNNEcmcYyC1MJ5wCw02HP/feDI+VcQvg+u/btJMpbgqYrh0fZg9uC8Q35494
        3KAyqWP4PlduLTy+mzL8TnI+UNydQoqshLcdaYRzGXD1LOTUDQ4J7FCxFJLvq8QI4+FzxX2J
        yN4waEojRI6FY0n1pNgbj+B5Zs5I5kB4VmGlnXPIoaPvlPiLz4sh910ZLY6XQ2O3m3iCHBKL
        roxslUH8CYXongzNNQ9IkZVw46WdSUAqw6hghlFhDKPCGP7vTUdUHlIKkXpNqKCfqxUO+OnV
        Gn2kNtRv5z6NEQ191uqBCvtD9Lh/hxlxLFKNlT219AYraHWUPkZjRsCSKndZ2OZvwQrZLnXM
        QUG3L0QXGS7ozciLpVRK2SGXlmAFF6reL+wVhAhB908lWFfPI+jojo2fvgbavL0T6y7atb5y
        pfWKv+84lfnlOsPlTU9aY8dYSqjJCUtXrurbsMRjw8JnjsMRLiHS1PfyxR0rWJ/YkAhz9t6L
        AdFB7buT1/uVe7ngnUrfjOqSHrtL9ULbq9t3AraWXrrcmbHaR00FTM1a3nVh+6QaW+uDCXWF
        Hnn5kZ0mFaXfo54zg9Tp1X8BCEBmZqgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xu7qm7Z+iDVq3qlr0njvJZNF67Bmj
        xftlPYwW84+cY7W48vU9m8XnhfeYLL5smsBmcfX7S2aLTY+vsVp87LnHanF51xw2i9+PjrFb
        LL1+kcniwcv9jBanGltZLC6ecrVo3XuE3eLftY0sFj8PnWeyePnxBIuDiMfaj/dZPRb//Mfk
        sWbeGkaP9zda2T3mran22PBoNavHzll32T32TDzJ5rFpVSebx/ZvD1g97ncfZ/LYvKTe40Dv
        ZBaPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL
        9O0S9DL2/nnEXtBiXDHpyGymBsafml2MnBwSAiYSixf8YQWxhQSWMkpsPlgEEReX2D3/LTOE
        LSzx51oXWxcjF1DNa0aJhgvPWEASwgK5Eitv/GQHsUUEtCW+zXwNVsQs0MsmsXFBLzNExy5W
        ifeTGphAqtgENCX+br7JBmLzCthJLPy9Dmw1i4CqxM65LWC2qECExNmX6xghagQlTs58AraN
        UyBQYt+GOWC9zALqEn/mXWKGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWM
        IqmlxbnpucVGesWJucWleel6yfm5mxiByWTbsZ9bdjB2vQs+xCjAwajEw3vgyMdoIdbEsuLK
        3EOMEhzMSiK8meGfooV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5jo8kriDU0NzS0sDc2N
        zY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MEbuEn0UYqr9v9Ze7tz93+1q09WSFpY3
        //3A4qRVn2ZdoH27/Yq7KVuaE0u3CPdqA+UzD/Z3njgpEVeZJvnhjvWb17t2bX689MaTI0d5
        mjvkFb2P39r8ou+vn9j8KVu2JYRmv/lT9ZnVjKF8m8Ku3z3fZm1Xln5woKD3Zrmfht0qnm+3
        02wnP1FiKc5INNRiLipOBACJeq/kPAMAAA==
X-CMS-MailID: 20181119094941eucas1p1dae153178512b6c9ef5f83678525c4e8
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
        <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
        <CAMty3ZD8wOyKJ32-itxshXmNbPs-_yf-S4_AmKcV4YuVX_gHGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2018 19:20, Jagan Teki wrote:
> On Tue, Nov 13, 2018 at 1:26 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 10.11.2018 08:32, Jagan Teki wrote:
>>> On Wed, Nov 7, 2018 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 06.11.2018 19:08, Jagan Teki wrote:
>>>>> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
>>>>>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>>>> On 26.10.2018 16:43, Jagan Teki wrote:
>>>>>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
>>>>>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
>>>>>>>>>
>>>>>>>>> So, this patch adds DSI specific binding details on existing
>>>>>>>>> dt-bindings file.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>>>>>> ---
>>>>>>>>> Changes for v3:
>>>>>>>>> - Use existing binding doc and update dsi details
>>>>>>>>> Changes for v2:
>>>>>>>>> - none
>>>>>>>>>
>>>>>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>>>>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>>>> index 35bc0c839f49..b7855dc7c66f 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>>>>>> @@ -1,12 +1,39 @@
>>>>>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>>>>>>>
>>>>>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
>>>>>>>>> +
>>>>>>>>> +Depending on the variant, the PCB attached to the panel module either
>>>>>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
>>>>>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
>>>>>>>>> +itself
>>>>>>>> As I understand this is display board, which contains 'pure' RGB panel
>>>>>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
>>>>>>>> These are separate devices, just connected by vendor to simplify its
>>>>>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
>>>>>>>> panel driver for S070WV20-CT16 - it looks more generic.
>>>>>>>> Then you can describe both in dts and voila.
>>>>>>>> Creating drivers for every combo of devices (panel + bridge), just
>>>>>>>> because some vendor sells them together seems incorrect - we have
>>>>>>>> devicetree for it.
>>>>>>> Rob suggested this, and also the opposite: using the same
>>>>>>> "bananapi,s070wv20-ct16"
>>>>>>> compatible string for both types of connections, and have the driver deal with
>>>>>>> detecting the bus type.
>>>>>>>
>>>>>>> The thing about the bridge chip is that there's no available datasheet that
>>>>>>> describes all the parts of the init sequence, in fact none at all. I managed
>>>>>>> to work out some bits, but the others remain a mystery and must be hard-coded
>>>>>>> to match the panel. That would work against having a generic bridge driver.
>>>>>> But it is common for many chips - 1st version of the driver is developed
>>>>>> on one platform and it supports only one configuration, if next platform
>>>>>> with the same cheap appears the driver is augmented if necessary.
>>>>> At-least few of the commands from panel initialization code, the
>>>>> respective opcode data values are based on panel timings and even
>>>>> clock value is different in DSI. I think it look hard to try bridge
>>>>> driver for these restrictions, do you have any suggestions?
>>>> Where do you see an issue? Since panel is RGB it should have no
>>>> initialization sequence (beside regulator/gpio power on/off), so the
>>>> only thing to do is to figure out which regulators/gpios belongs to
>>>> which component - with publicly available specs it should be doable.
>>>>
>>>> The whole initialization sequence is for the bridge, so you put it into
>>>> bridge driver, for starters it can be hardcoded.
>>> Yes, I understand we can move regulators/gpio setup separately and
>>> though we hardcode the init sequence there is difference  in clock for
>>> DSI(which I mentioned in previous mail). DSI panel can't work with
>>> clock used by RGB panel-simple.
>>
>> If you mean pixel clock from timings in next patch it seems incorrect.
>> Pixel clock should be always
>>
>> htotal * vtotal * vrefresh, in case of drm_display_mode result should be
>> divided by 1000 (as .clock is in kHz).
>>
>> With timings provided there you have: 928*525*60 = 29232000
>>
>> So pixel clock should be 29232, if other timings are correct. DSI clock
>> is a different thing and it is private thing of DSI bridge/panel it
>> should not be exposed via drm_display_mode.
> I understand your point, but in Allwinner case DSI clock which is
> named in tcon block can be computed using clock value from
> drm_display_mode from panel driver.


OK, it sounds like me telling you that 2+2=4 and you answering that you
understand my point but in your case 2+2=5 fits better.

This is nothing about 'my point', this is simple fact that if you have
928*525 pixels (including hidden ones) with refresh rate 60Hz pixelclock
is 29232kHz.


>
> DE -> Mixer -> tcon-> MIPI <--> panel
>
> So, for the value
> - 55MHz panel clock the computed divider for DSI clock in tcon [1] is
> 6 which is proper and working divider
> - 30MHz panel clock the computed divider for DSI clock in tcon [2] is
> 11 which can't work for this specific panel.


Please explain what exactly means "panel clock" and the divider here.

What rate reports modetest -v ...? For this and other panels.

Maybe we can figure out what should be fixed/adjusted.


Regards

Andrzej


>
> I have verified other panels, the divider value work similar to this
> computation and those panels work accordingly.  but this panel case
> the divider computation look weird, so we have used working and know
> clock. I'm thinking since this panel is of DSI to RGB bridge, so it
> may require some higher frequency to work but I've no document to
> confirm the same.
>
> Hope this information help, let me know if you have any inputs.
>
> [1] https://paste.ubuntu.com/p/drvzfHFMtY/
> [2] https://paste.ubuntu.com/p/hz29CTJY2J/
>
>

