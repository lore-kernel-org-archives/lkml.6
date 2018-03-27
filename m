Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeC0PKy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:10:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56023 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbeC0PHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:53 -0400
Date: Tue, 27 Mar 2018 17:07:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org,
        lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/16] rtc: mediatek: convert to use device managed
 functions
Message-ID: <20180327150751.GC22441@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
 <20180323105017.GI3417@piout.net>
 <1522037265.18424.14.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522037265.18424.14.camel@mtkswgap22>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2018 at 12:07:45 +0800, Sean Wang wrote:
> > > -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > > -					   &mtk_rtc_ops, THIS_MODULE);
> > > +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "mt6397-rtc",
> > > +						&mtk_rtc_ops, THIS_MODULE);
> > 
> > You should probably switch to devm_rtc_allocate_device() and
> > rtc_register_device instead of devm_rtc_device_register.
> > 
> 
> Just would like to know something details
> 
> It seems you just encourage me to switch into the new registration
> method and currently devm_rtc_device_register I used for the driver
> shouldn't cause any harm. right?
> 

It will work but it will have to be converted to rtc_register_device
later anyway.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
