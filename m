Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB44C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709E021473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCR2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:28:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:27608 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeJCR2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:28:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 03:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,335,1534834800"; 
   d="scan'208";a="269109480"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2018 03:40:33 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id CFD7120804; Wed,  3 Oct 2018 13:40:32 +0300 (EEST)
Date:   Wed, 3 Oct 2018 13:40:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>, jacopo@jmondi.org
Subject: Re: [PATCH v3 2/2] [media] imx214: Add imx214 camera sensor driver
Message-ID: <20181003104032.gesivjmiwf364ot3@paasikivi.fi.intel.com>
References: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
 <20181002133058.12942-2-ricardo.ribalda@gmail.com>
 <20181002162438.zia2pwztd6vuqme2@paasikivi.fi.intel.com>
 <CAPybu_1B+zAasFuiRrhByXaVGz6KfuBxXJYWRwBM-CL8Bh6C=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_1B+zAasFuiRrhByXaVGz6KfuBxXJYWRwBM-CL8Bh6C=g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, Oct 03, 2018 at 09:17:56AM +0200, Ricardo Ribalda Delgado wrote:
> HI Sakari
> 
> Thanks a lot for your review!
> 
> On Tue, Oct 2, 2018 at 6:27 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > > +static int imx214_s_power(struct v4l2_subdev *sd, int on)
> > > +{
> > > +     struct imx214 *imx214 = to_imx214(sd);
> > > +     int ret = 0;
> > > +
> > > +     on = !!on;
> > > +
> > > +     if (imx214->power_on == on)
> > > +             return 0;
> > > +
> > > +     if (on)
> > > +             ret = imx214_set_power_on(imx214);
> > > +     else
> > > +             imx214_set_power_off(imx214);
> > > +
> > > +     imx214->power_on = on;
> > > +
> > > +     return 0;
> >
> > Using runtime PM would relieve you of this function.
> 
> Tried using runtime PM, but did not manage to get it working with the
> qcom i2c driver. Will try again when this is merged on a separated
> patch.

Interesting. With runtime PM, also the parent device will be powered on
automatically. Usually that's what's needed after all.

Could you post the changes you made?

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
