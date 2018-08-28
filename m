Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C846C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D451520893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D451520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeH1Sa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:30:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeH1Sa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:30:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E219404007C;
        Tue, 28 Aug 2018 14:38:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4A65D2026D6B;
        Tue, 28 Aug 2018 14:38:24 +0000 (UTC)
Date:   Tue, 28 Aug 2018 16:38:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 4/5] perf/hw_breakpoint: Set breakpoint as disabled in
 modify_user_hw_breakpoint error path
Message-ID: <20180828143823.GM23727@krava>
References: <20180809120305.20693-1-jolsa@kernel.org>
 <20180809120305.20693-5-jolsa@kernel.org>
 <20180809141713.GB22636@redhat.com>
 <20180809163015.GA23170@krava>
 <20180828142914.GJ22309@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828142914.GJ22309@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 14:38:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 14:38:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:29:14AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 09, 2018 at 06:30:15PM +0200, Jiri Olsa escreveu:
> > On Thu, Aug 09, 2018 at 04:17:13PM +0200, Oleg Nesterov wrote:
> > > On 08/09, Jiri Olsa wrote:
> > > > -	if (err)
> > > > +	if (err) {
> > > > +		bp->attr.disabled = 1;
> > > >  		return err;
> > > 
> > > Yes, but on the second thought... Can't we simply do
> 
> <SNIP>
> 
> > > instead of this and the next patch?
> 
> <SNIP>
>  
> > yep, seems good.. will send new version
> 
> Ok, but this is just for 4/5 and 5/5, right?

I resent v4 yesterday with final changes/acks, in here:

7186 r   Aug 27 Jiri Olsa       (1.6K) [PATCHv4 0/5] perf/hw_breakpoint: Fix breakpoint modify

thanks,
jirka
