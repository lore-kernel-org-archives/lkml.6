Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B6BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5643121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJQWQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:16:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43295 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:16:28 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gCmga-0001dQ-5Q; Wed, 17 Oct 2018 16:20:32 +0200
Message-ID: <1539786031.4729.7.camel@pengutronix.de>
Subject: Re: [PATCH v2] ARC: HSDK: improve reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Date:   Wed, 17 Oct 2018 16:20:31 +0200
In-Reply-To: <1539784482.4199.35.camel@synopsys.com>
References: <20180928162856.4726-1-Eugeniy.Paltsev@synopsys.com>
         <1539346114.6204.5.camel@pengutronix.de>
         <1539784482.4199.35.camel@synopsys.com>
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

Hi Eugeniy,

On Wed, 2018-10-17 at 13:54 +0000, Eugeniy Paltsev wrote:
[...]
> > The documentation states that calling reset_control_assert "on an
> > exclusive reset controller guarantees that the reset will be asserted."
> > Since this is clearly not the case with this driver, it is appropriate
> > to keep returning an error in this case.
> > 
> > If there is a driver that requests an exclusive reset control, calls
> > reset_control_assert, and then checks the error value to see whether
> > asserting the reset succeeded, it should be made aware that
> > we couldn't actually assert the reset line as requested. If the driver
> > can continue operation even though the reset line was not asserted,
> > it should ignore the error.
> > 
> > So if you need to hide this error, I'd like to know the actual case that
> > is fixed by this, to see if we can't fix it in a better way.
> 
> Ok, I can drop it in my case as it will work fine with certain drivers:
> (several drivers use shared reset control, other drivers use exclusive reset
> control but don't check reset_control_assert() return value)
>
> I simply want to say that this wouldn't work in all cases (without changes
> in driver which use reset control).

Ok, if there is ever such a case, please let me know.

regards
Philipp
