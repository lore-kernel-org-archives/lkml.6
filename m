Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1D22083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1D22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHaQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:33:17 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42160 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbeHaQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:33:17 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 1FABC634C7D;
        Fri, 31 Aug 2018 15:25:59 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fviUw-00015S-Sb; Fri, 31 Aug 2018 15:25:58 +0300
Date:   Fri, 31 Aug 2018 15:25:58 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove sh_mobile_ceu_camera from arch/sh
Message-ID: <20180831122558.zv7537uyfw5pcnqj@valkosipuli.retiisi.org.uk>
References: <1527525431-22852-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527525431-22852-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, May 28, 2018 at 06:37:06PM +0200, Jacopo Mondi wrote:
> Hello,
>     this series removes dependencies on the soc_camera based
> sh_mobile_ceu_camera driver from 3 board files in arch/sh and from one
> sensor driver used by one of those boards.
> 
> Hans, this means there are no more user of the soc_camera framework that I know
> of in Linux, and I guess we can now plan of to remove that framework.

What's the status of this set? I think it'd be nice to get it in; the CEU
driver is the last using SoC camera framework.

I guess an ack from the SH folks would be needed for these patches to go
through the media tree.

On the sensor driver patches --- please just move the files. The CEU was
the last that it was possible to use the drivers with.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
