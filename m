Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E14C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1793B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+V+2dys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeI2FNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:13:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40209 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeI2FNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:13:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so9447555edd.7;
        Fri, 28 Sep 2018 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=kgnLYoHebAATAQhaGP2hiKypwyKQcaoDkmSi/KdyB80=;
        b=e+V+2dysWYe7nLFMEARo0mHAmSNJ1nrwBw1CpHoHH8eSO8y+YQvNWc0jPvO/+BaRI0
         ipQf68jl9c42kOQ88WpXOxp6wEd1ZLf7m4yWtDlJaJn5Nl4tkQDYF4POyFDNUQt7KCJr
         fBEOuIHhDLsDFxE55SjkQ/m5bMaTDgzFM55GdsXavFJS+8y7xozf8cr/GMjbyl7Plnop
         QOLQ3OWqw1dDIALEqvQwdiuoU6q6WUyJjDQLR+Gmg8qEmNeuw7pQnvbIfqBFDSPTl5da
         O0IyT4AM1Q1fv1W91lPceYTnxjMAqazHegxmec6GVOvyW0e9MToHUB3+9RU7Vp2BZFAu
         e8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=kgnLYoHebAATAQhaGP2hiKypwyKQcaoDkmSi/KdyB80=;
        b=P3gEHrBNTHhpEItFsh0j551E5kfn1AkUikuFKqLZml/p01xnhlt3QtxAoxDmqgeoi4
         xy2TIOJMOyHVKNvelJrckeObxo45nvIkEzTC7M3PZ7HuApNm2Ta5ZELhyVjR0SP3CTlQ
         ezzQctAv5eAL8Pk/4Vg0+GsRAkjmY2ycD3+/9o7KD14D5eLEA//spWv0CVTEuD6FuYAd
         zrlzXBVxMSF8YuUmAbgSCOBTVMC1uHI045l27XNpL8Sr2BQgnr2V9iIaW3hQdItubg4U
         PfUjxvxHZv4E9qGy+DUXzn1xXKc6jyTpdyhTd/WXQPdK8coWNSyNHN97BnBhebggHRmn
         co8g==
X-Gm-Message-State: ABuFfojAEDwuWU3gHg61ChMw9RU9NabhuQs4whv3pnCjtoN7FsHNe/n/
        fLZ9DV/dGjIlfTRrDzELVNTsDO49GB4lA8iKzRs=
X-Google-Smtp-Source: ACcGV61APEz3fTO2rG5Mnosto4hHMj4miFRJUGu1O2Gkm2iuayUXLHakEtbf1Zrbu8UELKQZWN73wXcE8Ui8oyVQUAc=
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr5443408eda.144.1538174824577;
 Fri, 28 Sep 2018 15:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
 <20180928220359.GF18045@cisco.lan> <CAKgNAkgcHENKrT=n4_YbmxJCOaY2Z+SXJcfuw9j7uOJwgym3Dg@mail.gmail.com>
 <CAGXu5j+GTwOZnNscfMmArxxJgNvPETgBns1Y6u11tapkoOwn+w@mail.gmail.com>
In-Reply-To: <CAGXu5j+GTwOZnNscfMmArxxJgNvPETgBns1Y6u11tapkoOwn+w@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 29 Sep 2018 00:46:53 +0200
Message-ID: <CAKgNAkis9WVwLoYGV+uT_YfQVTR-wh+-Ut_2wZW8B_F1KGRzOA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        lkml <linux-kernel@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,
On Sat, 29 Sep 2018 at 00:35, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 28, 2018 at 3:16 PM, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> > Hi Tycho,
> >
> > On Sat, 29 Sep 2018 at 00:04, Tycho Andersen <tycho@tycho.ws> wrote:
> >>
> >> On Fri, Sep 28, 2018 at 11:57:40PM +0200, Michael Kerrisk (man-opages) wrote:
> >> > Hi Tycho,
> >> >
> >> > On 09/27/2018 05:11 PM, Tycho Andersen wrote:
> >> > > Hi all,
> >> > >
> >> > > Here's v7 of the seccomp trap to userspace set. There are various minor
> >> > > changes and bug fixes, but two major changes:
> >> > >
> >> > > * We now pass fds to the tracee via an ioctl, and do it immediately when
> >> > >    the ioctl is called. For this we needed some help from the vfs, so
> >> > >    I've put the one patch in this series and cc'd fsdevel. This does have
> >> > >    the advantage that the feature is now totally decoupled from the rest
> >> > >    of the set, which is itself useful (thanks Andy!)
> >> > >
> >> > > * Instead of putting all of the notification related stuff into the
> >> > >    struct seccomp_filter, it now lives in its own struct notification,
> >> > >    which is pointed to by struct seccomp_filter. This will save a lot of
> >> > >    memory (thanks Tyler!)
> >> >
> >> > Is there a documentation (man page) patch for this API change?
> >>
> >> Not yet, but once we decide on a final API I'll prepare one.
> >
> > Honestly, the production of such documentation should be part of the
> > evolution towards the final API...
> >
> > Documentation is not an afterthought. It's a tool for pushing you, the
> > developer (and others, your reviewers) to more deeply consider your
> > design.
>
> In Tycho's defense, he did write up documentation in Documentation/
> for the feature, so it won't be an afterthought. :)

So, I missed that... How do I find this Documentation/ ?

> But yes, there's
> no manpage delta yet.

But, really, there should be, as part of the ongoing evolution of the patch...

(Apologies, Tycho. It may be that I came across a bit harshly.)

Thanks,

Michael


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
