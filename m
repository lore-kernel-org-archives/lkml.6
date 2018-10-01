Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44214C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7E208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljgLyIV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJBCZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:25:48 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40274 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJBCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:25:48 -0400
Received: by mail-ot1-f45.google.com with SMTP id w67so5070725ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMYSkabGXNpSmif2cQUmWgTCrGgiDlOm+m3Z9u7EYJ0=;
        b=ljgLyIV9SLp3Sgus1rNEFXtUuxBwgRXEX4rSwbs90BLrLVzC1cwi/4uBBqlQuxw3s6
         0QzqE96RB8e/FI/mrYdZjv+5PAGnNLFATAe0f1ggno9c7306XrwnJPsW8AwoLS7XJVEE
         1QWRohfdG3GHN3aCBnSq5kZi/+t/iQbL0QKh/cLH6P2+Xa1Yj/syL4dGVQZ/NdFitm+M
         3j/fold0hYNoow6OQMeflxem+YDOR6Hkpgw3kBgtjC3HbAvyOcKFW+p7HDfh5vzxLGcM
         hQZp0h1SqQ86se0yJFWp6/7GC5SEJu5Ct+JIQU+nQJ9pfl6eE/JcwcMB0pQgoaa1HOz3
         MoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMYSkabGXNpSmif2cQUmWgTCrGgiDlOm+m3Z9u7EYJ0=;
        b=hdZETuQMQLADrl6Eu086E0LugAEIyOYyqdk9l8TKxda57XhWJkL/IGbeB5IRso33RK
         lghNBsffZNlv1Zwh5M01vaUafhH6M6FRegIy+J3a22RwvC4td5w4p1wPZuMpSJJSgsVf
         62QpvsI/eGMeTI9SSQGye3IOKtGoCRykJmxJB2Ij41Al9Eezvbh/LDDeIhUlhzYS5Jve
         c5XXaercOSRWQRuWBwaZo+UWz4AnzJCk9kTJ3iFWpqJ2qkJQBl9wUXuAAOvFN4OFh9iV
         dIteovm6OX3VpUbxcvmYDwMQwdvN6xH2CB7zrCMtOU5L45OtztRTE/gI1OQRcELvTst3
         +0EQ==
X-Gm-Message-State: ABuFfoiKxo/Yan9aykVQfAiFwjhAGNchpRpWbsHjTu+Cgc12SqH1uROg
        V1Jk7CVf9b2YSR4RfSWP3h9i7qtdZhqkHuYJ+HNWxw==
X-Google-Smtp-Source: ACcGV62+qJ6EYH8L4+0iLRyo5/NUibY+BYqkzmBvZb/sN0x7n8U+P2wtej+JGOEkOIM/Al/3i17JXoO2s4rTHlCG6XQ=
X-Received: by 2002:a9d:1787:: with SMTP id j7-v6mr5912578otj.128.1538423186348;
 Mon, 01 Oct 2018 12:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180928234703.15970-1-badhri@google.com> <20180928234703.15970-2-badhri@google.com>
 <20181001095354.GB15780@kuha.fi.intel.com>
In-Reply-To: <20181001095354.GB15780@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 1 Oct 2018 12:45:49 -0700
Message-ID: <CAPTae5LODDhhHDL2Dq6L12sSqT4-KNaELtZNy++g_4B=wb7QsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] [PATCH v2 2/3] usb: typec: tcpm: Do not disconnect
 link for self powered devices
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cw00.choi@samsung.com, a.hajda@samsung.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. Just resent the patch stack !
On Mon, Oct 1, 2018 at 2:54 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Sep 28, 2018 at 04:47:02PM -0700, Badhri Jagan Sridharan wrote:
> > During HARD_RESET the data link is disconnected.
> > For self powered device, the spec is advising against doing that.
> >
> > >From USB_PD_R3_0
> > 7.1.5 Response to Hard Resets
> > Device operation during and after a Hard Reset is defined as follows:
> > Self-powered devices Should Not disconnect from USB during a Hard Reset
> > (see Section 9.1.2).
> > Bus powered devices will disconnect from USB during a Hard Reset due to the
> > loss of their power source.
> >
> > Tackle this by letting TCPM know whether the device is self or bus powered.
> >
> > This overcomes unnecessary port disconnections from hard reset.
> > Also, speeds up the enumeration time when connected to Type-A ports.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> Could you rebase these on top of the latest usb-next. These are not
> going to apply cleanly on top of it because tcpm.c and all port
> drivers are now in their own directory drivers/usb/typec/tcpm/.
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---------
> > Version history:
> >
> > V2:
> > Based on feedback from heikki.krogerus@linux.intel.com
> > - self_powered added to the struct tcpm_port which is populated from
> >   a. "connector" node of the device tree in tcpm_fw_get_caps()
> >   b. "self_powered" node of the tcpc_config in tcpm_copy_caps
> >
> > Based on feedbase from linux@roeck-us.net
> > - Code was refactored
> > - SRC_HARD_RESET_VBUS_OFF sets the link state to false based
> >   on self_powered flag
> >
> > V1 located here:
> > https://lkml.org/lkml/2018/9/13/94
> > ---
> >  drivers/usb/typec/tcpm.c | 12 ++++++++++--
> >  include/linux/usb/tcpm.h |  1 +
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index 4f1f4215f3d6e..c3ac0e46106b4 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -317,6 +317,9 @@ struct tcpm_port {
> >       /* Deadline in jiffies to exit src_try_wait state */
> >       unsigned long max_wait;
> >
> > +     /* port belongs to a self powered device */
> > +     bool self_powered;
> > +
> >  #ifdef CONFIG_DEBUG_FS
> >       struct dentry *dentry;
> >       struct mutex logbuffer_lock;    /* log buffer access lock */
> > @@ -3257,7 +3260,8 @@ static void run_state_machine(struct tcpm_port *port)
> >       case SRC_HARD_RESET_VBUS_OFF:
> >               tcpm_set_vconn(port, true);
> >               tcpm_set_vbus(port, false);
> > -             tcpm_set_roles(port, false, TYPEC_SOURCE, TYPEC_HOST);
> > +             tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
> > +                            TYPEC_HOST);
> >               tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
> >               break;
> >       case SRC_HARD_RESET_VBUS_ON:
> > @@ -3270,7 +3274,8 @@ static void run_state_machine(struct tcpm_port *port)
> >               memset(&port->pps_data, 0, sizeof(port->pps_data));
> >               tcpm_set_vconn(port, false);
> >               tcpm_set_charge(port, false);
> > -             tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> > +             tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
> > +                            TYPEC_DEVICE);
> >               /*
> >                * VBUS may or may not toggle, depending on the adapter.
> >                * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> > @@ -4409,6 +4414,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
> >               return -EINVAL;
> >       port->operating_snk_mw = mw / 1000;
> >
> > +     port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> > +
> >       return 0;
> >  }
> >
> > @@ -4717,6 +4724,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
> >       port->typec_caps.prefer_role = tcfg->default_role;
> >       port->typec_caps.type = tcfg->type;
> >       port->typec_caps.data = tcfg->data;
> > +     port->self_powered = port->tcpc->config->self_powered;
> >
> >       return 0;
> >  }
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index 7e7fbfb84e8e3..50c74a77db55c 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -89,6 +89,7 @@ struct tcpc_config {
> >       enum typec_port_data data;
> >       enum typec_role default_role;
> >       bool try_role_hw;       /* try.{src,snk} implemented in hardware */
> > +     bool self_powered;      /* port belongs to a self powered device */
> >
> >       const struct typec_altmode_desc *alt_modes;
> >  };
>
> Thanks,
>
> --
> heikki
