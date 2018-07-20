Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A57ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UbdNaQFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E4205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbeGTPKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:10:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37157 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbeGTPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:10:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so11304843ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO0jcPdxrRklxCJyI7pW2b7Nf5uDY7oE+ByEOqW+D4E=;
        b=UbdNaQFqPWlrG5vb8MoVPxjEdzL6EaXygn6iceFrGgJG8i/T65xC6l+hC8aAaNDabw
         /g9+HARrCXjeG2/xmwgXNAC5bR6qYvwC2GbTPIChhxyTTT1IKJOaTKgmXFnGEfo271v/
         oTzFgVMYqCdRaPgQtXIoddt8Ia2/yLAf+Flc38a+viDWeW4MLtV4IzQ2ykEssne+GuEe
         HTlDRcp2HjP92aS5pbnplgjy84yyvPuZRgRbNoORCKuB7DU07L0nEwaGX2mhnPIHpEfx
         wptcqXOnx53vydbpkBJeSDVPPJ+ZhENtmsrzA100Pe2mLUx+GMnqbl5s/XYlNZB5aTeu
         9wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO0jcPdxrRklxCJyI7pW2b7Nf5uDY7oE+ByEOqW+D4E=;
        b=cXp0hpYkXDHv5tmefP4WEifToz8773fqR/ItqiWHcGReW88AzXhl87eMZLhrEYm291
         UUlrISVoedni5MkoSJVW8RlD2aqZ5W+IqKLQEOIx8F0VLafD+XKFSzhFB5VPAxqnqMnC
         uyz+E9QlXO9wy4UZh4jZb6V0h/i00Hhh+3vprhmoOIWGML2L2MjaqkiNaf1buWc1ZHjl
         qScIpw1Q0h07LR1BY0v2YFFKgpCzFes6lsYOS5HzMMdbXQxmcG5R+8RxRLxmypqb7LGh
         EuA8Jqk0eN7qpW//bec2NbWmIKvbIkMu5fcceKAXtIZO61trm60ZZOOT3a3nbwKsNqkQ
         AjCg==
X-Gm-Message-State: AOUpUlEFHpLs2KmDPHU7TDwixUZ1+jG1xH4UZEqkNl2Shez8dNAAcR0/
        kSL6SzEOzTFuoXRFpScBEQoYMS0mmssMhyWK1+nT
X-Google-Smtp-Source: AAOMgpd9A2alwWvhvpHULIjARqe0uwburDuOKhxvoAcRp1BJnUivrfD0U8O758GA2O71XeXLHbq4wSZRdiOahSo6ETE=
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr515144ljt.8.1532096521574;
 Fri, 20 Jul 2018 07:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
 <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com>
 <20180713004122.qlxdpkae4ihkxatg@madcap2.tricolour.ca> <CAHC9VhTwYo2p9sKJvhK5haQWuNtR20AEDoA=yGW1gQqdYBzMzQ@mail.gmail.com>
 <20180719160803.7faw2feelfkunysa@madcap2.tricolour.ca> <CAHC9VhQs9g2yBJC+fy4xcAbgOAPWMnPs8+7ksffLgc3RUenKpw@mail.gmail.com>
 <20180720132737.nukm4xycty6mozh6@madcap2.tricolour.ca>
In-Reply-To: <20180720132737.nukm4xycty6mozh6@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jul 2018 10:21:50 -0400
Message-ID: <CAHC9VhT0WnmAGWk5pLJ9TYusdb_8Dububdi=8tWnvoaY+NMnSQ@mail.gmail.com>
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

On Fri, Jul 20, 2018 at 9:30 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-19 18:47, Paul Moore wrote:
> > On Thu, Jul 19, 2018 at 12:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2018-07-18 17:45, Paul Moore wrote:
> > > > On Thu, Jul 12, 2018 at 8:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2018-06-28 15:41, Paul Moore wrote:
> > > > > > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > The failure to add an audit rule due to audit locked gives no clue
> > > > > > > what CONFIG_CHANGE operation failed.
> > > > > > > Similarly the set operation is the only other operation that doesn't
> > > > > > > give the "op=" field to indicate the action.
> > > > > > > All other CONFIG_CHANGE records include an op= field to give a clue as
> > > > > > > to what sort of configuration change is being executed.
> > > > > > >
> > > > > > > Since these are the only CONFIG_CHANGE records that that do not have an
> > > > > > > op= field, add them to bring them in line with the rest.
> > > > > >
> > > > > > Normally this would be an immediate reject because this patch inserts
> > > > > > a field into an existing record, but the CONFIG_CHANGE record is so
> > > > > > variable (supposedly bad in its own right) that I don't this really
> > > > > > matters.
> > > > > >
> > > > > > With that out of the way, I think this patch is fine, but I don't
> > > > > > think it is complete.  At the very least there is another
> > > > > > CONFIG_CHANGE record in audit_watch_log_rule_change() that doesn't
> > > > > > appear to include an "op" field.  If we want to make sure we have an
> > > > > > "op" field in every CONFIG_CHANGE record, let's actually add them all
> > > > > > :)
> > > > >
> > > > > The version I'm looking at already had it when it was added in 2009.
> > > >
> > > > Yup, there it is ... now I'm wondering what tree I was looking at as a
> > > > reference while reviewing this?
> > > >
> > > > /me scratches head
> > > >
> > > > > This one doesn't add the auid and ses fields because they will be
> > > > > covered by the linking of this record with the syscall record via the
> > > > > audit_context() introduced in another patch.
> > > >
> > > > Yeah, I'm not concerned about that for the reasons you state.
> > > >
> > > > > > and one more in audit_receive_msg().  There may be more.
> > > > >
> > > > > I believe they're covered by other patches in the ghak59 set.
> > > >
> > > > If they are in the later patches it might be good to move those "op="
> > > > additions into this patch.
> > >
> > > I don't see any CONFIG_CHANGE records generated in audit_receive_msg()
> > > that are missing op= field.  Can you narrow it down?
> >
> > Well, just grep'ing my way through audit_receive_msg() I see that
> > AUDIT_ADD/DEL_RULE generates a CONFIG_CHANGE record.
>
> The failure case is addressed in this patch.  The success case is
> addressed in audit_log_rule_change().  The latter already has it.  What
> is the problem?  What tree are you looking at?  What am I missing?

So it does.  This discussion dragged out long enough that I forgot to
check the actual patch submission.

I think this patch is fine, I would recommend updating this patchset
using the feedback on the other individual patches and resubmitting.

-- 
paul moore
www.paul-moore.com
