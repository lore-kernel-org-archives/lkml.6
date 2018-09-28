Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A91206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ertY0ADe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A91206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeI2GPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:15:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40860 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeI2GPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:15:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so6843371oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chG0zSZWGt8bOeZpW3dBtKA3uVd1dx7gAMSUX5U1g0w=;
        b=ertY0ADee0k/ArEL/K8//dJmloacGiFWJ4fuY36W8Einbdnl7ROrZud5d1wrOgZeUN
         wpqDBUxOTmFTxwjat8kXP1QMnETJPgFgYK4T2eWC0+85NJoObQ7/BRUp6hk5XgHrWR7/
         3hOTrrOsIwvlNl4/Svy28oyo5OGnRzaPle4p8/3ORLVDe/1HKlXNz+Pz2xQBfKZLSvlv
         BD0blym9Pi9Ts/P+QnxWxr6tqLnRAmtceTzpAH06PYUSAQGVgqqoJJHDZOVu0TvS5j36
         HA9lOFxpAZoah7i4u1m9Gqjn2Cjx1Hf6GAavSDI6XyLwrmSuYGcdQPTl0LjiNkFYlKiX
         L/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chG0zSZWGt8bOeZpW3dBtKA3uVd1dx7gAMSUX5U1g0w=;
        b=t8MxJgt35hrG8MY+P6uPJ1BOsxUlljemMzeFaRTH3j3mDJWlPFPAGQUwxiLNZ/vuxf
         6I1HhJzOLfuJmXBTCzDrEn2r2qdbTgSW+A+QzTXMul92o8aTHG5szPD+mUi0DsSFdX4h
         /A0pPIa88eTu3lJk/uuCAR+LQ5D2yvkEhnZLmaPIayZWxYmrkSDg3fGN7u+5betJdfSO
         +wmFB0t8BYgUPuw8E9uzcEUT979eK+WQRdK6rxQhMclWMusDs0JAn4iid3GK5Qcus6Ih
         jN+gZ4t8vfiy3bUVr+N6yQ5nufJGy9g8u8FQHxOK3pVp1mJxnTsYHVKxTt0htlQxbgy2
         Hxbg==
X-Gm-Message-State: ABuFfog3mADfSiOvJG1qWPdLU77wISgaffS0x9kvfpsJ/c8CN8kzeqjp
        LGIKL/iigWId1a2VSVYbbrQBz5wddiMiTy80sQKeGQ==
X-Google-Smtp-Source: ACcGV62xCLCIkldTDEm6qtJInbXSRDN+y+DtojW/3w6RHcIcyZcQzkbT76Blua0j+I9zdI/3d9ord6WKsV8aOjh7S6s=
X-Received: by 2002:aca:4e81:: with SMTP id c123-v6mr488910oib.92.1538178535501;
 Fri, 28 Sep 2018 16:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180928234703.15970-1-badhri@google.com> <20180928234703.15970-3-badhri@google.com>
In-Reply-To: <20180928234703.15970-3-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 28 Sep 2018 16:48:18 -0700
Message-ID: <CAPTae5JsW17LUkrkAaT8AGeB=c5=Sv_M5dk0gCahDNkLrGy45g@mail.gmail.com>
Subject: Re: [PATCH 3/3] [PATCH v2 3/3] usb: typec: tcpm: charge current
 handling for sink during hard reset
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cw00.choi@samsung.com, a.hajda@samsung.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>, jackp@codeaurora.org
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ jackp@codeaurora.org
On Fri, Sep 28, 2018 at 4:47 PM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> During the initial connect to a non-pd port, sink would hard reset
> twice before deeming that the port partner is non-pd. TCPM sets the
> the charge path to false during the hard reset. This causes unnecessary
> connects/disconnects of charge path and makes port take longer to
> charge from the non-pd ports. Avoid this by not setting the charge path
> to false unless the partner has already identified to be pd capable.
>
> When partner is a pd port, set the charge path to false in
> SNK_HARD_RESET_SINK_OFF. Set the current limits to default value based
> of CC pull up and resume the charge path when port enters
> SNK_HARD_RESET_SINK_ON.
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> --------
> Changes in V2:
> Based on feedback of jackp@codeaurora.org
> - vsafe_5v_hard_reset flag from tcpc_config is removed
> - Patch only differentiates between pd port partner and non-pd port
> partner
>
> V1 version of the patch is here:
> https://lkml.org/lkml/2018/9/14/11
> ---
>  drivers/usb/typec/tcpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index c3ac0e46106b4..c25a69922ee6a 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -3273,7 +3273,8 @@ static void run_state_machine(struct tcpm_port *port)
>         case SNK_HARD_RESET_SINK_OFF:
>                 memset(&port->pps_data, 0, sizeof(port->pps_data));
>                 tcpm_set_vconn(port, false);
> -               tcpm_set_charge(port, false);
> +               if (port->pd_capable)
> +                       tcpm_set_charge(port, false);
>                 tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
>                                TYPEC_DEVICE);
>                 /*
> @@ -3305,6 +3306,12 @@ static void run_state_machine(struct tcpm_port *port)
>                  * Similar, dual-mode ports in source mode should transition
>                  * to PE_SNK_Transition_to_default.
>                  */
> +               if (port->pd_capable) {
> +                       tcpm_set_current_limit(port,
> +                                              tcpm_get_current_limit(port),
> +                                              5000);
> +                       tcpm_set_charge(port, true);
> +               }
>                 tcpm_set_attached_state(port, true);
>                 tcpm_set_state(port, SNK_STARTUP, 0);
>                 break;
> --
> 2.19.0.605.g01d371f741-goog
>
