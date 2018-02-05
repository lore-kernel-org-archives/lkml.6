Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBEIKp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeBEIKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:10:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED5B217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 16:10:20 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ARM: dts: imx25-pinfunc: Always set SION for SD CMD
Message-ID: <20180205081018.GQ31354@dragon>
References: <20180127000752.2879-1-benoit.thebaudeau.dev@gmail.com>
 <20180127153733.7ziaq6frli3jemc7@pengutronix.de>
 <CA+sos78H1_ihvVghJcpZQZmB6rE2nfgXF8gq8kqK=cQE9Qs0mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sos78H1_ihvVghJcpZQZmB6rE2nfgXF8gq8kqK=cQE9Qs0mw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 09:37:11PM +0100, Benoît Thébaudeau wrote:
> On Sat, Jan 27, 2018 at 4:37 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sat, Jan 27, 2018 at 01:07:52AM +0100, Benoît Thébaudeau wrote:
> >> The eSDHC does not work properly if the SION bit is not set for the
> >> bidirectional CMD signal, whatever the eSDHC instance and the selected
> >> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> >> this for MX25_PAD_*__SD*_CMD in imx25-pinfunc.h in order to enforce this
> >> behavior for all boards.
> >>
> >> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> >> MX25_PAD_FEC_MDC__SDHC2_CMD so that all the possible cases are covered
> >> from now on.
> >
> > There is an inconsistency in the naming. The eSDHC1 CMD constants are
> > named:
> >
> >         MX25_PAD_SD1_CMD__SD1_CMD
> >
> > The reference calls this:
> >
> >         CMD of instance: esdhc1.
> >
> > The register name is correct though. Not sure it's worth to fix this to
> > use consistent naming (which would result in:
> >
> >         MX25_PAD_SD1_CMD__ESDHC1_CMD
> >
> > which looks ugly, too).
> 
> Indeed. I had also noticed this. I can send a patch to apply before
> this one. But that would break the out-of-tree DT files using these
> definitions. Would that be OK?

That's OK, I would say.  It could be a reminder of that they should
upstream their files.

Shawn
