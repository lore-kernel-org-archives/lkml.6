Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD81C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CAF25490
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i4d9ab7a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SgbPxAPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CAF25490
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeFYFyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:54:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeFYFyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:54:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24E26600ED; Mon, 25 Jun 2018 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529906046;
        bh=R3IgmCXxAWbrytAsiDcPPKYrSy4/nZiBPwkhf5mRVos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i4d9ab7azurfbNd/1TNdbzS7JAy8IvF0MKmBqbQirRji3Hmxc16fKoVYjza4jy2gm
         IueIr92Nu9AMeLcSXo04l4sna3rAXvKSGZRJGOEdCocimKUPtgNb6Va1wiVWyNc+Uc
         yYhWxlkHZ2HE8RcEfkEtCaayp+v3sz0grx0DVVdY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 55C13600ED;
        Mon, 25 Jun 2018 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529906045;
        bh=R3IgmCXxAWbrytAsiDcPPKYrSy4/nZiBPwkhf5mRVos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SgbPxAPdR2fN4pAEppxU6rhfT/DUtUQR5OrJO+aXueXW7/Cq5V7W2WvbzcX5SbzXv
         UqcwY6jYgOEzRCUa95yeK4dFfzxB4TQkhdrg3pIwpVDJkDRc4Kg0byid387GIlCHPN
         lAquqIPhDJDQvc0CbvVADAs6vJ5EHs7+mIGq3yeA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jun 2018 11:24:05 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 5/7] backlight: qcom-wled: Add support for WLED4
 peripheral
In-Reply-To: <20180622230903.GM3402@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
 <20180620051417.GI15126@tuxbook-pro>
 <27aa7ff8f7e0cd8fdca5d3ee17bb1ef4@codeaurora.org>
 <20180622230903.GM3402@tuxbook-pro>
Message-ID: <b40a7640af6a99bfbcb0b21025dafd38@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-23 04:39, Bjorn Andersson wrote:
> On Wed 20 Jun 04:00 PDT 2018, kgunda@codeaurora.org wrote:
> 
>> On 2018-06-20 10:44, Bjorn Andersson wrote:
>> > On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
>> >
>> > > WLED4 peripheral is present on some PMICs like pmi8998 and
>> > > pm660l. It has a different register map and configurations
>> > > are also different. Add support for it.
>> > >
>> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> > > ---
>> > >  drivers/video/backlight/qcom-wled.c | 635
>> > > ++++++++++++++++++++++++++++--------
>> > >  1 file changed, 503 insertions(+), 132 deletions(-)
>> >
>> > Split this further into a patch that does structural preparation of
>> > WLED3 support and then an addition of WLED4, the mixture makes parts of
>> > this patch almost impossible to review. Please find some comments below.
>> >
>> Sure. I will split it in the next series.
> 
> Thanks!
> 
>> > >
>> > > diff --git a/drivers/video/backlight/qcom-wled.c
>> > > b/drivers/video/backlight/qcom-wled.c
>> > [..]
>> > >
>> > >  /* WLED3 sink registers */
>> > >  #define WLED3_SINK_REG_SYNC				0x47
>> >
>> > Drop the 3 from this if it's common between the two.
>> >
>> > > -#define  WLED3_SINK_REG_SYNC_MASK			0x07
>> > > +#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
>> > > +#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
>> > >  #define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
>> > >  #define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
>> > >  #define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
>> > > +#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
>> > >  #define  WLED3_SINK_REG_SYNC_ALL			0x07
>> > > +#define  WLED4_SINK_REG_SYNC_ALL			0x0f
>> > >  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>> > >
>> > [..]
>> > > +static int wled4_set_brightness(struct wled *wled, u16 brightness)
>> >
>> > Afaict this is identical to wled3_set_brightness() with the exception
>> > that there's a minimum brightness and the base address for the
>> > brightness registers are different.
>> >
>> > I would suggest that you add a min_brightness to wled and that you
>> > figure out a way to carry the brightness base register address; and by
>> > that you squash these two functions.
>> >
>> There are four different parameters. 1) minimum brightness 2) WLED 
>> base
>> addresses
>> 3) Brightness base addresses 4) the brightness sink registers address
>> offsets also
>> different for wled 3 and wled4. (in wled3 0x40, 0x42, 0x44, where as 
>> in
>> wled4 0x57, 0x67, 0x77, 0x87).
>> 
> 
> Sorry, I must have gotten lost in the defines, I see the difference
> between the two register layouts now. If you retain the old mechanism 
> of
> doing the math openly in the function this would have been obvious.
> 
>> Irrelevant to this patch, but wled5 has some more extra registers to
>> set the brightness.  Keeping this in mind, it is better to have
>> separate functions? Otherwise we will have to use the version checks
>> in the wled_set_brightness function, if we have the common function.
> 
> Okay, so it sounds reasonable to split this out to some degree.
> 
> Regards,
> Bjorn
> --
Thanks for that !
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
