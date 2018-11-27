Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF262086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnV7TnO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF262086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeK0Rey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:34:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeK0Rex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:34:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so7386907pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 22:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FCOOcHkAfoAGjfJYYFY3kt7fdCfH3+5Z87al/sdnHNI=;
        b=VnV7TnO3TV54TrSNlbNbMpS7TKGug7hrNF3EyS7oZtQDTRZmvLrjYp1uR8d3TuLhvv
         aMJX9nh61MKW73x/X3h9SxJjmMIpy6WuYKGtcA8LB659gBFQtQUU0anHzxJcLVQKYtD8
         XoFvqRR3x9c6OuQ1EBOEEWvmx/RVUb31Z45TPrfqQhViZz1zddYGs6jr7dTuyi93RfkA
         Gz80NQ1jTl7WisF4R0ZIFv031nxRN+fJ2lA05FTHx5O/ECvscpLechf8p+8ey3PXAjDX
         pLX8kd/O+Dy00vFwQPEpjilgVf8W079VKudgA01+gumZNPDEmz6ZPYBDsmcbYDVRevVC
         okxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FCOOcHkAfoAGjfJYYFY3kt7fdCfH3+5Z87al/sdnHNI=;
        b=DuJ/egysFJ0UvDbD1yXdlzrkF4pd7KaoN/DaB8A0xhKX4CC16jgozyZNmbbGp+KMuT
         vuhNIs4U6UEyQy8JtAzhDtWvZNVzng1DUEYPP7Bys9nax0gvqTJRaDHwyfdkUJpLh/ep
         jgZzF9PeMNue0JITscmuokDGFStv6ijBMVVAFhVh32XsGXqKRB0///nlbLWlLpAzicFE
         zG/muL4usvciJc9jX3z43PStvNRLRzdY1yTO6M1fycWHFORWC2j2IbvoRlZ0jx7NO82N
         Xhoj3vrr1yeHqVDtY9ORDcYaJDCA3hpsDWeBxhZKmVKThgcYLuiyh8Hx5r8xA1pWTz1S
         0ugw==
X-Gm-Message-State: AA+aEWb/VIV1P5Z/2TZwqz34pQ3xXGYlVNjaNwZv55gKTy46EBWEntMp
        2FaJkrU5ZJQqkP+fX3S2MXj2Bh+6
X-Google-Smtp-Source: AFSGD/Uz8qGbU1l3O6bulSxOaa6S3asH+vjd8hwh+y/fBJF8P7lBjdfCbfj0MINKB42CpNrVSDgDEg==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr27130365pgc.215.1543300682949;
        Mon, 26 Nov 2018 22:38:02 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id r4sm2959982pgn.54.2018.11.26.22.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 22:38:02 -0800 (PST)
Date:   Mon, 26 Nov 2018 22:38:00 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ptrace: take into account saved_sigmask in
 PTRACE_{GET,SET}SIGMASK
Message-ID: <20181127063758.GA10422@gmail.com>
References: <20181120060616.6043-1-avagin@gmail.com>
 <20181122114751.GA28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122114751.GA28270@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:47:52PM +0100, Oleg Nesterov wrote:
> On 11/19, Andrei Vagin wrote:
> >
> >  	case PTRACE_SETSIGMASK: {
> >  		sigset_t new_set;
> > @@ -962,6 +971,8 @@ int ptrace_request(struct task_struct *child, long request,
> >  		child->blocked = new_set;
> >  		spin_unlock_irq(&child->sighand->siglock);
> >
> > +		clear_tsk_restore_sigmask(child);
> > +
> 
> I am not sure I understand this change...
> 
> I forgot everything I knew about criu, but iiuc PTRACE_SETSIGMASK is used
> at "restore" time, doesn't this mean that TIF_RESTORE_SIGMASK/restore_sigmask
> can not be set?

PTRACE_SETSIGMASK isn't used on restore. On restore, criu generates
sigframe and calls sigreturn to restore registers, fpu state, sigmask
and resume a process. šWhen the kernel constructs a signal frame, it
calls sigmask_to_save() to get a process signal mask. With this patch,
PTRACE_GETSIGMASK returns the same signal mask what is returned by
sigmask_to_save().

In CRIU, we don't need to set TIF_RESTORE_SIGMASK, because all processes
are dumped when they are in user-space.

> 
> IOW, could you please explain how PTRACE_SETSIGMASK should be used, and why
> it doesn't do something like
> 

CRIU uses PTRACE_SETSIGMASKšwhen it injects a parasite code into a
target process. In this case, we have to be sure that when the process
is resumed by PTRACE_CONT, it will not start handling signals and
executing signal handlers.

> 	if (test_tsk_restore_sigmask(child))
> 		child->saved_sigmask = new_set;
> 	else
> 		child->blocked = new_set;
> 
> which looks symmetrical to PTRACE_GETSIGMASK?

If we set child->saved_sigmask, the child can start handling signals
which are not set in child->blocked.

> 
> Oleg.
> 
