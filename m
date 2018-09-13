Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C772DC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF1D20839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2lqCMSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF1D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeINE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:28:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35902 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeINE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:28:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id w17-v6so2891101otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2lFC0TLMFYioz1K/l54OA9egcodz1NPLNwjOkfbQqEw=;
        b=l2lqCMSQMIgjvzoLxFAvs295D6hJdais2K9xirrAGueE6AE19lMl1OA7aOk7uPgJ7Y
         O73jiM03VMI67YwwZ2BxEq60eGieEgHxSMiAfMkDxXUrHLwhNWDiD8uIYj9HobI7kfuY
         lPq9d5a/HYYBzGqYUD236z+vhG0BnYqvAT3igKJ4qbLtrd+Mr9iHUp4CibRJPhWO+a3D
         g3/odaIaoBu8xMjqzETcNpNeyQQSmtAT71QJrNLcfIS1OJq6omUpTlqPAyQHx4s9edZz
         kcVeHVZLYLezDeTriv1A3s+FOtm8VyOr3do/Hg+ftWs95wIcbOs97mZL6UE4NvB2+7MU
         o19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2lFC0TLMFYioz1K/l54OA9egcodz1NPLNwjOkfbQqEw=;
        b=kUEA3YqebCyZESOJXqw7s+QyDLIe0zktM1QUGifHOkc78HvzQuc9e+i02i0FXqo2BP
         rMxHKSpvB5c85g7gMX90Jn8w1LO1Yqi5WzhieXlnJhkfyFwh7H9CzcuYnATspik9i3Gj
         pW9YnM0KC9V7nZ4+ZCKyefNOqTrqBCtQYFOp00P5rqrvj6nMhJkppCML/nVh+ev9mTLB
         o0WwYTVU354K5l9kA/p+PPv3oLpCxYA51i96fA81eUh9oC+W4wQLuDDaVNgU+lPWAQX4
         gX+XmnN2X6WsLLWt/SK1OJqL4652wEZdnv1mR/IEjxkor+ysr3UyQ3VVuGfCd/ERH9rc
         GA2A==
X-Gm-Message-State: APzg51APPy9YGbWVXY86lLsg8YAscgd3gT5+zvX/oazvT1weC5tWlWOb
        OXDNfzqw9jleEQcZzZ1jfw70cyYm1bL62JqtktKdNQ==
X-Google-Smtp-Source: ANB0VdYF0hGs9tdPSuOr3D20vTP6ngZtrKTAZbvfDiKBA526Wi1gfziQLe511J3A/E6PM8wvHBqnzyFLZwZJoGCq/tY=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr2778423otl.209.1536880604425;
 Thu, 13 Sep 2018 16:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com> <20180913132408.GC19329@kuha.fi.intel.com>
 <20180913175108.GA11749@roeck-us.net>
In-Reply-To: <20180913175108.GA11749@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 13 Sep 2018 16:16:08 -0700
Message-ID: <CAPTae5JVv0F_9mrXSTxmB2n9A9fJvcakwC0AKV6GbB+6Y79rGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] typec: tcpm: Do not disconnect link for self powered devices
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Sep 13, 2018 at 04:24:08PM +0300, Heikki Krogerus wrote:
> > +Guenter
> >
> > On Wed, Sep 12, 2018 at 07:11:12PM -0700, Badhri Jagan Sridharan wrote:
> > > During HARD_RESET the data link is disconnected.
> > > For self powered device, the spec is advising against doing that.
> > >
> > > >From USB_PD_R3_0
> > > 7.1.5 Response to Hard Resets
> > > Device operation during and after a Hard Reset is defined as follows:
> > > Self-powered devices Should Not disconnect from USB during a Hard Res=
et
> > > (see Section 9.1.2).
> > > Bus powered devices will disconnect from USB during a Hard Reset due =
to the
> > > loss of their power source.
> > >
> > > Tackle this by letting TCPM know whether the device is self or bus po=
wered.
> > >
> > > This overcomes unnecessary port disconnections from hard reset.
> > > Also, speeds up the enumeration time when connected to Type-A ports.
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm.c | 6 +++++-
> > >  include/linux/usb/tcpm.h | 1 +
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > > index 4f1f4215f3d6..a4e0c027a2a9 100644
> > > --- a/drivers/usb/typec/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm.c
> > > @@ -3270,7 +3270,11 @@ static void run_state_machine(struct tcpm_port=
 *port)
> > >             memset(&port->pps_data, 0, sizeof(port->pps_data));
> > >             tcpm_set_vconn(port, false);
> > >             tcpm_set_charge(port, false);
> > > -           tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> > > +
> > > +           if (port->tcpc->config->self_powered)
> >
> > Add a member for that flag to the struct tcpm_port, and check that
> > here instead. I'll explain why below.
> >
> > > +                   tcpm_set_roles(port, true, TYPEC_SINK, TYPEC_DEVI=
CE);
> > > +           else
> > > +                   tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEV=
ICE);
> > >
>
> Maybe I am missing something, but
>                 tcpm_set_roles(port, port->self_powered,
>                                TYPEC_SINK, TYPEC_DEVICE);
> should accomplish the same (assuming the flag is moved to tcpm_port).

Yeah Makes sense to me..
>
> Does the code at SRC_HARD_RESET_VBUS_OFF: also have to be changed,
> or only SNK_HARD_RESET_SINK_OFF: ? In other words, does this only
> apply if the port is a sink, or also if is is source ?

Good question ! I dont see any direct guidance on the spec.
All that I can see is the following:

From 2.6.1 Source Operation:
Restores the Port=E2=80=99s data role to DFP.

From 7.1.5 Response to Hard Resets:
"The Source Shall meet both tSafe5V and tSafe0V relative to the start
of the voltage transition as shown in Figure 7-8."

I am leaning towards to changing the link state from false to true for
SRC_HARD_RESET_VBUS_OFF
as well. This is to keep it symmetrical. What do you think ?

>
> Guenter
>
> > >             /*
> > >              * VBUS may or may not toggle, depending on the adapter.
> > >              * If it doesn't toggle, transition to SNK_HARD_RESET_SIN=
K_ON
> > > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > > index 7e7fbfb84e8e..50c74a77db55 100644
> > > --- a/include/linux/usb/tcpm.h
> > > +++ b/include/linux/usb/tcpm.h
> > > @@ -89,6 +89,7 @@ struct tcpc_config {
> > >     enum typec_port_data data;
> > >     enum typec_role default_role;
> > >     bool try_role_hw;       /* try.{src,snk} implemented in hardware =
*/
> > > +   bool self_powered;      /* port belongs to a self powered device =
*/
> >
> > I'm not sure we should add any more members to that structure, but
> > maybe it's not a problem for now. We can't quite yet get rid of that
> > structure.
> >
> > You do need to introduce a new device property already. Then read the

This would be part of usb-connector binding. right ?

> > value for that new member you added to struct tcpm_port in
> > tcpm_fw_get_caps() and in tcpm_copy_caps().
> >
> >
> > Thanks,
> >
> > --
> > heikki
