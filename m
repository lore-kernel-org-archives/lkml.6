Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026FBC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAAETX+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7985E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJWBMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:12:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44287 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeJWBMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:12:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so37613544ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OQRy6bWiFyWNxW02VDulhGCt9vf+K4KgUWsQA2ATsgE=;
        b=JAAETX+FvYV+UxfgdrS3de/cpZaW0BSWdZyQIts+64RzecX3M7dSix+h72xBVrWKKM
         VcfUlqi8j4qTdsQKj2sq42umLMDjXPDDQRMm587Qz8/qjooTdP7fcbGj7cu2i5zKa/mN
         kZPJFgDDcmiNKWdFQSipirTZscOZBwybK/lXqSeLwv9WMC+hd32HGUmtjky2umK27eXe
         qEdtu3uMekI+A1sx1mpR6qIH2WL0xlbFMc5Pgq53zXpqt77yxokugTIdWL7KrZ5D5w73
         wm2ivUz4/AV3yeBx6lHMXZdY4S45w7SLFk65ViUScyCk+nld+lA0Btnt5QFT3DHkXBCt
         KKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OQRy6bWiFyWNxW02VDulhGCt9vf+K4KgUWsQA2ATsgE=;
        b=Wv54HYjLLm0oOJhcFtjOvBynmotrCqVZv4OcGF54dFU2KRwYCh4+3JuYjjyzaFIsxc
         dxUHg2rNcniSI9Eee5B8aIl9s0zLqn3O7uZE8UBPqBXX3LJpIa7HvkgjlIRJfl0OhVS2
         QGv02USN6A71aCnbuzjvVIpmSVTW9WsWMnALwieHaoBYYibKwJlcSO/nQw3yhpJCOHxY
         KSehbHFeNDeP/t7iOWYx660JaK9cUc8tizGi2FIEijJrmp1ozmvPv46R58+pWb4nvix0
         3RgCXzt37vNlainImBgcuqQj8oPG8gKHpqgO4U+JiNVp6xYHvb1Cny9Cudj1ib9FGJeJ
         28jA==
X-Gm-Message-State: ABuFfoh8d43ZG9h5MinXun7rNM2SoDwzv/I/NSec77fRMrI1E6gsdItY
        EpEhF1J8aKwz/VZZVrJsid4=
X-Google-Smtp-Source: ACcGV61v8kfBpSXSodu1eJb1fjdQATMuU2DNJ7quNnVCIkeHwbFOQ+nAW92cDzMyNw1kiQn6piIn7A==
X-Received: by 2002:a2e:121:: with SMTP id 33-v6mr29611477ljb.96.1540227177197;
        Mon, 22 Oct 2018 09:52:57 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6968219ljc.46.2018.10.22.09.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 09:52:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 22 Oct 2018 18:52:53 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181022165253.uphv3xzqivh44o3d@pc636>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022125142.GD18839@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 02:51:42PM +0200, Michal Hocko wrote:
> Hi,
> I haven't read through the implementation yet but I have say that I
> really love this cover letter. It is clear on intetion, it covers design
> from high level enough to start discussion and provides a very nice
> testing coverage. Nice work!
> 
> I also think that we need a better performing vmalloc implementation
> long term because of the increasing number of kvmalloc users.
> 
> I just have two mostly workflow specific comments.
> 
> > A test-suite patch you can find here, it is based on 4.18 kernel.
> > ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch
> 
> Can you fit this stress test into the standard self test machinery?
> 
If you mean "tools/testing/selftests", then i can fit that as a kernel module.
But not all the tests i can trigger from kernel module, because 3 of 8 tests
use __vmalloc_node_range() function that is not marked as EXPORT_SYMBOL.

> > It is fixed by second commit in this series. Please see more description in
> > the commit message of the patch.
> 
> Bug fixes should go first and new functionality should be built on top.
>
Thanks for the good point.

> A kernel crash sounds serious enough to have a fix marked for stable. If
> the fix is too hard/complex then we might consider a revert of the
> faulty commit.
>
The fix is straightforward and easy. It adds a threshold passing which we
forbid cond_resched_lock() and continue draining of lazy pages.

> >
> > 3) This one is related to PCPU allocator(see pcpu_alloc_test()). In that
> > stress test case i see that SUnreclaim(/proc/meminfo) parameter gets increased,
> > i.e. there is a memory leek somewhere in percpu allocator. It sounds like
> > a memory that is allocated by pcpu_get_vm_areas() sometimes is not freed.
> > Resulting in memory leaking or "Kernel panic":
> > 
> > ---[ end Kernel panic - not syncing: Out of memory and no killable processes...
> 
> It would be great to pin point this one down before the rework as well.
> 
Actually it has been fixed recently. Roman Gushchin pointed to the:

6685b357363b ("percpu: stop leaking bitmap metadata blocks")

i have checked, it works fine and fixes a leak i see.

Thank you!

--
Vlad Rezki

> Thanks a lot!
> -- 
> Michal Hocko
> SUSE Labs
