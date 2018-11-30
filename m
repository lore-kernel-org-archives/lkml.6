Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BDC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldt8w1V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BDC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeK3TSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:18:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55B0206B7;
        Fri, 30 Nov 2018 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565421;
        bh=gU4o9r8iFoOeEBSQraFc44QNd+eXnvT5fifJEEQqD8U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Ldt8w1V7Q3l9p6TS1PvKa5/21RmLN+2NIQcPNzPIyem9+qKWlgi76K7fASrCcyuZm
         2AjgS0qHGQZE0VddkbSknXysDiBk/C+wMpd5xbJHGsKbOQfRd3Nl9OQ9wK5ZwrA+m/
         Y4eztqxVUjFhxpbj7z8U/pyJWSXJu86LkqiDQIIk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DB3PR0402MB3916F9DC4C054747211EB90FF5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
 <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
 <DB3PR0402MB3916F9DC4C054747211EB90FF5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <154356542041.88331.1938476424482018533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Fri, 30 Nov 2018 00:10:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-11-29 23:37:14)
> Hi, Stephen
> =

> Best Regards!
> Anson Huang
> =

> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: 2018=E5=B9=B411=E6=9C=8830=E6=97=A5 15:25
> > To: kernel@pengutronix.de; linux-arm-kernel@lists.infradead.org;
> > linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org;
> > mturquette@baylibre.com; s.hauer@pengutronix.de; shawnguo@kernel.org;
> > Anson Huang <anson.huang@nxp.com>; Fabio Estevam
> > <fabio.estevam@nxp.com>
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
> > =

> > Quoting Anson Huang (2018-11-29 23:23:47)
> > > Same as other i.MX6 SoCs, ensure unused MMDC channel's handshake is
> > > bypassed, this is to make sure no request signal will be generated
> > > when periphe_clk_sel is changed or SRC warm reset is triggered.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > =

> > Does this need a fixes tag?
> =

> Normally this bit is 1b'1 by reset, but during our development, it used t=
o be
> overwritten in u-boot and lead to some clock operation fail in Linux kern=
el, that is why we ensure it
> in clock driver early phase. IMO, it should be OK to not add a fix tag, s=
ince it is just
> to make sure the setting is correct and NOT depends on the hardware reset=
 value which
> could be changed in u-boot.
> =

> =


Hmm ok.

