Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B4A206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545054683;
	bh=pPLO1iL8gYpLHb3ERWd4aIXuuz6YlwoxIM4Epdg0Pvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=unpzg8vIxPF9/kiLl2ylOBBBmGG/6aXjffK8lUy1+L/3f2sy8s+8DFcass6cfQY+j
	 yt1Z05bCp6wBVAGdnBngcgHHdpKVKRLFvmgjr9EOoJlCpl1RvvXplYcR+6hUche5J4
	 6sh6Y4wL5IkSKFqQIx8dGvx6Za29aGGoiP06FouU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeLQNvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeLQNvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:51:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCA6206A2;
        Mon, 17 Dec 2018 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545054681;
        bh=pPLO1iL8gYpLHb3ERWd4aIXuuz6YlwoxIM4Epdg0Pvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBJcKwZm7uCu3lypDr81Fi6DHbMfwWxaBB0+qFcJQrJYIlhLaXckImcJslI/RP7LR
         l5mFK1avnfDBiHQU74qkdm1wY+mv/LAPSlOb6ujrEIdwRJiO04wGDAqReV8jECQGOc
         PjPFDQu5VFVIegtuk54kwhuTjNwKn4feaJ2XJ43Y=
Date:   Mon, 17 Dec 2018 14:51:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] staging: rtl8188eu: convert unsigned char arrays to
 u8
Message-ID: <20181217135118.GB28400@kroah.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
 <20181215164616.2643-4-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215164616.2643-4-straube.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 05:46:11PM +0100, Michael Straube wrote:
> Covert unsigned char arrays to u8 and make them static and/or const
> where possible.

You are also moving things around here from different .h files in
different places.  Always say exactly what you are doing.

And this too needs to be broken up into smaller pieces, don't make
things static/const when you change the type.

thanks,

greg k-h
