Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9368C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC8205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAC8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKBBzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:55:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53168 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeKBBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:55:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIGBm-0006Oy-0k; Thu, 01 Nov 2018 16:51:22 +0000
Date:   Thu, 1 Nov 2018 16:51:21 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] mount API series
Message-ID: <20181101165121.GS32577@ZenIV.linux.org.uk>
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <87a7mut9cm.fsf@xmission.com>
 <20181031163601.GR32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031163601.GR32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 04:36:01PM +0000, Al Viro wrote:
> On Wed, Oct 31, 2018 at 10:38:17AM -0500, Eric W. Biederman wrote:
> > A couple of bugs that I can see quickly.  Several of which I have
> > previously reported:
> > 
> > - There is an easily triggered NULL pointer deference with open_tree
> >   and mount propagation.
> 
> What the hell?  If the fixes that went in do not handle something,
> especially if you have testcases, where the fuck have you been and
> where _are_ those testcases, while we are at it?
> 
> Eric, this is bloody ridiculous - "I have an easily triggered NULL pointer
> dereference in..., here it is" is hard to miscommunicate.  Sure, any such
> needs to be fixed.  For crying out loud, that thing has not been hidden -
> it sat in -next, it's been reposted several times...

Again, would you mind telling what exactly does the above refer to and whether
it is still true?  I'm not asking to put details in every time you mention
something of that sort, but generally one is expected to come up with those
on demand, especially if the bug _is_ easily triggered.

You, IIRC, had been Cc'd on the threads where open_tree breakage was
dealt with.  I can certainly believe that there might be something else
in that area (or any other, for that matter).  I *am* interested in finding
and fixing that and I would rather appreciate the details of what you
are seeing.
