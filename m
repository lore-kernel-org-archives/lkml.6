Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeBEKd1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:33:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbeBEKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:33:19 -0500
Date: Mon, 5 Feb 2018 11:33:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 3/6] livepatch: Initial support for dynamic structures
Message-ID: <20180205103318.m77bzxq5wykykmkn@pathway.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com>
 <20180125160203.28959-4-pmladek@suse.com>
 <alpine.LSU.2.21.1801311637140.7649@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1801311637140.7649@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-01-31 16:39:04, Miroslav Benes wrote:
> On Thu, 25 Jan 2018, Petr Mladek wrote:
> 
> > From: Jason Baron <jbaron@akamai.com>
> > 
> > We are going to add a feature called atomic replace. It will allow to
> > create a patch that would replace all already registered patches.
> > For this, we will need to dynamically create funcs' and objects'
> > for functions that are not longer patched.
> > 
> > This patch adds basic framework to handle such dynamic structures.
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index e5db2ba7e2a5..21cad200f949 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -35,12 +35,22 @@
> >  #define KLP_UNPATCHED	 0
> >  #define KLP_PATCHED	 1
> >  
> > +/*
> > + * Function type is used to distinguish dynamically allocated structures
> > + * and limit some operations.
> > + */
> > +enum klp_func_type {
> > +	KLP_FUNC_ANY = -1,	/* Substitute any type */
> > +	KLP_FUNC_ORIGINAL = 0,  /* Original statically defined structure */
> 
> Wouldn't KLP_FUNC_STATIC be better? KLP_FUNC_ORIGINAL confused me couple 
> of times.

OK, I am going to use KLP_FUNC_STATIC in v7.

Best Regards,
Petr
