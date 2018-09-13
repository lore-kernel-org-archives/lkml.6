Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58422C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060B120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsKDPONs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060B120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeIMSzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:55:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35699 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeIMSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so9499041oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6AI+xLHhLhosh1k8SCPRvDgwR2on1ob9kTQbtPYiHw=;
        b=lsKDPONs78XTqeBkUm1xgyg4ViI6rZUMcfuo8n2nuyzXnvuoN0S3sO5xkxUpIi83il
         SEAbdxzpKnkHPPj6XT9tIHnnLDZ76WyGTiMCBPM3AGMWaOtD0wjyAVrZyP5VEbdF7yEt
         fdUK67C7tV+yZzD6F8xK5CLaH09b5VBWahZ2Shtt4Ba7OhqFb31eUGZ7jhWikn6KPh70
         7TJUBtWcTaDC2q+KboXCqPjqI4oPVhbc9bgH8JSSm7QbMfhciz1oROKBsWcTaT4RdF+3
         USLhOkZSwBfUYyLzlWqWU8W5Ulfg174HsdGtBIIPgDo1UXKJpA0qoRiiku+bkKM8mIYz
         yBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6AI+xLHhLhosh1k8SCPRvDgwR2on1ob9kTQbtPYiHw=;
        b=num7kbMs/AAiJyVf+Zj5fBsGO8KFTwcCsswwYrMVdIR5DKVv99ptFwl+VCfA+Fj0nS
         BWxSb4Zpyteq/CDGIxjp++Cc3rHaqnfS42bbFbxp6yTLicwyViVI0eUUZQYaK8KsaBOW
         KD7dVvWj4VLtVpNBCblZQO9khK8UDMxBwUmrDKi+5efZZw6yKHMYVRw17+RVLZWXNTo6
         m4Tf3b0Xe8dWEA6Zrj9rhtVuU28HKdBD88D2P5oTBederuioc95P70RcR9WNIDhjsIHA
         GGpzhshtbrvrVh5xEYZtD/CMHjeht7VUm9KaFJ/ucQLA6B0W4f68bajUtBPPVgG/P+C0
         fHLA==
X-Gm-Message-State: APzg51DlmP4E5DuZpLe8XaHuEc94whQH+N3VxERjB4um7QboHV9K1aha
        bLE3dpicMyYeoDOhLmnN934pOsQysfeb9rd7Oe4yxA==
X-Google-Smtp-Source: ANB0VdZ8lp9W5tetCdx8Jn4sP2v6BDjFAjwmKUW8gLJrRcF+qlOwM+0igMl8UdKpA5jx6asZOTazeXQ/Ulmp9GlsAFA=
X-Received: by 2002:aca:f0a:: with SMTP id 10-v6mr6215750oip.183.1536846377954;
 Thu, 13 Sep 2018 06:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com> <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com> <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
In-Reply-To: <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 13 Sep 2018 06:45:41 -0700
Message-ID: <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at Vsafe5V
To:     jackp@codeaurora.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Guenter
On Thu, Sep 13, 2018 at 6:43 AM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Wed, Sep 12, 2018 at 11:39 PM Jack Pham <jackp@codeaurora.org> wrote:
> >
> > Hello Badhri,
> >
> > On Wed, Sep 12, 2018 at 07:11:13PM -0700, Badhri Jagan Sridharan wrote:
> > > During hard reset, TCPM turns off the charging path.
> > > The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.
> >
> > This doesn't make sense. By definition the sink isn't sourcing VBUS, so
> > how can it control whether to allow the voltage to be 5V or 0V?
>
> The way I understand it, this is for the current limits that can be
> set on the Sink side.
> During hard reset, sink has to fallback to VSafe5V or VSafe0V if
> higher pd contract was negotiated.
>
> >
> >
> > > From USB_PD_R3_0
> > > 2.6.2 Sink Operation
> > > ..
> > > Serious errors are handled by Hard Reset Signaling issued by either Port
> > > Partner. A Hard Reset:
> > > resets protocol as for a Soft Reset but also returns the power supply to
> > > USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
> > > Sink.
> >
> > I can see how the wording here "vSafe0V *or* vSafe5V" is misleading, as
> > I think it actually is both. In later parts of the spec, the source's
> > VBUS behavior is well defined in that it must first drop to vSafe0V
> > and then return to vSafe5V. Please refer to section 7.1.5.
>
>
> Yeah thats for the source. But for sink, Say if the source isnt PD, then,
> sink initiated hard resets happen during the connection. Sink would hard reset
> couple of times before deeming that the partner is non PD. When connected
> to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
> a reason to setcharge to false or drop the input current limit. Do you agree ?
>
> >
> >
> > > Add a config option to tcpc_dev and let the device specific driver decide
> > > what needs to be done.
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm.c | 7 ++++++-
> > >  include/linux/usb/tcpm.h | 1 +
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > > index a4e0c027a2a9..350d1a7c4543 100644
> > > --- a/drivers/usb/typec/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm.c
> > > @@ -3269,7 +3269,12 @@ static void run_state_machine(struct tcpm_port *port)
> > >       case SNK_HARD_RESET_SINK_OFF:
> > >               memset(&port->pps_data, 0, sizeof(port->pps_data));
> > >               tcpm_set_vconn(port, false);
> > > -             tcpm_set_charge(port, false);
> > > +             if (port->tcpc->config->vsafe_5v_hard_reset)
> >
> > Therefore I think this config option doesn't make sense.
> >
> > > +                     tcpm_set_current_limit(port,
> > > +                                            tcpm_get_current_limit(port),
> > > +                                            5000);
> >
> > But I do think this might still be useful at least in ensuring the sink
> > returns to drawing only default power during the transition before
> > re-establishing a contract. Given that the sink can't control when
> > exactly VBUS will go to 0V, is it ok to call set_current_limit() even if
> > VBUS is momentarily 0V, so at least it is in preparation for when VBUS
> > turns back on? Or would it be safer to do it during the
> > SNK_HARD_RESET_SINK_ON state after we know VBUS is back to vSafe5V?
>
> IMHO Doing it in SNK_HARD_RESET_SINK_ON makes more sense when
> vsafe_5v_hard_reset
> is not set.
>
> >
> >
> > > +             else
> > > +                     tcpm_set_charge(port, false);
> >
> > Regards,
> > Jack
> > --
> > The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
