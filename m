Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE6C65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E72082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="gnLO3GTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5E72082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeJCKJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:09:06 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:45963 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:09:06 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1g7Xk6-0009BO-5m; Tue, 02 Oct 2018 20:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1+rsfaL4+0JUpyeX3w7JnPQECDMypg22Jm7Gh5WCBe0=; b=gnLO3GTDDyZWvM5H1Mm3ql+PYi
        gWRHrGuJqEnSHd15ZOGRs4VxzWe5r8j6Asg3+7ZTDWk/GTwYQmd9g/mLhr0QWrg+a0s6gtq0S6Yj4
        zK861g+JKTPQ6KSQT4Tqprl2r/03wRjPZoBclTja/OyN27jAAHrD3Bx5MciTZ+QtcJ6vmiI33iMKl
        +29J6Y8p3IcCM7Q2zoa9jCAm42f1/Yz59z8l50wMnHNFe0BbmPhhyk5PBfUonuY5znYlLXH9P9jBp
        KK9IDUIlJkhjaJ+Je08LY891ypjhHi5tb3yvknXSDaFTuTO9Dg/Qc8l17rNMWRdIEDtkE/ShOmF4G
        qbH4SE2Q==;
Received: from [27.7.51.1] (port=46186 helo=[192.168.0.10])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1g7Xjr-004LfF-P3; Tue, 02 Oct 2018 23:22:16 -0400
Subject: Re: [linux-sunxi] Re: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix
 TCON DRQ set bits
To:     maxime.ripard@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
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
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com>
 <20180927165853.dpluekbqzat663q7@flea>
 <CAMty3ZDUxqokipNqnn6c618pebdVBWc8Pfzaz+4+SYqR42Yerg@mail.gmail.com>
 <20181002132008.qtatwtbb3ldu75ay@flea>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <45dbebe9-d0bd-4a1c-f8ee-3afd64cf35f9@openedev.com>
Date:   Wed, 3 Oct 2018 08:52:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002132008.qtatwtbb3ldu75ay@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gC00jEDO6ikw1TyIiswBhV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7zDil9nzpwm+X/neb6NqWhvt8C9mOBdONdnsxgsk1D2p81t61bzOH+dRuda
 OCHhfvkbONHJki/bT3w/adEN9DqaPbFM3vei53Yyp3v779HcSLG62plOzR5DsoLGZCSqoE3JNAYC
 28t8cR5ITCXTcZqmvaqpXrmasHx4eiR7j6vX9B9laqTmco/p+9en7IdA6p9E/g67cwxyIR8VmA5e
 WtNvnSJzSMipXLKj208wF0l+/LRpsq1uynJlGc1wGBNxKAasUDAM310p3PNWWaIaSygi7PgEVsGe
 cFro/0JGrOyRSaDNUgpG8fAJ7Lg21L451C+Y73wey0WZIByhkSafuhnLcy3brt7kvrJyGkSOIbze
 Phts3vFtUDOwEYF9reFkRh1Z2XmZE6Ulo3Sg6/fHCWNx01dKq9doQCQL/RyDC8HpXAynucv4rnju
 YPOfZh8jslwg7QT+iN5/VyfWKR5edUF17qyCLW5GY4F23J7eq8SL0BtM8UT3jCT30WOGa77ANY69
 cBNhkoiRE9GgA7DbpeRaXeO0Hg/cLwycMnvIieVWIs4dJKDqjPjhvPjqAjKg6VeiSiHqKnOM6HUc
 1C6txUOgA50Rgoi231VkAC4d/u07DCMMQ72GN0COt/Z36GxUDe1/x2bFJS+Hj6rj4u8HaEmUFFea
 Ix4/vVSo+8WBYHv3R/Quc8Wou4TIK4Bcb6TQCr94GXpVQ2KwGtu81JXrQcgqRYMJqVDlz3D3q3rG
 z4wpqXduuWzX2YNPcyspnKOz/GpVtBEI/lNmY9JL/ej0hsKuKmLtSOgDyocRXs5/Dj5QrbiOquAw
 kPRjlgIoLaXIRRdYY1xob1S/a4Rw9BKeg+GlaQRG0qurVqDgRPCOBb4ws+nK6Hdu5ythdss+87CL
 YnNBoGfS0DhK3BfvFNI4fRpBbmGFHU0Fd1FYwiLqVhSu3v+nCpyCSdscG09FH1xvLyyjtb2gYbxM
 T6+Iy9pOFZK275ou5bBvQX3uElphnHsYcHZLfQ+dkTJQ3t6fkiyQeQV6EipRzMVZ5LqwTx7Vvn9S
 VCuiP+10HNhHuWYhdKNkJvfZdFJiZZPY9MnZD1O5yq1ycjOgLhowTS+P/adv11jhqolFBFG+qwPb
 Jka7IFxibF3lEJ6eq2YzxUsDUmAQ1VjUsuiVMUz2osEFaYRxsB6RP1WtefrqFnxOMi6sKMFKy5Lq
 LFUIM7si3XKl+gouHE7VOEtHO7BXRk+kb0Ie3l6uI43eRHGnZHBV/yCqCu6qSBhrvScipRPhH6Ca
 KplAIvddMUFowKRpR2Sag0odmmn9nSUfEaFbXfx3YmWV3Eu1dd5T48p+m8Gi9mpWQ6cJTOhMhoTy
 AjQts04eAyoaGqs2BxWyJ5iZ/mYkQw5Sva7E5XuqpjkxjsxX7/OU+X56MDbCOXzqrgeRjh9HHXX0
 2BXFZ0oSYx0xwIlnSxHDnJq+tjf1ariSumYaswHs71h51UM9FqN9xH7aeMYHGsZ/4QaVkaMLBQ2N
 o2eCxS3UTYtuZQ==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 October 2018 06:50 PM, Maxime Ripard wrote:
> On Thu, Sep 27, 2018 at 11:15:50PM +0530, Jagan Teki wrote:
>> On Thu, Sep 27, 2018 at 10:28 PM Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
>>>> TCON DRQ set bits for non-burst DSI mode can computed via
>>>> horizontal front porch instead of front porch + sync timings.
>>>>
>>>> Since there no documentation for TCON_DRQ_REG(0x7c) register
>>>> this change is taken as reference from BPI-M64-bsp.
>>>
>>> Detailing more what the issue is would be great.
>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> index 599284971ab6..9918fdb990ff 100644
>>>> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>>>>        struct mipi_dsi_device *device = dsi->device;
>>>>        u32 val = 0;
>>>
>>> The computation here is in the A64 driver:
>>>
>>> if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
>>>          dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode = 0;
>>> } else {
>>>          dsi_dev[sel]->dsi_tcon_drq.bits.drq_set =
>>>                  (panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
>>>                  dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
>>> }
>>>
>>> It is testing that the sync + front porch is smaller than 21, and
>>> otherwise sets the drq.
>>>
>>>> -     if ((mode->hsync_end - mode->hdisplay) > 20) {
>>>
>>> My code here is testing that the difference between hsync_end and
>>> hdisplay is superior to 20, and sets the DRQ if true. The condition is
>>> reversed, but otherwise, that difference is the front porch plus the
>>> sync length.
>>
>> True, I understand this, but does drq setting here is specific to SoC?
>> I thought of finding DRQ in A31 BSP but I couldn't find the code. do
>> you have bsp somewhere in github?
>>
>>>
>>>> +     if ((mode->hsync_start - mode->hdisplay) > 20) {
>>>
>>> However, you are testing for just the front porch, unlike what your
>>> commit log is saying, and unlike what allwinner's code is saying. So
>>> this deserves some explanation.
>>
>> but A64 is doing this, do you think it's completely A64 specific or
>> testing panel with front porch drq?
> 
> See the above code excerpt:
> panel->lcd_ht - panel->lcd_x - panel->lcd_hbp
> 
> This is hsync + front porch. Not the sole front porch. So no, it's not
> doing this.

=> panel->lcd_ht - panel->lcd_x - panel->lcd_hbp

from drivers/video/sunxi/disp2/disp/de/disp_lcd.c
timmings->hor_front_porch= panel_info->lcd_ht-panel_info->lcd_hbp - 
panel_info->lcd_x;

=> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x) - 
panel->lcd_x - panel->hbp
=> timmings->hor_front_porch
=> mode->hsync_start - mode->hdisplay

This is simply a front porch.
