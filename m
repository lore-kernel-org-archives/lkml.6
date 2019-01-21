Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C8C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD222085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548065484;
	bh=Lp9UiY8aEZ+FDUNn91RjtEtUtVn0QS93n+m/e9GABsk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=vw9CEGFiJEbTDUb+HND8n43VLKqGvVlhA91z4txt4cWBh8sFn6LvVG7Ps/X67e5Rw
	 48X8qEVMAs5QGPUSmr8hC9OWL7u1vTFrJTIOed8tBKhDBDhDV3c6UbCocNuUN++dY/
	 aYNJAud9yVhsrP/N9YTvdnVrn4Z/Nrb9kG429FVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAUKLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:11:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:46934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbfAUKLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:11:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69BBAAFAE;
        Mon, 21 Jan 2019 10:11:20 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:11:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] Input: document meanings of KEY_SCREEN and
 KEY_ZOOM
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Message-ID: <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Dmitry Torokhov wrote:

> It is hard to say what KEY_SCREEN and KEY_ZOOM mean, but historically DVB
> folks have used them to indicate switch to full screen mode. Later, they
> converged on using KEY_ZOOM to switch into full screen mode and KEY)SCREEN
> to control aspect ratio (see Documentation/media/uapi/rc/rc-tables.rst).
> 
> Let's commit to these uses, and define:
> 
> - KEY_FULL_SCREEN (and make KEY_ZOOM its alias)
> - KEY_ASPECT_RATIO (and make KEY_SCREEN its alias)
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Please let me know how we want merge this. Some of patches can be applied
> independently and I tried marking them as such, but some require new key
> names from input.h

Acked-by: Jiri Kosina <jkosina@suse.cz>

for the HID changes, and feel free to take it through your tree as a 
whole, I don't expect any major conflicts rising up from this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

