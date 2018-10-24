Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C13ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB4D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kY2XwqVm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kr8QgGnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB4D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJYDB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:01:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJYDB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:01:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F18F60C1B; Wed, 24 Oct 2018 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540405969;
        bh=r6fIr463GEoNFeFvkNBPZR8bR9memTwKtKrXmoWTUIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kY2XwqVmTl/sBxBoBhOuRNmwLJFHqev/6tsrC85EKHfeoA4sNmmXk0P1WwM6kUHku
         veXoJZEK4CjR/UG/clQEMrsPvPM5C6XqBqf6SimFbbHJbftG8pbLmKBGMQKlqBenK1
         aZvh+9OjrBRG3sSHFtvPJ6pHyiFoEVeuIUUFiVHs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D9C7360C1B;
        Wed, 24 Oct 2018 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540405967;
        bh=r6fIr463GEoNFeFvkNBPZR8bR9memTwKtKrXmoWTUIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kr8QgGnrpQv4NKCDgX+4s9dDPFbPZWvmsPeQcb0X6xzlHXhkk3oN+XkMYrS2PYeqo
         Cq9JfIR+79fKZmdtTbKZ7Ol/9II7P5eLJj211a218WJBEJvjcXk5dnmS1i5U6aBprP
         R6OigEb3s9qKeMkuuVgt86SVKcaQYyKOGDee/9B4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 00:02:47 +0530
From:   spanda@codeaurora.org
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>, linux-arm-msm@vger.kernel.org,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Allow DT to set "HPD delay"
In-Reply-To: <20181019201940.138179-2-dianders@chromium.org>
References: <20181019201940.138179-1-dianders@chromium.org>
 <20181019201940.138179-2-dianders@chromium.org>
Message-ID: <9d5b42b94772fb3adb86e20eff72cd88@codeaurora.org>
X-Sender: spanda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-20 01:49, Douglas Anderson wrote:
> Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
> ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
> reason we needed that mystery delay is that we weren't paying
> attention to HPD.
> 
> Looking at the datasheet for the same panel that was tested for the
> original commit, I see there's a timing "t3" that times from power on
> to the aux channel being operational.  This time is specced as 0 - 200
> ms.  The datasheet says that the aux channel is operational at exactly
> the same time that HPD is asserted.
> 
> Scoping the signals on this board showed that HPD was asserted 84 ms
> after power was asserted.  That very closely matches the magic 70 ms
> delay that we had.  ...and actually, in my esting the 70 ms wasn't
> quite enough of a delay and some percentage of the time the display
> didn't come up until I bumped it to 100 ms.
> 
> To solve this, we tried to hook up the HPD signal in the bridge.
> ...but in doing so we found that that the bridge didn't report that
> HPD was asserted until ~280 ms after we powered it (!).  This is
> explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
> (Hot Plug/Unplug Detection)".  Reading there we see that the bridge
> isn't even intended to report HPD until 100 ms after it's asserted.
> ...but that would have left us at 184 ms.  The extra 100 ms
> (presumably) comes from this part in the datasheet:
> 
>> The HPD state machine operates off an internal ring oscillator. The
>> ring oscillator frequency will vary [ ... ]. The min/max range in
>> the HPD State Diagram refers to the possible times based off
>> variation in the ring oscillator frequency.
> 
> Given that the 280 ms we'll end up delaying if we hook up HPD is
> _slower_ than the 200 ms we could just hardcode, for now we'll solve
> the problem by just allowing boards to hardcode a value.  If someone
> using this part finds that they can get things to work more quickly by
> actually hooking up HPD that can always be a future patch.
> 
> One last note is that I tried to solve this through another way: In
> ti_sn_bridge_enable() I tried to use various combinations of
> dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
> was up.  In theory that would let me detect _exactly_ when I could
> continue and do link training.  Unfortunately even if I did an aux
> transfer w/out waiting I couldn't see any errors.  Possibly I could
> keep looping over link training until it came back with success, but
> that seemed a little overly hacky to me.
> 

Thanks for very detailed explanation.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 45 ++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index f8a931cf3665..5deed667480c 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -93,6 +93,7 @@ struct ti_sn_bridge {
>  	struct clk			*refclk;
>  	struct drm_panel		*panel;
>  	struct gpio_desc		*enable_gpio;
> +	int				panel_hpd_delay_ms;
>  	struct regulator_bulk_data	supplies[SN_REGULATOR_SUPPLY_NUM];
>  };
> 
> @@ -459,16 +460,37 @@ static void ti_sn_bridge_enable(struct drm_bridge 
> *bridge)
>  	int ret;
> 
>  	/*
> -	 * FIXME:
> -	 * This 70ms was found necessary by experimentation. If it's not
> -	 * present, link training fails. It seems like it can go anywhere 
> from
> -	 * pre_enable() up to semi-auto link training initiation below.
> +	 * The timing diagram of some eDP panels says that you're supposed to
> +	 * wait for HPD to be asserted before the aux channel is operational.
>  	 *
> -	 * Neither the datasheet for the bridge nor the panel tested mention 
> a
> -	 * delay of this magnitude in the timing requirements. So for now, 
> add
> -	 * the mystery delay until someone figures out a better fix.
> +	 * While we could configure the bridge to report the HPD signal to us
> +	 * and add a delay here until the HPD is asserted, it turns out 
> that's
> +	 * slower than just hardcoding the max delay from the panel in some
> +	 * cases.  Why?
> +	 *
> +	 * The sn65dsi86 datasheet says that it only reports the debounced
> +	 * HPD signal to software.  It will tell software about HPD assertion
> +	 * as quickly as 100 ms after it's asserted, but sometimes it might
> +	 * take 400 ms because it's timed with a very inaccurate ring
> +	 * oscillator.  In practice it was measured at 200 ms on at least
> +	 * one system.
> +	 *
> +	 * On a particular panel, HPD was asserted 84 ms after power was 
> given.
> +	 * This same panel specified that HPD would always be asserted within
> +	 * 200 ms of applying power.  Thus on this panel with the measured
> +	 * 84 ms to assert HPD + the 200 ms measured debounce we'd wait 284 
> ms
> +	 * which is 84 ms longer than just hardcoding the sleep.
> +	 *
> +	 * For now we don't know of any cases where paying attention to HPD
> +	 * is better than hardcoding the value.  Thus for now only support 
> the
> +	 * hardcoded delay and print a warning if it wasn't specified.  Later
> +	 * one could imagine improving the driver to enable HPD support if
> +	 * panel-hpd-delay-ms wasn't specified in the device tree.
>  	 */
> -	msleep(70);
> +	if (pdata->panel_hpd_delay_ms >= 0)

Is Zero a valid option here, msleep(0) ?


> +		msleep(pdata->panel_hpd_delay_ms);
> +	else
> +		DRM_WARN("HPD not supported; consider a hardcoded delay\n");
> 
>  	/* DSI_A lane config */
>  	val = CHA_DSI_LANES(4 - pdata->dsi->lanes);
> @@ -656,6 +678,7 @@ static int ti_sn_bridge_probe(struct i2c_client 
> *client,
>  {
>  	struct ti_sn_bridge *pdata;
>  	int ret;
> +	u32 val;
> 
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		DRM_ERROR("device doesn't support I2C\n");
> @@ -712,6 +735,12 @@ static int ti_sn_bridge_probe(struct i2c_client 
> *client,
>  	if (ret)
>  		return ret;
> 
> +	if (!of_property_read_u32(pdata->dev->of_node,
> +				  "ti,panel-hpd-delay-ms", &val))
> +		pdata->panel_hpd_delay_ms = val;
> +	else
> +		pdata->panel_hpd_delay_ms = -1;

Same comment as above.
> +
>  	pm_runtime_enable(pdata->dev);
> 
>  	i2c_set_clientdata(client, pdata);
