Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1470ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OWLytztZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6057A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJaSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:12:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56700 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:12:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181031091531euoutp01f8c642f26fe90ec25b8c046c415c18e5~iprf1v4yS1830218302euoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:15:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181031091531euoutp01f8c642f26fe90ec25b8c046c415c18e5~iprf1v4yS1830218302euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540977331;
        bh=4fDz7OGglv4jrow0yHk+J4UtIJEdV9FZcKz3xuFdbb4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OWLytztZFRA0Bpig/8ijwRqBdgdTUC1o5AD8tXZ8zmXCbFUgy0j3kcHZ+ktJ9ffgq
         OAhL2y+JsnNuHP5zGUbdCtixCmtswTWreEtBCDAH8MQzlzvfjwpYUB4E36a/wyYDmF
         fdBqeLoGLmJMRFoLuNMM72B4uSkvuwbSJfndBThg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181031091530eucas1p29f9c69be2b9094c4ea55047080f2198a~iprfEYnh53063030630eucas1p2T;
        Wed, 31 Oct 2018 09:15:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.C2.04806.2B279DB5; Wed, 31
        Oct 2018 09:15:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181031091529eucas1p195f3ff765eea90d10e5163f67a0fc2d7~ipreTtRge2940129401eucas1p1z;
        Wed, 31 Oct 2018 09:15:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181031091529eusmtrp19998aeb1ca740ad21103f9da485e80e9~ipreEd8bM1836318363eusmtrp1K;
        Wed, 31 Oct 2018 09:15:29 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b9-5bd972b2a341
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.96.04284.1B279DB5; Wed, 31
        Oct 2018 09:15:29 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181031091528eusmtip299b174501162b178f7bff52cc5a0524b~iprdNlOvR1181011810eusmtip2M;
        Wed, 31 Oct 2018 09:15:28 +0000 (GMT)
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com>
Date:   Wed, 31 Oct 2018 10:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SazBUYRie79z22FpzWoyXbtqmZpgJTc34ukyTqcz5FdWfJl1sOUOTdTmn
        lepHJQzSjS5jR6glCZWlyJRK5VZEF60uGHYakoyQ2ZLJcTT597zP+7zv+zzffCypTWfc2f2R
        BwUxUh+hY9TUvVp78zKL2B7sW9gP+HRzA4ETa78gPHg9DeGcZ800fjs6yODhqx0EHrGcY/C7
        sT4SW3raaDyU1kHjN1VZDP7dXavC+e9bCdzV9wjhxhOJFG5t3IQTHz5T4Ym2Ugrba14RuG+o
        nlrvzJcMddK82T5B8MXZxYgftCaq+Ozio/yd7iKav2/6rOIfnG9geMvNFIav+NlF852n6gi+
        LO8Y//h0BsUPWxYEOe5Qrw0VIvbHCqLPuhB1+MVTNlV0jkfcmZcJ6DgqcU9FLAvcSugo25KK
        HFgtdwPB5fs7UpF6Eo8g+FF+klSKYQRjvwtJWSUPnKxMJZRGAYIq04XpYgBB/9gDWlY5cQYo
        tNpVMnbmPODp9xKVLCK5DAaS3t2aEjGcJ/wpa2dkrOHWQVFWDy17orglYB53k2kXbjskdxZN
        S+ZAQ6aNkiUO3BboaZ9aT3ILoWIgi1SwK3yw5Uz5Aa6FhUvVrxkl5kaITwlUAjjB17pylYLn
        wYuMNErBxyA+8y2pzCYjqDcXMEpjDTyta52yRk5avl3lo9D+UPjxIa2sdwTrwBzFgiOk37tM
        KrQGkpO0inoRdDbdnX5CV8hvGWXOIZ1pRi7TjDCmGWFM/+/mIuomchWMkiFMkFZECoe8Jb1B
        MkaGee+LMljQ5E99MVE3Womqx/fWII5Futmarn3WYC2tj5UOG2oQsKTOWXMxbpLShOoPHxHE
        qD2iMUKQatBcltK5aq5nlwZruTD9QeGAIEQL4r8uwTq4H0fm3MDelSuuiK3qisoAl4I2ryRp
        NVEW6tJtTAj4lfJ8d8y3gD8eQfMX28UvEWe+9+sqPa/1pCWsemL81mfcRjO8LbRx1yXrVr/Z
        tvGsgvPCa1Tt17LzyeYYN5+REIRfnh1NaTIF+QcHJu1svrYhc+niR+vj9zTOgt75eb5be/3T
        P+koKVy/3IsUJf1fRPeM8KUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+85tR2lxWht+rpssu2LTecnPsGFEcKB+ZBFEFrXWSaXNxc4U
        rR8tymJLyxCpDfOSM1Jn5KwsTRKzmWZ2NzVTcWaMMBtmJZq0uYL9e3jf5+Hjg5fGRbdIKZ2e
        YeD0GSqNjAomns+1D26s0/elRHmerkL53R0YynWOATRxMw+g0rZuEr2bmqDQZPkghn44Cij0
        /pcbRw5XD4k8eYMkettYTKGZEacAVX54jaFh92OAOs/kEuh153aU29wmQHM9dQSabn2JIbfn
        GZEkZms9QyRbMT2HsfYSO2AnenMFbIn9FHtnpIZkH1o/CdhHVzoo1lFtotiGn8MkO3SxHWPr
        bafZlvxCgp10rNi1aL88Ua/LNHBhaTresEWWokDRckUCkkfHJsgVMfEHN0fHySKViUc5TXoW
        p49UHpanFV0cFZwoDcu+1HUOGEGt1AyCaMjEwrMPzJgZBNMiphLAsevduH8RAptKx//xEjjb
        Y6b80lcA+8oqKN9iCaOFVb3TAh+LmTD45FutwCfhzFUKlpmqSX/hxKCxfGC+oJj18E993zwL
        GSWsKXZ5JZommNWwYjbUN5Yw++AL923gVxbDDsso4VOCmGTo6pt/C2fWwtmSN7ifV8KG8eJ/
        HAL7R0uxAiCyBtTWgMQakFgDkjJAVAMxl8lrU7W8Qs6rtHxmRqpcrdM6gPdK7jun6x+AN3V7
        WgFDA9lC4bC6N0VEqrL4HG0rgDQuEwuLsr0j4VFVzklOrzukz9RwfCuI837tCi6VqHXem8sw
        HFLEKeJRgiI+Jj5mE5KFCF9G5ewXMakqA3ec405w+v8dRgdJjSAp7/eOAf5gR1qE5Xy3mLd1
        Xt5m0oyHHm6MkcpF6qH0yAVbmxv6w2eS17Vds99bFvFjxrj7y5Edxi7PI25T1+fhNZLfN56E
        W/DvzH0lYVp4IOrmBduNqbsfG6b+FAZfclX3dN6yLS1I6VevEk7al+/Ndx5relXoNlVJEsct
        p/idLTKCT1MpNuB6XvUXXeuHgTsDAAA=
X-CMS-MailID: 20181031091529eucas1p195f3ff765eea90d10e5163f67a0fc2d7
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.2018 09:58, Chen-Yu Tsai wrote:
> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 26.10.2018 16:43, Jagan Teki wrote:
>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
>>>
>>> So, this patch adds DSI specific binding details on existing
>>> dt-bindings file.
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>> Changes for v3:
>>> - Use existing binding doc and update dsi details
>>> Changes for v2:
>>> - none
>>>
>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> index 35bc0c839f49..b7855dc7c66f 100644
>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>> @@ -1,12 +1,39 @@
>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>
>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
>>> +
>>> +Depending on the variant, the PCB attached to the panel module either
>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
>>> +itself
>> As I understand this is display board, which contains 'pure' RGB panel
>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
>> These are separate devices, just connected by vendor to simplify its
>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
>> panel driver for S070WV20-CT16 - it looks more generic.
>> Then you can describe both in dts and voila.
>> Creating drivers for every combo of devices (panel + bridge), just
>> because some vendor sells them together seems incorrect - we have
>> devicetree for it.
> Rob suggested this, and also the opposite: using the same
> "bananapi,s070wv20-ct16"
> compatible string for both types of connections, and have the driver deal with
> detecting the bus type.
>
> The thing about the bridge chip is that there's no available datasheet that
> describes all the parts of the init sequence, in fact none at all. I managed
> to work out some bits, but the others remain a mystery and must be hard-coded
> to match the panel. That would work against having a generic bridge driver.


But it is common for many chips - 1st version of the driver is developed
on one platform and it supports only one configuration, if next platform
with the same cheap appears the driver is augmented if necessary.

Regards

Andrzej


>
> ChenYu
>
>> Regards
>> Andrzej
>>
>>
>>> +
>>>  Required properties:
>>> -- compatible: should be "bananapi,s070wv20-ct16"
>>> +- compatible:
>>> +  for 24-bit RGB interface, use "bananapi,s070wv20-ct16"
>>> +  for ICN6211 MIPI-DSI to RGB bridge, use "bananapi,s070wv20-ct16-icn6211"
>>> +
>>> +Required properties for RGB:
>>>  - power-supply: see ./panel-common.txt
>>>
>>> +Required properties for MIPI-DSI to RGB:
>>> +- reg: for DSI virtual channel used by that screen
>>> +- avdd-supply: analog regulator dc1 switch
>>> +- dvdd-supply: 3v3 digital regulator
>>> +- reset-gpios: a GPIO phandle for the reset pin
>>> +
>>>  Optional properties:
>>> -- enable-gpios: see ./simple-panel.txt
>>> +- enable-gpios: see ./simple-panel.txt(not available in MIPI-DSI to RGB bridge)
>>>  - backlight: see ./simple-panel.txt
>>>
>>>  This binding is compatible with the simple-panel binding, which is specified
>>>  in ./simple-panel.txt.
>>> +
>>> +Example:
>>> +panel@0 {
>>> +     compatible = "bananapi,s070wv20-ct16-icn6211";
>>> +     reg = <0>;
>>> +     avdd-supply = <&reg_dc1sw>;
>>> +     dvdd-supply = <&reg_dldo1>;
>>> +     reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
>>> +     backlight = <&backlight_dsi>;
>>> +};
>>
>

