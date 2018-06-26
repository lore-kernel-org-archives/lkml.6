Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8251EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC726F3A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EC726F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeFZVHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:07:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeFZVHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDB6040122A2;
        Tue, 26 Jun 2018 21:07:10 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8E332026D6A;
        Tue, 26 Jun 2018 21:07:10 +0000 (UTC)
Date:   Tue, 26 Jun 2018 16:07:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Allan Xavier <allan.x.xavier@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
Message-ID: <20180626210709.i2x5qrpu7bf5xi2p@treble>
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
 <20180626164338.GH2458@hirez.programming.kicks-ass.net>
 <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
 <20180626184405.hsbuuq5eo7qzicoi@treble>
 <20180626194327.GP2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626194327.GP2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 21:07:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 21:07:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 09:43:27PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 01:44:05PM -0500, Josh Poimboeuf wrote:
> > On Tue, Jun 26, 2018 at 07:31:18PM +0100, Allan Xavier wrote:
> 
> > > Is there a particular concern you're trying to address by having the logic there
> > > instead?
> > 
> > Thanks for the patch and the excellent problem description.  I think the
> > concern is that the overlap might cause other unforeseen issues (now or
> > in the future).
> 
> Yeah, overlapping symbols are just really weird and unfortunate, I've no
> idea what the GCC people were thinking.
> 
> Note how find_symbol_containing() already more or less assumed !overlap.

If there are no objections to my patch, I'll run it through 0-day
testing and post an official version tomorrow-ish if it doesn't break
anything.

-- 
Josh
