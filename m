Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E85320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAaTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:33:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:39491 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:33:45 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 930F520031;
        Thu, 31 Jan 2019 20:33:42 +0100 (CET)
Date:   Thu, 31 Jan 2019 20:33:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Stefan Mavrodiev <stefan@olimex.com>
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190131193340.GA2929@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=6RmNp6sAYilJb8JbLVgA:9 a=q7FuESofmqym2wpK:21
        a=EXmA4UXLiXgPqqSR:21 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

On Thu, Jan 31, 2019 at 08:26:00PM +0100, Sam Ravnborg wrote:
> Hi Thierry et al.
> 
> While reviewing a number of new panel drivers there was a
> certain pattern in the feedback:
> - the now deprecated drmP.h file was used
> - dev_err() and friends was used
> 
> This patch-set address the above items in the panel
> drivers in drm/panel/
> The hope is that new panel drivers will no longer inherit bad
> patterns from the existing drivers.
> 
> The use of DRM_DEV* is not accepted by everyone, so this conversion
> was split up in smaller bits.
> If some drivers do not want to use DRM_DEV* then just drop the relevant patch.
> 
> All patches are build tested on x86/arm.
> 
> The DRM_DEV* patches depends on the drmP.h removal.
> 
> One extra patch sneaked in "panel-innolux: drop unused variable"
> This is a fix for an unused variable and was added to flush my panel patches.
> 
> Note: Waiting for key storage (for gpg key) before I start the process getting
> commit rights, so I rely on someone else (Thierry?) to commit this.
> 
> Patches are made on top of drm-misc-next as of a few days ago.
Just for the record, all patches are checkpatched - OK.
A lot of the DRM_DEV_ERROR() etc lines had to be linewrapped to avoid
the maximum linelength.

The conversion was done manually, no fancy coincielle script behind.
That's something to look into for future changes.

	Sam
