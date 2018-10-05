Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5867C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A13120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A13120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJEW3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:29:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEW3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:29:36 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8S3Z-0008V9-W4; Fri, 05 Oct 2018 17:30:21 +0200
Message-ID: <1538753420.3545.39.camel@pengutronix.de>
Subject: Re: [PATCH] reset: socfpga: add an early reset driver for SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     marex@denx.de, linux-kernel@vger.kernel.org
Date:   Fri, 05 Oct 2018 17:30:20 +0200
In-Reply-To: <04f701c1-8f1c-ee99-6797-cfbe769ebbc7@kernel.org>
References: <1537195830-25759-1-git-send-email-dinguyen@kernel.org>
         <1538646836.14153.4.camel@pengutronix.de>
         <04f701c1-8f1c-ee99-6797-cfbe769ebbc7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Fri, 2018-10-05 at 10:17 -0500, Dinh Nguyen wrote:
[...]
> > > +static int a10_reset_init(struct device_node *np)
> > > +{
> > > +	struct reset_simple_data *data;
> > > +	struct resource res;
> > > +	resource_size_t size;
> > > +	int ret;
> > > +	u32 reg_offset = 0;
> > 
> > ... now it is 0x0.
> > I think this should be
> > 
> > 	u32 reg_offset = 0x10;
> > 
> > to avoid breaking SocFPGA with ancient device trees.
[...]
> > Could we keep the SOCFPGA_NR_BANKS #define to reduce the amount of magic
> > numbers?
> > 
> > I can make both changes when applying if you want.
> > 
> 
> If you don't mind, that would be great!

Done, applied to reset/next with the above changes.


I get the following build warning:

  drivers/reset/reset-socfpga.c:81:13: warning: symbol 'socfpga_reset_init' was not declared. Should it be static?

It would be nice to put the declaration into a header in
include/soc/socfpga (or wherever is more appropriate) at some point.

regards
Philipp
