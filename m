Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCFC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676B221755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oUQXUm/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B221755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbeHNCXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:23:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45278 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:23:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id w16-v6so13916692ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxGW85wZ4Zf1lWkMM7WRx443cr2SxhSjUFaFnD6qT/I=;
        b=oUQXUm/E11ucaGFX7fnAXu+rn8fBVBnTN4y+lA+ZP0oYSgOwsZIJQ+HvFuFQf067Us
         EhbhFcd3YD6VK0xR7uzquVtqmt+jt8LyJaVAvI22X80rpZzShsuyv7mlJKJk5oK01zEM
         L+Y10kjHCuYXo1UwGLyHod7vAGRgK0K8V1aQtmNRydQOBtVWKXFMyKKVJZvQout/YqL3
         vcBBSK9FqGBuaKf54ADqCL1Qx1E6wZ9hv1y2OJCYluKNrfHLAomrkIQDsadNWHnvb4vU
         weVJEo7r85yvmuAJsILJYFyu1GBaxkOQe2FrS58CGvWo7g519EqDTiy9YucdwkYZFH0j
         USpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxGW85wZ4Zf1lWkMM7WRx443cr2SxhSjUFaFnD6qT/I=;
        b=FdSwrmk5vixiQmiuqBoYiVO9LGR38tTrcN0R9LmYuSTuHKbc9J/zdxRteq7Sxdm8Fj
         NIvQ7iAsFtv+OjIC2llSYGtKuax4OW497A320TL49BDICXwsp0kc+Z4mxYrfF2pGFG4a
         ZpRD+F7OOq4p+31ZsIAl7/z83PQFUETLpSAI/25XrobVA1tcRaNe9uHa/Oo5OKEln3WT
         zg5JYpsg+C5C+9iwcItH/53Gpf5UF28wMLqGCy685kQM6QP0Qvdm4btGmbZXoHImhykw
         o229rhP+4Oafre8o5FhlDmmPvax3kxAE67qy8aVpECDGZPuS0m00ogkJsqmuCxVAXm2t
         VJfQ==
X-Gm-Message-State: AOUpUlHrvW5k/EMHo7Em+6n867QJqC52K9M74iE9wkVs2NLs5rUA8XB9
        MOHiaS2Jc2TihBz5S2wLfB7S+x09e2FaIm6wpJ3l
X-Google-Smtp-Source: AA+uWPz0AwzTJCSnP86YeC3UVpg/uKmXNoPsfJOvBebfinCVWijxiaJtP8ijwO1kCzt2qSn+WiEnIDJVRy++5WDBbww=
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr14130792lje.146.1534203532830;
 Mon, 13 Aug 2018 16:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com> <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
 <CAGH-Kgvn5=BT0GQU2qHBwJos8Ev=VgasicXeqQEG166Mi8fc6w@mail.gmail.com> <CAG48ez1QS6e4cBsunh=V0fx6Gj-VENGeuakz2XK9eQoHU6Uh6Q@mail.gmail.com>
In-Reply-To: <CAG48ez1QS6e4cBsunh=V0fx6Gj-VENGeuakz2XK9eQoHU6Uh6Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Aug 2018 19:38:40 -0400
Message-ID: <CAHC9VhSkr1dtU=ai-ss8xPLiSvb5_L839+7ytTY1ya=h_yk5sg@mail.gmail.com>
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make it stricter
To:     jannh@google.com
Cc:     Paul Moore <pmoore@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 7:01 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 9, 2018 at 4:07 AM Paul Moore <pmoore@redhat.com> wrote:
> > On Wed, Aug 8, 2018 at 9:56 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > The intended behavior change for this patch is to reject any MLS strings
> > > > that contain (trailing) garbage if p->mls_enabled is true.
> > > >
> > > > As suggested by Paul Moore, change mls_context_to_sid() so that the two
> > > > parts of the range are extracted before the rest of the parsing. Because
> > > > now we don't have to scan for two different separators simultaneously
> > > > everywhere, we can actually switch to strchr() everywhere instead of the
> > > > open-coded loops that scan for two separators at once.
> > > >
> > > > mls_context_to_sid() used to signal how much of the input string was parsed
> > > > by updating `*scontext`. However, there is actually no case in which
> > > > mls_context_to_sid() only parses a subset of the input and still returns
> > > > a success (other than the buggy case with a second '-' in which it
> > > > incorrectly claims to have consumed the entire string). Turn `scontext`
> > > > into a simple pointer argument and stop redundantly checking whether the
> > > > entire input was consumed in string_to_context_struct(). This also lets us
> > > > remove the `scontext_len` argument from `string_to_context_struct()`.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > > Refactored version of
> > > > "[PATCH] selinux: stricter parsing in mls_context_to_sid()" based on
> > > > Paul's comments. WDYT?
> > > > I've thrown some inputs at it, and it seems to work.
> > > >
> > > >  security/selinux/ss/mls.c      | 178 ++++++++++++++-------------------
> > > >  security/selinux/ss/mls.h      |   2 +-
> > > >  security/selinux/ss/services.c |  12 +--
> > > >  3 files changed, 82 insertions(+), 110 deletions(-)
> > >
> > > Thanks for the rework, this looks much better than what we currently
> > > have.  I have some comments/questions below ...
> > >
> > > > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > > > index 39475fb455bc..2fe459df3c85 100644
> > > > --- a/security/selinux/ss/mls.c
> > > > +++ b/security/selinux/ss/mls.c
> > > > @@ -218,9 +218,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > > >  /*
> > > >   * Set the MLS fields in the security context structure
> > > >   * `context' based on the string representation in
> > > > - * the string `*scontext'.  Update `*scontext' to
> > > > - * point to the end of the string representation of
> > > > - * the MLS fields.
> > > > + * the string `scontext'.
> > > >   *
> > > >   * This function modifies the string in place, inserting
> > > >   * NULL characters to terminate the MLS fields.
> > > > @@ -235,22 +233,21 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > > >   */
> > > >  int mls_context_to_sid(struct policydb *pol,
> > > >                        char oldc,
> > > > -                      char **scontext,
> > > > +                      char *scontext,
> > > >                        struct context *context,
> > > >                        struct sidtab *s,
> > > >                        u32 def_sid)
> > > >  {
> > > > -
> > > > -       char delim;
> > > > -       char *scontextp, *p, *rngptr;
> > > > +       char *sensitivity, *cur_cat, *next_cat, *rngptr;
> > > >         struct level_datum *levdatum;
> > > >         struct cat_datum *catdatum, *rngdatum;
> > > > -       int l, rc = -EINVAL;
> > > > +       int l, rc, i;
> > > > +       char *rangep[2];
> > > >
> > > >         if (!pol->mls_enabled) {
> > > > -               if (def_sid != SECSID_NULL && oldc)
> > > > -                       *scontext += strlen(*scontext) + 1;
> > > > -               return 0;
> > > > +               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > > > +                       return 0;
> > > > +               return -EINVAL;
> > >
> > > Why are we simply not always return 0 in the case where MLS is not
> > > enabled in the policy?  The mls_context_to_sid() is pretty much a
> > > no-op in this case (even more so with your pat regardless of input and
> > > I worry that returning EINVAL here is a deviation from current
> > > behavior which could cause problems.
> >
> > Sorry, I was rephrasing the text above when I accidentally hit send.
> > While my emails are generally a good source of typos, the above is
> > pretty bad, so let me try again ...
> >
> > Why are we simply not always returning 0 in the case where MLS is not
> > enabled in the policy?  The mls_context_to_sid() function is pretty
> > much a no-op in this case regardless of input and I worry that
> > returning EINVAL here is a deviation from current behavior which could
> > cause problems.
>
> Reverse call graph of mls_context_to_sid():
>
> mls_context_to_sid()
>     mls_from_string()
>         selinux_audit_rule_init()
>             [...]
>     string_to_context_struct()
>         security_context_to_sid_core()
>             [...]
>         convert_context()
>             [...]
>
> string_to_context_struct() currently has the following code:
>
>         rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
>         if (rc)
>                 goto out;
>
>         rc = -EINVAL;
>         if ((p - scontext) < scontext_len)
>                 goto out;
>
> In my patch, I tried to preserve the behavior of
> string_to_context_struct(), at the expense of slightly changing the
> behavior of selinux_audit_rule_init().
>
> But if you think that's a bad idea or unnecessary, say so and I'll change it.

I'll be honest and mention that I kinda spaced on the change you made
to string_to_context_struct() while I was looking over the
mls_context_to_sid() changes.  As you point out, I believe
string_to_context_struct() will continue to work as expected for
callers so that should be okay.

The selinux_audit_rule_init() function is a little different, but
looking at some of the callers, and thinking about it a bit more, it
probably isn't a bad thing to return EINVAL as in your patch.  The
label isn't valid given that the system isn't in MLS mode and letting
admins know that should be okay.  So I guess we can leave this section
of the patch as-is, but understand that we might need to tweak this if
we end up breaking something important.

As an aside, I believe my other comments on this patch still stand.
It's a nice improvement but I think there are some other small things
that need to be addressed.

-- 
paul moore
www.paul-moore.com
