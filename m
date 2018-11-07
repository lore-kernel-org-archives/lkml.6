Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gNY2H+5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeNt9FfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF4B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeKGSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:44:42 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39581 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbeKGSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:44:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CEFFA219DA;
        Wed,  7 Nov 2018 04:15:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Nov 2018 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9d2xXnUutPFpd5OSjHjOnPppkIs
        MEK8bnCOzBUKcO0w=; b=gNY2H+5hpcbLOXuIl/Zykk1ThnovlNNOIgj9/te99mI
        UlM4cly9oo6p/qw3eDDSvKhjSPjsnLGi2dyCDrP0/X8vyzhpQKR8bEfJhBs/9v1Z
        CHahCK+lSyc0pX/tL8WFIbpzB0XRVRbPD69CrJyKS9UhRmoYlIhKugYfjcEsoGBa
        0mfwcTJeKq/n0UE2ZVHYzj+q4o9+/M2eob2C21ytFf6iBLmmx5bfKvVxrgHEpsci
        2cztdO+ypyJRA/eNo4i9+534hZU2ofDTRBD8NemHUhpJFxC4yGbLrnyTMqbtX5Lz
        fAU/JjZLU5RCEodvrJhR7BoHWDIYdZrv5X/4L7YnmsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9d2xXn
        UutPFpd5OSjHjOnPppkIsMEK8bnCOzBUKcO0w=; b=ZeNt9FfI+F0/cjxc8nAXRa
        mGiNqxWltCUUNsFG3JFKhnk6ydL0xJy3ZFggobGuE+KuYAeENzHlccZKHb8iQRry
        4cuwrkOPrwg9djWJK3O0+Vy8n86X+/TWoXwO+Qj5HDXmogcagEjiGOk9/5ZAyPjl
        GtX5+aWUDHplgYY0nKsh4EXoguNdRQt+fYynq6HYMbQ/eoGppzAa9D44m8SmacDB
        D+Q4LJY/qkJXS1u8kKXORq4t2drYK50MmIQ84AyDFfpadfxwoAibGwu6CnYVaFO7
        xXaACYPf68ZaOC2yXh7Hb8BjtFEEq3Tp4Y1WZi7d8wnFmksPTzmzRZQk7cZ1M87g
        ==
X-ME-Sender: <xms:Ia3iW-ql2THyHu93vl7FxXUPahrVBOCIsUeVPg8NpjDtq-ZUslXmaQ>
X-ME-Proxy: <xmx:Ia3iW-dLV6XZLg-grMy9FgGg1puSDmOp-v0aQzrBapC5JebW-6Aqig>
    <xmx:Ia3iW8d3S-0lr36GcMr-tYVjW3Az70VXCHq1Ik6_QAeiH0-xhrpqZQ>
    <xmx:Ia3iWzG9g9ZaqNMhyucOIVI_f8YUswjYj5dkIpMalMBEkhyncdTttA>
    <xmx:Ia3iW7GkafG1EdjuSpAqgXQb0YBmaTeM53ITbBTCvgu-DWpxYQ5RIg>
    <xmx:Ia3iW0D1wBH74QADVXiAXLJkgsGnGoGJN8sTfFpNJbNluOuBmjo3IA>
    <xmx:Ia3iW2gW5SjMJM93ixo7ZJWmKILDcymoPDWTYuD7cbpxKmkJWTlFag>
Received: from localhost (unknown [104.153.224.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0CF42102F1;
        Wed,  7 Nov 2018 04:15:12 -0500 (EST)
Date:   Wed, 7 Nov 2018 10:15:04 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Jerry Lin <wahahab11@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, astrachan@google.com,
        ghartman@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181107091504.GD31015@kroah.com>
References: <20181107023043.GA18052@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107023043.GA18052@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
> Add a attribute called permissions under vsoc device node for examining
> current granted permissions in vsoc_device.
> 
> This file will display permissions in following format:
>   begin_offset  end_offset  owner_offset  owned_value
>             %x          %x            %x           %x
> 
> Signed-off-by: Jerry Lin <wahahab11@gmail.com>
> ---
>  drivers/staging/android/vsoc.c | 48 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)

What changed from v2?  And where was v2?  What about v1?

You need a change log here of what you did different from the previous
patches.

And why ignore my response saying that this type of sysfs file is not ok
at all?

thanks,

greg k-h
