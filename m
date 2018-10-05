Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519EEC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7521473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmccabe.xyz header.i=@cmccabe.xyz header.b="Ys20RMFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1fM4kx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB7521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmccabe.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeJEX0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:26:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45765 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbeJEX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:26:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BAB12076C;
        Fri,  5 Oct 2018 12:27:17 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute3.internal (MEProxy); Fri, 05 Oct 2018 12:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmccabe.xyz; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:date:in-reply-to:references:subject; s=fm1; bh=4En
        BePvNDWk4jCDuF7t+MX8c3GMuZy/PJXIomGtFkDI=; b=Ys20RMFdNEDfMj3RgPd
        keBA3wmd61WVMrA9InthngGWMgZ2jEGsio9MQmgbxRVE+E2rjqfcV2+v3CjL8zyg
        rDZCWS6t1REf5XLW5o7QQYEgbYNuLayqY6n06N7E6Dw5Gc1rEnLym10xhMJcCccr
        AMArJ+EJf4axB5dZXbWg7i49zT7s3z7+71szFTjgSRHPJ+9sYGjeZN3daH01LaVp
        Y1DWDyUNzy4MEG6P2MQShNrtubwCVQBGibla5E4mhKGyM4jESBLMgCQOU7i9njcZ
        T1DcDY26Zj/h259hmna4LnsPDcK3ZGLWhtM+uwC2ldBEeJTZiNAJaP4wFGwsqFWE
        2mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=4EnBePvNDWk4jCDuF7t+MX8c3GMuZy/PJXIomGtFk
        DI=; b=h1fM4kx4gtvMd+rSRpzp61EWJo8LXnRb3Erc87Rsy5q94LeeNo3SUVRSS
        pt+Bfs5k5tsVn2UgsyA81rkChEcvdIf1EGYs03VgAFQNPd0XmIpTalGN0IRmIOBw
        YsQ247XIgCf2NhfymtMQbUPlUOoS8uCjMaQQ2X6j+eYHuDESdBWdq6FcnapPaBOf
        qKFn8jjmdF2gZkc9w/R0CPyqqg5hbvOlJN7EQvoPsQYMKwaFDXPZC2Loh53PQhNY
        k4H+WhFWEjL0WXHgbd2zP+IyQTRF+4rR70PGWfFksh4HMFV/51e02neVqO2Wn6yf
        Nz7KCs4fGyU/rGy9Mc5a/gV1GLOqw==
X-ME-Sender: <xms:5JC3WyOU_3QiwlRK3H7PsBxw45KI6UKUBSCmctzJbU7EZZskLXa_3Q>
X-ME-Proxy: <xmx:5JC3W-NOl3eWC3ApG_5Zea-rZTFk18I31rXZl_Xzg5AOdDK4-MLywg>
    <xmx:5JC3W9eOcCIg5o_xqyC8__4MlQ6yVhwlfM2iiLh-xZKo-gRKMgd3Sw>
    <xmx:5JC3W2zzFX9WCk-ycIxBCzIaIYXj2MeUK7vv5HU_3LL63aQJGd5d-A>
    <xmx:5JC3W3YL4goDQ0IPB3XPLb2OaP3icS3CQo7i3JXCPh5UhQZXU29q6Q>
    <xmx:5JC3W52ZezACDie8gmtjZmebeEd2O7m8BsURdNTouIaS8-X9NrjAAg>
    <xmx:5ZC3W_F4GJlTYl5FdpO_heeM1gCLaVLRvUPVc7F3A7Iaic04v1U7Jw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id AEED9422C; Fri,  5 Oct 2018 12:27:16 -0400 (EDT)
Message-Id: <1538756836.4131485.1532106896.50BF1EF3@webmail.messagingengine.com>
From:   Colin McCabe <colin@cmccabe.xyz>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-929b9749
Date:   Fri, 05 Oct 2018 09:27:16 -0700
In-Reply-To: <20181005113056.55b23c31@gandalf.local.home>
References: <20181002175539.2ac894c7@gandalf.local.home>
 <20181005113056.55b23c31@gandalf.local.home>
Subject: Re: [PATCH v3] tools/lib/traceevent: Replace str_error_r() with an open
 coded implementation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  Did you consider setting the ifdefs you can set to always get the POSIX version of strerror_r?

best,
Colin


On Fri, Oct 5, 2018, at 08:30, Steven Rostedt wrote:
> On Tue, 2 Oct 2018 17:55:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > While working on having PowerTop use libtracevent as a shared object
> > library, Tzvetomir hit "str_error_r not defined". This was added by commit
> > c3cec9e68f12d ("tools lib traceevent: Use str_error_r()") because
> > strerror_r() has two definitions, where one is GNU specific, and the other
> > is XSI complient. The strerror_r() is in a wrapper str_error_r() to keep the
> > code from having to worry about which compiler is being used.
> > 
> > The problem is that str_error_r() is external to libtraceevent, and not part
> > of the library. If it is used as a shared object then the tools using it
> > will need to define that function. I do not want that function defined in
> > libtraceevent itself, as it is out of scope for that library.
> > 
> > As there's only a single instance of this call, I replaced it with an open
> > coded algorithm that uses sys_nerr and sys_errlist error array with
> > strncpy() to place the error message in the given buffer. We don't need to
> > worry about the errors that strerror_r() returns. If the buffer isn't big
> > enough, we simply truncate it.
> > 
> > The sys_nerr and sys_errlist idea was found here:
> > 
> >   http://www.club.cc.cmu.edu/~cmccabe/blog_strerror.html
> > 
> > Cc: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
> > Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > Changes since v2:
> > 
> >   Use sys_nerr and sys_errlist idea.
> > 
> >  tools/lib/traceevent/event-parse.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> > index 7980fc6c3bac..d23d10bc5314 100644
> > --- a/tools/lib/traceevent/event-parse.c
> > +++ b/tools/lib/traceevent/event-parse.c
> > @@ -18,7 +18,6 @@
> >  #include <errno.h>
> >  #include <stdint.h>
> >  #include <limits.h>
> > -#include <linux/string.h>
> >  #include <linux/time64.h>
> >  
> >  #include <netinet/in.h>
> > @@ -6215,7 +6214,13 @@ int tep_strerror(struct tep_handle *pevent __maybe_unused,
> >  	const char *msg;
> >  
> >  	if (errnum >= 0) {
> > -		str_error_r(errnum, buf, buflen);
> > +		if (buflen > 0) {
> > +			if (errnum < sys_nerr)
> > +				strncpy(buf, sys_errlist[errnum], buflen);
> > +			else
> > +				snprintf(buf, buflen, "Unknown error %d", errnum);
> > +			buf[buflen - 1] = 0;
> > +		}
> 
> Bah, I now get warnings that sys_nerr and sys_errlist are deprecated.
> 
> OK, so going back to just using the racy strerror() should be good
> enough, as this incompatibility with strerror_r() is a disaster!
> 
> -- Steve
> 
> 
> >  		return 0;
> >  	}
> >  
> 


C.
