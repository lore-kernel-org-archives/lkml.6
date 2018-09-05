Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153532077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153532077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIERQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:16:55 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:51660 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbeIERQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:16:55 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id A38BD13F6ED; Wed,  5 Sep 2018 14:46:46 +0200 (CEST)
Date:   Wed, 5 Sep 2018 14:46:46 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        martin@lichtvoll.de, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905124646.GR17123@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180905070847.GC24519@BitWizard.nl>
 <3805399.0d8HT3LL4o@merkaba>
 <20180905080444.GD24519@BitWizard.nl>
 <CAJDTihya-DxyjzPJfh0LX+qOs2jvwr5TakcmRr8_U7h3pdw6cg@mail.gmail.com>
 <1b02ddae-35ae-8ff7-760f-bc9bafee4541@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b02ddae-35ae-8ff7-760f-bc9bafee4541@gmail.com>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:07:25AM -0400, Austin S. Hemmelgarn wrote:
> On 2018-09-05 04:37, 焦晓冬 wrote:

> >At this point, the /bin/sh may be partially old and partially new. Execute
> >this corrupted bin is also dangerous though.

> But the system may still be usable in that state, while returning an
> error there guarantees it isn't.  This is, in general, not the best
> example though, because no sane package manager directly overwrites
> _anything_, they all do some variation on replace-by-rename and call
> fsync _before_ renaming, so this situation is not realistically
> going to happen on any real system.


Again, the "returning an error guarantees it isn't" is what's
important here. A lot of scenarios exist where it is a slightly less
important file than "/bin/sh" that would trigger such a comiplete
system failure. But there are a whole lot of files that can be pretty
critical for a system where "old value" is better than "all programs
get an error now". So when you propose "reads should now return error", 
you really need to think things through. 

It is not enough to say: But I encountered a situation where returning
an error was preferable, you need to think through the counter-cases
that others might run into that would make the "new" situation worse
than before.

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
