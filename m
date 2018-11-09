Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14402086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14402086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeKJE6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:58:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727961AbeKJE6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:58:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79DCFAF12;
        Fri,  9 Nov 2018 19:16:33 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:16:22 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Todd Kjos <tkjos@google.com>
Cc:     chouryzhou@tencent.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hj?nnev?g <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] binder: ipc namespace support for android binder
Message-ID: <20181109191622.t4usetsmidtyt7oa@linux-r8p5>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
 <20181109182654.ojzc7wae3jcivlup@linux-r8p5>
 <CAHRSSEzc96qbDOQt8L+J4JMAazYv-d2xdyLT2nyPe7_t+8_5=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHRSSEzc96qbDOQt8L+J4JMAazYv-d2xdyLT2nyPe7_t+8_5=A@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018, Todd Kjos wrote:
>
>print_binder_proc() drops proc->inner_lock and calls
>binder_alloc_print_allocated() which acquires proc->alloc->mutex.
>Likewise, print_binder_stats() calls print_binder_proc_stats() which
>drops its locks to call binder_alloc_print_pages() which also acquires
>proc->alloc->mutex. So binder_procs_lock needs to be a mutex since it
>can block on proc->alloc->mutex.

Ah, very good then.

Thanks,
Davidlohr
