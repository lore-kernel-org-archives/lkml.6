Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70AC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0353620685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DoGhjGEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0353620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbeGXXFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:05:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45313 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbeGXXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:05:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so4900609ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iyh5/l+9wD2eF4PbLjsGylOS3pcSnbgG5lxBOiJtv7M=;
        b=DoGhjGEFLXH/VmUfT2DZ1uRIe7PGeONHlydjg7CmnJFONvkNtiTKzgd5tMI7gUqf66
         B2135K0QjoIpT7qlEfkC6EHuVnSJsVc8LTL3/iTBCHye0QUbkr8sSF/u9avSveOGJ4xC
         jdybmi9a2lphSZ43t/L8ze90Ue1jGkE8V8vwal7/58zdbNbOsGLOcRSjKhAnjUi/pHj6
         HFSLTeU1SU7RvWg7LnO/yRABCKu6aafRoGfgXMTk8lRtjOfFxC5ZpwnrGICNxwKs2rCV
         Q+F5ipIFNIAd4giMTjuZg0JZTpyxyV1VeEhpXu3FqQS9x5mqzYnYK1YmIFV9IWEgbgaA
         w0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iyh5/l+9wD2eF4PbLjsGylOS3pcSnbgG5lxBOiJtv7M=;
        b=cj4rn6bAEdqpLvy0OVWE1hvrUfSQmkPXsZIo902qJK0+ShMZZfpue5zFsCMimPVoiK
         CGGRZ3Hp1TXC0lyx+NguNJQLCVbtU/2c9FjWZnp58Ynx6BGIuBEfeNShvZRBfzCtMh6g
         hg+YHt/29mVTh2LBWoezB7VTJMspL5aIG3PMYUSmr7ieeZuNnJJkeXIQ+hR0ev/FFF2C
         bXdfWELM7eYpiXZvQ0TVsiJs5Xywjj5PBvy7uE/ABBGnPrmlQXCPfs1ApIPoG3wtLLv3
         UODBZ6zOW5pp/o0Vw7X5ye4kUJ5H5qcsiscvHCyznbFPYbYvGfD7XXG1QAOoXZfLoaVu
         MNKQ==
X-Gm-Message-State: AOUpUlFWuGUNJO2lBXsT77Ua6N/XQM9DIGby91Wqszl5vIJs/U0mC0Jz
        Y7VisbRt2840rDmQYHrfVZDiKddCQiCqlMjDWuHt
X-Google-Smtp-Source: AAOMgpdb7EYD0HKAMDp4wXA/aRJUhIowwFyk9T6VyTaWD0NDUNnoh9X2Nlgyh4K3jWvQ/BpDPio0Qp8/t38D7wv2SwI=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr12886349lje.70.1532469434080;
 Tue, 24 Jul 2018 14:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <dcd3d6e27c4beb8aec11805faeb4de7013132bd7.1528304204.git.rgb@redhat.com>
 <CAHC9VhRkH+UaZXfbsmfMsuCO7rQ48R5cBPU__00eG=pyO7AyCw@mail.gmail.com> <20180724193725.k27la4ubg2g2n4qm@madcap2.tricolour.ca>
In-Reply-To: <20180724193725.k27la4ubg2g2n4qm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 17:57:02 -0400
Message-ID: <CAHC9VhTX99Gqnv5SQbm1_3KON7g2R83qSt=bM3KJibDnORBXzQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 04/10] audit: add support for
 non-syscall auxiliary records
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 3:40 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-20 18:14, Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Standalone audit records have the timestamp and serial number generated
> > > on the fly and as such are unique, making them standalone.  This new
> > > function audit_alloc_local() generates a local audit context that will
> > > be used only for a standalone record and its auxiliary record(s).  The
> > > context is discarded immediately after the local associated records are
> > > produced.
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  include/linux/audit.h |  8 ++++++++
> > >  kernel/auditsc.c      | 25 +++++++++++++++++++++++--
> > >  2 files changed, 31 insertions(+), 2 deletions(-)

...

> > > +       struct audit_context *context;
> > > +
> > > +       if (!audit_ever_enabled)
> > > +               return NULL; /* Return if not auditing. */
> > > +
> > > +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
> > > +       if (!context)
> > > +               return NULL;
> > > +       context->serial = audit_serial();
> > > +       context->ctime = current_kernel_time64();
> > > +       context->in_syscall = 1;
> >
> > Setting in_syscall is both interesting and a bit troubling, if for no
> > other reason than I expect most (all?) callers to be in an interrupt
> > context when audit_alloc_local() is called.  Setting in_syscall would
> > appear to be conceptually in this case.  Can you help explain why this
> > is the right thing to do, or necessary to ensure things are handled
> > correctly?
>
> I'll admit this is cheating a bit, but seemed harmless.  It is needed so
> that auditsc_get_stamp() from audit_get_stamp() from audit_log_start()
> doesn't bail on me without giving me its already assigned time and
> serial values rather than generating a new one.  I did look to see if
> there were any other undesireable side effects and found none, so I'm
> tmepted to rename the ->in_syscall to something a bit more helpful.  I
> could add a new audit_context structure member to make
> auditsc_get_stamp() co-operative, but this seems wasteful and
> unnecessary.

That's what I suspected.

Let's look into renaming the "in_syscall" field, it borderline
confusing now, and hijacking it for something which is very obviously
not "in syscall" is A Very Bad Thing.

-- 
paul moore
www.paul-moore.com
