Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC5AC67837
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCD42085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pSTCQMAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCD42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJLIcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:32:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35590 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeJLIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:32:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so11611533wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wi7DQQzs1cn8DBSCSTYJL4Er2trNvvKE9aMQTPQT7Co=;
        b=pSTCQMAGpvvjAI1X6CLmNR7DNKK2puY9pgduoQgpIYwugoR/Xg6uOzH5Sad0hslQMb
         6IWcmy7x5I3a/2XIv2scOZdubb2yA4Vd+XKGE/mnpXRg3CU9RgmcvPFt9P6rDpmdohPB
         t3FIjBnq9Hu1ljLJNRBauvNPVeFUCpyCsjP4YGLJg7EPHucZhQgDGtkrQ+YwAl3mPEhf
         qXwV95JPwqWehBcCwYSC0lzHxbW2lt4beLc90NnsBWUIwu4iNfcrzM0YUqeJpyQlIQOS
         76eBXCsedTeGwpX0K3PsRGuAyuAc92zODwVFzrvMMWINzfE7IsmjWeEAyLsxl7WU0d6s
         Z6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wi7DQQzs1cn8DBSCSTYJL4Er2trNvvKE9aMQTPQT7Co=;
        b=lplJxfJcpqpmVD5CyEg2y89je3HfrruoaJ4/s/qm73tAzddkhlPz50XFmQCmh6LH35
         NSTWKS3PGOsroOtPbp3OehzPaC3DTJwrvOZWO8xhL0YycqrXUJvIa4u1ZUeIgnjGBfmm
         2nFsAuQ+A79JbKhRvOegeWJYgMRMIpI0uXqDL3lbLmi2Owv9k/LTTZRNzmSOwEbuz2K7
         bmFRKE4sc/Rsmta5QmgmaxkEMlySsZVD2C/oloFMdhPCCUCegFh/fFLXB17s8N1K761f
         1izZQfw/gFc1/xR4x82WXjXLEyJd0iJV6XpGCI2ON+4hDKYa8giyAfvAdnPGnoH5PTm5
         BBwg==
X-Gm-Message-State: ABuFfoiy9jql8ECKaWbbE8izRmlhSSLVj0gp4rdUKXqZqP1wZHz3uHFq
        OV6FT4KJbCogdBW6vTx/5QPWrDwqdAXD8CrhW6v4WA==
X-Google-Smtp-Source: ACcGV62gRMUjjKb8Zor/8LPVNvkbZanbigu1ceWGdF5TL7dy9ZISnV5OBt1DO7uDT3P/6hscrZqFq7r83gV04x9r1Ck=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr3434946wra.95.1539306138848;
 Thu, 11 Oct 2018 18:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io> <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io> <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com> <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 11 Oct 2018 18:02:06 -0700
Message-ID: <CALCETrV1fWKJe96ow3XGy_kmZoXoehb99e4AZehsO84YGxKjgQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux-NSA <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 4:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On October 11, 2018 9:40:06 AM Jann Horn <jannh@google.com> wrote:
> > On Thu, Oct 11, 2018 at 9:24 AM Paul Moore <paul@paul-moore.com> wrote:
> >> On October 10, 2018 11:34:11 AM Jann Horn <jannh@google.com> wrote:
> >>> On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> >>>>> +cc selinux people explicitly, since they probably have opinions on this
> >>>>
> >>>> I just spent about twenty minutes working my way through this thread,
> >>>> and digging through the containers archive trying to get a good
> >>>> understanding of what you guys are trying to do, and I'm not quite
> >>>> sure I understand it all.  However, from what I have seen, this
> >>>> approach looks very ptrace-y to me (I imagine to others as well based
> >>>> on the comments) and because of this I think ensuring the usual ptrace
> >>>> access controls are evaluated, including the ptrace LSM hooks, is the
> >>>> right thing to do.
> >>>
> >>> Basically the problem is that this new ptrace() API does something
> >>> that doesn't just influence the target task, but also every other task
> >>> that has the same seccomp filter. So the classic ptrace check doesn't
> >>> work here.
> >>
> >> Due to some rather unfortunate events today I'm suddenly without easy access to the kernel code, but would it be possible to run the LSM ptrace access control checks against all of the affected tasks?  If it is possible, how painful would it be?
> >
> > There are currently no backlinks from seccomp filters to the tasks
> > that use them; the only thing you have is a refcount. If the refcount
> > is 1, and the target task uses the filter directly (it is the last
> > installed one), you'd be able to infer that the ptrace target is the
> > only task with a reference to the filter, and you could just do the
> > direct check; but if the refcount is >1, you might end up having to
> > take some spinlock and then iterate over all tasks' filters with that
> > spinlock held, or something like that.
>
> That's what I was afraid of.
>
> Unfortunately, I stand by my previous statements that we still probably want a LSM access check similar to what we currently do for ptrace.
>

I would argue that once "LSM" enters this conversation, it just means
we're on the wrong track.  Let's try to make this work without ptrace
if possible :)  The whole seccomp() mechanism is very carefully
designed so that it's perfectly safe to install seccomp filters
without involving LSM or even involving credentials at all.

--Andy
