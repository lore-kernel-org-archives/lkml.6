Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD8C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4C220664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g17fV/JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4C220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJVWUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:20:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41611 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:20:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id q39-v6so30445848lfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UhkGHSoVnp7RarPQBnZ0k0r3I18r5NVenEUHB5tvd98=;
        b=g17fV/JWRCv7GSRokczJfa1xMGvqzwjdTS3ypcnyyFfrNu+f701B7Jk3HDtOAW686n
         NDeKmOxjJq4RPviibap+gSyMVmQZifn5zJpgh3Bp7Xdl80VkddV9Q0XYvFuIsQgT0ur9
         NVNQhCJuXJNaYNLJOcRURzTlJZgS+eNFwXAkSID7+jrE5O7ddKLjf5SgOn2S+ngQkw6g
         br7jn/vW9ryey07fpIFyve5f8FHWjaUUuTfZYewHbvPQPFikbi8D9dia5yo35bDDJXug
         hzkFFKL1GlhZdGhSgW3jHVRZtQvGnW3ZXPE53noKrvdeVeMkDRxp5r6Uj6ZyCxy1FDdg
         SHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UhkGHSoVnp7RarPQBnZ0k0r3I18r5NVenEUHB5tvd98=;
        b=rDeiM8fkjSXmzpi8Egxo/UXiMfRB9BQ5r5x4xPkjkdHUQPfE1nZ0kRNC58YxPMBcd3
         mdN0HDKtmhEZKYpVu/RnZRd9hk1UvPJE5Lew01rzRwSGtlyCzqXC/q+6TJf5HVPGA364
         IeyWkJJD+IXqvhYxyAMebv+QxfEZFNnSScHQ1M7rPDVIAZmVX8GppQyYt7YkhNpCi6Vm
         /c0hFSp6aAGBYWEoFW0GTqPDamare3UO7lYj1BEluwTnG1NPm7FB/NP1qmMeHX4qJWiR
         epFk4rFdsDHdgoKJAOX4mj1cN+QlFUqn5sb1Mnz5EQZ1EfEdQWq3/f1lUoLzjhpIx3EF
         0V/A==
X-Gm-Message-State: ABuFfog9RN3n+kHV+a72MkATuG93tMYU7hd9SvavCCtvQvtyY+dMwrGD
        ozqmlX7RzrZRizynMwzYDKM=
X-Google-Smtp-Source: ACcGV60zWkvaYMOBhNig+z0WzwAA/4QitkcI42Yn6ie2SToFzyz1bUvdlikaBvB3v5qmXIziyh406g==
X-Received: by 2002:a19:2a4b:: with SMTP id f72mr7620122lfl.139.1540216877570;
        Mon, 22 Oct 2018 07:01:17 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h21-v6sm1958498lfh.38.2018.10.22.07.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 07:01:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 22 Oct 2018 16:01:08 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181022140108.jwahqbudbn4xiw43@pc636>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181019224432.GA616@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019224432.GA616@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:44:39PM +0000, Roman Gushchin wrote:
> On Fri, Oct 19, 2018 at 07:35:36PM +0200, Uladzislau Rezki (Sony) wrote:
> > Objective
> > ---------
> > Initiative of improving vmalloc allocator comes from getting many issues
> > related to allocation time, i.e. sometimes it is terribly slow. As a result
> > many workloads which are sensitive for long (more than 1 millisecond) preemption
> > off scenario are affected by that slowness(test cases like UI or audio, etc.).
> > 
> > The problem is that, currently an allocation of the new VA area is done over
> > busy list iteration until a suitable hole is found between two busy areas.
> > Therefore each new allocation causes the list being grown. Due to long list
> > and different permissive parameters an allocation can take a long time on
> > embedded devices(milliseconds).
> ...
> > 3) This one is related to PCPU allocator(see pcpu_alloc_test()). In that
> > stress test case i see that SUnreclaim(/proc/meminfo) parameter gets increased,
> > i.e. there is a memory leek somewhere in percpu allocator. It sounds like
> > a memory that is allocated by pcpu_get_vm_areas() sometimes is not freed.
> > Resulting in memory leaking or "Kernel panic":
> > 
> 
> Can you, please, try the following patch:
> 6685b357363b ("percpu: stop leaking bitmap metadata blocks") ?
>
I have tested that patch. It fixes the leak for sure. Thank you for a
good point.

> 
> BTW, with growing number of vmalloc users (per-cpu allocator and bpf stuff are
> big drivers), I find the patchset very interesting.
> 
> Thanks!
Thank you!

--
Vlad Rezki
