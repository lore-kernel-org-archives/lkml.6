Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF664C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819EC20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAWKwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:52:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:52:21 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gmG8l-0001Ie-Nw; Wed, 23 Jan 2019 11:52:15 +0100
Message-ID: <1548240735.3904.8.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 23 Jan 2019 11:52:15 +0100
In-Reply-To: <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
         <20181220010700.8598-3-andrew.smirnov@gmail.com>
         <1547743553.4009.16.camel@pengutronix.de>
         <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 14:38 -0800, Andrey Smirnov wrote:
[...]
> > To be honest, I don't like these two, I'm not convinced anymore that
> > they actually qualify as reset signals. To me it looks like this is
> > something that the PCIe glue code should handle via syscon like i.MX6.
> > Leonard, Lucas, what do you think?
> 
> OK, one thing to keep in mind about this is that those bits are
> already exposed for i.MX7D and I think (correct me if I am wrong)
> there's no going back there.

That's not a reason to repeat the same mistake for i.MX8QM, but at the
moment I'm still trying to figure out if it actually was a mistake.

> PCIe driver already has the code to use
> those on i.MX7D and, due to high degree of similarity, i.MX8MQ
> actually re-uses the same codepath (at least for
> IMX8MQ_RESET_PCIE_CTRL_APPS_EN).

We can always switch to i.MX6-like direct syscon/GPR manipulation and
just drop the resets from DT.
Since if this is done, it should be done for i.MX7 as well, I see no
reason for this issue to hold up your i.MX8M changes.

regards
Philipp
