Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6DCC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D92184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfA2SDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:03:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfA2SDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:03:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30C5D317F;
        Tue, 29 Jan 2019 18:03:08 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:03:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] mm: add priority threshold to
 __purge_vmap_area_lazy()
Message-Id: <20190129100307.7b6d7346fbfabb9a3fd176c9@linux-foundation.org>
In-Reply-To: <20190129161754.phdr3puhp4pjrnao@pc636>
References: <20190124115648.9433-1-urezki@gmail.com>
        <20190124115648.9433-3-urezki@gmail.com>
        <20190128120429.17819bd348753c2d7ed3a7b9@linux-foundation.org>
        <20190129161754.phdr3puhp4pjrnao@pc636>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 17:17:54 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:

> > > +	resched_threshold = (int) lazy_max_pages() << 1;
> > 
> > Is the typecast really needed?
> > 
> > Perhaps resched_threshold shiould have unsigned long type and perhaps
> > vmap_lazy_nr should be atomic_long_t?
> > 
> I think so. Especially that atomit_t is 32 bit integer value on both 32
> and 64 bit systems. lazy_max_pages() deals with unsigned long that is 8
> bytes on 64 bit system, thus vmap_lazy_nr should be 8 bytes on 64 bit
> as well.
> 
> Should i send it as separate patch? What is your view?

Sounds good.  When convenient, please.
