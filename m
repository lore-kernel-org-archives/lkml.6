Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188D2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d8sTeuhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4188D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJYTWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:22:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJYTWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:22:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id c21-v6so1866568ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcsovGaIJnZHecEXeBDG75ymycE3viddVu6oy8QZM00=;
        b=d8sTeuhuIMVKhN4Ox6RQZcKzT31C9SBIZONXmgB1GvxUmdVuvpCJSO3wYsv08YmHyV
         bO4BGoXO5TlzXEfaSPG/qEfhjGDCGAERX0IDdhnnGKxkGCYr24WQDiraON/GIiCDan1f
         2O8MN66KkY4RSAUz0ryplpRfg0vvteCVsdq4LQaEzV/p7o5jkRNJ4CgM7xOJu5LYPw/l
         pUE2IlzNouWo9zqUvWiEUoRoOev7jctd7KPstu98lP6RH4z3hVCO/s/GI8Q7fZfnrWTh
         bNVmDkaPOBo8SGaNcHUwI3ZbynOp+JxHHI+NRvCfwNEhLTVGHuH+ybDAMKFPc+/hWnYn
         nOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcsovGaIJnZHecEXeBDG75ymycE3viddVu6oy8QZM00=;
        b=l0jhJpIUxAPssHtw3z3QqsG61She1wTn5oxWo7ywW+7/c5AdKd+K1r8kMVwmCoYFiC
         paKu54/BB/legkeiq0HbloxojkfzzjUMr1rvqt7IQndXprR5lFpVaf6nFm7/8P6Z0uMN
         h7TQJ/EH/14KlVYFNOzSr9iISChpxF2vxeFBbWIbY5Gkj/iyEkj4D6go77lJnIHRutL6
         dOs2muE7BMhh951Uqbi7ghKOpLz5WU83qNRe9ClMPE6A6i6WOp1Rp5seT+8D1H2RP+fG
         L2vyATb4tDtpajQ1PTX6QKh1yaQ5nBDD4Q7pyFo/iVsWgyr7+uPAvlY3qEICikyTqx6G
         GIYg==
X-Gm-Message-State: AGRZ1gLipTiMgat+V1GxKY/IdaGEDX7yywlR3/mrebzkesIuClyjnluG
        XaicJwPvZ5Os2QwdufEw2Jmap+jRMVcXnV9VGrzv
X-Google-Smtp-Source: AJdET5cETN62cpRpY473gpckPX0Rms1NDc3UpMEarfun+kPlRgDJw8aVqTGtIvRyBhIp0YWm2NZ6JAxdhmtiI4DgZRQ=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr982424ljn.18.1540464601700;
 Thu, 25 Oct 2018 03:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
 <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca> <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
 <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca> <20181025080638.771621a3@ivy-bridge>
In-Reply-To: <20181025080638.771621a3@ivy-bridge>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Oct 2018 06:49:50 -0400
Message-ID: <CAHC9VhR02siURgadQs0EikcOm0d_TPAi4jJYCx4NkA=wQ5rjSA@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of syscalls
To:     sgrubb@redhat.com
Cc:     rgb@redhat.com, simo@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:06 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wed, 24 Oct 2018 20:42:55 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-10-24 16:55, Paul Moore wrote:
> > > On Wed, Oct 24, 2018 at 11:15 AM Richard Guy Briggs
> > > <rgb@redhat.com> wrote:
> > > > On 2018-10-19 19:16, Paul Moore wrote:
> > > > > On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs
> > > > > <rgb@redhat.com> wrote:

...

> > > > > > +/*
> > > > > > + * audit_log_contid - report container info
> > > > > > + * @tsk: task to be recorded
> > > > > > + * @context: task or local context for record
> > > > > > + * @op: contid string description
> > > > > > + */
> > > > > > +int audit_log_contid(struct task_struct *tsk,
> > > > > > +                            struct audit_context *context,
> > > > > > char *op) +{
> > > > > > +       struct audit_buffer *ab;
> > > > > > +
> > > > > > +       if (!audit_contid_set(tsk))
> > > > > > +               return 0;
> > > > > > +       /* Generate AUDIT_CONTAINER record with container ID
> > > > > > */
> > > > > > +       ab = audit_log_start(context, GFP_KERNEL,
> > > > > > AUDIT_CONTAINER);
> > > > > > +       if (!ab)
> > > > > > +               return -ENOMEM;
> > > > > > +       audit_log_format(ab, "op=%s contid=%llu",
> > > > > > +                        op, audit_get_contid(tsk));
> > > > > > +       audit_log_end(ab);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(audit_log_contid);
> > > > >
> > > > > As discussed in the previous iteration of the patch, I prefer
> > > > > AUDIT_CONTAINER_ID here over AUDIT_CONTAINER.  If you feel
> > > > > strongly about keeping it as-is with AUDIT_CONTAINER I suppose
> > > > > I could live with that, but it is isn't my first choice.
> > > >
> > > > I don't have a strong opinion on this one, mildly preferring the
> > > > shorter one only because it is shorter.
> > >
> > > We already have multiple AUDIT_CONTAINER* record types, so it seems
> > > as though we should use "AUDIT_CONTAINER" as a prefix of sorts,
> > > rather than a type itself.
> >
> > I'm fine with that.  I'd still like to hear Steve's input.  He had
> > stronger opinions than me.
>
> The creation event should be separate and distinct from the continuing
> use when its used as a supplemental record. IOW, binding the ID to a
> container is part of the lifecycle and needs to be kept distinct.

Steve's comment is pretty ambiguous when it comes to AUDIT_CONTAINER
vs AUDIT_CONTAINER_ID, but one could argue that AUDIT_CONTAINER_ID
helps distinguish the audit container id marking record and gets to
what I believe is the spirit of Steve's comment.  Taking this in
context with my previous remarks, let's switch to using
AUDIT_CONTAINER_ID.

-- 
paul moore
www.paul-moore.com
