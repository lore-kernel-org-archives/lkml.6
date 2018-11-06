Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DBC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxKA8ICA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8142F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeKFJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:38:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42141 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeKFJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:38:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id x63-v6so5507052oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IgQmPMuONbf/jroYcUop5JoTdZG60Yj4YKkksGzoF8=;
        b=ZxKA8ICAjqhYhfC/l4gMeRxTW4oytZHl116F6g4IHDEWphkdZkf0LKH4mcPhtIeV98
         GOfX61FTnuyk17SRO81d9VyGtiJBvYt/QMOoNpjRSLP9gmcKeF7OufzFY1UgXytp2e8I
         yrtmkAmoVd2p9egDVfk8Q85Ezu6Mych6qVHmBcUV4hpxvBcmm9k8gChAH0bJ0wQDu3wq
         1YudZtvB30k1zkFUWzbaTcDe7Pm5oAtB4b7i0KakDEzXp02hhDDHixOylOQ5SSqvobHU
         lCwE2NCvZNrby7GL/qF1r7mv1+uK6pBwJA5eHHkU8h6Je9KzmHD/EIKwQPGDYkNDheOD
         teHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IgQmPMuONbf/jroYcUop5JoTdZG60Yj4YKkksGzoF8=;
        b=Jm8X9ma1VvPbVIEqwohoxu8bUDcvXlMYzw6wWmUilP9vQChAdl6KHXuqTfIuut16e9
         TcHBNaLYx6nNd31CA2rYT7opcoPh8CUVCujdYnuWXdtaUdfQqs95o18Md8wb/5TZWv4m
         7gVyDJyE/io49LzZwaJwnbpSH/uLjatrL+ACehgEpx34bfiVNt6QiVN0uA64tIW8I5JS
         d9SGEZkGv9E2U7iRpSyQiVched/NkKjoj1ExuHsemdMPKuMmopaErjtqVrnlDrq3Ndg7
         i313xSrpHk9uiBTWck4Gh6ssv1RMKEpkZ7kr0P63V6dWJyXdG0hTrjeKZVyZeMJ1Nb2+
         zDKA==
X-Gm-Message-State: AGRZ1gLv7yKaIWIV4ZD9Hw5TNFvi5igEVPUPDx0zTyz2BWia+ZYweqgZ
        NLrrKFD4AIiHRKW8qFwjSe+r1pL0dkfLrhpWxdtgtw==
X-Google-Smtp-Source: AJdET5dlp+aKXJ6Qeq8JMdLVeN3HY7bYUFOGOLv0i0fev1YlF/lv3QsM0cNCinEKup52OLh1/EPK/4qXSs8eUtYpbmg=
X-Received: by 2002:aca:f1d6:: with SMTP id p205-v6mr14737058oih.332.1541463361388;
 Mon, 05 Nov 2018 16:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20181001194501.58338-1-badhri@google.com> <20181001194501.58338-3-badhri@google.com>
 <20181102132847.GC6543@kuha.fi.intel.com>
In-Reply-To: <20181102132847.GC6543@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 5 Nov 2018 16:15:24 -0800
Message-ID: <CAPTae5K7o31eFJxaW=_6UCyLgiagSz45O6iDhgfqh2vu3QMQsg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: typec: tcpm: charge current handling for sink
 during hard reset
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cw00.choi@samsung.com, a.hajda@samsung.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>, jackp@codeaurora.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki, Rob,

Thanks for reviewing !
Should I update the patchset with the Reviewed-by tag and bumpup the
patchset version ?
Or is that not necessary?

Thanks,
Badhri.

On Fri, Nov 2, 2018 at 6:28 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Oct 01, 2018 at 12:45:01PM -0700, Badhri Jagan Sridharan wrote:
> > During the initial connect to a non-pd port, sink would hard reset
> > twice before deeming that the port partner is non-pd. TCPM sets the
> > the charge path to false during the hard reset. This causes unnecessary
> > connects/disconnects of charge path and makes port take longer to
> > charge from the non-pd ports. Avoid this by not setting the charge path
> > to false unless the partner has already identified to be pd capable.
> >
> > When partner is a pd port, set the charge path to false in
> > SNK_HARD_RESET_SINK_OFF. Set the current limits to default value based
> > of CC pull up and resume the charge path when port enters
> > SNK_HARD_RESET_SINK_ON.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > --------
> > Changes in V3:
> > Rebase on top of usb-next
> >
> > Changes in V2:
> > Based on feedback of jackp@codeaurora.org
> > - vsafe_5v_hard_reset flag from tcpc_config is removed
> > - Patch only differentiates between pd port partner and non-pd port
> > partner
> >
> > V1 version of the patch is here:
> > https://lkml.org/lkml/2018/9/14/11
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index c3ac0e46106b..c25a69922ee6 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -3273,7 +3273,8 @@ static void run_state_machine(struct tcpm_port *port)
> >       case SNK_HARD_RESET_SINK_OFF:
> >               memset(&port->pps_data, 0, sizeof(port->pps_data));
> >               tcpm_set_vconn(port, false);
> > -             tcpm_set_charge(port, false);
> > +             if (port->pd_capable)
> > +                     tcpm_set_charge(port, false);
> >               tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
> >                              TYPEC_DEVICE);
> >               /*
> > @@ -3305,6 +3306,12 @@ static void run_state_machine(struct tcpm_port *port)
> >                * Similar, dual-mode ports in source mode should transition
> >                * to PE_SNK_Transition_to_default.
> >                */
> > +             if (port->pd_capable) {
> > +                     tcpm_set_current_limit(port,
> > +                                            tcpm_get_current_limit(port),
> > +                                            5000);
> > +                     tcpm_set_charge(port, true);
> > +             }
> >               tcpm_set_attached_state(port, true);
> >               tcpm_set_state(port, SNK_STARTUP, 0);
> >               break;
> > --
> > 2.19.0.605.g01d371f741-goog
>
> thanks,
>
> --
> heikki
