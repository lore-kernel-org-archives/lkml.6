Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E8C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ECE20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="EYHmH0pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ECE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeJAOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:46:18 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:48799 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbeJAOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:46:18 -0400
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 10:46:18 EDT
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1g6tGs-0003Ea-Rs; Mon, 01 Oct 2018 01:09:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0mFflzC3+b76Aonv5G5icDFMk453decShCsyckxwXvg=; b=EYHmH0pipXsvWUtVovrdXaq3kZ
        7X5Q1NpPzUJOm2/b086HGMZMDtXtfvnfTso7mB9qKeweU0SvAR/aR0DHCZI250k+7Z7K8tPOXIF7b
        AhefPXyq9mEOz2JDn2YDr19SIIJU60dOz7c1RkOAqI4cy3JtYQzyDKg/UrRZN3Nxo4PDSi4QbvwD+
        mbv+uJfZqd4Z22eM38s+SmDS0VP6KhSHxsVMjYLL5kcyrVDtLiy2faY/5HXdYtfD+WMTEtBjStxiL
        AHJZy4J9Nz0XPqcxL1S7wqx5s/VSAnAwtj/kL0sV3s8rEL7gddy98j1HVK7FUTKgGI1tmZRcS6bhY
        U5aayquA==;
Received: from [223.237.19.35] (port=14204 helo=[192.168.43.180])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1g6tGi-000iUe-P5; Mon, 01 Oct 2018 04:09:36 -0400
Subject: Re: [linux-sunxi] Re: [PATCH 06/12] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
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
 <20180927114850.24565-7-jagan@amarulasolutions.com>
 <20180927152126.vovnvwmqdfpuxgdm@flea>
 <CAMty3ZABx9Fod5W_T7JciZEsn7jGvuM-LsBFATdA=hQ2CVwELw@mail.gmail.com>
 <20180929135302.ymdzapz5npvapti2@flea>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <63b40c20-670b-1c53-bf5e-62f64e6e02f0@openedev.com>
Date:   Mon, 1 Oct 2018 13:39:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929135302.ymdzapz5npvapti2@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hQobFtKNA//mjbleNTKjz1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7zDil9nzpwm+X/neb6NqWhvt8C9mOBdONdnsxgsk1D2p81t61bzOH+dRuda
 OCHhfvkbONHJki/bT3w/adEN9DqaPbFM3vei53Yyp3v779HcSLG62plOzR5DsoLGZCSqoE3JNAYC
 28t8cR5ITCXTcZqmvaqpXrmasHx4eiR7j6vX9B9laqTmco/p+9en7IdA6p9E/g67cwxyIR8VmA5e
 WtNvnSJzSMipXLKj208wF0l+/LRpsq1uynJlGc1wGBNxKAasUDAM310p3PNWWaIaSygi7PgEVsGe
 cFro/0JGrOyRSaDNUgpG8fAJ7Lg21L451C+Y73wey0WZIByhkSafuhnLcy3brt7kvrJyGkSOIbze
 Phts3vFtUDOwEYF9reFkRh1Z2XmZE6Ulo3Sg6/fHCWNx01dKq9doQCQL/RyDC8HpXAynucv4rnju
 YPOfZh8jslwg7QT+iN5/VyfWKR5edUF17qyCLW5GY4F23J7eq8SL0BtM8UT3jCT30WOGa77ANY69
 cBNhkoiRE9GgA7DbpeRaXeO0Hg/cLwycMnvIieVWIs4dJKDqjPjhvPjqAjKg6VeiSiHqKnOM6HUc
 1C6txUOgA50Rgoi231VkAC4d/u07DCMMQ72GN0COt/Z36GxUDe1/x2bFJS+Hj6rj4u8HaEmUvqOm
 FuO+t4VfdYX5HF0Jd/Quc8Wou4TIK4Bcb6TQCr94GXpVQ2KwGtu81JXrQcgqRYMJqVDlz3D3q3rG
 z4wpqXduuWzX2YNPcyspnKOz/GpVtBEI/lNmY9JL/ej0hsKuKmLtSOgDyocRXs5/Dj5QrbiOquAw
 kPRjlgIoLaXIRRdYY1xob1S/a4Rw9BKeg+GlaQRG0qurVqDgRPCOBb4ws+nK6Hdu5ythdss+87CL
 YnNBoGfS0DhK3BfvFNI4fRpBbmGFHU0Fd1FYwiLqVhSu3v+nCpyCSdscG09FH1xvLyyjtb2gYbxM
 T6+Iy9pOFZK275ou5bBvQX3uElphnHsYcHZLfQ+dkTJQ3t6fkiyQeQV6EipRzMVZ5LqwTx7Vvn9S
 VCuiP+10HNhHuWYhdKNkJvfZdFJiZZPY9MnZD1O5yq0pWWScINzg4dgw5iDGlYGqF8vXDOId4ZvF
 xjFOs0DvEGYfBtA7NQTMLOZX0MM27/fUsuiVMUz2osEFaYRxsB6RP1WtefrqFnxOMi6sKMFKy5Lq
 LFUIM7si3XKl+gouHE7VOEtHO7BXRk+kb0Ie3l6uI43eRHGnZHBV/yCqCu6qSGtTjyILXkKxOPov
 txRJN5kteXJGNpNt4GbSsOU/9v/KnSUfEaFbXfx3YmWV3Eu1dd5T48p+m8Gi9mpWQ6cJTOhMhoTy
 AjQts04eAyoaGqs2BxWyJ5iZ/mYkQw5Sva7E5XuqpjkxjsxX7/OU+X56MDbCOXzqrgeRjh9HHXX0
 2BXFZ0oSYx0xwIlnSxHDnJq+tjf1ariSumYaswHs71h51UM9FqN9xH7aeMYHGsZ/4QaVkaMLBQ2N
 o2eCxS3UTYtuZQ==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 September 2018 07:23 PM, Maxime Ripard wrote:
> On Thu, Sep 27, 2018 at 09:50:34PM +0530, Jagan Teki wrote:
>> On Thu, Sep 27, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 05:18:44PM +0530, Jagan Teki wrote:
>>>> According to horizontal and vertical timings are defined
>>>> per the diagram from include/drm/drm_modes.h
>>>>
>>>> Back porch = [hv]total - [hv]sync_end
>>>>
>>>> So, update SUN6I_DSI_BASIC_SIZE0_VBP calculation as
>>>> mode->vtotal - mode->vsync_end
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> index 1c7e42015645..599284971ab6 100644
>>>> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> @@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>>>>        regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
>>>>                     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
>>>>                                               mode->vsync_start) |
>>>> -                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
>>>> -                                            mode->vdisplay));
>>>> +                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
>>>> +                                            mode->vsync_end));
>>>
>>> Is it purely theoretical, or did you find some source that back that?
>>
>> VSA is done as per that, sync_end - sync start would give sync time.
> 
> That's a different register though.
> 
>> VBP also done in BPI-M64-bsp[1] which results back porch existing code
>> results fron porch.
>>
>> [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L955
> 
> That code does back porch - sync length. Such a calculation doesn't
> make much sense as is, but you're saying that it results in the front
> porch. Again, what makes you say that?

No what code shows is not a real back porch value used for drm it's 
panel back porch value which is a DTS property in BSP.
(I made wrong comment on previous mail as front porch, sorry)

here is the real code

from drivers/video/sunxi/disp2/disp/de/disp_lcd.c
timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;


u32 vbp = panel->lcd_vbp;
u32 vspw = panel->lcd_vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;

So,

dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;

=>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
=>  timmings->ver_back_porch
=>  mode->vtotal - mode->end

VSA, which a proper value.

dsi_dev[sel]->dsi_basic_size0.bits.vsa = vspw;
=> panel_info->lcd_vspw;
=> timmings->ver_sync_time
=> mode->vsync_end - mode->vsync_start
