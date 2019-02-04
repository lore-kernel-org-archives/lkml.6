Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0795C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56E42082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="HMUACkQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfBDPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:10:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42618 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfBDPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:10:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so131731edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32Cc5ZaLpXCG5C97IKMd1bhKy4dPC8hpFHY1eIXSExM=;
        b=HMUACkQUMsW/dXGA2iaNdvGQf2+Pr29lIitYQAiDecYqgE35Wb7rxztU/RZEl5lOf5
         EydI0NLdVXDRdBr2PNPEpNbc6iCAY6A/BxyycOwgSn1XfN63ulT4xHxnjMiJvE6ni18o
         3oDY/g3aJsfTQOhuoBQR5k+xGwYrBI+jfCu5PxwJjH+cCZM3EoGKZ+pKksOsZ/bXtqh3
         VgdzoBJpipbNiusug4P/IsTXMeUriUG89bRDpo6rNa3rqLXDU5JGT6qcU9TszJ4biTMg
         Xqof8DAE+Rf636aGNhCm1cLQC7T+QceRzpmaXNSWeX1wgQ7ry2ghyO00EuhfFqLRIZWf
         jzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32Cc5ZaLpXCG5C97IKMd1bhKy4dPC8hpFHY1eIXSExM=;
        b=B2girh/okP+kHJDWiNdau9hCdl4Z9JmisdubQN9cr+YkNWtPc3L3tFwtKjCCD2X8OM
         KAP4Ojy9An3G5tOcgCQOniAVN86SN/3t7xaLKsON4GsrZCA6jqeKX1+oUhAcSkFFQQbR
         lOZoZlsp8mvvP7LSfmu7O3lTkrk6e4bkMJ9WQEwmn0YnSgpx/txtHEdthSVBRANSvryi
         evl6R8PAVU2SsH/cJ8SIW0WHEt6H8wLFtVoZYJCBiZEMP17EyMzB2gBVFNWELyEknmej
         aDb7YdElEMyzKAnaANyW9/XjHSUrtjcU7H1XX5SxR0nrHb1GEnxu65n3zc26cXWtbq+c
         Ifzg==
X-Gm-Message-State: AJcUukcKXzyKu6bC5twoB2lJIrfWdj0hXdsHD+3yhHawT621dzbEBQL/
        5EwWtO/4UII1aErBb/R6nLn43w==
X-Google-Smtp-Source: ALg8bN4vesrOfVMEXZJglRPhcdYJ9zfNrtWSkPCswu5/xjeYx2HEyry4QvSNNKAmBTv3XyEsvg6M4Q==
X-Received: by 2002:a17:906:9611:: with SMTP id s17mr33021005ejx.37.1549293012046;
        Mon, 04 Feb 2019 07:10:12 -0800 (PST)
Received: from brauner.io ([84.198.244.205])
        by smtp.gmail.com with ESMTPSA id b19-v6sm2505506ejp.77.2019.02.04.07.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 07:10:10 -0800 (PST)
Date:   Mon, 4 Feb 2019 16:10:08 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
Message-ID: <20190204151007.ps2gkerx5cgetrfv@brauner.io>
References: <20190203074939.7261-1-jackoalan@gmail.com>
 <20190203083933.ee4a6j4mdecesbn2@brauner.io>
 <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 10:33:55AM -0800, Kees Cook wrote:
> On Sun, Feb 3, 2019 at 12:39 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Sat, Feb 02, 2019 at 09:49:38PM -1000, Jack Andersen wrote:
> > > The patch titled
> > > `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> > > created a regression for users of PTRACE_GETSIGINFO needing to
> > > discern signals that were raised via the tgkill syscall.
> > >
> > > A notable user of this tgkill+ptrace combination is lldb while
> > > debugging a multithreaded program. Without the ability to detect a
> > > SIGSTOP originating from tgkill, lldb does not have a way to
> > > synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> > > entire process.
> > >
> > > This patch allocates the siginfo as it did previously whenever the
> > > SI_TKILL code is present.
> > >
> > > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> >
> > The  commit you're trying to fix has been discussed before wrt to
> > seccomp tests:
> >
> > commit 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Thu Dec 6 15:50:38 2018 -0800
> >
> >     selftests/seccomp: Remove SIGSTOP si_pid check
> >
> >     Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
> >     means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
> >     Since it's believed[1] there are no other userspace things depending on the
> >     old behavior, this removes the behavioral check in the selftest, since it's
> >     more a "extra" sanity check (which turns out, maybe, not to have been
> >     useful to test).
> >
> >     [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
> >
> >     Reported-by: Tycho Andersen <tycho@tycho.ws>
> >     Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> >     Signed-off-by: Kees Cook <keescook@chromium.org>
> >     Signed-off-by: Shuah Khan <shuah@kernel.org>
> >
> > Ccing Kees on this. Seems that this commit might be worth given that
> > there's some parts of userspace relying on it and not just internal
> > kernel tests.
> 
> Yup, so this is the "real" userspace example that Eric was looking for.
> 
> Eric, how does the proposed fix look? I'd also like to revert my

I think Eric's proposal in [1] is better. Iiuc, the proposed fix here
doesn't restore the behavior for seccomp. I'd rather have you or Jack
pick up Eric's fix with a Suggested-by for Eric in there and then
restore the old behavior. I'd feel comfortable acking this.
Once we have that you can revert the seccomp fix you sent. Later we can
think about Eric's proposal to make siginfo_t allocation more robust.

Christian

[1]: https://lore.kernel.org/lkml/87zhtthkuy.fsf@xmission.com/
