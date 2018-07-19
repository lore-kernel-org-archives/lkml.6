Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeGSNx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:53:29 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:59180 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731126AbeGSNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:53:29 -0400
Received: from lanttu.localdomain (unknown [IPv6:2001:1bc8:1a6:d3d5::e1:1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 916CA634C83;
        Thu, 19 Jul 2018 16:10:21 +0300 (EEST)
Received: from sailus by lanttu.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@iki.fi>)
        id 1fg8hI-0006Or-T6; Thu, 19 Jul 2018 16:10:20 +0300
Date:   Thu, 19 Jul 2018 16:10:20 +0300
From:   sakari.ailus@iki.fi
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, jacopo mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 2/3] media: ov772x: use SCCB regmap
Message-ID: <20180719131019.2kolodvc4r5ewqic@lanttu.localdomain>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <20180719074736.GA6784@w540>
 <20180719084208.4zdwt4vzcop4hve7@ninjato>
 <2173334.CLADOdgFxd@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2173334.CLADOdgFxd@avalon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:14:06PM +0300, Laurent Pinchart wrote:
> On Thursday, 19 July 2018 11:42:08 EEST Wolfram Sang wrote:
> > > > -static int ov772x_mask_set(struct i2c_client *client, u8  command, u8 
> > > > mask,
> > > > -			   u8  set)
> > > > -{
> > > > -	s32 val = ov772x_read(client, command);
> > > > -
> > > > -	if (val < 0)
> > > > -		return val;
> > > > -
> > > > -	val &= ~mask;
> > > > -	val |= set & mask;
> > > > -
> > > > -	return ov772x_write(client, command, val);
> > > > -}
> > > > -
> > > 
> > > If I were you I would have kept these functions and wrapped the regmap
> > > operations there. This is not an issue though if you prefer it this
> > > way :)
> > 
> > I have suggested this way. It is not a show stopper issue, but I still
> > like this version better.
> 
> Wrapping the regmap functions minimizes the diff and makes it easier to 
> backport the driver.

May be, but using the regmap functions directly makes the driver cleaner.
Most drivers have some kind of wrappers around the I²C framework (or
regmap) functions; this one is one of the few to get rid of them.

The two could be done in a separate patch, too, albeit I think the current
one seems fine as such.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
