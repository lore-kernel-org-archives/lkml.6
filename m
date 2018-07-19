Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A26720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sWXLBZPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A26720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGSXdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:33:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39093 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGSXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:33:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so9540546lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNoc1JwOSv3mDpN+XL2osgqJxM34n4DRSwvbFzmhT7I=;
        b=sWXLBZPZ+TFV0Zmm9Qx7+l/tDOpTs3J2OB47zgrp9xq8in6V82Fmk2lKwpFSnit0Xo
         AZRtryD5FHKrSwyQz1jdnCv5ZZ61ElkMQvy8hPSLcTe6OZoBVjG/SfumGpAWuTfs7GWW
         E43E/6vHN152y7pZ7gF2GZLfrUk5LaOBaTGPGrIPcA+dQtisCDX97Be+9LCRZJae3And
         GYcTEBa+NSiFoPF4A7vzfg4bBCHTwr4I6Y1UhIA1T2+BzsyKHuD1/rRrJNdUD0ZJ34+g
         f0zFaLTyopfwf6GIKltrSHmHalS8mwjsQF0DxTEqKqLaHIt7A3ZVnlVCrYLVnF6ATgSe
         T9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNoc1JwOSv3mDpN+XL2osgqJxM34n4DRSwvbFzmhT7I=;
        b=BigEgCgQOc3jhk2QMsuNhh4Mit0M100inWQgBDwdcXrgXtUZyZLxozzJRgo1zQVJPp
         wguTithTMfo+FWRxls17/vmiPEA0eMYSG3eRIZNyzn+nuIJHQMxkl5BA+Nx1tU1E7JOl
         x8k2eIm0Qy9zBt9k0F94KRBlb/slRWgqkJ55iPecudyHf8NYKXJmrgcf2fsPcb4FOixJ
         GBioDnTcM5EM5Ml1+BfuXuEDnn9tPGjtAvcL6nrAqQLUbwPOf+Rw9Z/Ku6+fS001yBBh
         sPbOnktLJnx3m9KvHUDWMzYZq/PpLjWG8/RC6h/4s0tZRIh7H8DJ8OGGqXYnVgeBkiKI
         HMLA==
X-Gm-Message-State: AOUpUlFF6ChX+iYki1D2zS16vjC0Kh6x79P9qcf0Lra9uOQoC0wcCBDQ
        fA4/LCwCIwxZ7zHPp0Fmy4KFKZVXFj1hU80F95D4
X-Google-Smtp-Source: AAOMgpft6J3IXSnyMjXDy0xRUlGvIB4o7to1m6ThgG5DEVAQe1wkG8VLmGup2L1j5B2OIFKAFt3ibSc9tw5Ouxa9bcU=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr8700382lje.70.1532040467595;
 Thu, 19 Jul 2018 15:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
 <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com>
 <20180713004122.qlxdpkae4ihkxatg@madcap2.tricolour.ca> <CAHC9VhTwYo2p9sKJvhK5haQWuNtR20AEDoA=yGW1gQqdYBzMzQ@mail.gmail.com>
 <20180719160803.7faw2feelfkunysa@madcap2.tricolour.ca>
In-Reply-To: <20180719160803.7faw2feelfkunysa@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Jul 2018 18:47:35 -0400
Message-ID: <CAHC9VhQs9g2yBJC+fy4xcAbgOAPWMnPs8+7ksffLgc3RUenKpw@mail.gmail.com>
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

On Thu, Jul 19, 2018 at 12:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-18 17:45, Paul Moore wrote:
> > On Thu, Jul 12, 2018 at 8:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2018-06-28 15:41, Paul Moore wrote:
> > > > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > The failure to add an audit rule due to audit locked gives no clue
> > > > > what CONFIG_CHANGE operation failed.
> > > > > Similarly the set operation is the only other operation that doesn't
> > > > > give the "op=" field to indicate the action.
> > > > > All other CONFIG_CHANGE records include an op= field to give a clue as
> > > > > to what sort of configuration change is being executed.
> > > > >
> > > > > Since these are the only CONFIG_CHANGE records that that do not have an
> > > > > op= field, add them to bring them in line with the rest.
> > > >
> > > > Normally this would be an immediate reject because this patch inserts
> > > > a field into an existing record, but the CONFIG_CHANGE record is so
> > > > variable (supposedly bad in its own right) that I don't this really
> > > > matters.
> > > >
> > > > With that out of the way, I think this patch is fine, but I don't
> > > > think it is complete.  At the very least there is another
> > > > CONFIG_CHANGE record in audit_watch_log_rule_change() that doesn't
> > > > appear to include an "op" field.  If we want to make sure we have an
> > > > "op" field in every CONFIG_CHANGE record, let's actually add them all
> > > > :)
> > >
> > > The version I'm looking at already had it when it was added in 2009.
> >
> > Yup, there it is ... now I'm wondering what tree I was looking at as a
> > reference while reviewing this?
> >
> > /me scratches head
> >
> > > This one doesn't add the auid and ses fields because they will be
> > > covered by the linking of this record with the syscall record via the
> > > audit_context() introduced in another patch.
> >
> > Yeah, I'm not concerned about that for the reasons you state.
> >
> > > > and one more in audit_receive_msg().  There may be more.
> > >
> > > I believe they're covered by other patches in the ghak59 set.
> >
> > If they are in the later patches it might be good to move those "op="
> > additions into this patch.
>
> I don't see any CONFIG_CHANGE records generated in audit_receive_msg()
> that are missing op= field.  Can you narrow it down?

Well, just grep'ing my way through audit_receive_msg() I see that
AUDIT_ADD/DEL_RULE generates a CONFIG_CHANGE record.

> > > > > Old records:
> > > > > type=CONFIG_CHANGE msg=audit(1519812997.781:374): pid=610 uid=0 auid=0 ses=1 subj=... audit_enabled=2 res=0
> > > > > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> > > > >
> > > > > New records:
> > > > > type=CONFIG_CHANGE msg=audit(1520958477.855:100): pid=610 uid=0 auid=0 ses=1 subj=... op=add_rule audit_enabled=2 res=0
> > > > >
> > > > > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : op=set audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> > > > >
> > > > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > >  kernel/audit.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > index e7478cb..ad54339 100644
> > > > > --- a/kernel/audit.c
> > > > > +++ b/kernel/audit.c
> > > > > @@ -403,7 +403,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
> > > > >         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > > > >         if (unlikely(!ab))
> > > > >                 return rc;
> > > > > -       audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> > > > > +       audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> > > > >         audit_log_session_info(ab);
> > > > >         rc = audit_log_task_context(ab);
> > > > >         if (rc)
> > > > > @@ -1365,7 +1365,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> > > > >                         return -EINVAL;
> > > > >                 if (audit_enabled == AUDIT_LOCKED) {
> > > > >                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> > > > > -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> > > > > +                       audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
> > > > > +                                        msg_type == AUDIT_ADD_RULE ? "add" : "remove",
> > > > > +                                        audit_enabled);
> > > > >                         audit_log_end(ab);
> > > > >                         return -EPERM;
> > > > >                 }
> > > > > --
> > > > > 1.8.3.1
> > > >
> > > > --
> > > > paul moore
> > > > www.paul-moore.com
> > >
> > > - RGB
> > >
> > > --
> > > Richard Guy Briggs <rgb@redhat.com>
> > > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > > Remote, Ottawa, Red Hat Canada
> > > IRC: rgb, SunRaycer
> > > Voice: +1.647.777.2635, Internal: (81) 32635
> >
> >
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
