Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354D821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354D821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:17:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:39447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbeJCSRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:17:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 04:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,335,1534834800"; 
   d="scan'208";a="94245715"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 04:29:27 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id DCA1A20804; Wed,  3 Oct 2018 14:29:26 +0300 (EEST)
Date:   Wed, 3 Oct 2018 14:29:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Subject: Re: [PATCH v4 2/2] [media] imx214: Add imx214 camera sensor driver
Message-ID: <20181003112926.oxfqykqrazisjwab@paasikivi.fi.intel.com>
References: <20181003072905.21786-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003072905.21786-1-ricardo.ribalda@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, Oct 03, 2018 at 09:29:05AM +0200, Ricardo Ribalda Delgado wrote:
> Add a V4L2 sub-device driver for the Sony IMX214 image sensor.
> This is a camera sensor using the I2C bus for control and the
> CSI-2 bus for data.
> 
> Tested on a DB820c alike board with Intrinsyc Open-Q 13MP camera.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

How about adding that exposure control? And perhaps analogue and digital
gain as well.

I'd like to see the exposure control there because

	1. it's needed for the driver to be actually usable and

	2. it requires other non-trivial changes to the driver (runtime PM
	   or other arrangements to avoid accessing registers when the
	   power is off).

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
