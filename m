Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225C88W/gF2KH5y6h/vTX6yeWYWBQDNTydb991Db5wlMPo2LPZp98YwRN8V4LPTlWNJncXp3
ARC-Seal: i=1; a=rsa-sha256; t=1518572033; cv=none;
        d=google.com; s=arc-20160816;
        b=oUHSwQJGnjA/j3ibfS/+fzYTETQ5YGVIkmZA+ph5FmEqDroSt7BX9JobvnhsMAyPtx
         9cH6jzEs+b04ODntYA5pgVh3+Gvvt4CTjd5nzJRhLIgU1sscVrocath/jBUtFDk2afRg
         CUSOEnh80NNEhRCA4dGk199dW2mNLvd4jlqIB6JzII6oV4nCb9vUBMsAk9xVnleoahAo
         EsRyVyiif9D/1/Fu+He+Sx3T5UNwRmafB+vpv+KJyXYTXpmug++haRvAno96OijyeItk
         cuRYnpUgP3aoqqp3Yb+cjK6yzo9wDYqYo2iZmRSRplPvx4ItgY4qY9TOXILZBkJZ0Qjb
         n0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kx9HfB9KAOqK8d8YDvzymSiGSZ8YZtnmhRVjp8Et0QU=;
        b=irVqpXZMPedfVLXbgKKv63uNzEaMb2RhGErUG7T0mXgJNr/WmFNybcKgmpAuj5hB4n
         G2fikHBVGa/DKS6wZ26dgGHljaY0ic6GKLNQcqQ/fnR/8Q3DfMf79tkdT+fpqOx3fGRo
         /wCvGyC9x7g1lMtb7PPj1bk8L2zCJC+EIcJ0ylv5MJrd609lW/tl4Gbc8nO//WBY251p
         8o0LtrkskTH/ABq2acD6avN1Zo4FsivLK7KTGwK7ZIYfohukSbdfvxoPuyqvlsgJdIPg
         EDziEUZpTWI/0Hm/Yoy4WFb8TNZdOU8DwCewh7OUKqtovGKaDAJyJtLaBYx6LApVVSXF
         024Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=fv0vulwQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=fv0vulwQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966383AbeBNBdw (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 20:33:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966311AbeBNBdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 20:33:51 -0500
Date: Tue, 13 Feb 2018 17:33:47 -0800
From: Darren Hart <dvhart@infradead.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
Message-ID: <20180214013347.GA5786@fury>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
 <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592338188514831049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 02:26:46PM -0700, Shuah Khan wrote:
> On 02/07/2018 10:24 AM, Daniel Díaz wrote:
> > The Makefile lacks a couple of line continuation backslashes
> > in an `if' clause, which produces an error while make'ing:
> > 
> >   $ make
> >   make[1]: Entering directory `/[...]/linux/tools/testing/selftests/futex'
> >   /bin/sh: -c: line 5: syntax error: unexpected end of file
> >   make[1]: *** [all] Error 1
> >   make[1]: Leaving directory `/[...]/linux/tools/testing/selftests/futex'
> >   make: *** [all] Error 2
> > 

What is the failure scenario here? Is this shell specific? What does /bin/sh
point to for you?

> > Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> > ---
> >  tools/testing/selftests/futex/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> > index cea4adc..a63e845 100644
> > --- a/tools/testing/selftests/futex/Makefile
> > +++ b/tools/testing/selftests/futex/Makefile
> > @@ -12,9 +12,9 @@ all:
> >  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
> >  		mkdir $$BUILD_TARGET  -p;	\
> >  		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
> > -		if [ -e $$DIR/$(TEST_PROGS) ]; then
> > -			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/;
> > -		fi
> > +		if [ -e $$DIR/$(TEST_PROGS) ]; then \
> > +			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
> > +		fi \
> >  	done
> >  
> >  override define RUN_TESTS
> > 
> 
> Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3
> 
> thanks,
> -- Shuah
> 

-- 
Darren Hart
VMware Open Source Technology Center
