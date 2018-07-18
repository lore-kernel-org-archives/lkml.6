Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9095ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C802075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tAZ+3Tjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C802075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeGRWZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:25:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34752 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeGRWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:25:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so4532163lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qW0tQr/2trFOnuamV4ubuXaekRjF8utwMgUZWjP6xEs=;
        b=tAZ+3TjxNtPIvMkSBen+Xcgw4APiS5NF2n0o6icZ64/QSnTOiUh9OZOE8DqttTOoa7
         9VFi5IcmBbllmjpFgvzJV8bLpJoqZjCX7AWkN87mgT0Obst0xa/YN6/7jfeS9Zyznsy5
         dALndTQBjrG0F71601w3EFpb5+RN+yGC5k+e/9DR0Spi/3Hm/xsLLV4lN4lpOmpy1fqY
         r0UFR1hobiZdY+kpbmrCZ8A7T+odl2rycsTVRxfupSta+oinbtylY/FnVlNJ4+WNDx+R
         eTqg0nqs3Iu7nKK8m9Apr+zMklq2nV7BJb4bfarUr0WlF4FNQe0Mo9vvk2xNx02vXtFM
         7Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qW0tQr/2trFOnuamV4ubuXaekRjF8utwMgUZWjP6xEs=;
        b=fTfZ9ck4okKpis749b/8fyYJDx2XPWy2/rOPrRN7x2NRMx1paFsMLPBokLGIUeZ/nr
         RSSW3pBo37EzsAYZup+Ju04gIiUPAHlwuiC9wWsxzfD2iR80zDsX7jwfzkXojXuFjxbh
         3oYnmU/nDs6NLj2FIFI99GSvIrcIjSQxr2xp17LWRtBxAwnFk951AuJPZTysYQ1CRLXT
         PKHYKjjDj4LtAjoZnqnla4qraQPXsknB0SNZ4y1l4I/p7xctCBdjOmnlc0yUk+H2Povg
         MS5wuS01r74ZJrnEDKoYKY+k7YJbeKOchcayRuFzkTV2fpFAae6EVAEJvFjov9E1y14z
         LAHg==
X-Gm-Message-State: AOUpUlFuZC78NDZxZMuCNg0q9EZdJEk5PRkUDP231bG9NuBwO6eW3/Zf
        kukdCU6FZKS6bJt/2cPgnpMLoOBDBQbmlCkS4wgx
X-Google-Smtp-Source: AAOMgpdSKk9h45Iy75jFOe5dXgj9a0VmPFb4KTEOAhefxxVGGibTuyENEeCF5zAx76nXiSW6O5WfAqjHxcTxIvY3rj8=
X-Received: by 2002:a19:cb44:: with SMTP id b65-v6mr5215168lfg.12.1531950342501;
 Wed, 18 Jul 2018 14:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
 <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com> <20180713004122.qlxdpkae4ihkxatg@madcap2.tricolour.ca>
In-Reply-To: <20180713004122.qlxdpkae4ihkxatg@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Jul 2018 17:45:31 -0400
Message-ID: <CAHC9VhTwYo2p9sKJvhK5haQWuNtR20AEDoA=yGW1gQqdYBzMzQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 1/6] audit: give a clue what CONFIG_CHANGE
 op was involved
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 8:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-06-28 15:41, Paul Moore wrote:
> > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > The failure to add an audit rule due to audit locked gives no clue
> > > what CONFIG_CHANGE operation failed.
> > > Similarly the set operation is the only other operation that doesn't
> > > give the "op=" field to indicate the action.
> > > All other CONFIG_CHANGE records include an op= field to give a clue as
> > > to what sort of configuration change is being executed.
> > >
> > > Since these are the only CONFIG_CHANGE records that that do not have an
> > > op= field, add them to bring them in line with the rest.
> >
> > Normally this would be an immediate reject because this patch inserts
> > a field into an existing record, but the CONFIG_CHANGE record is so
> > variable (supposedly bad in its own right) that I don't this really
> > matters.
> >
> > With that out of the way, I think this patch is fine, but I don't
> > think it is complete.  At the very least there is another
> > CONFIG_CHANGE record in audit_watch_log_rule_change() that doesn't
> > appear to include an "op" field.  If we want to make sure we have an
> > "op" field in every CONFIG_CHANGE record, let's actually add them all
> > :)
>
> The version I'm looking at already had it when it was added in 2009.

Yup, there it is ... now I'm wondering what tree I was looking at as a
reference while reviewing this?

/me scratches head

> This one doesn't add the auid and ses fields because they will be
> covered by the linking of this record with the syscall record via the
> audit_context() introduced in another patch.

Yeah, I'm not concerned about that for the reasons you state.

> > and one more in audit_receive_msg().  There may be more.
>
> I believe they're covered by other patches in the ghak59 set.

If they are in the later patches it might be good to move those "op="
additions into this patch.

> > > Old records:
> > > type=CONFIG_CHANGE msg=audit(1519812997.781:374): pid=610 uid=0 auid=0 ses=1 subj=... audit_enabled=2 res=0
> > > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> > >
> > > New records:
> > > type=CONFIG_CHANGE msg=audit(1520958477.855:100): pid=610 uid=0 auid=0 ses=1 subj=... op=add_rule audit_enabled=2 res=0
> > >
> > > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : op=set audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> > >
> > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  kernel/audit.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index e7478cb..ad54339 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -403,7 +403,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
> > >         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > >         if (unlikely(!ab))
> > >                 return rc;
> > > -       audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> > > +       audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> > >         audit_log_session_info(ab);
> > >         rc = audit_log_task_context(ab);
> > >         if (rc)
> > > @@ -1365,7 +1365,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> > >                         return -EINVAL;
> > >                 if (audit_enabled == AUDIT_LOCKED) {
> > >                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> > > -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> > > +                       audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
> > > +                                        msg_type == AUDIT_ADD_RULE ? "add" : "remove",
> > > +                                        audit_enabled);
> > >                         audit_log_end(ab);
> > >                         return -EPERM;
> > >                 }
> > > --
> > > 1.8.3.1
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635



-- 
paul moore
www.paul-moore.com
