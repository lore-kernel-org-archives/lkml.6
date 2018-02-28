Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeB1Qe2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:34:28 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:36994 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbeB1QeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:34:25 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside
 encoder init functions
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180228155559.lqm22dzeiptrwyxe@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <ee7bff10-527a-5481-598b-47e1d7a9eeb6@micronovasrl.com>
Date: Wed, 28 Feb 2018 17:34:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228155559.lqm22dzeiptrwyxe@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 28/02/2018 16:55, Maxime Ripard ha scritto:
> Hi,
> 
> On Wed, Feb 28, 2018 at 01:51:58PM +0100, Giulio Benetti wrote:
>> sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
>> so it finds dclk_min_div and dclk_max_div set to 0 and fails
>> adding crtc.
>>
>> Move dclk_min_div and dclk_max_div to encoders init functions.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> I sent a similar patch there:
> https://lists.freedesktop.org/archives/dri-devel/2018-February/166666.html

I've missed that.
And where you put it is better, since it's called every time set_mode is 
called.

On lvds instead I don't see anything about this,
it should have the same potential problem.
Also I can't understand why it has been set min=7 and max=7 on lvds.
With those values I would obtain 77Mhz only.
And I can't find values on datasheet for minimum and maximum.

> 
> I guess eventually, we'll want to remove the usage of the clock
> framework entirely, but it's not really the scope of a fix.

Where would you handle dclk instead of tcon?

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> Maxime
> 
