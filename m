Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DFBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4723C40
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rszLokPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB4723C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934084AbeFVCQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:16:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37795 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeFVCQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:16:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so650021wmg.2;
        Thu, 21 Jun 2018 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JbndTnYc3Q3Dqvmu4J4c1v+h6gLXYgoIfJasBccAGE=;
        b=rszLokPwx2q7OqPtTz1xpnXWeEchjLFuIMsh46y1VBO8Y4oO/HhLmGPMwXs9Cz4VYS
         xqbNA1UxHVoKChH4IcwMoWz7eFUk+HwFNrLZTs/A/IKYNtzzAiFS9Ve0FL6qNweoI+r3
         dWsrhgQe706eyJxGqzMIOZnEu/mnY+S8g9Ad1fGqRB5kJXevx8ICKWRblZpor3+kRUqo
         7V2kdfz/v1eItRDF9cOown8+DACmPHP7o9s28N9ZpgRbd8HQVgXvFY2P/MW8xfG24eRW
         7NHm9zljzUgpj9JH46eIoLaXkkjKcoK3rAAk9YFTNQaXS+JcqcAXGrV8Iwp3TMZ8LVOg
         ZkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JbndTnYc3Q3Dqvmu4J4c1v+h6gLXYgoIfJasBccAGE=;
        b=nsjj8cj1tWJKTyjTGAxb77Hu4EYEaVZMAC2XqIvOwsiIVanzzQ+K/i8xJXv6ms/nGI
         sYvX67f1NH4TIWVKSwzWUSYUCI3rA9SGvWmUodKpV/RlfmkfHIJnIikxAZd8pRcG7uZQ
         2gvsuBc7Hl6ka2EpR563rnbvk0mvXKiEdNV7HumovpEUCQ5IAEZCHWpRLoE/DPDhQYSk
         PbEEE3qzXffJ7t39yCDXIfKX7e27uxAD6y91QZTL0fyTlHY016SIAAwiG8eDw+OGt8ft
         7bDDseJo+U+1utmkEaQ2PyOplzSJC6A6KPKOJ/SVCsy1DGI06cHY9NdpGSK6VMglGKYF
         aj1A==
X-Gm-Message-State: APt69E3yhNC1Ik+cqr7Zv+j7I5Xv56ZXyYM9EvbVFzk9lIak6SDc3mRE
        CMdN9gzYqPPFpazxOaURC0A=
X-Google-Smtp-Source: ADUXVKIaiQOoqMx0ZntTCUoE2bOwmbhfSxMFsogX9d2OrKfTd9nHTu4Fbs5HJslUVDo27w0ve5R+Aw==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr45052wml.5.1529633799251;
        Thu, 21 Jun 2018 19:16:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o13-v6sm388305wmc.8.2018.06.21.19.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 19:16:38 -0700 (PDT)
Date:   Fri, 22 Jun 2018 04:16:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180622021636.GA11266@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
 <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
 <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> However, the other question that has to be asked then is whether
> there is anything wrong with wait4()/waitid() and getrusuage() that
> we want to change beyond the time value passing. We have
> answered a similar question with 'yes' for stat(), which has led
> to the introduction of statx(),

So we are thinking about adding wait5() in essence, right?

One thing we might want to look into whether the wait4() and waitid() ABIs could 
be 'merged', by making wait4() essentially a natural special case of waitid().

This would mean that the only new system call we'd have to add is waitid2() in 
essence, which would solve both the rusage layout problem and would offer a 
unified ABI.

If that makes sense (it might not!!), then I'd also modernize waitid2() by making 
it attribute structure based, have a length field and make the ABI extensible from 
now on going forward without having to introduce a new syscall variant every time 
we come up with something new...

I.e. how the perf syscall does ABI extensions: we've had dozens of ABI extensions, 
some of them pretty complex, and not a single time did we have to modify glibc and 
tooling was able to adapt quickly yet in a both backwards and forwards compatible 
fashion.

Another, simpler example is the new sys_sched_setattr() syscall, that too is using 
the perf_copy_attr() ABI method, via sched_copy_attr(). (With a minor 
compatibility quirk of SCHED_ATTR_SIZE_VER0 that a new wait ABI wouldn't have to 
do - i.e. it could be made even simpler.)

This way we only have:

SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr, unsigned int, flags)

But even 'pid' and 'flags' could have been part of the attribute, i.e. one we pick 
up an attribute structure from user-space we can have really low argument count 
system calls. This also concentrates all the compat concerns into handling the 
attribute structure properly - no weird per-arch artifacts and quirks with 4-5-6 
system call arguments.

Thanks,

	Ingo
