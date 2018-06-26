Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383F026A4F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383F026A4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934984AbeFZMTi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:19:38 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:41454 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933509AbeFZMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:19:36 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id B6544634C7E;
        Tue, 26 Jun 2018 15:19:34 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fXmwY-0000r3-CZ; Tue, 26 Jun 2018 15:19:34 +0300
Date:   Tue, 26 Jun 2018 15:19:34 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] media: imx274: cleanups, improvements and
 SELECTION API support
Message-ID: <20180626121934.5xhp6k7x2se6pmqr@valkosipuli.retiisi.org.uk>
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Jun 11, 2018 at 01:35:31PM +0200, Luca Ceresoli wrote:
> Hi,
> 
> this patchset introduces cropping support for the Sony IMX274 sensor
> using the SELECTION API.
> 
> With respect to v3, this version uses the SELECTION API with taget
> V4L2_SEL_TGT_COMPOSE to change the output resolution. This is the
> recommended API for cropping + downscaling. However for backward
> compatibility the set_format callback is still supported and is
> equivalent to setting the compose rect as far as resolutions are
> concerned.
> 
> Patches 1-5 are overall improvements and restructuring, mostly useful
> to implement the SELECTION API in a clean way.
> 
> Patch 6 introduces a helper to allow setting many registers computed
> at runtime in a straightforward way. This would not have been very
> useful before because all long register write sequences came from
> const tables, but it's definitely a must for the cropping code where
> several register values are computed at runtime.
> 
> Patch 7 is new in this series, it's a trivial typo fix that can be
> applied independently.
> 
> Patch 8 implements the set_selection pad operation for cropping
> (V4L2_SEL_TGT_CROP) and binning (V4L2_SEL_TGT_COMPOSE). The most
> tricky part was respecting all the device constraints on the
> horizontal crop.

My apologies for delays in reviewing the set. I'll take patches 1--5 and 7
and then I'll comment on patches 6 and 8 separately. Would that work for
you?

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
