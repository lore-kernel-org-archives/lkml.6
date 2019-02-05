Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA01E20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgHnQsQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfBEVnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:43:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40065 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfBEVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:43:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1973997pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MEL22RTFEeHTQ5RB+fLcpec6uTWtlUHjCecnCGUAUyc=;
        b=OgHnQsQOZ7Pg854Pq9a9go95x6tRR0Eul9DZsdHF+d7TCAgYBJ74lM/lWejtbVjb2A
         Yl4g5XwoW8StIijPmm2VRD8AraIqsuOa6FQe9l3WkOeyvkIbKTJbaGhysS7L3jzyx0hl
         qOeB8Q06orObNDV8VDBIruJp6D5dpwAXfpE1rGm+ygjyyBD5qVchcSPx0Y5gQteh/FRZ
         /5qVzgSklZrNbTP0rdD3rfQd2MKyf0D7g4QcYj5zK59aC3T/8znRTqYWy5mRevbIzWrv
         tM1NmsMzbl6GtSYUy9QK7CmorZypcOmlqs/0rMfe8BG+grMOYRbuIsydjWGefaRte0Uc
         4cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEL22RTFEeHTQ5RB+fLcpec6uTWtlUHjCecnCGUAUyc=;
        b=oiAmvgz6MnliB2DIPg7KWNWecjRj5owO2yEHKXu8oo43RxTiq8/X3eXbwvQ9nt3VLX
         nTrcsQQdcnwx45ISa+m3Ah0DdZQkw88/iZGZejfo14iRrCMZ1ZpWwQKsu341wYjenuyw
         gnGditouaGS/qnpLxtRvK0Iv2rsk+d+h4oJHN05bTdVGYUOJvx42gsnY8EYUtH0csxeq
         Lc+FIfSVot0DOHmh04qEZ0FNk5p9k2upWTZniuERe5DumBL2u5ppcQoAO+Y/R0As3O1l
         QurLohQWw7kIe/7bazzuPiDr3n95uG/Q6mQZe09OXMDro5AUKD+1pwxdTuIR7XBCKIx5
         9+Ag==
X-Gm-Message-State: AHQUAuZjyLzeRmeOAX12xlznqfUYKDmvQXifDyt6XErk9YGF8giOYA/D
        d29W7yCnSCfumDizGSk6Gro=
X-Google-Smtp-Source: AHgI3IaLhGsPqCVCnMzH4DjJTH1d8vvC3FbmKj3llICY8tzpVJPMh+xKcVqCsjxKUMtstRRPHcmMtQ==
X-Received: by 2002:a62:178f:: with SMTP id 137mr7121813pfx.226.1549403033753;
        Tue, 05 Feb 2019 13:43:53 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t5sm6309016pgo.70.2019.02.05.13.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:43:52 -0800 (PST)
Date:   Tue, 5 Feb 2019 13:43:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 3/3] cap11xx: fix potential user-after-free on module
 unload
Message-ID: <20190205214351.GB19151@dtor-ws>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-4-TheSven73@googlemail.com>
 <20190205081846.GA118684@dtor-ws>
 <6565ec19-b629-c289-2fed-a5f404763b74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6565ec19-b629-c289-2fed-a5f404763b74@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:24:47PM +0100, Jacek Anaszewski wrote:
> Hi Dmitry,
> 
> On 2/5/19 9:18 AM, Dmitry Torokhov wrote:
> > Hi Sven,
> > 
> > On Mon, Feb 04, 2019 at 05:09:52PM -0500, Sven Van Asbroeck wrote:
> > > The work which is scheduled by led_classdev->brightness_set() is
> > > potentially left pending or running until after the driver module
> > > is unloaded.
> > > 
> > > Fix by using resource-controlled version of INIT_WORK().
> > 
> > I believe this is wrong way of fixing this. The LED classdev objects are
> > refcounted, and may live beyond the point where we unwibd devm stack,
> > so we are still left with the same use-after-free that we currently
> > have.
> 
> Could you please share what LED classdev objects refcounting
> do you have on mind?

My mind was in a state of confusion when I wrote the above ;)

> 
> > This is a general issue with LED subsystem as it provides no callback
> > for properly tearing down device structures, but I think in this
> > particular case we can simply switch from set_brightness() to
> > set_brightness_blocking() which will use the work item internal to the
> > LED classdev and that one is being shut down properly.
> > 
> > Jacek, does the above sound right?
> 
> Yes, since the introduction of brightness_set_blocking op there is no
> need for out-of-led-core workqueues for deferring brightness setting.
> And we do flush_work() in led_classdev_unregister().

OK, great, I'll write up a patch for cap11xx and others if I find them.

Thanks.

-- 
Dmitry
