Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EE1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5F2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC5F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeI0SzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:55:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0SzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:55:14 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD1B4FF0;
        Thu, 27 Sep 2018 12:37:08 +0000 (UTC)
Date:   Thu, 27 Sep 2018 14:37:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
Message-ID: <20180927123706.GA23563@kroah.com>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927090309.614592493@linuxfoundation.org>
 <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:43:33PM +0200, Holger Hoffstätte wrote:
> On 09/27/18 11:03, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Lyude Paul <lyude@redhat.com>
> > 
> > commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
> > 
> > As pointed out by Daniel Vetter, we should be usinng
> > drm_drv_uses_atomic_modeset() for determining whether or not we want to
> > make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> > the former isn't an accurate representation of whether or not the driver
> > is actually using atomic modesetting internally (even though it might
> > not be exposing atomic capabilities).
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch breaks switching the console to high resolution during boot on my
> workstation with a Radeon card; it worked fine with 4.18.10 and reverting it
> fixes the problem:

Is 4.19-rc5 also a problem?

thanks,

greg k-h
