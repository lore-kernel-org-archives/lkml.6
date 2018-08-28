Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E912087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E912087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeH2Cn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:43:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeH2Cn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:43:57 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3EBD9CDF;
        Tue, 28 Aug 2018 22:50:07 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:50:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/2] fs/dcache: Track # of negative dentries
Message-Id: <20180828155006.a6a94a7ba64ac4ce6b8b190c@linux-foundation.org>
In-Reply-To: <1535476780-5773-1-git-send-email-longman@redhat.com>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 13:19:38 -0400 Waiman Long <longman@redhat.com> wrote:

> This patchset is a reduced scope version of the
> patchset "fs/dcache: Track & limit # of negative dentries"
> (https://lkml.org/lkml/2018/7/12/586). Only the first 2 patches are
> included to track the number of negative dentries in the system as well
> as making negative dentries more easily reclaimed than positive ones.
> 
> There are controversies on limiting number of negative dentries as it may
> make negative dentries special in term of how memory resources are to
> be managed in the kernel. However, I don't believe I heard any concern
> about tracking the number of negative dentries in the system. So it is
> better to separate that out and get it done with. We can deal with the
> controversial part later on.

Seems reasonable.

It would be nice to see testing results please.  Quite comprehensive
ones.

And again, an apparently permanent feature of this patchset is that the
changelogs fail to provide descriptions of real-world problems with the
existing code.  Please do provide those (comprehensive) descriptions and
demonstrate that these changes resolve those problems.

Also, a grumpynit: with 100% uniformity, the vfs presently refers to
negative dentries with the string "negative" in the identifier.  This
patchset abbreviates that to "neg".

