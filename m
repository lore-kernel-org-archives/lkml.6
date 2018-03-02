Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967993AbeCBQu1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:50:27 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:33666 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965207AbeCBQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:50:24 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301095721.4iga7dcgg566j44m@flea>
 <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
 <20180302143736.kkxx54og2ppcmpzh@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <0d10e2ef-8b7a-3ec2-fb8b-ee72345cbbb1@micronovasrl.com>
Date: Fri, 2 Mar 2018 17:50:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302143736.kkxx54og2ppcmpzh@flea.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 02/03/2018 15:37, Maxime Ripard ha scritto:
> On Fri, Mar 02, 2018 at 12:42:14PM +0100, Giulio Benetti wrote:
>> Hi,
>>
>> Il 01/03/2018 10:57, Maxime Ripard ha scritto:
>>> On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
>>>>    static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
>>>>    	.get_modes	= sun4i_lvds_get_modes,
>>>> +	.mode_valid	= sun4i_lvds_mode_valid,
>>>>    };
>>>
>>> This should be on the encoder, not the connector.
>>
>> I've seen it is bound to connector in rgb and to encoder in hdmi.
>> Is it correct rgb mode_valid under connector funcs?
>> Otherwise I send a patch also for that one.
> 
> This would need to be fixed as well. Bridges attach to encoder, not
> connectors, so if you ever have a bridge connected to the RGB output
> (like on the A13-Olinuxino), mode_valid isn't called at the moment.

Ok, I will do the same for rgb and submit a patchset,
need some time to test both lvds and rgb.

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
