Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9B4218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012317;
	bh=6wDA8/c560gdEi1H70OOOwswHXChvajAw0AkkC89Nzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MMSXkxOggQ//acYowREOefynYocFcS1JXrManeNrHLr2VDPTL5Lc0LfU1oiU/Qo8h
	 KQJwdOvU7UJPq63HON9hEWaO6RdYp5pz0L7QVwBOqP4goWLkV7jRCLqo3MIhxqQJ/y
	 sdWILV+xkYyB0iFgp1D4StL+uOCP+4zkEDtmiiBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfBAJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:11:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbfBAJLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09D1EB047;
        Fri,  1 Feb 2019 09:11:54 +0000 (UTC)
Date:   Fri, 1 Feb 2019 10:11:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Jiri Kosina <jkosina@suse.cz>,
        Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH 3/3] mm/mincore: provide mapped status when cached status
 is not allowed
Message-ID: <20190201091152.GG11599@dhcp22.suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
 <20190130124420.1834-4-vbabka@suse.cz>
 <20190131100907.GS18811@dhcp22.suse.cz>
 <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-02-19 10:04:23, Vlastimil Babka wrote:
> The side channel exists anyway as long as process can e.g. check if
> its rss shrinked, and I doubt we are going to remove that possibility.

Well, but rss update will not tell you that the page has been faulted in
which is the most interesting part. You shouldn't be able to sniff on
/proc/$vicimt/smaps as an attacker.
-- 
Michal Hocko
SUSE Labs
