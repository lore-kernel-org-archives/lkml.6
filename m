Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58103C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2661820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550770468;
	bh=e8dz5AHm8H2PJh36XS08gj1aFt155We2QyapPmI7e1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uFNFgJxBaJWaGsE3Nk91UwbOZ8SnNUo2UJBTQnR4lg8crjDZnO6jcS3e83tdzdNlb
	 +b7+5WyGyfnNA56fB7g/Aq2jXPpY7nSfP6iqYluRmF4IJ2L5tezzyHddUtLtVW64Q6
	 QX2h4C8actehRwc0EHgDjHmqPc2YCwzMUa+JX68U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfBURe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:34:26 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42504 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBURe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:34:26 -0500
Received: by mail-yb1-f196.google.com with SMTP id j189so11188412ybj.9;
        Thu, 21 Feb 2019 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZd5V90RuKK+ZbKvrS8KZJwldBEBUcHT50D54ZP9GEs=;
        b=hK9JSeTVv0HCK65Qnku4+5Kl4Tc7KVtEQV68EPlOVwGF/ZY1amMKgBdiIrDc/PLk4X
         Wkka0YqLmFOToI1gEeSo2PDxU1yOz7ka8tlrFeB9n9LPfFHH+u7jQLJN17qWnraLO2v1
         SCVYD1h/iC5xcvt7Zy/MKztao0MuT68+1CYYafmm3WJPl+wYIR+wIej1nGDVK8/NokUB
         7FCryMTYRVLITDtzKwN6drLI2TbNfWvevtUYzGjr0AkWGwJHYZfdkicZhpiBXOd5Wrc8
         m3Vz4ofkNF0iyrVOBEGQmoxAVNKE6x91UdPSIItQM1Llp9cCsTqAFeKuPw0rsz+uvosD
         xDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZd5V90RuKK+ZbKvrS8KZJwldBEBUcHT50D54ZP9GEs=;
        b=iHhLGBF5NrxsJ2+d28j2tUqWigqTyT4pczPrmMx1k+eg/ERJWsKVa+4TvmCxFn+WPD
         r6wMfYl5YM85pKWSq9zygDbde//Ug7FEcSHf3OyhjkPbJH7zPuM1KHQrIJQCh1Te3Kde
         m26pd7BSuW9lmuA1o7lbW9DG2AjqjCz6ijmFmmMEmfdZz5WRwjHhhEBxReDWRF/V0g7B
         wdG0LyHCb0BczBJeFiI6U1q8b7oXpz3zkHch+9cbup/FGWPAoTpo1yW37nkCi3G9YpGV
         IqYl2T0hZIUkMbOgFGeiJ3L1ralAYqM46B5PTKb69QJ5xp6wcmD7g+qE9KU9u0UDuFQH
         PwGg==
X-Gm-Message-State: AHQUAuacAvWUoR9rjW3/rsi5XBb+2xN303oSut2iJaJECVvTZ1I5IBst
        cB01dWX26NPcz2ylUluSfdg=
X-Google-Smtp-Source: AHgI3IY4Due4D3xFTcz8nYkn7tCaWbjkkR9v/rr7ae4KjDfvWJafAunLUlBSh1ERkk9NOC8HAcatgA==
X-Received: by 2002:a25:6b50:: with SMTP id o16mr20283521ybm.391.1550770465337;
        Thu, 21 Feb 2019 09:34:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:7a2b])
        by smtp.gmail.com with ESMTPSA id b188sm14406580ywa.58.2019.02.21.09.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:34:24 -0800 (PST)
Date:   Thu, 21 Feb 2019 09:34:22 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Roman Gushchin <guroan@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190221173422.GY50184@devbig004.ftw2.facebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162923.GA26064@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg.

On Thu, Feb 21, 2019 at 05:29:24PM +0100, Oleg Nesterov wrote:
> But to me this is a reasonable trade-off because this way we do not add
> additional complexity to the kernel.

So, I really wanna avoid allowing userspace to cause D state sleeps.
It's not impossible to work around but becomes really nasty.  For
example, imagine a memory pressure based userspace oom handler issuer
kills based on per-cgroup pressure metric (as oomd would do).  It
might not necessarily have the insight that a victim cgroup is frozen
or whether it can move out its members to a different cgroup (in a lot
of cases that will cause a lot of confusion in management software).

The frozen state in cgroup1 is a new task state which is different
from all others and in a nasty way and it has been causing various
confusions and mistakes from its users.  We really should make it
closer to the existing stop behaviors even if that means more
complexity in the implementation.

> Actually, "killable" is not that difficult afaics. "ptraceable" looks more
> problematic to me. Again, user-space can do
> 
> 	1. PTRACE_SEIZE
> 	2. move the tracee to the root cgroup
> 	3. do anything with the tracee
> 	4. move it back

which is fine.  The goal isn't trying to block userspace from doing
things that it explicitly wants to do.  That's fine.  We just want
things like killing and ptracing to behave similarly to other stopped
states (ie. avoid introducing completely new behaviors).

> But there is another case. If admin wants to freeze a cgroup then it is not
> clear why a user which can send SIGKILL to a frozen process should wake it up.
> 
> ------------------------------------------------------------------------------
> Again, it is not that I hate the idea of killable/ptraceable freezer. Just I
> personally think it's not worth the trouble. Perhaps I am wrong, but so far
> I do not see a good implementation...
> 
> And, apart from reading/writing the registers, what can ptrace do with a frozen
> tracee? This doesn't look like a "must have" feature to me.
> 
> At least, may I ask you again to make (if possible) a separate patch which adds
> the ability to kill/ptrace?

ptrace support is a lot less important than kill for sure but if at
all possible I think it'd be better to have it because that makes the
frozen state closer to other stopped states and thus less surprising.

To summarize, the ideal result is the frozen state to be "stuck in
jobctl stop loop" but except for looping in it no different from
regular jobctl stop.  Plus, register state examination is already
useful for frozen cgroups for debbugging purposes in itself.

Thanks.

-- 
tejun
