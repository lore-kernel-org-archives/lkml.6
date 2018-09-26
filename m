Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E5BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E020843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7E020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeIZOFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:05:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:38217 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbeIZOFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:05:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 00:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,305,1534834800"; 
   d="scan'208";a="72957639"
Received: from jmoran2-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.26.29])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2018 00:54:07 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id AF10921E18; Wed, 26 Sep 2018 10:54:06 +0300 (EEST)
Date:   Wed, 26 Sep 2018 10:54:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [PATCH 1/2] [media] imx214: Add imx214 camera sensor driver
Message-ID: <20180926075406.2rvwaxmdk6jsluas@kekkonen.localdomain>
References: <20180921085450.19224-1-ricardo.ribalda@gmail.com>
 <20180921092833.c3bznrhc3yyarmq4@kekkonen.localdomain>
 <CAPybu_2J4b8C_AQu5trH6fLG3FAkSvFiUOYt-HFwG+YXK9PkkQ@mail.gmail.com>
 <20180924203252.wxeclgjc7zvepyhb@kekkonen.localdomain>
 <CAPybu_3WF3x42k814dvEwqrMMfaxt2s4OpuK3BGMobBfmsgQ5Q@mail.gmail.com>
 <CAPybu_0quOqpSrCooOgesnsZBSL1vthmff4SmPdY2=_VvTch5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_0quOqpSrCooOgesnsZBSL1vthmff4SmPdY2=_VvTch5g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ricardo!

On Wed, Sep 26, 2018 at 08:06:55AM +0200, Ricardo Ribalda Delgado wrote:
> Hi Sakari
> On Wed, Sep 26, 2018 at 7:26 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> >
> > Hello Sakari
> > On Mon, Sep 24, 2018 at 10:32 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Fri, Sep 21, 2018 at 12:15:55PM +0200, Ricardo Ribalda Delgado wrote:
> > > ...
> > > > > > +static struct reg_8 mode_1920x1080[];
> > > > > > +static struct reg_8 mode_4096x2304[];
> > > > >
> > > > > Const. Could you rearrange the bits to avoid the forward declarations?
> > > > Const done, but I prefer to keep the forward declaration. Otherwise
> > > > the long tables will "hide" the mode declaration.
> > >
> > > Well, I guess the long tables do "hide" a bunch of other stuff, too. :-)
> > > But... I agree there's no trivial way around those tables either.
> > >
> > > It appears I'm not the only one who's commented on the matter of the
> > > forward declaration.
> >
> > Ok, I will change it, Eppur si muove  ;)
> > >
> > > ...
> > >
> > > > > > +static int imx214_probe(struct i2c_client *client)
> > > > > > +{
> > > > > > +     struct device *dev = &client->dev;
> > > > > > +     struct imx214 *imx214;
> > > > > > +     struct fwnode_handle *endpoint;
> > > > > > +     int ret;
> > > > > > +     static const s64 link_freq[] = {
> > > > > > +             (IMX214_DEFAULT_PIXEL_RATE * 10LL) / 8,
> > > > >
> > > > > You should check the link frequency matches with that from the firmware.
> > > >
> > > > I am not sure what you mean here sorry.
> > >
> > > The system firmware holds safe frequencies for the CSI-2 bus on that
> > > particular system; you should check that the register lists are valid for
> > > that frequency.
> > >
> 
> Can you point me to a driver that does this? Just for the example. Thanks

The imx319 driver:

<URL:https://patchwork.linuxtv.org/patch/52233/>

> > I am with you here. The i2c controller is a different driver but is
> > integrated with camss. Checkout
> > https://patchwork.kernel.org/patch/10569961/ I am interacting with
> > Todor and Vinod to enable the i2c port indepently with camss. At least
> > now it does not kill the port after an i2c timeout :)

Nice!!

-- 
Cheers,

Sakari Ailus
sakari.ailus@linux.intel.com
