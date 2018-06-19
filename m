Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BC920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="If4gxVUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BC920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967041AbeFSQvc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:51:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35373 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:51:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so554694lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCMVS6vFaHSeMIrX6/Y8Jh4v2fb44VZE5kGIiUIwvRo=;
        b=If4gxVUjOGICSpHKKPa5D3Bv3d1rg7raSQKzwhhU7qNleSGiX6kGlBfe441+Z2FqUb
         MILmV2gqt4X1gboMZU0xoqhZU6d1zbWX4dOuri04OVurgIx9tdvR5Lqp+JD0VC3T9r9O
         pTvdA/El33wF9q3KDDqH/d3hM2uQ1GfIl1G8DkMl++tWAWRtMFnwxZbZ9cNPM+RF7Lwj
         cGvvYyG3nG3ywD7FE80NbjP+z79sdprMlQ/vn3ijuy5gI0sJ8gNXrW96tVLlSe/lHxSF
         XUn+OPUXWJ8j6DKu7gN9hT4/pyP+SQE2lpEdb0XQJFY4wzi3z5qG9I1Ah0vUzLobnMPU
         b5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCMVS6vFaHSeMIrX6/Y8Jh4v2fb44VZE5kGIiUIwvRo=;
        b=HFLjYzMafasAxXusdVkRFQu+JWRPsZ983sRTI0029ooXLXLc4sNQz3ARZXcKJ14bgK
         lJFkTV7QNOoUbKlsau+8WytIhB8iAw55Co32N8q+cDOcetEoUhzDqzJSfvpSB89BSpPc
         Z5bS/3weLdI6hsA1Mzp3RQtbu+YU2b+Nlr6wyNcT4JHXzkilNHKn9XdUzu8krXSNj961
         37wqPU+SohJ8RIf5wN4KPBQaEHiU5PM37aXXPkWeSipZYkUGkwgCiRqDohvcxj+mFQ7/
         UZY7aS6+TuwI3axjKVaXfXjlNNBDckhuVsv/yHrFltSfiOdxUDaxcjqLMvzBokBJZvmb
         kDKA==
X-Gm-Message-State: APt69E2OcFixnKaCvIKqibrqEKUCtzSqhKmt6ts3GY0diUwRFKDowsWP
        7ikxP0mZjNNXXpICExdn1pfNe4aRUA4+LwgZ1X6W
X-Google-Smtp-Source: ADUXVKIv/DpmFYakabUc9Epo4bsqcVgl7f2y8e9ienIxTl0QiXuV8Pr2kYCGtThMSeAOR6Dgj/3PbaiZNySuha/dj5Y=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr10459671lfe.39.1529427089267;
 Tue, 19 Jun 2018 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-4-peter.enderborg@sony.com> <CAHC9VhTULXGAjbRSeriXm6g=aQbaG6XcfXtROVoJr632yis=Gw@mail.gmail.com>
 <e66cad5399b741b8d5c06c8ea772c8b84caf1150.camel@perches.com>
In-Reply-To: <e66cad5399b741b8d5c06c8ea772c8b84caf1150.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 12:51:18 -0400
Message-ID: <CAHC9VhRPeSjtWE_HNhRQGZedtOsHKfPN0d=_yC9-n=HhAtkMrg@mail.gmail.com>
Subject: Re: [PATCH 03/13] selinux: Cleanup printk logging in policydb
To:     joe@perches.com
Cc:     peter.enderborg@sony.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:45 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-06-19 at 12:41 -0400, Paul Moore wrote:
> > On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
> > <peter.enderborg@sony.com> wrote:
> > >
> > > Replace printk with pr_* to avoid checkpatch warnings and
> > > replace KERN_CONT with 2 longer prints.
> > >
> > > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 91 +++++++++++++++++++++---------------------
> > >  1 file changed, 46 insertions(+), 45 deletions(-)
> >
> > Merged, thank you.  While removing the separate KERN_CONT message
> > introduces some duplication, I think that's the right thing to do.
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> []
> > > @@ -504,7 +504,7 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
> > >         struct hashtab_info info;
> > >
> > >         hashtab_stat(h, &info);
> > > -       printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
> > > +       pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
> > >                "longest chain length %d\n", hash_name, h->nel,
> > >                info.slots_used, h->size, info.max_chain_len);
> > >  }
> > > @@ -533,15 +533,17 @@ static int policydb_index(struct policydb *p)
> > >  {
> > >         int i, rc;
> > >
> > > -       printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
> > > -              p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
> > >         if (p->mls_enabled)
> > > -               printk(KERN_CONT ", %d sens, %d cats", p->p_levels.nprim,
> > > -                      p->p_cats.nprim);
> > > -       printk(KERN_CONT "\n");
> > > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats",
> > > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > > +                        p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
> > > +       else
> > > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools",
> > > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > > +                        p->p_bools.nprim);
>
> This lost the terminating newline on each pr_debug

Good catch.  I haven't pushed to selinux/next yet, and this is pretty
minor, so I'll just fix that up in the merge.

-- 
paul moore
www.paul-moore.com
