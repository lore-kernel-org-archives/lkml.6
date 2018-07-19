Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3380C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pmB/i3jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3380C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeGSM42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:56:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44728 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeGSM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:56:28 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:587:8041:9d00:717d:d1d9:bcc8:c702])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 499D2B7F;
        Thu, 19 Jul 2018 14:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532002414;
        bh=0aW5VaLGXiiIMBeMvMHJoKT5pvIlsJjj3CjhPc2HX+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmB/i3jqAmCQCEdkB3lvnYTEAS8yriN5gftVPp2Hlkj5oVTOwYsOOOndCr3OUaVGT
         sZk3vmHMTTV+FU5ZITtxeICA4WrYGgheZfxmU2vevE86ZuFJgrTKLg8TPab9mzLslv
         TGwUCab3tYsyoMhOEnb+020H1xUSAbczzgU5fHIE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     jacopo mondi <jacopo@jmondi.org>,
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
Date:   Thu, 19 Jul 2018 15:14:06 +0300
Message-ID: <2173334.CLADOdgFxd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180719084208.4zdwt4vzcop4hve7@ninjato>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com> <20180719074736.GA6784@w540> <20180719084208.4zdwt4vzcop4hve7@ninjato>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 19 July 2018 11:42:08 EEST Wolfram Sang wrote:
> > > -static int ov772x_mask_set(struct i2c_client *client, u8  command, u8 
> > > mask,
> > > -			   u8  set)
> > > -{
> > > -	s32 val = ov772x_read(client, command);
> > > -
> > > -	if (val < 0)
> > > -		return val;
> > > -
> > > -	val &= ~mask;
> > > -	val |= set & mask;
> > > -
> > > -	return ov772x_write(client, command, val);
> > > -}
> > > -
> > 
> > If I were you I would have kept these functions and wrapped the regmap
> > operations there. This is not an issue though if you prefer it this
> > way :)
> 
> I have suggested this way. It is not a show stopper issue, but I still
> like this version better.

Wrapping the regmap functions minimizes the diff and makes it easier to 
backport the driver.

-- 
Regards,

Laurent Pinchart



