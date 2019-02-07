Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC95C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB62147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAhXqKM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBGGig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:38:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40668 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfBGGig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:38:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so4083060pgp.7;
        Wed, 06 Feb 2019 22:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ff/A2SLuwUiDcDJNXB6Y/JYR4znirC1CDHnoU+YD4pE=;
        b=fAhXqKM+W7C6Pt2b0EbDaC1XVfMsNV+ZYxafiRK2r1oIM6tDIdPIoyfRMc7sIdVf5/
         Iq2vnlSkXPbFYlSjppreR7ghdtpHhmOxJhzhGAgTQWUqetea+votUVT3brBQA1s0krf7
         SRaDk1Z5iBrtx4j8QejOSHxCNjItkFSnUDzua+zy+Xf+UZWJKc3XQzn+7uJPVNgn2JDT
         Yez704+5UXYZYUUnzwS18xAzm/LcyWH0pgoDv8ff/TxkUqwJoe4LgFS2eAfCUC33aMd9
         7rs6rDqAgM96D+rgClsWlrKgXlya+BFMEC5zUu942jWJ87MERvTZV9HCAtnCoXvcpz3q
         bTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ff/A2SLuwUiDcDJNXB6Y/JYR4znirC1CDHnoU+YD4pE=;
        b=H82fxcqPw5gZj+Zs68pOvJ6FKmxncQkjqsN5Yk+uoGi35OPzQs/QooB0Pl8URwehDr
         pJorYYRFvLrAIKtOef/IXgGp7wrfEYEd8Mh/7Tplo20qN52eKmQTuvq7rzHYTeyUnzsS
         GmRBl6EkBTsW75STfFOy+IMmiicJ9i+U6FryLjqXwSgJy/xialhdQIt64pY5FjPbowPA
         yWvLmAqSdt9K2heimtzM8zqFVVLWmInOSnz677p0/9N9Cr49x8C/Ns4bWD3bmslpvXln
         0Y6UeGAl81F8BuhJeCH5PGoMrVtu91Th+rpwOzjN/YVnhnw1gzrpFgTVdlRJUiTltZAk
         gkFQ==
X-Gm-Message-State: AHQUAub2bdhsb+OvjBgHTuO0HA3O3O82nte9DSfstaGIGhCLf30ib3Xc
        mnmxQ5z2GGJKIVfkfYXhgL4=
X-Google-Smtp-Source: AHgI3IZfqppa3gybnlxj1IqEHIQHK1WnYvlXN+4UslFnJ+y2M3Qpmxiz02UNVCBjKGqTY0FDJQjFsw==
X-Received: by 2002:a65:6294:: with SMTP id f20mr6019170pgv.174.1549521514766;
        Wed, 06 Feb 2019 22:38:34 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id n74sm27017184pfi.163.2019.02.06.22.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:38:34 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:38:31 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 05/32] timerfd/timens: Take into account ns clock offsets
Message-ID: <20190207063830.GB24912@gmail.com>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-6-dima@arista.com>
 <20190206085203.GB25251@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190206085203.GB25251@uranus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:52:03AM +0300, Cyrill Gorcunov wrote:
> On Wed, Feb 06, 2019 at 12:10:39AM +0000, Dmitry Safonov wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> > 
> > Make timerfd respect timens offsets.
> > Provide two helpers timens_clock_to_host() timens_clock_from_host() that
> > are useful to wire up timens to different kernel subsystems.
> > Following patches will use timens_clock_from_host(), added here for
> > completeness.
> > 
> > Signed-off-by: Andrei Vagin <avagin@openvz.org>
> > Co-developed-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  fs/timerfd.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/timerfd.c b/fs/timerfd.c
> > index 803ca070d42e..c7ae1e371912 100644
> > --- a/fs/timerfd.c
> > +++ b/fs/timerfd.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/compat.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/time_namespace.h>
> >  
> >  struct timerfd_ctx {
> >  	union {
> > @@ -433,22 +434,27 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
> >  }
> >  
> >  static int do_timerfd_settime(int ufd, int flags, 
> > -		const struct itimerspec64 *new,
> > +		struct itimerspec64 *new,
> >  		struct itimerspec64 *old)
> >  {
> >  	struct fd f;
> >  	struct timerfd_ctx *ctx;
> >  	int ret;
> >  
> > -	if ((flags & ~TFD_SETTIME_FLAGS) ||
> > -		 !itimerspec64_valid(new))
> > -		return -EINVAL;
> 
> Please don't defer this early test of a @flags value. Otherwise
> if @flags is invalid you continue fget/put/clock-to-host even
> if result will be dropped out then.

Cyrill, you are right. I moved this check together with
itimerspec64_valid(). The idea was to call itimerspec64_valid() after
applying clock offsets but for that, we need to know clockid.

Let's wait a bit for other comments to this patch set and then we will
fix all things what will be found.

Thanks,
Andrei
