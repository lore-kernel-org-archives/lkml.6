Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9AC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9222E21872
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfAEB2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:28:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:28:05 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B816515;
        Sat,  5 Jan 2019 01:28:03 +0000 (UTC)
Date:   Fri, 4 Jan 2019 17:28:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>
Subject: Re: KMSAN: uninit-value in mpol_rebind_mm
Message-Id: <20190104172802.ce9c4b77577a9c2810f04171@linux-foundation.org>
In-Reply-To: <52835ef5-6351-3852-d4ba-b6de285f96f5@suse.cz>
References: <000000000000c06550057e4cac7c@google.com>
        <a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz>
        <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com>
        <52835ef5-6351-3852-d4ba-b6de285f96f5@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 09:50:31 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> > Yes, it doesn't and it's not trivial to do. The tool reports uses of
> > unint _values_. Values don't necessary reside in memory. It can be a
> > register, that come from another register that was calculated as a sum
> > of two other values, which may come from a function argument, etc.
> 
> I see. BTW, the patch I sent will be picked up for testing, or does it
> have to be in mmotm/linux-next first?

I grabbed it.  To go further we'd need a changelog, a signoff,
description of testing status, reviews, a Fixes: and perhaps a
cc:stable ;)

