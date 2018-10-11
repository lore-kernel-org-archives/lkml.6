Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA11C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F4C2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEjunEM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F4C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeJKVHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:07:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40766 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJKVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:07:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so8927787ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5TfyFrjGrlzpJ2DNaYpFmSqPaCZWK+MgDuCMXQIe08=;
        b=LEjunEM191gRoqoi54Z/nzJyoIfYa4lSuKI1E6XI+2liPXtYZFCwOZLMPdIImdW5qy
         qMG6ribXgY5F1sDvMu56l2gSuZHkZ/XHL7YFAjQQYjn3rpn0GUCd5aSK4rqoMfHlMw4k
         /aswJJHHtpmN0FzCvp2NqoHji3Vpy1sBa9rCXwDte9HBQr6EgR7Kc3r6r97HJ+UOV7b+
         fhTN/QLrmsu3XFYVNaCSFb8HXaedOqs6jSJXMAhS1ftsxnc3Zi/hexGR6YRJkeo6aV/p
         9w2ASsHSwQHYIHpBwQ/DQVSvsOWR5mw6NDUZ10J73rPMFwlkohb43AN5idBbEN4N9HN0
         /rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5TfyFrjGrlzpJ2DNaYpFmSqPaCZWK+MgDuCMXQIe08=;
        b=ifVlT4Et5YgMoBLL4dXY3Z2jMxpFfCLRrZyHdztWTMpkxd/QYTOXA5BmRPmbT9hlHf
         BmrD2iwW0nKETYcRBTPCOyob1C9zZGYBYKeeuPdeDxhm0Z+W9unl0SdKReQwAZg51zzD
         whnVdJPTPmnT2JJce7SRgUpDp91X97ttPFvaLguwMX6Z27H24Vbkyk9PKMBybTqRW72x
         o7vVgxR8QJ5bhKbQ+5EKzV0vuhmMuxXbsigJ3927vi2Oi8DwYn4/BMetnyL7gJBXApVw
         2kp/RYYjOknyF7E6oPD5dilIbbX7SClspOeY+zJ130xnLhmwIQCDmgttFJ6+2f58pn1k
         JsKw==
X-Gm-Message-State: ABuFfoieSYuwdglQe0gm2X5boiaZMg2W8oTeCIaO1UpB+ZbkuLnAX2qQ
        mzuziaqWpALlBS5ujXj+epmD/G2ZIRvkI9tIWA89lw==
X-Google-Smtp-Source: ACcGV61b994IuGIe+Adm88lq6xsYjOBCX8Iqx8/9y+kO6Lmkx5EY8UqN9tm76XHTDETtP+OON1v+W3FZt+Zq3rDiIE4=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr1124110otf.73.1539265205211;
 Thu, 11 Oct 2018 06:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io> <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io> <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com> <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 11 Oct 2018 15:39:37 +0200
Message-ID: <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Paul Moore <paul@paul-moore.com>
Cc:     christian@brauner.io, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 9:24 AM Paul Moore <paul@paul-moore.com> wrote:
> On October 10, 2018 11:34:11 AM Jann Horn <jannh@google.com> wrote:
> > On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> >>> +cc selinux people explicitly, since they probably have opinions on this
> >>
> >> I just spent about twenty minutes working my way through this thread,
> >> and digging through the containers archive trying to get a good
> >> understanding of what you guys are trying to do, and I'm not quite
> >> sure I understand it all.  However, from what I have seen, this
> >> approach looks very ptrace-y to me (I imagine to others as well based
> >> on the comments) and because of this I think ensuring the usual ptrace
> >> access controls are evaluated, including the ptrace LSM hooks, is the
> >> right thing to do.
> >
> > Basically the problem is that this new ptrace() API does something
> > that doesn't just influence the target task, but also every other task
> > that has the same seccomp filter. So the classic ptrace check doesn't
> > work here.
>
> Due to some rather unfortunate events today I'm suddenly without easy access to the kernel code, but would it be possible to run the LSM ptrace access control checks against all of the affected tasks?  If it is possible, how painful would it be?

There are currently no backlinks from seccomp filters to the tasks
that use them; the only thing you have is a refcount. If the refcount
is 1, and the target task uses the filter directly (it is the last
installed one), you'd be able to infer that the ptrace target is the
only task with a reference to the filter, and you could just do the
direct check; but if the refcount is >1, you might end up having to
take some spinlock and then iterate over all tasks' filters with that
spinlock held, or something like that.
