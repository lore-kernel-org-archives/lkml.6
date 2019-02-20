Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB73121738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfBTCOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:14:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:34248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfBTCOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 18:14:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="301046091"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.196.154])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2019 18:14:02 -0800
Message-ID: <1550628841.3372.1.camel@intel.com>
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wei Ni <wni@nvidia.com>, daniel.lezcano@linaro.org,
        edubezval@gmail.com
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Wed, 20 Feb 2019 10:14:01 +0800
In-Reply-To: <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
         <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
         <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
         <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-02-18 at 15:59 +0800, Wei Ni wrote:
> Rui,
> Will you take this serial?
> 
it is already in my tree.
I missed -rc6, thus I will queue them for 5.1-rc1.

thanks,
rui

> Thanks.
> Wei.
> 
> On 21/1/2019 5:17 PM, Wei Ni wrote:
> > 
> > Does there have any comments?
> > 
> > Thanks.
> > Wei.
> > 
> > On 11/1/2019 10:20 AM, Wei Ni wrote:
> > > 
> > > Hi Eduardo,
> > > Do you have any more comments, will you take this serial?
> > > 
> > > Thanks.
> > > Wei.
> > > 
> > > On 3/1/2019 6:12 PM, Wei Ni wrote:
> > > > 
> > > > This series fixed some issues for Tegra soctherm,
> > > > and add get_trend().
> > > > 
> > > > Main changes from v6:
> > > > 1. Per Eduardo's comment, we can remove the change:
> > > > "thermal: tegra: parse sensor id before sensor register"
> > > > 
> > > > Main changes from v5:
> > > > 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/
> > > > 643
> > > > into this serial.
> > > > 
> > > > Main changes from v4:
> > > > 1. fixed for the parsing sensor id.
> > > > 2. keep warning for missing critical trips.
> > > > 
> > > > Main changes from v3:
> > > > 1. updated codes for parsing sensor id, per Thierry's comments
> > > > 
> > > > Main changes from v2:
> > > > 1. add codes to parse sensor id to avoid registration
> > > > failure.
> > > > 
> > > > Main changes from v1:
> > > > 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> > > > "thermal: tegra: fix memory allocation".
> > > > 2. Print out the sensor name when register failed.
> > > > 2. Remove patch "thermal: tegra: fix coverity defect"
> > > > 
> > > > Wei Ni (3):
> > > >   thermal: tegra: remove unnecessary warnings
> > > >   thermal: tegra: fix memory allocation
> > > >   thermal: tegra: add get_trend ops
> > > > 
> > > >  drivers/thermal/tegra/soctherm.c | 40
> > > > +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > > > 
