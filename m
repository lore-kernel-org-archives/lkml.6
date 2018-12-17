Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63382C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270B4206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjYPYixP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbeLQM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:29:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33846 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732836AbeLQM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:29:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so13824686qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzfSo9DWN6fzd05UazwSoUju6NS9mxZMerk1b/8SzVY=;
        b=LjYPYixPcAJkKrfAcd/jNQVxvdnS7+m0dak0/Xexs6G/I4khvTkiJI6aygInyvhGcs
         NudCGizN+G9YK5e80LynI2gZAdv6zDFcaTOL97XEDDED7d61TAtUEic5YsyvpEAUvfWy
         ADizS94NZE4dJjTnymMkEQ+mcJX7MlI0uaDcu7r1Hz90bcMZZ5DuGF62r6BeHGccyL7c
         +lMzvJfaZ9pLgl2cgc0Rd6hdgHTlHRhTxw1kIqWjFyThVjq7U0UfuywRKNIIJalpw5Dx
         f9DPj+xW+eVnk+SP6aitO4K9IsIIJ6VN9Oebasu7zCSlYcTncLzhk07EzvYmtx7/rn61
         mQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzfSo9DWN6fzd05UazwSoUju6NS9mxZMerk1b/8SzVY=;
        b=t7R04wAaoz/8X/9nAoWnKEpU2Z7otiV65yE7d40urp0WKITqbFYQppWnXIXDuzSgD8
         OOJkVssxPFlYdLxPxNhwzxfVbstE1wey+96lLPcN+P1zePiWyrRpg/Z1J62Or8xtPRRp
         XuDkcwf5AGwVSXd1S107TLxmQkELMf9ELTntWgVDTsgyUv1A5WngxFDJinCPSQ7qCZsd
         lNiSk3UnAJ8TdENeUpo2FHH6C9Gi4mFFz4fXzmRRX2kVWxxeMxnOaosKcBQrK6dnEbbp
         LTQfzCrs/JVbvkz/XnK9I8gQLCPo7pI+gKpThT9bGlKDu4zDknthgiaGMnzEZu+Dhg9x
         YGIg==
X-Gm-Message-State: AA+aEWZ2h0e594aSaJooweNMDNm9EoSctsZtQd7JbXR3ULFIZOS3cWDH
        yKQjE0vN337Hfy7EdAgmwqdj//xCGdibFiY8vvQXKA==
X-Google-Smtp-Source: AFSGD/VqwbZJFoqx1AuZ6lnqHvMVt79SswiSBziJsmQhtrCwRWxmlpKZthx/3erBxsrBCbECOlRMnsscyU/pZnhAwx8=
X-Received: by 2002:a0c:b61b:: with SMTP id f27mr12773304qve.174.1545049760928;
 Mon, 17 Dec 2018 04:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20181217024805.122897-1-kyletso@google.com> <20181217113551.GA14121@kuha.fi.intel.com>
In-Reply-To: <20181217113551.GA14121@kuha.fi.intel.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 17 Dec 2018 20:29:09 +0800
Message-ID: <CAGZ6i=2EPhW5OMGwavhW66Y4nzzNnhTacZk_9GPM9wAWru6Mpw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, gregkh@linuxfoundation.org,
        Adam.Thomson.Opensource@diasemi.com,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 7:36 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Dec 17, 2018 at 10:48:05AM +0800, Kyle Tso wrote:
> > Current matching rules ensure that the voltage range of selected Source
> > Capability is entirely within the range defined in one of the Sink
> > Capabilities. This is reasonable but not practical because Sink may not
> > support wide range of voltage when sinking power while Source could
> > advertise its capabilities in raletively wider range. For example, a
> > Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
> > will not be selected if the Sink requires 5V-12V@3A PPS power. However,
> > the Sink could work well if the requested voltage range in RDOs is
> > 5V-11V@3A.
> >
> > Currently accepted:
> >               |--------- source -----|
> >       |----------- sink ---------------|
> >
> > Currently not accepted:
> >                       |--------- source -----|
> >       |----------- sink ---------------|
> >
> >       |--------- source -----|
> >               |----------- sink ---------------|
> >
> >       |--------- source -----------------|
> >               |------ sink -------|
> >
> > To improve the usability, change the matching rules to what listed
> > below:
> > a. The Source PDO is selectable if any portion of the voltage range
> >    overlaps one of the Sink PDO's voltage range.
> > b. The maximum operational voltage will be the lower one between the
> >    selected Source PDO and the matching Sink PDO.
> > c. The maximum power will be the maximum operational voltage times the
> >    maximum current defined in the selected Source PDO
> > d. Select the Source PDO with the highest maximum power
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> In case you'll do one more version, I have a minor comment about the
> style below, but no need to resend only because of that.
>
> > ---
> > Changelog since v1:
> > - updated the commit message as suggested by Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 3620efee2688..3001df7bd602 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
> >       unsigned int i, j, max_mw = 0, max_mv = 0;
> >       unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
> >       unsigned int min_snk_mv, max_snk_mv;
> > -     u32 pdo;
> > +     unsigned int max_op_mv;
> > +     u32 pdo, src, snk;
> >       unsigned int src_pdo = 0, snk_pdo = 0;
> >
> >       /*
> > @@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
> >                                       continue;
> >                               }
> >
> > -                             if (max_src_mv <= max_snk_mv &&
> > -                                 min_src_mv >= min_snk_mv) {
> > +                             if (min_src_mv <= max_snk_mv &&
> > +                                 max_src_mv >= min_snk_mv) {
> > +                                     max_op_mv = min(max_src_mv, max_snk_mv);
> > +                                     src_mw = (max_op_mv * src_ma) / 1000;
> >                                       /* Prefer higher voltages if available */
> >                                       if ((src_mw == max_mw &&
> > -                                          min_src_mv > max_mv) ||
> > +                                          max_op_mv > max_mv) ||
> >                                           src_mw > max_mw) {
> >                                               src_pdo = i;
> >                                               snk_pdo = j;
> >                                               max_mw = src_mw;
> > -                                             max_mv = max_src_mv;
> > +                                             max_mv = max_op_mv;
> >                                       }
> >                               }
> >                       }
> > @@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
> >       }
> >
> >       if (src_pdo) {
> > -             pdo = port->source_caps[src_pdo];
> > -
> > -             port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
> > -             port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
> > -             port->pps_data.max_curr =
> > -                     min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
> > +             src = port->source_caps[src_pdo];
> > +             snk = port->snk_pdo[snk_pdo];
> > +
> > +             port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
> > +                                           pdo_pps_apdo_min_voltage(snk));
> > +             port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
> > +                                           pdo_pps_apdo_max_voltage(snk));
> > +             port->pps_data.max_curr = min_pps_apdo_current(src, snk);
> >               port->pps_data.out_volt =
> > -                     min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> > +                     min(port->pps_data.max_volt, port->pps_data.out_volt);
>
> While here, you could have aligned that like the above lines:
>
>         port->pps_data.out_volt = min(pdo_pps_apdo_max_voltage(pdo),
>                                       port->pps_data.out_volt);
>

Thanks Heikki Krogerus,
I will fix this (and the lines below as well) in the next (should be V3) patch.

> >               port->pps_data.op_curr =
> >                       min(port->pps_data.max_curr, port->pps_data.op_curr);
> >       }
> > --
> > 2.20.0.405.gbc1bbc6f85-goog
>
> thanks,
>
> --
> heikki
