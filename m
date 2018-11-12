Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB2322419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="znatyHsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB2322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeKMEuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:50:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54037 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:50:11 -0500
Received: by mail-it1-f195.google.com with SMTP id r12-v6so14207584ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jy8dt7nfYXm2bU+vklele1Ugeqqnphq1OlnLRaIukdw=;
        b=znatyHsE9yS2g0pHtK+OorkFiwHBjP3w5RVDZsXwtCEwt1zTBaKjbmTpUM9YuG9JMC
         s9cf+D/QWyTrjTlwXEAPGDZLz6qmUxeQYVy8KNCIdDH6xwblEFyA3AF5hpXt+2/cq5HE
         eHdHS5p7gDbEDEwPEX2jdY1m6ik3p4tM0XzhqsokstepMO3Ue7XCkEBtG0Rgv3P56M3U
         szRnNIGwTDOd4Nt09xJK+a2+plILEDwnyBWj+G7xP4jamH5x9YjRUV34Wc2fZXq2TAx6
         XJzg3Vz0RouwQL9eindq+USAKurlP6yWL9LZzyFZ9hwEWPmcPpNMx9XoXwM+Q44uJqcD
         GtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jy8dt7nfYXm2bU+vklele1Ugeqqnphq1OlnLRaIukdw=;
        b=Jjs7VX98EMq0zp1K+fKDuY5bS6M2mpNTqDUo+fg4MP/4si6WeU3YSxpCuB+ocVg7CV
         NH8qydheENXlpj/Gd01X85vJH8F32HMnb8L8Lx1R5fJmk7pR9Db5tZzk2vc2FVzXlCBi
         lNy8LdTuk6xkGX7fCmGLHHprHlRYP089hLJXTIXgCC2LZNsH+LfDyHdZ3gMOFpm0bDXW
         +5CqN/AbXd+OSrvZboqv9DCdG6Py6rUSkMCKSs9UY1xJj+p3Yt/DlfQqUTaco2tfdygP
         sS0VGWcpBB+96iLMiPJi8KAnKr3OVL6+/pd/spPJkhPAKCXy4jAMd9lVYyxgv5nEpQ6i
         +07A==
X-Gm-Message-State: AGRZ1gIzzDDGQwr3uWc+6TAcWhPatoPJ+BTn30rTEYNGaJ6JFhDeXqkx
        hbs1UIJn+PGQNQXFHLSONLRTPw==
X-Google-Smtp-Source: AJdET5ek3hsuAD6k7/6ic18zepkQX2uVIYmoJCKnlKR6O5SqeqdZWvphcKrGMQU4eY1D4hPRBRXfbA==
X-Received: by 2002:a02:330d:: with SMTP id c13-v6mr1933850jae.86.1542048940589;
        Mon, 12 Nov 2018 10:55:40 -0800 (PST)
Received: from cisco (75-166-182-157.hlrn.qwest.net. [75.166.182.157])
        by smtp.gmail.com with ESMTPSA id m142-v6sm5384949itm.8.2018.11.12.10.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 10:55:39 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:55:38 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181112185538.GK3645@cisco>
References: <20181112171144.GI3645@cisco>
 <87efbqi1xa.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efbqi1xa.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:30:25PM -0600, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.ws> writes:
> 
> > Hi Oleg,
> >
> > I've been running some tests on my seccomp series, and in one of the
> > tests on v4.20-rc2, I noticed,
> >
> > [ RUN      ] global.syscall_restart
> > seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (1492) == info._sifields._kill.si_pid (0)
> > global.syscall_restart: Test failed at step #22
> >
> > which seems unrelated to my series (the kernel was stock v4.20 with my
> > patches on top).
> >
> > I've been running a lot of tests, and only seen this once, so it seems
> > like a fairly rare race. I tried to look through the code but didn't
> > see anything obvious. Thoughts?
> 
> My guess would be pid namespaces, or stopping for a signal other than
> SIGSTOP.
> 
> If you can get this to reproduce at all it would be interesting to see
> si_signo and si_code.  So that we can see just which signal is in info,
> and how it should be decoded. 

Sure, here's what I see,

seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (2195) == info._sifields._kill.si_pid (0)
seccomp_bpf.c:2785:global.syscall_restart:si_signo: 19
seccomp_bpf.c:2786:global.syscall_restart:si_code: 0

> I see this test at line 2736 in 4.20-rc1 so there are almost 50 lines of
> change in your version of seccomp_bpf.c.  So I hope I am reading the
> proper test.

Yes, sorry, that's additional test stuff from my user trap series. I
haven't manage to reproduce it on stock v4.20-rc2, unfortunately. It
could be that this is some memory corruption introduced by my series,
but I'm running these tests with KASAN so hopefully it would complain?

Tycho
