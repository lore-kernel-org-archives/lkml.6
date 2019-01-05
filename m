Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D1C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CCA21721
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiCAzWjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfAERx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:53:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35948 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfAERxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:53:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so27500752lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDznCWOE3aiUDnWvGXu6cmZs8ljON9oG34lTnH4wsO4=;
        b=OiCAzWjmkeez6H3tUCpiFdC2i2TICdEwlaf3PXWuCzoPNo3hcstK1BKHRyyf2qg+LL
         r5/meN3L2a2+5TpVAcbjMiliroVHpd5uAss+P3hR4aUHHL6CiB0mOzZHFz3y1UnTAwX4
         155gLyOuLwdyFwWJlyvpsbZ7j25f0R9E8pN2kJwO72jEfDTO2Ii+f0TiwmQ9Bk6p2QFS
         x4wf5VlUGHDERRGqv2Tm1ZK9vSyd3IujFWxEcjQW3zmM0DUsBjDfiKonsnWai9uN9a5x
         FzADCtTk032rrATcsEZFCofZDHGvRU+rJ2vvWnymXqHrIydLLzAw2k+Hg9V6TUbJUO85
         DYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDznCWOE3aiUDnWvGXu6cmZs8ljON9oG34lTnH4wsO4=;
        b=KHPXeNBS3LtDYyuuoVbhB6mXmCKjmvOiQWI7hk9A6JiN/DoYMa0abGkZpfHBpWH7w7
         0gfNCl2PaqYs6XAlFoCkSxbEVe+7v2r/xabo4dCs074Q9f+UZCJoSy0yK1zqRxvUUah1
         y2A/n+iwr1n+rVXzQ8vTmfUEprO/Gk8FSdP521bo6xergp9SREBflykBvRKFG6nX5Fdm
         JXBppwsb2o8By/JJliW2tB6/Llcq10DS6d3crsk4Q2K4M08SyU2inW+Mvm+FvLE/d7PN
         OV2jJbO3dS717R/Ttn1kGy8lxMvr5rmr6oVGIXsJ0XGUG1daQx3lqKBe2ScPobq4KobQ
         iSOw==
X-Gm-Message-State: AA+aEWbU+a42u+3smMd2Fvg0RVH2VbnrM6i/+DQ8f3lS2hFBVgyiZbqv
        sXTrgCP5sQRV8r4QZVr8A9E=
X-Google-Smtp-Source: AFSGD/WIZ9z99CDvoYY3YKrM6MtVlurcRji0OXqNjDzXzmbaNYG+mQgCXBvLfOrgJaEUFf6e/utPug==
X-Received: by 2002:a19:c014:: with SMTP id q20mr25696185lff.16.1546710830700;
        Sat, 05 Jan 2019 09:53:50 -0800 (PST)
Received: from pc636 (mm-89-15-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.15.89])
        by smtp.gmail.com with ESMTPSA id 10sm9344937ljr.4.2019.01.05.09.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 09:53:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 5 Jan 2019 18:53:31 +0100
To:     shuah <shuah@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/3] selftests/vm: add script helper for
 CONFIG_TEST_VMALLOC_MODULE
Message-ID: <20190105175331.hogka35k3qkweewo@pc636>
References: <20190103142108.20744-1-urezki@gmail.com>
 <20190103142108.20744-4-urezki@gmail.com>
 <d62089c4-8225-6363-1de5-ff2e8a3f684e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62089c4-8225-6363-1de5-ff2e8a3f684e@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 11:34:30AM -0700, shuah wrote:
> On 1/3/19 7:21 AM, Uladzislau Rezki (Sony) wrote:
> > Add the test script for the kernel test driver to analyse vmalloc
> > allocator for benchmarking and stressing purposes. It is just a kernel
> > module loader. You can specify and pass different parameters in order
> > to investigate allocations behaviour. See "usage" output for more
> > details.
> > 
> > Also add basic vmalloc smoke test to the "run_vmtests" suite.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> 
> Thanks for adding skip handling. Here is my
> 
> Reviewed-by: Shuah Khan <shuah@kernel.org>
> 
Thanks Shuah!

--
Vlad Rezki
