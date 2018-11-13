Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20E322510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20E322510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbeKNBSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:18:18 -0500
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:60432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731840AbeKNBSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:18:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 903F2837F242;
        Tue, 13 Nov 2018 15:19:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth02_374569711be57
X-Filterd-Recvd-Size: 2218
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Nov 2018 15:19:39 +0000 (UTC)
Message-ID: <71d315a34e4b12b0eb1d4c9003b297e46695f9cf.camel@perches.com>
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
From:   Joe Perches <joe@perches.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Tue, 13 Nov 2018 07:19:37 -0800
In-Reply-To: <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
         <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
         <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 13:24 +0100, Hans Verkuil wrote:
> On 11/13/18 09:24, Maxime Ripard wrote:
> > The older CSI drivers have camera capture interface different from the one
> > in the newer ones.
[]
> > diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
[]
> > +	// Videobuf2
> 
> Doesn't checkpatch.pl --strict complain about the use of '//'?

No, not since

commit dadf680de3c2eb4cba9840619991eda0cfe98778
Author: Joe Perches <joe@perches.com>
Date:   Tue Aug 2 14:04:33 2016 -0700

    checkpatch: allow c99 style // comments
    
    Sanitise the lines that contain c99 comments so that the error doesn't
    get emitted.


