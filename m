Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F2C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F2C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeIJTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:19:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIJTTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:19:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D2D280D;
        Mon, 10 Sep 2018 07:25:21 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.localdomain (DESKTOP-E1NTVVP.cambridge.arm.com [10.1.27.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10CC63F557;
        Mon, 10 Sep 2018 07:25:18 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:25:13 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Ayan Halder <ayan.halder@arm.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, tfiga@chromium.org, hoegsberg@chromium.org,
        nd@arm.com
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
Message-ID: <20180910142512.GA4164@DESKTOP-E1NTVVP.localdomain>
References: <20180823152343.6474-1-brian.starkey@arm.com>
 <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local>
 <20180910141134.GA19567@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180910141134.GA19567@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On Mon, Sep 10, 2018 at 03:11:34PM +0100, Ayan Halder wrote:
>On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
>> On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:

[snip]

>> >  		unsigned int min_size;
>> > +		u8 bpp = drm_format_info_plane_bpp(fb->format, i);
>You might want to pass info here instead of fb->format because fb is
>NULL. ie drm_format_info_plane_bpp(info, i);
>

Thanks, good catch. I have to admit I only compile-tested these.

-Brian
