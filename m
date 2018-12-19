Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CEA218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeLSPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbeLSPgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:36:51 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713B52084A;
        Wed, 19 Dec 2018 15:36:49 +0000 (UTC)
Date:   Wed, 19 Dec 2018 10:36:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
Message-ID: <20181219103647.18c61a6a@gandalf.local.home>
In-Reply-To: <1545231703.4491.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
        <1545231703.4491.2.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 09:01:43 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > > +	if (hist_field && hist_field->var.idx == var_idx &&
> > > +	    hist_field->var.hist_data == var_data)
> > > +		found = hist_field;
> > >  
> > >  	return found;  
> > 
> > It seems we don't need "found" var here. Just return hist_field or
> > NULL.
> >   
> 
> OK, will change these and resubmit shortly.

Tom,

If this is the only patch in the series that needs updating, can you
just reply to this patch with the v2 of 3/7? That is have a subject of:

[PATCH v2 3/7] tracing: Use var_refs[] for hist trigger reference checking

and reply to the [PATCH 3/7]


This isn't the normal way of updates, but I want to start taking this
patches in ASAP, and I figured this may be the easiest for both of us.

It's fine to send a v2 of the entire patch series (which other
maintainers require), so I'll leave it up to you.

If there's any other patch that needs changing, then a full v2 series
is required. But if this is the only change and you want to send just
this patch, then I'll take that as well.

-- Steve
