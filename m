Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47031C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lufky9im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeLCRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:23:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40782 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:23:10 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so9731174ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viy+lR9png5tY12hF8Jt7yR+hVkil670P2oH9PehlJE=;
        b=Lufky9imuHHXxSa82UzNV3dpaJA+TtSpEmfTxeZZhlu+A0r5R9ioq41qbBqLPnahLx
         pw2LYTTYLlpBf9LEUWANQuLEBuqYPKVxoTe1p2tb0bsktsX6ycvQfbkbFM3J/+axx4CG
         NcmVc8g9AJWfyl3sUEc4VZnl5YGVMvAxEEZmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viy+lR9png5tY12hF8Jt7yR+hVkil670P2oH9PehlJE=;
        b=dPJ5QZe7CsJTPiDspL7O+Wmp8nzB3iMvURxDo1tQb/jUIuiLiBxqJGoKSTToZElYIS
         TKwYvPLwlAKjwEbT3oaX1t3QzmMWkjI1mplWgxLtjxYQMv7jRXnx3OqD/B5xIztDUEkS
         oKcGBADjuS79UJmiaEMfPV/iKhLk3VhB0GU8l73KsT6zrkbXRSzi7EMiB7M44gfhDIOM
         gj6Dp8DbkrVx+quJwKdKZK0MbJZQsJQ5v8KD9QxjdD6XngfpUUHGDkrz8/bMFivsWV5F
         diRlUrfewLGkS6DQkXWndcu/bI9LB8dPs37xTPlNhVJuPrTIbuBzC4nZhd8NwN6U1wIT
         aoAw==
X-Gm-Message-State: AA+aEWZL4MjcwuJPCAXIUilM5oYe/1/qIOcBnUA7yLeQydpi0zytV9x4
        XrXw1WZ2gqEpWvrtn7eaZK9hpg+s1mXmUfSA1Dqu7A==
X-Google-Smtp-Source: AFSGD/VQ4WJtbvcEsNZ5smtE4wq3s2wILy5CpiHAYIi/yP+0pW4oE4kUrvV00YYb0n4BjVTHCahq2ZqMqzkOVo48zSg=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr9087851ith.23.1543857785680;
 Mon, 03 Dec 2018 09:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net>
In-Reply-To: <20181201005759.28093-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:22:54 +0000
Message-ID: <CAApk1dXwAtoFRRq971fwsE+yrbJT1kcYnjzSwShHBrXkU+nv_g@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/v3d: Document cache flushing ABI.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * The caches (L1T, slice, and L2T) will be flushed before the job
> + * executes.  The TLB writes are guaranteed to have been flushed by

I would say before *each* job executes, as the caches are flushed
before both bin and render.
I wouldn't say "the caches" as not all of the V3D caches are flushed
before executing a control list. In particular, the VCD cache is not
cleared by the kernel driver (not even sure if there is a register
interface to do this); it is expected that the control list will do
this itself (using the CLEAR_VCD_CACHE instruction).
On 3.3 and earlier there is a separate L2C for instructions/uniforms
and a GCA. These do need to be flushed, and it looks like they are, so
they should be mentioned here.
