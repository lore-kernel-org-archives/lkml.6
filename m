Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9BE263EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="s9M61WXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9BE263EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeFZBcL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:32:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43692 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934543AbeFZBcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:32:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so6853302pgw.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vdbmf8N7kpZxNR4Bgi3lDwsCruA6bMNnC16SPX4GO6o=;
        b=s9M61WXuKCVhIyIcmzzQBtmLDx9Qi0MGxRMGx7LwyTFe2Q9RYcagTRRnV0SDeAmUzY
         6TAlbB+D8Cd4fOfXK67tkJSz7qgkyT/x1O8HBSxpVMg/G2Z4iP17kUev/BVLFZLp6AcK
         KcESa/H9ksC1D+MIAoE3cucG1n/S2rQCNbvW4JYjTdQc+bn3lOJshZn4acqS62KNReVo
         pWWIwRD1384TIkcpH20++gB0Qg7FSCniphPI9Q5W0tFtMORO0cKE8TlrYc0hi6X3zDlc
         qfuKA+efl6kAKovn98tYMlHkgR4PgOWOuvdG3Lk0p3hl5uUeFDuheYkPNGN9eKSyv79e
         4kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vdbmf8N7kpZxNR4Bgi3lDwsCruA6bMNnC16SPX4GO6o=;
        b=ptd/vZjPpHiaSDJ3iv+Ga543HRicq0ABkv2XFUZF1ULnTrOd675j0aUm6DRWdf/VtP
         lXC57FQ1j7my9INgsFsBgJg4T6Pl568YY16kBxb8o0XK4RMHFyNETQgmYur1/ntoZzpa
         vCxebwLUgdVZhCST8V++v1QsSzjkRNX1b/rdNIVQqfFunzuubCu0cZwEt2UzDSohY7km
         zOsvOLzxfqihZy7hwMVIFy5lN3vAOPnqziYnhMpk6QFb7xwS3ut5wzb+Yh0unQwNGSIC
         nfQifuWm9BTwJV6cU3tsNg8PGUtgcNGcBS6dMYR17sk1ruhD5cXRK2Ui9YyJ2wupp8LI
         pVZQ==
X-Gm-Message-State: APt69E1kdscomriintY2+7AG2tREk1d+01pCJ87p76T1pLfjlPLGWT14
        Tq4JO9Nq617L9EC27gTLUEqXKw==
X-Google-Smtp-Source: ADUXVKIU3r7hSCNLxBh+hcc6RhxCNtG2dgKIBPGsh4/xtU9oOQ2cl9wRDAfAzjKFg/Dk9KEgcVkhIQ==
X-Received: by 2002:a65:4a92:: with SMTP id b18-v6mr12321122pgu.107.1529976728595;
        Mon, 25 Jun 2018 18:32:08 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.191])
        by smtp.gmail.com with ESMTPSA id y22-v6sm388894pfi.166.2018.06.25.18.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 18:32:07 -0700 (PDT)
Date:   Mon, 25 Jun 2018 19:32:04 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180626013204.GA7261@cisco.cisco.com>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
 <20180622151514.GM3992@cisco>
 <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net>
 <CAGXu5jKWQCDzXPdTz=+bxT9+4enaBvgYfMseUiGti+t1KwZT8g@mail.gmail.com>
 <CAG48ez3gobTL5mUnZKjhLedotZx49nGrxYKKud5_7+512PaOFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3gobTL5mUnZKjhLedotZx49nGrxYKKud5_7+512PaOFw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 12:27:43AM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jun 22, 2018 at 11:09 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> > > One possible extra issue: IIRC /proc/.../mem uses FOLL_FORCE, which is not what we want here.
> 
> Uuugh, I forgot about that.
> 
> > > How about just adding an explicit “read/write the seccomp-trapped task’s memory” primitive?  That should be easier than a “open mem fd” primitive.
> >
> > Uuugh. Can we avoid adding another "read/write remote process memory"
> > interface? The point of this series was to provide a lightweight
> > approach to what should normally be possible via the existing
> > seccomp+ptrace interface. I do like Jann's context idea, but I agree
> > with Andy: it can't be a handle to /proc/$pid/mem, since it's
> > FOLL_FORCE. Is there any other kind of process context id we can use
> > for this instead of pid? There was once an idea of pid-fd but it never
> > landed... This would let us get rid of the "id" in the structure too.
> > And if that existed, we could make process_vm_*v() safer too (taking a
> > pid-fd instead of a pid).
> 
> Or make a duplicate of /proc/$pid/mem that only differs in whether it
> sets FOLL_FORCE? The code is basically already there... something like
> this:

But we want more than just memory access, I think. rootfs access, ns
fds, etc. all seem like they might be useful, and racy to open.

I guess I see two options: use the existing id and add something to
seccomp() to ask if it's still valid or independent of this patchset
add some kind of pid id :\

Tycho
