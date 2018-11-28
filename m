Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACAEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E2720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E2720832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeK2IDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeK2IDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:03:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0318230C583F;
        Wed, 28 Nov 2018 21:00:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2165819754;
        Wed, 28 Nov 2018 21:00:00 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org
Subject: Re: [PATCH] procfd_signal.2: document procfd_signal syscall
References: <20181119103241.5229-1-christian@brauner.io>
        <20181119103241.5229-4-christian@brauner.io>
Date:   Wed, 28 Nov 2018 21:59:52 +0100
In-Reply-To: <20181119103241.5229-4-christian@brauner.io> (Christian Brauner's
        message of "Mon, 19 Nov 2018 11:32:40 +0100")
Message-ID: <87in0g7waf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 28 Nov 2018 21:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> +.\" Copyright (C) 2018 Christian Brauner <christian@brauner.io>

The text seems to be largely derived from rt_sigqueueinfo, so I'm not
sure if this appropriate here.

> +the null signal (0) can be used to check if a process with a given
> +PID exists.

What does this mean if hte process is identified by file descriptor?

> +.PP
> +The optional
> +.I info
> +argument specifies the data to accompany the signal.
> +This argument is a pointer to a structure of type
> +.IR siginfo_t ,
> +described in
> +.BR sigaction (2)
> +(and defined by including
> +.IR <sigaction.h> ).
> +The caller should set the following fields in this structure:
> +.TP
> +.I si_code
> +This must be one of the
> +.B SI_*
> +codes in the Linux kernel source file
> +.IR include/asm-generic/siginfo.h ,
> +with the restriction that the code must be negative
> +(i.e., cannot be
> +.BR SI_USER ,
> +which is used by the kernel to indicate a signal sent by
> +.BR kill (2))
> +and cannot (since Linux 2.6.39) be

Obsolete reference in this context.

> +.TP
> +.B ESRCH
> +The process or process group does not exist.
> +Note that an existing process might be a zombie,
> +a process that has terminated execution, but
> +has not yet been
> +.BR wait (2)ed
> +for.

Again: What does this mean if the process identified by a descriptor?
Does a process in zombie state exist in this sense or not?

Thanks,
Florian
