Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBAC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0894720874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfADKVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:21:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:45404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfADKVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:21:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 474E7AD7E;
        Fri,  4 Jan 2019 10:21:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 11:21:39 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/vmalloc: fix size check for
 remap_vmalloc_range_partial()
In-Reply-To: <20190104093808.GJ31793@dhcp22.suse.cz>
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-2-rpenyaev@suse.de>
 <20190103151357.GR31793@dhcp22.suse.cz>
 <dba7cb2c2882e034c8c99b09a432313a@suse.de>
 <20190103194054.GB31793@dhcp22.suse.cz>
 <5502b64d6c508f5432386d2cfe999844@suse.de>
 <20190104093808.GJ31793@dhcp22.suse.cz>
Message-ID: <4630dd7797fc7934f98c01ea789105a8@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-04 10:38, Michal Hocko wrote:

[...]

>> >
>> > OK, my response was more confusing than I intended. I meant to say. Is
>> > there any in kernel code that would allow the bug have had in mind?
>> > In other words can userspace trick any existing code?
>> 
>> In theory any existing caller of remap_vmalloc_range() which does
>> not have an explicit size check should trigger an oops, e.g. this is
>> a good candidate:
>> 
>> *** drivers/media/usb/stkwebcam/stk-webcam.c:
>> v4l_stk_mmap[789]              ret = remap_vmalloc_range(vma, 
>> sbuf->buffer,
>> 0);
> 
> Hmm, sbuf->buffer is allocated in stk_setup_siobuf to have
> buf->v4lbuf.length. mmap callback maps this buffer to the vma size and
> that is indeed not enforced to be <= length AFAICS. So you are right!
> 
> Can we have an example in the changelog please?

You mean to resend this particular patch with the list of possible
candidates for oops in a comment message?  Sure thing.

--
Roman

