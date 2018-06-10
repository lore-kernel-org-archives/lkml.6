Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Q9upMiDWHFsqWwAAmS7hNA
	; Sun, 10 Jun 2018 07:41:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B499660850; Sun, 10 Jun 2018 07:41:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjY7p8G5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 28EFD604D4;
	Sun, 10 Jun 2018 07:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28EFD604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeFJHlQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 03:41:16 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46586 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeFJHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 03:41:14 -0400
Received: by mail-ua0-f193.google.com with SMTP id e8-v6so11546700uam.13;
        Sun, 10 Jun 2018 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LYdEpi30ftsqOsMFpOx/lypTOIevXtyH+Nlj0s334xs=;
        b=fjY7p8G5hlXZElMufyMhuqjj6JkyyzAWlTCxxOPRheIsncV0LQjIOobMS0fQsJjZVi
         KBMffL3S+iBMyIPVoCf3dDUe8M8sNTqvPqzGLjmZ9Z01XaALB8aoTdPE9HTpN5mxL2CS
         DSxYgn0LCRocUo+0H0T2mhFeLRMyHNxhxwQ18/JexImZ1r+lDLjZ8VjPb/uwq73Kr6DI
         z+JdsZeoCF6Xh52ll7qvdF6fQwHM23TJNhtGXQlGC+igsY0n4kC4mFx8KFuYFN3fsjoC
         sewLHhLtu101veeRSukdnFYgG/2+rKtYNj7RwOZc2OmSvvwnmMb5NX9xxDh0UDgn3Nrp
         7ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LYdEpi30ftsqOsMFpOx/lypTOIevXtyH+Nlj0s334xs=;
        b=eeYMBSKpNPa+/HCw/jH490eodP/5gS8PRkvXNAkPAzA/JQVoC9xQfn2kXVDJx/ccCJ
         3v0wjy9FwtuEsIQKQtFbMcqpfpvmsvC5Ph+jl61DaMZPOPYdgJOK8s068HXuGXi3ZbaI
         iO2YQSmY4H785JGPF9AISEt/gxsboOFrE2qqCCZ96GoJji2v1tmnxu3b0dwEGWzuWa46
         lMboylAriL/9f5P1Tut/jKUpMmAIT4W4NZyXfTEaOAc+GmnRwQiayHvE42e1plY8Ek/p
         UA1ukJ6cYiA8YAP8xZkshucMthgBVfwOS4J8q6JFq4CaXGI26DdDv0EkWy2w9mII5NnS
         u9jQ==
X-Gm-Message-State: APt69E3VkYPa5C2Am5mSo0cCFIGmFpDoT8kArCEqsu2xwEg6KbPCt+rj
        On6cN2a460LguVHRKYV4547K4UJDi80DIdGlqNc=
X-Google-Smtp-Source: ADUXVKJ6jR29UrWUtULzPZFoVJjo7kd5AiYu+m4FI6bEeasd5Blz0tor0jB9lKrb55PENiFCkokjF7nqXo302iWpRis=
X-Received: by 2002:ab0:987:: with SMTP id x7-v6mr8408650uag.131.1528616473703;
 Sun, 10 Jun 2018 00:41:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7c88:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 00:40:53
 -0700 (PDT)
In-Reply-To: <CABxV-EWN8ag2zk2CDxWyC3+DvuM3ADbf=qGm4uczK8YnOd5JBQ@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
 <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
 <CAJHCu1Ky09DWskcD4nVW5u1C5faWMv1A4kcxWzdiap7+G1SPkg@mail.gmail.com> <CABxV-EWN8ag2zk2CDxWyC3+DvuM3ADbf=qGm4uczK8YnOd5JBQ@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 10 Jun 2018 09:40:53 +0200
Message-ID: <CAJHCu1LMzXeySHDXyXNpDbVjD2Lpu-dNTXFm3YhEuTnrU0tA9A@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Steve Kemp <steve.backup.kemp@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-04 18:57 GMT+02:00 Steve Kemp <steve.backup.kemp@gmail.com>:
>> A configurable LSM is probably the right way to do this.
>
> I wonder how many out of tree LSM there are?  Looking at the mainline
> kernel the only "small" LSM bundled is YAMA, and it seems that most of
> the patches proposing new ones eventually die out.
>
> I appreciate that there are probably a lot of "toy" or "local" modules
> out there for specific fields, companies, or products, but it does
> seem odd that there are so few discussed publicly.
>
> (The last two I remember were S.A.R.A and something relating to
> xattr-attributes being used to whitelist execution.)

FWIW S.A.R.A. is not dead [1].
Unfortunately it needs infrastructure managed security blobs, so I didn't
tried to get it upstream, yet.
Of course, I can't give you any guarantees about when or if it will be
upstreamed,
but it's definitely still alive.

[1] https://github.com/smeso/sara/releases/latest
