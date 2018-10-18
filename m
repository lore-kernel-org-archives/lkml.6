Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7021ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43D21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9rvMeDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeJSBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:05:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45781 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:05:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so1253434pga.12;
        Thu, 18 Oct 2018 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HdtjDLDJGO58lGgH1pmwkm5pqONiy1TdcgufnJt5jk=;
        b=o9rvMeDM4mro7no9Tu9UlzaIDA3agBLUYkXFZKlG6Tg1oWHdmHHrDAIVvTNao7HilA
         h60Ntdqv+gF2OxbgY9M9dVtpe/SkJBCyhK1p3yaL4oFBosHJtdb01yp7CY7C5iZJLQ/o
         mrP9im4Zpwkul7QEW5PH4+pu/saeNjx9UYo2ObhKbSTDXPj2/8ovV2qwy0pteodviU2L
         BhjQ8rIsmNA8Bdbre/LfiH7d19kG9h9lkFHWNc4s/7ms/ltGhPjLHbJRjR9Dh9hVYIq4
         uLG89Hd3OEljnBRx/20v0nB3Pmc8EXUn4vYNmIg8GgM/pkBF58rAPSmR3O+5CQeeMckt
         USpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HdtjDLDJGO58lGgH1pmwkm5pqONiy1TdcgufnJt5jk=;
        b=KYpiJD0uE7WqsDc1TyKgTTjxzlfi//oioaiT5AoVIZpsUF0s/6WmjUIyB1K0Jdf2jn
         WI5MT+h1DipRcOgppfhUvGMnoIEPjDDmLk65AopYWejvznhDuHEXzc4HZIUlaXZSdjsO
         OTPprzgVXCmM98aigOla08SgwtRyzK7BiAYSJiHYYy9g/MRrj+bBZcZVXpctmHkdUZLR
         oO32JD0Kjxk8KkjhAG303ioJbWy8g8V1UoG6VMQEsoMR4CMGTGxJ7sXd5IuLlZpX6NA0
         ZLQ2S12NQYf/a+y4fPpJ48bCciMTlI3lFhZfDguMJPZglmwFiAOl0djNoM6iUb5mQFYj
         aY6g==
X-Gm-Message-State: ABuFfojZ4Oz5kcvq4YtUFnYGrNhdwwXXKNFihft3J+d4Liuo3g6YUo5e
        yk0K0btWq/WL9Xykn4lszlo=
X-Google-Smtp-Source: ACcGV63IK/eCpi5LYf1bdWv2iiMzhcBliG+bU1xL027vp8fvR54XyDzJTglHkBqA2ckY36VHm+RHaw==
X-Received: by 2002:a63:a80c:: with SMTP id o12-v6mr29445959pgf.271.1539882215860;
        Thu, 18 Oct 2018 10:03:35 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 64-v6sm42234940pfq.10.2018.10.18.10.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:03:35 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:03:33 +0000
From:   Du Changbin <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Du Changbin <changbin.du@gmail.com>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        linux@armlinux.org.uk, akpm@linux-foundation.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH 2/4] kernel hacking: new config NO_AUTO_INLINE to disable
 compiler auto-inline optimizations
Message-ID: <20181018170333.ctwhuyecd5m6wxoh@mail.google.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
 <20181018162548.6399-3-changbin.du@gmail.com>
 <20181018125948.789c72de@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018125948.789c72de@gandalf.local.home>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:59:48PM -0400, Steven Rostedt wrote:
> On Thu, 18 Oct 2018 16:25:46 +0000
> Du Changbin <changbin.du@gmail.com> wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > this option will prevent the compiler from optimizing the kernel by
> > auto-inlining functions not marked with the inline keyword.
> > 
> > With this option, only functions explicitly marked with "inline" will
> > be inlined. This will allow the function tracer to trace more functions
> > because it only traces functions that the compiler has not inlined.
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I have acked patch this before, but this particular patch has extra
> changes that I have not acked.
>
Steven, no extra changes made. I just wronly rebased it on top of mainline.
:)

> 
> 
> > +config ENABLE_WARN_DEPRECATED
> > +	bool "Enable __deprecated logic"
> > +	default y
> > +	help
> > +	  Enable the __deprecated logic in the kernel build.
> > +	  Disable this to suppress the "warning: 'foo' is deprecated
> > +	  (declared at kernel/power/somefile.c:1234)" messages.
> > +
> 
> What is that?
> 
> -- Steve

-- 
Thanks,
Du Changbin
