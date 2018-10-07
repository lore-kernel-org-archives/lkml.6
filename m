Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F0EC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25292088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 05:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Id69BnJv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y62ZLQxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25292088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJGM17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 08:27:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54475 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbeJGM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 08:27:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D2D3E21F24;
        Sun,  7 Oct 2018 01:21:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 07 Oct 2018 01:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=X6ohA7jjERlL1OHqoACu0tZyTOl
        xlj5Xry1RPElnhB4=; b=Id69BnJvEVs3VG8+Ljhrr9GCTV6/dnQECoRHLb/Vrre
        t2QLCRWumDtzrYYvTMWxxm73SNFe66s/RwHKy6IEEbBoUKhQCEYNXLi4kCeHEl6I
        EUTiBZT/64icZ2hKXMIgT4LTNAhfFbMW6jVmmT7eBgDm/gW7XudsUDBIT/ml2xcA
        vdDWW8Nv1G0909JqoS22dr9S75pb6RdWcRDitZwp3krDZrKro8ummJvuWzKSq6nE
        2QyYo0ogqjGIgmdBkK6WzT55xHIrycQr6FQZJMwsBJa/MmulzYPki4IeGD0YoL/L
        fLUo1Rf/CEclX5YZVijGxwFLMhqzqL6FltY/0YqOoQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X6ohA7
        jjERlL1OHqoACu0tZyTOlxlj5Xry1RPElnhB4=; b=Y62ZLQxWGnf2cHukA0bu9y
        a+HoB3wpoiW5BTCxkDmlW/Mkc0SGgSSdKYh0naKlM0p31+mqJP2X8/HJr80lkg71
        cuRHhq8LYFP5I5LpmKPxzfSRx1EBjH5Bm/hHRrB7P5RjMn3ChwNQsPhJLPXmVBA3
        MmmmOxcGg0uHyGJsUBr15DP0xHj8tloDDUlu37aGBoJ0v+y1lmO9d0vCgRnXVuFy
        LZrV67WaFkdUKgCt+R6WiTTz5UvS+RX+yctc2G5lKGf1CvA06RaQwCa/8cX8oK2V
        tp2GabTSOaBf+SFeoBoI6C3qZK63GCrBqiWkIURfx+ovT4TvD//deiIHSR3gP5Gw
        ==
X-ME-Sender: <xms:8pe5WzqIxiZZPd6QaysQjJj8Zlfe36QYNtKvDX_knCEtEURIsxViAQ>
X-ME-Proxy: <xmx:8pe5W9YER3QhEVzj1hyJephrxD9QUINNJKJ5nQV6BfrjhAuXTjlhqg>
    <xmx:8pe5W__8FGi2vs1Ur07J2ZlRdmAYOJZmNzmNsdw1oR3XlBqEz_E_LA>
    <xmx:8pe5W3McIL5083Z0ijguBz5FfxkZVvssNP1a54Gf5632Ls5WcDwsNg>
    <xmx:8pe5W0CyExE_rHcRS6ou6akH-T3rTDH0MvXAFdTqyfq9z4cQ57maAw>
    <xmx:8pe5W0ZrXUM7cUPfyCjHMWe6V00kiwn5zQth63z404YTAqZfjGiydg>
    <xmx:8pe5W88VhW5LnRj5Rdfrj14r_3NHb-4oqXYmQjFKdGBhskoWU0MWhw>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA4A4102D7;
        Sun,  7 Oct 2018 01:21:53 -0400 (EDT)
Date:   Sun, 7 Oct 2018 07:21:52 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.19-rc5
Message-ID: <20181007052152.GB9243@kroah.com>
References: <1538846412.4088.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538846412.4088.1.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 10:20:12AM -0700, James Bottomley wrote:
> Small fix for an unititialized mutex in the qedi driver.
> 
> The patch is available here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Now merged, thanks.

greg k-h

