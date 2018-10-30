Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E747C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F210E20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pn613Bh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F210E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJaBeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:34:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44238 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeJaBen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:34:43 -0400
Received: by mail-io1-f68.google.com with SMTP id c6-v6so7651271iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfS6KoU32w9BT0xsemMgbsjrnSc7TivyeZsvun1cINw=;
        b=Pn613Bh6Ki/3l3lw984fWyNienOtpe8vsc2BQA0MgrSFaqjVLm8dj4IW0hjjrt6UKN
         +Fof2cQdGBodfvKAubfU9P5KiKudgjzS5A6esTXeRwHY9ajyjkGsa3Sss9q/7pUGsRM+
         Zt0Vo390S57GPnND2B5X2nRQ48YSchJfMgNp556LnaLOGe+KHjdMOq3o2ZbVCXv8y/WP
         wVPH579NzIm8sUaOmQv0ZMm/9Gn7Rjiv0Lu67NQ8+Bz88khsVl8Vy/JQhG8i/k9P4z2k
         wyP9tWr3EZOqCjlsNn68RYtxlqDOSTdNiMUQJCMjXD7/imeo0OlU9JS/uKZmaGrrlrXJ
         FaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfS6KoU32w9BT0xsemMgbsjrnSc7TivyeZsvun1cINw=;
        b=lFR0mK6Cn9Po9r2muf9yFpNstEOUG6HNeKbczLej5bpLjmNwzHTVTmno6cJSBNgy6n
         AXVxj21tvZU3CIm9DN2Mpuzjblx2HDJWdrGm0FBhZr7O+sSMoWMmYGxTZ+QETOnM/RoR
         T3fxFLoCuFWLQiTuhjuBKlaWPqgoymltw7mBeHgMOHkVlWScFdHiQQZ+c+oNWp3/211Y
         WY77K5qjecJakO9SM+o2NhHvWb7OQmqLNegf4FK6Ue0rfnLABcnvDt+WBQZlm4o02e3t
         lpYuVAKpOluI/5v8PvP6rkvMkzzzxV6HSg24EqK7d+MD81SWw6SodqIrOypC8VfGSiwC
         N5+Q==
X-Gm-Message-State: AGRZ1gKwS6/rQv4oP2/B7TPziI1FRrH4Zn71z7Rx/aUtclA4mkkL6VMZ
        hJ6ZkSvNJf6UTWTqR+vGid0xlA==
X-Google-Smtp-Source: AJdET5dJSOT1VIPdVjFPaN5zvhuPCKtmNV6No2EH9bhzawQrB7kBczGDY3DZBiSq+TTP1H1pc3AWWw==
X-Received: by 2002:a6b:6818:: with SMTP id d24-v6mr11705776ioc.293.1540917630553;
        Tue, 30 Oct 2018 09:40:30 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:d68b:e645:8da4:bbe1])
        by smtp.gmail.com with ESMTPSA id v134-v6sm9180609ita.23.2018.10.30.09.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 09:40:29 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:40:27 -0600
From:   Benjamin Gordon <bmgordon@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc: use ns_capable instead of capable for timerslack_ns
Message-ID: <20181030164027.GA184838@google.com>
References: <20181017224738.193598-1-bmgordon@google.com>
 <87in1pn9d0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in1pn9d0.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 01:56:27PM -0500, Eric W. Biederman wrote:
> > Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
> > in its effective capability set, but the current check looks in the root
> > namespace instead of the process' user namespace.  Since a process is
> > allowed to do other activities controlled by CAP_SYS_NICE inside a
> > namespace, it should also be able to adjust timerslack_ns.
> 
> The goal seems legitimate.  However the permission checks look wrong.
> 
> In particular the choice of user namespace should be
> "p->cred->user_ns".  This will limit this to tasks that have
> CAP_SYS_NICE in the same namespace as the task that is being modified.
> 
> Testing file->f_cred->user_ns it is testing whoever opened the file and
> that could be anyone.

Thanks, that seems like the right answer here.  I'll send a v2 to fix
it.

Thanks,
Benjamin
