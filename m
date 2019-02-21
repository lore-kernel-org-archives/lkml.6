Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51732084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfBUQsI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:48:08 -0500
Received: from muru.com ([72.249.23.125]:40126 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBUQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:48:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E74580C8;
        Thu, 21 Feb 2019 16:48:17 +0000 (UTC)
Date:   Thu, 21 Feb 2019 08:48:03 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20190221164803.GX15711@atomide.com>
References: <20180922094405.4067-1-andreas@kemnade.info>
 <20190220223132.GV15711@atomide.com>
 <20190221170840.5c970def@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190221170840.5c970def@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190221 16:43]:
> Hi,
> 
> On Wed, 20 Feb 2019 14:31:32 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [180922 09:48]:
> > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > the counter will be incremented but the resume callback not called,
> > > so enumeration and charging will not start properly.
> > > To avoid that happen, disable irq on suspend and recheck on resume.
> > > 
> > > Practically this happens when the device is woken up from suspend by
> > > plugging in usb.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v2:
> > > * use pm suspend/resume callback instead of delayed_work
> > >   as suggested by Dmitry  
> > 
> > Hmm it just occurred to me that this issue too might be fixed with commit
> > c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
> > for suspend"). Andreas, care to check? That is if this is still an
> > issue.
> > 
> this one made already its way into 4.20. But for the records, I will
> build the latest 5.0-rc and revert it and will check if the problem
> still occurs.

OK thanks.

> I do not think the patch you mentioned has something to do with this
> because here solely the problem is about things happen on resume.

OK

> But on gta04 we had several irregular behavior regarding to actions
> on the other i2c bus where all the sensors and touchscreen are located.
> It happens rarely and most often when I am not up to debugging it.
> So maybe your patch helps there.

Yeah maybe, it's worth checking :)

Regards,

Tony
