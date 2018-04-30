Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeD3HGv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:06:51 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:33848 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeD3HGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:06:50 -0400
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
 <2055912.iuafLNK0IC@amdc3058>
 <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <cd513378-7be2-a5eb-adc5-bf04c789f1d4@ti.com>
Date: Mon, 30 Apr 2018 10:06:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/18 21:12, Aaro Koskinen wrote:

>> You should be targeting omapdrm driver instead, fbdev subsystem is closed
>> for the new hardware support.
> 
> AFAIK, based on N950 display support discussion, it's impossible to get
> anything new into omapdrm for a long time. And based on Tomi's comments,
> restoring RFBI support with omapfb should be a minor thing.

I was perhaps a bit vague, but I didn't say it should be a minor thing.
I meant that there should be no architectural obstacles in omapfb, and I
think all the generic plumbing to enable N800 display is there in omapfb.

That said, it still needs a real amount of work with the rfbi driver,
the encoder driver and the panel driver on N800 (the encoder and the
panel driver are not in mainline anymore).

Also, if I remember right, omapfb doesn't support automatic updates (or
"flushing") with manual update displays. omapfb was designed to depend
on the userspace to flush the framebuffer. This may limit its uses.

I personally do think that it would be better to target omapdrm, on top
of the manual update series, but as discussed, the schedule to support
manual update is still unclear.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
