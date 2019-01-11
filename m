Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F806C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EB420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfAKMyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:54:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49907 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfAKMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:54:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 70367209BD; Fri, 11 Jan 2019 13:54:13 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B084206A7;
        Fri, 11 Jan 2019 13:54:13 +0100 (CET)
Date:   Fri, 11 Jan 2019 13:54:13 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Borsodi Petr <Petr.Borsodi@i.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used
 as IRQ controller
Message-ID: <20190111135413.73dad0b2@windsurf>
In-Reply-To: <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
        <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
        <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
        <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
        <20190107164210.3ecf37e8@windsurf>
        <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:

> My stance is that the driver is responsible of enabling and managing
> runtime PM for its hardware block(s).
> 
> Runtime PM in the core should only be added if the core needs to
> be aware about it, such as is the case when e.g. a block device
> needs to drain its write buffer before going to runtime sleep.
> 
> I fail so see why the GPIO core need to be aware about this.

In this very same thread at
https://www.spinics.net/lists/arm-kernel/msg600515.html, you kind of
proposed to handle this in the core in fact :-) Though indeed you said
that the core could provide helpers.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
