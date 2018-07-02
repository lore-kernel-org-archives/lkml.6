Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F469C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AAF25BCF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AAF25BCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeGBVMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:12:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbeGBVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:12:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 817FACD2;
        Mon,  2 Jul 2018 21:12:07 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:12:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v5 2/6] fs/dcache: Make negative dentry tracking
 configurable
Message-Id: <20180702141206.8d08b4769a9c8a4300ce06de@linux-foundation.org>
In-Reply-To: <1530510723-24814-3-git-send-email-longman@redhat.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
        <1530510723-24814-3-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 13:51:59 +0800 Waiman Long <longman@redhat.com> wrote:

> The negative dentry tracking is made a configurable option so that
> users who don't care about negative dentry tracking will have the
> option to disable it. The new config option DCACHE_TRACK_NEG_ENTRY
> is disabled by default.
> 
> If this option is enabled, a new kernel parameter "neg_dentry_pc=<%>"
> allows users to set the soft limit on how many negative dentries are
> allowed as a percentage of the total system memory. The default is 2%
> and this new parameter accept a range of 0-10% where 0% means there
> is no limit.
> 
> When the soft limit is reached, a warning message will be printed to
> the console to alert the system administrator.

It would be much more convenient if this was tunable at runtime via yet
another /proc knob.  Is there any particular reason why we can't do this?

