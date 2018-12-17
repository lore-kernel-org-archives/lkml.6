Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38432133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyxJaBIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeLQMpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:45:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43500 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeLQMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:45:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so7190947qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoKAFNlqBXAcoto9ZYoUMnQ6qZtFfdac/CIbHk9LtGc=;
        b=OyxJaBILsRYvsAET2O9hFIuL4bTf68LCw295ffokq0uw7z70RRkjQgOZ1dqSjn2Lm6
         KecaHxu3VwHYEvkTLjMuf3Ih8rbpZdIQax+rRQGdxYRwdsCaIghNKEpLJwCDTYmrodJb
         KijVvOjFrOQHfOrAzoef8kmxOwa2rzvB6GXdDtZnKFwb1rIaEpiqt7MlPcEqQQR1+L2A
         iFeWA/XbPjZKWEBUx4QuiAp6PJH4tfif5g7J2FBMbPHNjMmVSq9xkZPunQs8e6apc/F3
         NvE3Orn+SAKvlvlKJ0lxE+dShaAhuxa+KRSWOS6Xzbc8ePiQJQHpJqpZ2jxylcy5sSJ6
         9Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoKAFNlqBXAcoto9ZYoUMnQ6qZtFfdac/CIbHk9LtGc=;
        b=GYIV1xZiQbJOBGD8WMRwqCLT4/UEs5ndIGEJVGscvnrLB9IYa9wr0ZBMlG4SKEh7hc
         tW2wBSuAtPcU5MKk6BBAhw0KlSH5wBXSwG9LIbR3KpBnwzq1KxffsmZCHdDpWMTRyBT8
         gyi7c2HZcUh9ZxUPmEIrqUhi6NeGFuQ9L+WngxzabvsZAFoo4UTlsqgtBQWz66BZHIIO
         6zhCDl/td460/+cGAUwY6ODq4GW4ZuOtjvE3Qp1VVneZh+veyCUgNwlwV5bDqHzF4whG
         jR8tx9kTFarUUz17PolbH9HFpgwpXGlrqX3Ez489HZnfZalPwuED36qRMH7N3KuLtXoP
         Cx4Q==
X-Gm-Message-State: AA+aEWZjxXs2fNKInbAAL1h1+M00uHV1hXI1bHYNfBWdFlqOcIg7u8Yx
        7syg21sLh5YrzrNUkwhgX9RzSL2WQrFBpaqSAUyy9w==
X-Google-Smtp-Source: AFSGD/VQpZ8QsXvIt9hJa4ezEwgc/POf5VDpF3l63k+/o0TjJIqaZ1hd1vU9687+qF/kzTcFF7tn1uhoZNZKDi2OF08=
X-Received: by 2002:a37:6005:: with SMTP id u5mr11322956qkb.219.1545050721363;
 Mon, 17 Dec 2018 04:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20181217024805.122897-1-kyletso@google.com> <HE1PR1001MB1002719044E56D116949E2AE80BC0@HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <HE1PR1001MB1002719044E56D116949E2AE80BC0@HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 17 Dec 2018 20:45:10 +0800
Message-ID: <CAGZ6i=1jC0e1gkh6nmDS2y4SE3op0pZ+RPAgExfmfnBJkcFWCw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "badhri@google.com" <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:23 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 17 December 2018 02:48, Kyle Tso wrote:
>
> > Current matching rules ensure that the voltage range of selected Source
> > Capability is entirely within the range defined in one of the Sink Capabilities. This
> > is reasonable but not practical because Sink may not support wide range of
> > voltage when sinking power while Source could advertise its capabilities in
> > raletively wider range. For example, a Source PDO advertising 3.3V-11V@3A (9V
>
> relatively
>

noted!
Thanks for the correction. I will fix this in the next patch.

> > Prog of Fixed Nominal Voltage) will not be selected if the Sink requires 5V-
> > 12V@3A PPS power. However, the Sink could work well if the requested voltage
> > range in RDOs is 5V-11V@3A.
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
> >    maximum current defined in the selected Source PDO d. Select the Source PDO
> > with the highest maximum power
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> >
> > ---
> > Changelog since v1:
> > - updated the commit message as suggested by Guenter Roeck <linux@roeck-
> > us.net>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 3620efee2688..3001df7bd602 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> > tcpm_port *port)
> >       unsigned int i, j, max_mw = 0, max_mv = 0;
> >       unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
> >       unsigned int min_snk_mv, max_snk_mv;
> > -     u32 pdo;
> > +     unsigned int max_op_mv;
> > +     u32 pdo, src, snk;
> >       unsigned int src_pdo = 0, snk_pdo = 0;
> >
> >       /*
> > @@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> > tcpm_port *port)
> >                                       continue;
> >                               }
> >
> > -                             if (max_src_mv <= max_snk_mv &&
> > -                                 min_src_mv >= min_snk_mv) {
> > +                             if (min_src_mv <= max_snk_mv &&
> > +                                 max_src_mv >= min_snk_mv) {
> > +                                     max_op_mv = min(max_src_mv,
> > max_snk_mv);
> > +                                     src_mw = (max_op_mv * src_ma) / 1000;
> >                                       /* Prefer higher voltages if available */
> >                                       if ((src_mw == max_mw &&
> > -                                          min_src_mv > max_mv) ||
> > +                                          max_op_mv > max_mv) ||
> >                                           src_mw > max_mw) {
>
> Sorry I didn't raise this before, but came to mind this morning when I was
> considering your updates again. What happens if the Source validly provides two
> PPS APDOs, for example:
>
>         3.3V - 11V, 3A (9V programmable)
>         3.3V - 16V, 3A (15V programmable)
>
> and the sink APDO is:
>
>         5V - 9V, 3A
>
> I think the code here will now select the higher range (15V programmable) as it
> gives a larger power output value, even if the sink can only support a voltage
> that's far smaller. I really don't think this is correct. *If* you are going to
> allow selection of PPS APDOs that provide a larger voltage range than the Sink
> can actually cope with, then I think you should at least select the lower of
> those advertised which fulfils the needs of the Sink.

Source:
3.3V - 11V, 3A (9V programmable)
3.3V - 16V, 3A (15V programmable)

Sink
5V - 9V, 3A

In this case, the Sink will select "3.3V - 11V, 3A (9V programmable)"
because the
"max_op_mv" when dealing with both Source Cap will be the same.

See line#2269, "max_op_mv" will be limited by "max_snk_mv" which is 9V.
And in line#2273, "max_op_mv" (of the second src_cap) fails the check
because "max_mv", which is equal to the "max_op_mv" of the previous src_cap,
is the same as it.

2267                             if (min_src_mv <= max_snk_mv &&
2268                                 max_src_mv >= min_snk_mv) {
2269                                     max_op_mv = min(max_src_mv,
max_snk_mv);
2270                                     src_mw = (max_op_mv * src_ma) / 1000;
2271                                     /* Prefer higher voltages if
available */
2272                                     if ((src_mw == max_mw &&
2273                                          max_op_mv > max_mv) ||
2274                                         src_mw > max_mw) {
2275                                             src_pdo = i;
2276                                             snk_pdo = j;
2277                                             max_mw = src_mw;
2278                                             max_mv = max_op_mv;
2279                                     }
2280                             }

>
> >                                               src_pdo = i;
> >                                               snk_pdo = j;
> >                                               max_mw = src_mw;
> > -                                             max_mv = max_src_mv;
> > +                                             max_mv = max_op_mv;
> >                                       }
> >                               }
> >                       }
> > @@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> > tcpm_port *port)
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
> > +             port->pps_data.min_volt =
> > max(pdo_pps_apdo_min_voltage(src),
> > +                                           pdo_pps_apdo_min_voltage(snk));
> > +             port->pps_data.max_volt =
> > min(pdo_pps_apdo_max_voltage(src),
> > +                                           pdo_pps_apdo_max_voltage(snk));
> > +             port->pps_data.max_curr = min_pps_apdo_current(src, snk);
> >               port->pps_data.out_volt =
> > -                     min(pdo_pps_apdo_max_voltage(pdo), port-
> > >pps_data.out_volt);
> > +                     min(port->pps_data.max_volt, port-
> > >pps_data.out_volt);
> >               port->pps_data.op_curr =
> >                       min(port->pps_data.max_curr, port->pps_data.op_curr);
> >       }
> > --
> > 2.20.0.405.gbc1bbc6f85-goog
>
