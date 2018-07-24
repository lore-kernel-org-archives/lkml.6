Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9BAC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B652B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NcfNgojS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B652B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeGYAr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:47:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45863 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeGYAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:47:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so5057297ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEOIyk7zbyBiq+MLwQ3IHyIwnT2xmU7lVQUKKy7+R+s=;
        b=NcfNgojSl2p/39QXthIlvZq30SJwpOlMccz3emS1QnQ4+XDqcfdBlouT2VGBHYeyKC
         26x+9o3mQ6bQaM3VHbheik20XST3to0r2zbp8I3mhR3IBzvHWXA18h7tqFwIhl3cUN/S
         LGK8NfZ/dCtIIch/f3dbeyzN1oYbbFi3pxzOArfhoUU5v4yWyqiAnWcsvuZGIC9AzoN/
         7WFDEmLSnv7eSyxb3xvYB6OrZnyaV5nGcjK0M78AC+jSlBUxhWSd2FKAQ0ynykM3ejvV
         eFjo2p58s4phX4jJnIGUcej052X7yY5gzVqz3VzCeY8nRQYvtPuQCi/pBZu97aXttkWo
         TPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEOIyk7zbyBiq+MLwQ3IHyIwnT2xmU7lVQUKKy7+R+s=;
        b=grCTQxDhQP54RBhX4+u9nXQ+oUwj/KZLvw/9BI6Q3rbC3TcSamDvICb+IFU5ZG9sB1
         InCFlCO5x6ca6/mmjxa42Zz0ysbSq6VckUlsynWgWn1Ujc91Frifv16VesISkXLERadh
         BotOUfaXDyacKoqzILmaFvgVz3JMSTrs9fb74e0s6Cm1kOa90aeG8/Obh2FlMfdYiZI7
         WmkAEhu+pwJgpnzXQwcU4gWzucEdkVkehPGkl0p3e1uYfiPQQWR2KjADiWFF9yN9tPEL
         G1SbNECA2zEpMmkdPIkJ2DAWoHEaA9d/cSNmfWxr2WHSdeRQSb4hALIBzvw0u68FtXr9
         9gDg==
X-Gm-Message-State: AOUpUlGITHG20s48mJpf4bEYdNm2HYVz9WnZ3edIjTEJZEcDM8rU6mPQ
        JodO/IjU4ofhPcrL3qJWKWXrU92B3wTT6EgwhWnX
X-Google-Smtp-Source: AAOMgpcloKvlTfBHk/22joP8z5orgxrb8VT3FoSHeL8ZgCFi10/4DRpnyhesBs0BcwfF30Y7JQlRRNoOokObT8OVFYE=
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr11778658ljt.8.1532475512988;
 Tue, 24 Jul 2018 16:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn>
 <450ab68cc6b7cebbf1b6292e3140932ea1ac9e57.camel@redhat.com>
 <CAHC9VhQy6Rakx6WZ236R+PjwtaZ2Sq9SuoGMC8iejOmhRbCM_w@mail.gmail.com> <89963f4c8c4f89bc766ffc0b58fe8e24942c3793.camel@redhat.com>
In-Reply-To: <89963f4c8c4f89bc766ffc0b58fe8e24942c3793.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 19:38:21 -0400
Message-ID: <CAHC9VhRZnzKF03tFmgp007BWB4GuWOM5e8X7s=_GuPQ4d1tjow@mail.gmail.com>
Subject: Re: [PATCH] audit: fix potential null dereference 'context->module.name'
To:     Eric Paris <eparis@redhat.com>
Cc:     wang.yi59@zte.com.cn, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 6:38 PM Eric Paris <eparis@redhat.com> wrote:
> On Tue, 2018-07-24 at 15:55 -0400, Paul Moore wrote:
> > On Tue, Jul 24, 2018 at 7:39 AM Eric Paris <eparis@redhat.com> wrote:
> > > Would it make more sense to actually check for failure on
> > > allocation
> > > rather than try to remember to deal with it later? How about we
> > > just
> > > have audit_log_kern_module return an error and fail if we are OOM?
> >
> > Generally I agree, checking on allocation is the right thing to do.
> > However, in this particular case the error recovery for a failed
> > allocation would likely ignore the record entirely, and I think a
> > module load record with a "(null)" module name is still better than
> > no
> > module load record at all ... and yes, I understand that if the
> > module
> > name allocation fails there is a good chance other allocations will
> > fail and we might not emit the record, but I'll take my chances that
> > the load is transient and the system is able to recover in a timely
> > manner.
>
> On the load_module() code path passing the error up the stack would
> cause the module to not be loaded, instead of being loaded with loss of
> name information. I'd rather have the module not loaded and a
> name=(null) record than it BE loaded and get name=(null)
>
> You've sold me on why Yi Wang's patch is good, but not on why we
> wouldn't propagate the error up the stack on load/delete. (even if we
> may choose to delete the module on OOM)

For better or worse most (all?) of the various audit_log_*() functions
don't return an error code, or if they do they aren't reliably checked
by callers.  I agree with you that in a perfect world it would be nice
if an audit failure here would block the operation, but that isn't how
audit is typically used.

We could presumably fail the record generation on an allocation
failure and signal a lost record via audit_log_lost()?  Perhaps that's
the best option as it would leave the decision up to administrator
(continue without the record, printk, or panic).

-- 
paul moore
www.paul-moore.com
