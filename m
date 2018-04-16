Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48R/vc+xo4bZZ5eab3X+aUAq5qiWwx75RvPC3A648QcvC1vAS75BJNDuUBxaT46eWX/A3fL
ARC-Seal: i=1; a=rsa-sha256; t=1523878439; cv=none;
        d=google.com; s=arc-20160816;
        b=EsQZi/GokQ5zKcY7LhEykWQI4EbX9RcV/Eb3WcRwS4u7U6ouGXS/fy8VvwDvSAJ/+Q
         dAjcgYDrjWyrN0sQwurRzYlZlfjvcWoUWfce4al3iBnYgAFtb0b1k5ToYsI8lfogH0mn
         sD7y4FPWEZ5apFoS7MXA7iKwpyC8FGkzztovwg4QObt6xOy9sRScZt9W74ICddj2ySLC
         hmLJjNucph8l/elDTyKUCvF36R5i/ouLOm/eJAv+WsJ2lMXFoVaIszCngcXQMSOhLk55
         Q/qYx7W/66MZtfPpV8Khe2HKTLYEVvVfjwtxtIPoe0O4QKpem76UTl0/1+G+STIs7GT3
         RvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=zRIg2Rdh0qOwgrqbQkIEVm74tV7FiZhQccsfb3hxWM8=;
        b=e8H4fS//OeiJAPT4Sg7H1h2YF1NdaNfEt7WVpSHCVGxzJQ7fgyJqhXzcsweOpew7qY
         og3O/E4cAJt8/UU7a20fz5wirphVVF9oSoKUJQjf9HtHaQkAWLhXbf9rDafY0jOW4i0w
         Dv3L2RIMbopvoZTQUtZLGeXFw2ciJ7Ega3q376mjZybhhAorTiHAafwizINvx5854yyE
         Rz4CtEs6cjZztdnoH3AJbKMmAGw5fbG+RhW1NHi+MOXtqM0Vi+lxFZQDRW4SNdnGqVxn
         f9anBW+Re4alwboHS5Nk23ft2xLOgfIPAk++aJgA411/h9CDni8h6QtoHpbGDLajfrWr
         ov6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeDPLd6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 16 Apr 2018 07:33:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:36473 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeDPLd5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Apr 2018 07:33:57 -0400
Date: Mon, 16 Apr 2018 13:33:55 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
In-Reply-To: <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
Message-ID: <alpine.LSU.2.21.1804161329040.23118@pobox.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com> <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com> <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz> <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597902358375664288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018, Joe Lawrence wrote:

> On 04/13/2018 07:20 AM, Miroslav Benes wrote:
> > Hi,
> > 
> > On Thu, 12 Apr 2018, Joe Lawrence wrote:
> > 
> >> Add a few livepatch modules and simple target modules that the included
> >> regression suite can run tests against.
> > 
> > Could you include a brief description which features are tested?
> 
> I can add this to the commit msg:
> 
>       - basic livepatching (multiple patches, atomic replace)
>       - pre/post (un)patch callbacks
>       - shadow variable API
> 
> Or do you prefer a little more detail?

That would suffice. Thanks.
 
> >  
> >> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> >> ---
> > 
> >> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> >> new file mode 100644
> >> index 000000000000..18c75b21cb9e
> >> --- /dev/null
> >> +++ b/lib/livepatch/test_klp_shadow_vars.c
> >>
> >> +/*
> >> + * Shadow variable wrapper functions that echo the function and arguments
> >> + * to the kernel log for testing verification.  Don't display raw pointers,
> >> + * but use the ptr_id() value instead.
> >> + */
> >> +void *shadow_get(void *obj, unsigned long id)
> >> +{
> >> +	void *ret = klp_shadow_get(obj, id);
> >> +
> >> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx) = PTR%d\n",
> >> +		__func__, ptr_id(obj), id, ptr_id(ret));
> >> +
> >> +	return ret;
> >> +}
> > 
> >> +void shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor)
> >> +{
> >> +	klp_shadow_free(obj, id, dtor);
> >> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx, dtor=PTR%d)\n",
> >> +		__func__, ptr_id(obj), id, ptr_id(dtor));
> >> +}
> > 
> > Sparse (make C=1) would be happier with those two being static.
> 
> Ah right. I wonder why the kbuild test robot didn't complain about
> those, too.  Easy enough to fix up, thanks.
> 
> > Otherwise it works as expected. Good job!
> 
> Thanks for reviewing.  I'll hold off on posting v4 until Petr (and
> others) get a chance to comment.  Perhaps there are other tests that
> would be helpful?

I think it would be useful to have tests for a stack checking and a 
consistency. Nicolai has written some lately for our internal testing, but 
it would take some time to transform them appropriately, I think.

So I would start with this and we can add more later. I would also 
establish a (soft) rule to submit selftests with new features.

Miroslav
