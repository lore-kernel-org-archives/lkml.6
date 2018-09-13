Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A41C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A1420C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRgs1S3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A1420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIMSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:53:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46379 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbeIMSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so9394433oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YWxzqETBOQqt9hsvagVoYUtnYSuf068RtdNyNkt+Is=;
        b=GRgs1S3J1AMD0yDzkKBNj3ajz/sBNblOCzXZMvhGo5bvGvzGv6mESjsH3SqIm+Uicg
         lvbOW6oxX6XRHZtVfDQJ/+/fMsFDmeVEBLeRAL46KEXwqL8x8QYtDfoov/n3cxtKvHCL
         1JiGSp388n5lar8b15J6WFs2veLOj4sqvMOP1880HBqv0WnhhpGOvU59Owo4CzTMr1Wl
         EO2W+DCjBkgPeDc0DqlwGTz3O9eXinak8UURdexQWFRXlg4N7i0sj2WRy1bXWJ7U90YJ
         2LNvR32xIcEjfJ0QGshCTR6uMcMxxjfuBqzEdMoIwqAjhANPmeQt6JEIQhYBFxo1pLdX
         96cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YWxzqETBOQqt9hsvagVoYUtnYSuf068RtdNyNkt+Is=;
        b=o4MTRQYnaKyb4vYHdDbFM39BsNV9sPXqlC2lANXo6CPkjmQWjRGi8kPj6HFA3ZhG4f
         OZ99SaNguF9DELtUryrPkbfhSnbd1F0gyShLc+ToES2RQadwGeY4yde6bdkWrTz6NTKm
         8/OLYoj01Ej/1kpHb6va6FXrELi0J/3Pwwn+jPsOqgKupw0R9fMF07eSchwWBiSEkbqU
         6f1OETd1sekB7QOO8DF5wuxJ1W/zzSmEZMVViIBzVbGXzdVzR50SLCgDLpkEiO5RZiMN
         YE4ZLKK7EGrtd13riMX+4Uy6r0bxhv3eG4sDByyGh1jc4MAmZD08/AY+87DLR1MOVDTo
         hgfQ==
X-Gm-Message-State: APzg51CGJNSdOlJZNi+7immF3n8T6uoUB/B3Yg1BYm+oQhNOGeglczUc
        rJ3NwmWa9hU8mKaVhbR8z1UQj2lTBBGkSp0p32mb9A==
X-Google-Smtp-Source: ANB0VdbndFAR1ZV92pFMZcxx+qaUTc4drRfhQJTN7ombfBNjsHe5+QzySBwrEvuMlmptTnC0Z6JQmm4X0omUkGscGAI=
X-Received: by 2002:aca:f0a:: with SMTP id 10-v6mr6209348oip.183.1536846225191;
 Thu, 13 Sep 2018 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com> <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com>
In-Reply-To: <20180913063943.GA13306@jackp-linux.qualcomm.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 13 Sep 2018 06:43:09 -0700
Message-ID: <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at Vsafe5V
To:     jackp@codeaurora.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:39 PM Jack Pham <jackp@codeaurora.org> wrote:
>
> Hello Badhri,
>
> On Wed, Sep 12, 2018 at 07:11:13PM -0700, Badhri Jagan Sridharan wrote:
> > During hard reset, TCPM turns off the charging path.
> > The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.
>
> This doesn't make sense. By definition the sink isn't sourcing VBUS, so
> how can it control whether to allow the voltage to be 5V or 0V?

The way I understand it, this is for the current limits that can be
set on the Sink side.
During hard reset, sink has to fallback to VSafe5V or VSafe0V if
higher pd contract was negotiated.

>
>
> > From USB_PD_R3_0
> > 2.6.2 Sink Operation
> > ..
> > Serious errors are handled by Hard Reset Signaling issued by either Port
> > Partner. A Hard Reset:
> > resets protocol as for a Soft Reset but also returns the power supply to
> > USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
> > Sink.
>
> I can see how the wording here "vSafe0V *or* vSafe5V" is misleading, as
> I think it actually is both. In later parts of the spec, the source's
> VBUS behavior is well defined in that it must first drop to vSafe0V
> and then return to vSafe5V. Please refer to section 7.1.5.


Yeah thats for the source. But for sink, Say if the source isnt PD, then,
sink initiated hard resets happen during the connection. Sink would hard reset
couple of times before deeming that the partner is non PD. When connected
to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
a reason to setcharge to false or drop the input current limit. Do you agree ?

>
>
> > Add a config option to tcpc_dev and let the device specific driver decide
> > what needs to be done.
> >
> > Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm.c | 7 ++++++-
> >  include/linux/usb/tcpm.h | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index a4e0c027a2a9..350d1a7c4543 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -3269,7 +3269,12 @@ static void run_state_machine(struct tcpm_port *port)
> >       case SNK_HARD_RESET_SINK_OFF:
> >               memset(&port->pps_data, 0, sizeof(port->pps_data));
> >               tcpm_set_vconn(port, false);
> > -             tcpm_set_charge(port, false);
> > +             if (port->tcpc->config->vsafe_5v_hard_reset)
>
> Therefore I think this config option doesn't make sense.
>
> > +                     tcpm_set_current_limit(port,
> > +                                            tcpm_get_current_limit(port),
> > +                                            5000);
>
> But I do think this might still be useful at least in ensuring the sink
> returns to drawing only default power during the transition before
> re-establishing a contract. Given that the sink can't control when
> exactly VBUS will go to 0V, is it ok to call set_current_limit() even if
> VBUS is momentarily 0V, so at least it is in preparation for when VBUS
> turns back on? Or would it be safer to do it during the
> SNK_HARD_RESET_SINK_ON state after we know VBUS is back to vSafe5V?

IMHO Doing it in SNK_HARD_RESET_SINK_ON makes more sense when
vsafe_5v_hard_reset
is not set.

>
>
> > +             else
> > +                     tcpm_set_charge(port, false);
>
> Regards,
> Jack
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
