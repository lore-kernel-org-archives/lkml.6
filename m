Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC7AC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4213720880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0Ifayw1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbeGXVEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:04:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35743 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbeGXVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:04:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so4652075ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE8nwzTxFQR1H/VDYi57q7ALnBHLGOMnmP2dh5LlHSk=;
        b=0Ifayw1RHQiS98hk5aD7t1jgg3McxSxUHwozS0FszLIPGi5bOctlOFSFGxI2asHIcp
         2+bzQcURNwcJiNjswfiAhZ0wEt3IZxC5tkIZ5it5dik4Fvdf5PZYBIs0EDWW53pQLYqh
         kxMXiubJWew1WhyEOGAg+G3C4vKFEKowWyLwdfN4S/PDFXRGUPfAsT60PRGzbN9EXho5
         Sil5X2BZW+84zm3S139ZsHyrH2CCpAVzL7mitvl2N/biicjzRO+71tXrH9kd6YMijNia
         kYtk9VxRUPMffccqeQsbf7mBYKhXzhynkK2RFfqLevD+u8ielgcgASvALl8ITMDz8EJ4
         qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE8nwzTxFQR1H/VDYi57q7ALnBHLGOMnmP2dh5LlHSk=;
        b=QmVgRRMGaHjYAprreCn73ifcDel27RTEpvnyqqkD8ap1pWUdhvpmjLwpvHxdB0d15q
         I5ih4hHvCvex4+AJTW9ZhCrhKFmuOu2rPvwCX3rbkocE9ngwj1vu1PHtAOxZJJdjXNHY
         JqF1+86l+akidDhRQTdPMftAKZmvuhWcofjorNtVoaTFl71ot1reAHAGdyG6jO+uw55n
         qehIuOOMQVS6szNOaIMQQV2ImsbqvKP3fh2ry+zuTZ8hUtEjatSy55M+czrYtBJOPVUS
         8Brcyl4EkoxhuKY7sUvNhMjoqe3WCtsYe+SxMgM/BwXocNoiaVJRvM0LoebpZXpLnJfL
         8cCg==
X-Gm-Message-State: AOUpUlHGxEC6SDDGHWmGTiRfqc+NxuSmQdQG5GYwIqS8jW9l1kTmzdeA
        kjBYGxtMXAH+AkaUb/1/rxJQkUtlAOujTYtKmS6/
X-Google-Smtp-Source: AAOMgpevTjLRL9a7RL2mmmjgPd4VISAnZBtOXOthJzLL4uCGH7nTwBtolMxeQO4gHXDLlfNOH2SppwRCdY+Mur7/Ikg=
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr12779366ljh.98.1532462166405;
 Tue, 24 Jul 2018 12:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn> <450ab68cc6b7cebbf1b6292e3140932ea1ac9e57.camel@redhat.com>
In-Reply-To: <450ab68cc6b7cebbf1b6292e3140932ea1ac9e57.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 15:55:55 -0400
Message-ID: <CAHC9VhQy6Rakx6WZ236R+PjwtaZ2Sq9SuoGMC8iejOmhRbCM_w@mail.gmail.com>
Subject: Re: [PATCH] audit: fix potential null dereference 'context->module.name'
To:     Eric Paris <eparis@redhat.com>, wang.yi59@zte.com.cn
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 7:39 AM Eric Paris <eparis@redhat.com> wrote:
> Would it make more sense to actually check for failure on allocation
> rather than try to remember to deal with it later? How about we just
> have audit_log_kern_module return an error and fail if we are OOM?

Generally I agree, checking on allocation is the right thing to do.
However, in this particular case the error recovery for a failed
allocation would likely ignore the record entirely, and I think a
module load record with a "(null)" module name is still better than no
module load record at all ... and yes, I understand that if the module
name allocation fails there is a good chance other allocations will
fail and we might not emit the record, but I'll take my chances that
the load is transient and the system is able to recover in a timely
manner.

> (also this seems like a good place to use kstrdup, instead of
> kmalloc+strcpy)

Yes, I agree.  Yi Wang, could you submit a v2 of this patch using kstrdup()?

> On Tue, 2018-07-24 at 13:57 +0800, Yi Wang wrote:
> > The variable 'context->module.name' may be null pointer when
> > kmalloc return null, so it's better to check it before using
> > to avoid null dereference.
> >
> > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> > ---
> >  kernel/auditsc.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index e80459f..4830b83 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1272,8 +1272,12 @@ static void show_special(struct audit_context
> > *context, int *call_panic)
> >               break;
> >       case AUDIT_KERN_MODULE:
> >               audit_log_format(ab, "name=");
> > -             audit_log_untrustedstring(ab, context->module.name);
> > -             kfree(context->module.name);
> > +             if (context->module.name) {
> > +                     audit_log_untrustedstring(ab, context-
> > >module.name);
> > +                     kfree(context->module.name);
> > +             } else
> > +                     audit_log_format(ab, "(null)");
> > +
> >               break;
> >       }
> >       audit_log_end(ab);
> > @@ -2409,7 +2413,8 @@ void __audit_log_kern_module(char *name)
> >       struct audit_context *context = current->audit_context;
> >
> >       context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
> > -     strcpy(context->module.name, name);
> > +     if (context->module.name)
> > +             strcpy(context->module.name, name);
> >       context->type = AUDIT_KERN_MODULE;
> >  }
> >



-- 
paul moore
www.paul-moore.com
