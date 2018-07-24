Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C369C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2461C20671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EqOgpfLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2461C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeGXVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:25:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45436 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388666AbeGXVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:25:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id j143-v6so3848523lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzOTaNgEV2PT/zNNp3mDF3NDzLmZM7jae331scRigko=;
        b=EqOgpfLIvtDXIF8GyWTQSjSMnxTwhG5y7n0lIzfguw46fT+kPI0+NP6sqjfoWApg97
         RS6gn3JFH/vtD4rUs6r0887sVb2QiIxwIIajXVwCnppncJ0gyxrUlA1FgTMjCsm8AIZd
         A7VxW+YWf+gtBQn2sfDtLbjCID3t4JS7GZ3BIyW5NWl2/WTCx8/C9DzEGzpnGxrVMUwM
         J2ljtY3TwgZwj7uKRDRaUaN9V7jwJ0hzuGpoqm/JYiwXDKwDBy1ppCB8NEt9cigav1VC
         2PzG30lCQw528CWaPlcRRBpfL3k+cpuZByxzvfSR2KoDDH20ZqDrquRZGY0m6h7PQltX
         +djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzOTaNgEV2PT/zNNp3mDF3NDzLmZM7jae331scRigko=;
        b=Z5+Ml5VoVbqdilZGPKe0dqbIiLazoIJBl1wJhVzfNKEJnqUwnW59qTM2+sFrNeUAMu
         LNs0Kn8uDagp+U4zYR/JgVKR60KH8opF4EvizZbcF/73iaNBxuCFPoJI7wRF4UPzRVwY
         Mg2vidKS88TLNC0hYYmFsVH92IoRLEWdTsTU6lyr6tUHks1tZLhxsdUGSN7AITptdYd4
         TD6BZA//4YU+MsnR4GW92ncx0zmf9qQRquOrm2mSld35BAhsZdPOw/KWjGAD29eRVLR8
         bKt3IKk+0Ah8J58JNdYWKEaY3YaJVt4b7HO2LUAWEkcoLCKZliqCKvTOxfg3qaaOACiA
         fnVA==
X-Gm-Message-State: AOUpUlH6TpnIDNq5oYh9jPs0ecuZUUG57Bjy/VqJLCOgBj45sHx4QsDL
        KNOq2DinW6aKgPueVviGsZb/V3Dj0Dnec6/VinTK
X-Google-Smtp-Source: AAOMgpfT9vD5ezinyl44uAlJ7SfawMrGi/6Qpxx5kSLfAPZhfZhc7YQbw5ep4fSQRtmnlDf716eLvtpIcxt/5XaPN3o=
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr10524878lfg.14.1532463451006;
 Tue, 24 Jul 2018 13:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <907e32319825bb6336a662f4f6f6d173f56f3226.1529003588.git.rgb@redhat.com>
 <CAHC9VhSKcxHScr-ZNQU3iVrqhU4CDKW7tpn3e+NBKAAmnpRP4g@mail.gmail.com>
 <20180712214608.ed4chli7mdc7ymin@madcap2.tricolour.ca> <20180723164035.wkazolpmpf3mvdxw@madcap2.tricolour.ca>
 <CAHC9VhQ3qxHQ6mHhs1JNMg5qr3qJJh2DpD147QWnfsXdM7=rGA@mail.gmail.com> <20180724130203.by5ev4xhaixgzvq5@madcap2.tricolour.ca>
In-Reply-To: <20180724130203.by5ev4xhaixgzvq5@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 16:17:19 -0400
Message-ID: <CAHC9VhS_QwH+SG9kuVQn3GZ+N=FAuFU-d+TUDn+G4Qkm5xOvHw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 3/6] audit: exclude user records from
 syscall context
To:     rgb@redhat.com
Cc:     Eric Paris <eparis@parisplace.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:05 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-23 17:00, Paul Moore wrote:
> > On Mon, Jul 23, 2018 at 12:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2018-07-12 17:46, Richard Guy Briggs wrote:
> > > > On 2018-06-28 18:11, Paul Moore wrote:
> > > > > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > Since the function audit_log_common_recv_msg() is shared by a number of
> > > > > > AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> > > > > > and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> > > > > > syscall accompanied record type, special-case the AUDIT_USER_* range of
> > > > > > messages so they remain standalone records.
> > > > > >
> > > > > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > > ---
> > > > > >  kernel/audit.c | 12 +++++++++---
> > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > I think this is fine, but see my previous comment about combining 2/6
> > > > > and 3/6 as a safety measure.
> > > >
> > > > This one I left as a seperate patch for discussion.  We'd previously
> > > > talked about connecting all possible records with syscall records if
> > > > they exist, but this one I'm unsure about, since we don't really care
> > > > what userspace process is issuing this message.  It is just the message
> > > > content itself that is important.  Or is it?  Are we concerned about
> > > > CAP_AUDIT_WRITE holders/abusers and want as much info about them as we
> > > > can get in case they go rogue or pear-shaped?
> > >
> > > I'm waiting on re-spinning this patchset because of this open question.
> > >
> > > Is connecting AUDIT_USER* records desirable or a liability?
> >
> > Like I said, I think special casing the AUDIT_USER* records so they
> > are *not* associated with other records is okay, and perhaps even the
> > right thing to do.  The problem is that we don't have the necessary
> > context (har har) to match any kernel events (and there is the
> > possibility that there are none) to the userspace generated
> > AUDIT_USER* event.  Further, I don't think this is something we would
> > ever be able to solve in a reasonable manner.
>
> Ok, having said that, I think I'd still prefer to keep this patch
> seperate, partly to retain the simplicity of the previous patch and make
> very clear what each one is doing, and partly if we decide to change our
> mind in the future that these AUDIT_USER* records should be autonomous.

Okay, I'll buy that argument.

-- 
paul moore
www.paul-moore.com
