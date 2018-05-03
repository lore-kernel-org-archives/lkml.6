Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525352688-2-10223627328057187705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525352687; b=PJECqJ/nR+vzHq7EEzoe3nfDaX5V2ODcKN65rqhM5xCo9n8fTi
    NMLYiVYJxyzyxdIFNus+8ulbMUOucc1abYhMjHoRmFWoX0KiKnexkRskXHhw/xag
    SvgN4bbQgY4VxVA3FicqJSYm55X7c/fLeTMWDFkw48jwUSMZxOoa30KBMDaQkg8P
    5gTikOnSWP9QeuUqGLT+wHe+ZpBEf1iw8B+KU6Cp2lE1mRVi5HXUcwNnDgU3j5C3
    IRXWJEjAAh/fcEtDQocWG4eEAP+Ro/SSUic/PrEoJuef/QhqNbj96pcMv/GS4ipd
    sgxP2YM7/zfGV/2hn8HMbyxVv80nXC00CwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525352687; bh=civebXnwpuhzgztaqWwa3EZCL9pOY+qlCWaD3jg2iQ
    4=; b=HiNCu5Llq0W5SV+F1Au/7ASAXS5O/Q1ArAIIVg/JfAo27p1ITroGgObuyB
    x98rLrj0YDjyiSULVn/K5yAlv4eQJJ1yMQWelzn+NJhhTmGL9hjViO320oTA144E
    s3SrNTEZxYPE03jA1GuZmoN3Yu5ckrv2hOmrVWOm+rQVjxenMnBRRHMQp9Trq9PQ
    rbgBaQ1Ra5KYScCJc8xZeCEeZ9EJ83q9/IMbdIOkKuKvTSfrWwCoBLPTInvJbrn5
    NYtWi9NZfwBnCpzmUFQJlipHLA/hcCqPcaBINLoD/ZGH8xjMTD36P+wsAtkg2FFK
    VYw2+Y9d/Ds8VAYAyVjDv15U6n+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=RtWmBjPJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=RtWmBjPJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHYh2EVWTAwoUXJN5y5YtJNnxXl/F2GqlNj62+VMhq766CSLjkNkbBiVftaZErAP4tT+AQtp7toVLFNEFj0x3igB1KgA/SjQNvT5RyF5Kylg6GeU27jS
    vR0CMXfQit0VjEDaVSaLiEiNgBRdZFcCLMd1dmkkDnbVONXtd67Kxcb7fehIzCCeWrrAioCoJWeHd1ruLagDxBTMvZJutYwRk36uYn3HSDASed26fHCQ1d2m
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=z6a2HzZOvpPXfH-QSMAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeECNEo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 09:04:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeECNEm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 09:04:42 -0400
X-Google-Smtp-Source: AB8JxZpMBDRLV35dcChGodzIglINURaOeBQY07CtGIXLuUNq88PrFkb7y631/+ViVfGFqugF+8uN/9e04nwNXPckOnQ=
MIME-Version: 1.0
In-Reply-To: <20180502160939.GU30522@ZenIV.linux.org.uk>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com> <20180502160939.GU30522@ZenIV.linux.org.uk>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 3 May 2018 15:04:36 +0200
Message-ID: <CAPP7u0VPyWAsL_kkb4JnJHMmK=kM0m4zRjVjst1iHDd6V=t0mQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 resend] statfs: handle mount propagation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hch@infradead.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, Greg KH <gregkh@linuxfoundation.org>,
        pombredanne@nexb.com, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:09:39PM +0100, Al Viro wrote:
> On Wed, May 02, 2018 at 05:42:33PM +0200, Christian Brauner wrote:
> > Hey,
> >
> > This is the second resend of this patchset. I'm not sure whether it has
> > simply been overlooked but the number of people get_maintainer.pl was
> > rather small and seemed a little random so I added Linus and Christoph,
> > two people I know that do look at VFS stuff at least from time to time,
> > although they weren't listed by get_maintainer.pl. I hope that's ok.
> >
> > This little series
> > - unifies the definition of constants in statfs.h and fs.h
> >   *Note, that Andreas has expressed doubts whether this unification is
> >   useful. Please see https://lkml.org/lkml/2018/4/13/571 . I still think
> >   it is but I'm happy to drop these two patches if others agree.*
> > - extends statfs to handle mount propagation. This will let userspace
> >   easily query a given mountpoint for MS_UNBINDABLE, MS_SHARED,
> >   MS_PRIVATE and MS_SLAVE without always having to do costly parsing of
> >   /proc/<pid>/mountinfo.
> >   To this end the flags:
> >   - ST_UNBINDABLE
> >   - ST_SHARED
> >   - ST_PRIVATE
> >   - ST_SLAVE
> >   are added. They have the same value as their MS_* counterparts.
>
> How about some rationale for that in the first place?  statfs() looks like
> a bad match for that - not to mention anything else, there's no way to
> get anything beyond "it is a peer of something", not even "do these two
> get propagation between them".  What would be using that, what would the
> userland side of users look like, etc...

Ok, sorry if I wasn't detailed enough.

>From a userspace perspective we often run into the case where we simply
want to know whether a given mountpoint is MS_SHARED or is MS_SLAVE.
If it is we remount it as MS_PRIVATE to prevent any propagation from
happening. We don't care about the peer relationship or how the
propagation is exactly setup. We only want to prevent any propagation
from happening.

The above case is what I see most often. A more specific use-case is to
differentiate between MS_SLAVE and MS_SHARED mountpoints.
Mountpoints that are MS_SLAVE are kept intact and mountpoints that are
MS_SHARED are made MS_PRIVATE.

For both cases the only way to do this right now is by parsing
/proc/<pid>/mountinfo. Yes, it is doable but still it is somewhat costly
and annoying as e.g. those mount propagation fields are optional.

Another problem are scenarios where propagation matters but /proc is not
mounted.

Here are three concrete use-cases I run into frequently:
- (*buzzword alarm*) container runtimes:
  They do usually clone(CLONE_NEWNS) and inherit the mount table but
  want to remount specific mountpoints to prevent propagation.
  Again the specifics of propagation don't matter in this case usually.

- Sharing shared mountpoints:
  Sometimes it is desirable to share shared mountpoints between
  namespaces.
  Say, the first process sets up the shared mountpoint on the host and
  all the other ones want to know "Did someone already make this rshared
  or do i need to set this up?". It would be very helpful if you could
  just check a mount by using the statvfs() syscall.

- I want to know whether a mountpoint is unbindable to e.g. skip it if
  it is or remount it.

About how this would work what I simply expect and tested with this
patch was e.g. this:

int ret;
char *s = "/some/path";
struct statvfs sb;

ret = statvfs(s, &sb);
if (ret < 0)
        return false;

if (sb.f_flag & ST_SHARED) {
        ret = mount("", s, NULL, MS_SLAVE | MS_REC, NULL);
        if (ret < 0)
                return -1;
}

>
> And in any case linux-api should've been Cc'd.  I'm not saying that this

Ah, thanks! Sorry I missed this.

> (or something similar) would be an inherently bad idea, but the question
> "why this way?" deserves a bit more than "parsing is costly"...

I hope some of the above helped to clarify this.

Thanks!
Christian
