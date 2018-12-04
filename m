Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D397EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4ED2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw8hD+GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4ED2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLDJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:17:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46973 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:17:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15063830wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytjnow4UsmAuDbhZo9rz7nvixqdCGbxqyNn/1NoB0kk=;
        b=gw8hD+GYsjFji87yOaMag+9XkJ1rumG0rXPeHiI5k2COvZJsOAEJqdsCWeJult9pI7
         MA2Vyo1FPemE9aQqz+AEuxn/9Cr7OgyZG/ksGGrRclGKnRstYEjzPp2//nYX+DZN9pnG
         gCB4xfh4ZDHJ5tuNQc5XFSkPDxImt4YldMnVZA+18+O4PM1Z2S6inVISpkNGmenyGw7e
         KL+1U+ErFPHz9+6lFhFACJli5E9jrNC5jP1eT5i5lkO8EFAJOnahedBjLWSY7EkFnGcR
         aezrnQ1Ju97Ezbltb6U56uy6KJoPqnrjEFUYGa0rtBlIyqeJdM1uQZKqbwhqrDt5xJkM
         s1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytjnow4UsmAuDbhZo9rz7nvixqdCGbxqyNn/1NoB0kk=;
        b=SZ/12anwIYiB3eiJsHs7jKkMUX7XwgnBxeJh8Z6S2TG2KWxgmFuETNU/Fr8EtmV58y
         3DxWk9Vh+0JnbJV8Xxc6E1I7MWWljXpW8N50YfxwogzVt1ghf7/RwX4RA5GxFSLTLlFY
         m7IjH1rgy5oP4g4/pWFEPiJpL7Ew17g3YmnQIOoPdGvrh9GnXGNwLJJCuI1DdSlRZdZL
         P4i4TOREiiiTNWzqSLMu2nRYB5DtpWhq1+PNbdBsJvrTUMdejduS5njPc8yI6LeIXXvk
         nXivj0IlOct61KRvCikMkNq0aZPHas+P7ALe9rVbGGJajsg6AYTpNMyy34eQS9N5iR7Q
         Y13A==
X-Gm-Message-State: AA+aEWYVz1uxp4LDxnHBRdj7T4Bh0eebr22zjcZDdMaeClfxDAOEaiKN
        1x9pZ0IGE2RPtLnnpiWoP7Q=
X-Google-Smtp-Source: AFSGD/VUXcO7i+leXDkOmuf7IC0ONjQ/WAKj8Bu0+bZJJUQBQRcKm4F9WHcDT6/XFewgz5Yx5M6B+Q==
X-Received: by 2002:adf:e407:: with SMTP id g7mr16685620wrm.277.1543915059275;
        Tue, 04 Dec 2018 01:17:39 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x15sm13940344wrs.27.2018.12.04.01.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:17:38 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:17:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Pavel Machek <pavel@ucw.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204091736.GD73770@gmail.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203115601.GA31795@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203115601.GA31795@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> > I reviewed the ->cred_guard_mutex code, and the mutex is held across all
> > of exec() - and we always did this.
> 
> Yes, and this was always wrong. For example, this test-case hangs:
> 
> 	#include <unistd.h>
> 	#include <signal.h>
> 	#include <sys/ptrace.h>
> 	#include <pthread.h>
> 
> 	void *thread(void *arg)
> 	{
> 		ptrace(PTRACE_TRACEME, 0,0,0);
> 		return NULL;
> 	}
> 
> 	int main(void)
> 	{
> 		int pid = fork();
> 
> 		if (!pid) {
> 			pthread_t pt;
> 			pthread_create(&pt, NULL, thread, NULL);
> 			pthread_join(pt, NULL);
> 			execlp("echo", "echo", "passed", NULL);
> 		}
> 
> 		sleep(1);
> 		// or anything else which needs ->cred_guard_mutex,
> 		// say open(/proc/$pid/mem)
> 		ptrace(PTRACE_ATTACH, pid, 0,0);
> 		kill(pid, SIGCONT);
> 
> 		return 0;
> 	}
> 
> we really need to narrow the (huge) scope of ->cred_guard_mutex in exec paths.
> 
> my attempt to fix this was nacked, and nobody suggested a better solution so far.

Any link to your patch and the NAK?

Thanks,

	Ingo
