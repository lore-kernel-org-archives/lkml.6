Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12492084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12492084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJECet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:34:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34341 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeJECes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:34:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so3635231pgs.1;
        Thu, 04 Oct 2018 12:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9zMW9bERXi3NkWIxlfREGbrXfTxmhtmntbvdycspDY=;
        b=jSSA3uhDFmkzssuahk4Wyqqu/BQRR5ybQHBsBpYtoxdXCxPGVRQsBBS6EMW5QmY8h+
         3LZMXEUipr26e6IbMvkeLgTkfyI8/v9YPuSYX8Go14mggyVozs7scl2nxMtqf6a2AnIs
         1aZ/+rFFEPyRNYq9H51vetP1178V8KB7wRFagT6Fak2ppfJN/12X1SvaGV6eHb9liYC4
         Po8cK66DWwqcG07TPEZBv7n8McivSy8dE0+Bf5b0ydbjk31NAnvqOMR4BVV0Rno42MU0
         XIzg9LKZzeeLLlUjfRraj/uR4fw4TRyXhgWzJ2jtve/bR2REk2hLwfqAZLG0nPCC9mg6
         RNIg==
X-Gm-Message-State: ABuFfojFVC/OkiUS/smo49SsnjaSAj8ClI5bW3ehqVZa5mKeznioP2VH
        SdDOiPTvwjqexhi36Unmxeo=
X-Google-Smtp-Source: ACcGV60RGE7CRqneu6tX9RZu4kc8dbjXM8H/K/1otwN6MJcGQ44JekVSN0BlUSP7ar5KJ0DOiP5KGw==
X-Received: by 2002:a62:5b85:: with SMTP id p127-v6mr8296888pfb.33.1538682004908;
        Thu, 04 Oct 2018 12:40:04 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id i186-v6sm12727370pge.80.2018.10.04.12.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:40:03 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 04 Oct 2018 12:40:00 -0700
Date:   Thu, 4 Oct 2018 12:40:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     michael@schupikov.de, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] kernel/sysctl.c: remove duplicated include
Message-ID: <20181004194000.GI5238@garbanzo.do-not-panic.com>
References: <20181004134223.17735-1-michael@schupikov.de>
 <CAFLxGvw6tsdO2rqH1XzW84jN5kRqjzMP+cLtKhkDU1MtYUgJow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvw6tsdO2rqH1XzW84jN5kRqjzMP+cLtKhkDU1MtYUgJow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 04:10:14PM +0200, Richard Weinberger wrote:
> On Thu, Oct 4, 2018 at 3:48 PM Michael Schupikov <michael@schupikov.de> wrote:
> >
> > Remove one include of <linux/pipe_fs_i.h>.
> > No functional changes.
> >
> > Signed-off-by: Michael Schupikov <michael@schupikov.de>
> > ---
> >  kernel/sysctl.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index cc02050fd0c4..523cb36b72eb 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -66,7 +66,6 @@
> >  #include <linux/kexec.h>
> >  #include <linux/bpf.h>
> >  #include <linux/mount.h>
> > -#include <linux/pipe_fs_i.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/processor.h>
> 
> Reviewed-by: Richard Weinberger <richard@nod.at>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
