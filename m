Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55D21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B55D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbeK0UQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:16:32 -0500
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:35258 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729387AbeK0UQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:16:31 -0500
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 183ED634C85;
        Tue, 27 Nov 2018 11:19:15 +0200 (EET)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1gRZWU-0001eI-TM; Tue, 27 Nov 2018 11:19:14 +0200
Date:   Tue, 27 Nov 2018 11:19:14 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: imx274: don't declare events, they are not
 implemented
Message-ID: <20181127091914.zai73kgmam7oi33m@valkosipuli.retiisi.org.uk>
References: <20181127083445.27737-1-luca@lucaceresoli.net>
 <20181127083859.zljff4wk4hikel56@paasikivi.fi.intel.com>
 <dcd7ded2-7876-c017-0d8c-1f3d159e5d2f@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd7ded2-7876-c017-0d8c-1f3d159e5d2f@lucaceresoli.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:09:08AM +0100, Luca Ceresoli wrote:
> Hi Sakari,
> 
> On 27/11/18 09:38, Sakari Ailus wrote:
> > Hi Luca,
> > 
> > On Tue, Nov 27, 2018 at 09:34:43AM +0100, Luca Ceresoli wrote:
> >> The V4L2_SUBDEV_FL_HAS_EVENTS flag should not be set, event are just
> >> not implemented.
> >>
> >> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > 
> > The driver supports controls, and so control events can be subscribed and
> > received by the user. Therefore I don't see a reason to remove the flag.

I further missed the driver does not set the event (un)subscription
callbacks; the event support is actually not functional as a result. :-\

It's trivial to do that, see e.g. the imx319 driver.

> 
> Thanks, good to know.
> 
> Would it be worth adding a note where V4L2_SUBDEV_FL_HAS_EVENTS is
> #defined, to make this clear?

Could you send a patch? A few words should be enough, no need for a too
elaborate description I guess.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
