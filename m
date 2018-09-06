Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E39220652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="EhUzZyuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E39220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIFU7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:59:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43126 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeIFU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:59:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id g53-v6so12914859qtg.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w29DW2Vfqsb64YF/CFDEkfLEzFBB5iLBf9jAomVruYQ=;
        b=EhUzZyuBD9KfMw/MW9wcJ3C/5walSCSaycbKfEPDETgwQMPBaBThW5KByCBuJATYps
         YJeqAL8gLrK7ygH7NxKuP4WzZhcQq7eozHLrkqhO+z+GqwFuwszTwD4T7y2/uftwzwkj
         xFlHv97/dhfIKlaNOJRXIMoyymVyjl6qtONctU75wqelq9kYCLGDw1KhJZ45WkiLiibI
         L7+C54v+5dsyvU9MA9ItSnzPq3NOpwqTF+XTG1xbhcJWBdtAalLa0Aq2naSNm+PyG3ol
         8QLM8Vi03TW/TzNTHmBc/zneJonwcoula6Wm2J5wUVsDPVSEUy8ddEl6TMZN/ARfWCAq
         N1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w29DW2Vfqsb64YF/CFDEkfLEzFBB5iLBf9jAomVruYQ=;
        b=KUdnGeME+44t6TwWzq9E6GEq0skiXrtV8j2g9mqqagXcDkvoSGfXJy5vDmp28+T/l8
         4ievJHeDUBCpRmRRo9Qy4Y6EPa9tqma/7n65Hl0PYI49UITHGBqrfESJ16JaOj3na1Iw
         47wLRyIfKKKKlOzPmyVkQErGsqQxYZpYJkaxY4P54yaGka68HqTUsooOZFHRdXasfsNa
         fx3xdoM52+AEG+nltvEI7X0btQ7IsLqQ9XVd2WUE818kldD2kpJOcs5UBgQlajQcnafg
         werKLx1SpmvTNM127CxwR+1QK24LoSyGisRQWIG7fB+jpfmD4q28urMXVUV/QwQyGRIQ
         uizA==
X-Gm-Message-State: APzg51A7OyPWrOCAyIpot3Qbz5Ucdko5KUTtrNEG8s7kKHBdMp3L4hEH
        6CsPRZUw0uqRlzQMmpUq6b6Kew==
X-Google-Smtp-Source: ANB0VdY41a+0aU/jT7PkXI+mRmC4Dd3E/cX+09eTvq9jXNqcHO2EHURg8tMK8mE253aBzla2t818mw==
X-Received: by 2002:aed:3e17:: with SMTP id l23-v6mr2901430qtf.52.1536250970109;
        Thu, 06 Sep 2018 09:22:50 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id n189-v6sm3277415qkn.2.2018.09.06.09.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 09:22:49 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:22:46 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180906162246.GB3326@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:15:18PM +0200, Jann Horn wrote:
> On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > The idea here is that the userspace handler should be able to pass an fd
> > back to the trapped task, for example so it can be returned from socket().
> [...]
> > diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> > index d1498885c1c7..1c0aab306426 100644
> > --- a/Documentation/userspace-api/seccomp_filter.rst
> > +++ b/Documentation/userspace-api/seccomp_filter.rst
> > @@ -235,6 +235,9 @@ The interface for a seccomp notification fd consists of two structures:
> >          __u64 id;
> >          __s32 error;
> >          __s64 val;
> > +        __u8 return_fd;
> > +        __u32 fd;
> > +        __u32 fd_flags;
> 
> Normally,  syscalls that take an optional file descriptor accept a
> signed 32-bit number, with -1 standing for "no file descriptor". Is
> there a reason why this uses a separate variable to signal whether an
> fd was provided?

No real reason other than I looked at the bpf code and they were using
__u32 for bpf (but I think in their case the fd args are not
optional). I'll switch it to __s32/-1 for the next version.

> Apart from that, this patch looks good to me.

Thanks,

Tycho
