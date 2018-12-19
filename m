Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FE920866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeLSU2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLSU2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:28:21 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB472075B;
        Wed, 19 Dec 2018 20:28:20 +0000 (UTC)
Date:   Wed, 19 Dec 2018 15:28:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219152818.29068982@gandalf.local.home>
In-Reply-To: <1545250591.4161.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 14:16:31 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> > Yeah, I had considered it but wasn't sure it was worth it.  Since
> > you're suggesting it is, I can send another patch on top of these, or
> > feel free if you want to too.  ;-)
> >   
> 
> How's this?
> 
> [PATCH] tracing: Introduce and use strcmp_const() for hist triggers
> 
> Provide a new strcmp_const() macro and make use of it instead of the
> longer and more error-prone strncmp(str, "str", sizeof("str") - 1).
> 
> Idea-and-macro-by: Steve Rostedt <rostedt@goodmis.org>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

And I just sent you my version :-) (cross emails).

Note, I changed it to strncmp_const() because it should note that it's
a strncmp() and not an strcmp().

Pretty much identical patches too ;-)

-- Steve
