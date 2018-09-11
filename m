Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5BFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF8D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeIKN3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:29:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeIKN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:29:15 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fze4b-00045Y-4t; Tue, 11 Sep 2018 10:31:01 +0200
Message-ID: <1536654660.3453.1.camel@pengutronix.de>
Subject: Re: [RFC] reset: make reset controller driver initialize early
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>
Date:   Tue, 11 Sep 2018 10:31:00 +0200
In-Reply-To: <9854fd68-14e3-aed3-ca35-8e259baa0348@kernel.org>
References: <9854fd68-14e3-aed3-ca35-8e259baa0348@kernel.org>
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

Hi Dinh,

On Mon, 2018-09-10 at 14:59 -0500, Dinh Nguyen wrote:
> Hi Philipp,
> 
> I need to make the reset controller on the SoCFPGA platform initialize
> early.

What does early mean in this context?

> I have one solution which is similar to what reset-sunxi is
> doing, making the "altr,rst-mgr" initialize early in a separate
> reset-socfpga.c but using the reset-simple operations.

That's what I would have gone for as well.

> I'm guessing SoCFPGA may not be the only platform that needs the reset
> driver early, would it make sense to have a solution in reset-simple
> that is capable of an early init?

I suppose you could share sunxi_reset_init if you pass it a struct
reset_simple_devdata as an argument.

regards
Philipp
