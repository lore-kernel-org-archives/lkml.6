Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9982C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930E620818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7IwYkAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBEISt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:18:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35013 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfBEISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:18:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1176495plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6DZi/YW1xhoUu/IfsxT4rh7D0UgkiipATkIT2lgPSk=;
        b=i7IwYkAdisgFQeA5zo9dmGXgvd0nbmOG6e7TtHmxMyEu6zUL18QXgU9MxjFR5O8k2E
         OY9OG5nknoR7FKGMJ3bwQm4SUdPn1flolEGHHsY+cZ91xEKG02cTI/E0JrtirxGXQQk/
         Q3rmPKcYti3bX/O80iyR1BXeZUfh6R49FGkBfJkm9W9eZUwOQ+LVDyiz97rMS9dwYMzt
         TQmY0pC2SSV/7ZhdufutSpfJk8D1lzRHgIxr0C/FqXWkjmER2nasiTxImXSgGDTqwGXs
         hOI/z1uyxVRYruVyfGtpwysQ4U3lv/kRi2uwiZrmjIvJbSkeVWLMyfUge1uT6kKMrGLV
         ikog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6DZi/YW1xhoUu/IfsxT4rh7D0UgkiipATkIT2lgPSk=;
        b=FiY8cdD/gTtorRdxo9CpUfL8/TrmnRkMvKNjgPkfh+JbKQ9Vwfm8GMELo31+6Sv02q
         cF2ZeCO9oOddxDnUE3qEJO3JV9uuzGl0GceDftdWCAcgTGXXSuf50FBdBgKkWm1vWjJu
         j6Bqb4dnsOWhq/ph+zGN/2nBaB/89ts+hpQl/boDMoOpVGORkfTjMkGtZX7CMgkPu/+s
         TkI5Mczq2S/1a6I5ak4Fv/+k59yRb55lQBrbWiBRdgzA91eTNbEfT28j+mi01tEoRtYJ
         Xm7d6UCU0utx0rxczc5Be6ckxGM72zUiSHa7LC7TyHXEJc5fxnmZjAWfcM0V4jNL7PeU
         oCxw==
X-Gm-Message-State: AHQUAua54d6OXmAKnQzYg0LWoIIuz8Y9pZTPkBBYKL54S57yLL//22t8
        1uXRGqTH7Q3pDc6d8ERe8ig=
X-Google-Smtp-Source: AHgI3IZZ3mjmKH9B8LEhKFdxbzWb0EqfNTDVWZVmcvBAgp6u/uxftwBN6jOmCtZOAtivbGGVYW/Hkg==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr3902625pll.305.1549354728480;
        Tue, 05 Feb 2019 00:18:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b4sm2723950pgq.57.2019.02.05.00.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:18:47 -0800 (PST)
Date:   Tue, 5 Feb 2019 00:18:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 3/3] cap11xx: fix potential user-after-free on module
 unload
Message-ID: <20190205081846.GA118684@dtor-ws>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-4-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204220952.30761-4-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Mon, Feb 04, 2019 at 05:09:52PM -0500, Sven Van Asbroeck wrote:
> The work which is scheduled by led_classdev->brightness_set() is
> potentially left pending or running until after the driver module
> is unloaded.
> 
> Fix by using resource-controlled version of INIT_WORK().

I believe this is wrong way of fixing this. The LED classdev objects are
refcounted, and may live beyond the point where we unwibd devm stack,
so we are still left with the same use-after-free that we currently
have.

This is a general issue with LED subsystem as it provides no callback
for properly tearing down device structures, but I think in this
particular case we can simply switch from set_brightness() to
set_brightness_blocking() which will use the work item internal to the
LED classdev and that one is being shut down properly.

Jacek, does the above sound right?

Thanks.

-- 
Dmitry
