Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CB620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CB620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbeGWNhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:37:00 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:55316 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388302AbeGWNg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:36:59 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id D76CB634C7E;
        Mon, 23 Jul 2018 15:35:57 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fha4D-0008GI-Kk; Mon, 23 Jul 2018 15:35:57 +0300
Date:   Mon, 23 Jul 2018 15:35:57 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/17] media: v4l2: async: Remove notifier subdevs
 array
Message-ID: <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks for the update.

On Mon, Jul 09, 2018 at 03:39:16PM -0700, Steve Longerbeam wrote:
> All platform drivers have been converted to use
> v4l2_async_notifier_add_subdev(), in place of adding
> asd's to the notifier subdevs array. So the subdevs
> array can now be removed from struct v4l2_async_notifier,
> and remove the backward compatibility support for that
> array in v4l2-async.c.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

This set removes the subdevs and num_subdevs fieldsfrom the notifier (as
discussed previously) but it doesn't include the corresponding
driver changes. Is there a patch missing from the set?

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
