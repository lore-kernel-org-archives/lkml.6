Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58018C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AB82064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AB82064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJXPS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:18:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58037 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJXPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:18:56 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gFD1F-0007c4-TT; Wed, 24 Oct 2018 08:51:53 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gFD1F-0001W9-2J; Wed, 24 Oct 2018 08:51:53 +0200
Date:   Wed, 24 Oct 2018 08:51:52 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
Message-ID: <20181024065152.yinlj4axprtwdzku@pengutronix.de>
References: <20181009112837.2517-1-peron.clem@gmail.com>
 <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
 <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
 <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 03:35:31PM -0500, Dinh Nguyen wrote:
> 
> 
> On 10/23/2018 09:44 AM, Clément Péron wrote:
> > HI Dinh,
> > 
> > On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>
> >> Hi Clément,
> >>
> >> On 10/09/2018 06:28 AM, Clément Péron wrote:
> >>> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> >>>
> >>> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
> >>>
> >>
> >> I'm not sure the need for this patch. Are there any cyclone5 based
> >> boards that has UART1 as the debug uart? I see that all of them are
> >> using UART0.
> > 
> > There is no upstream device with this UART used. But the board I have
> > use it, and there is no limitation to not have it available upstream
> > no ?
> > 
> 
> I see. Then I don't think the patch is applicable because none of the
> upstream devices need it. Now, if you were to upstream your board that
> uses UART1, then there will be a case for this patch. Do you agree?

I'd not say having to upstream the board is a sensible precondition for
such a patch. One of the arguments for moving ARM to dt was that this
allows to separate the machine specifics from the code. So I'd say if
Clément has a need, this is a good enough reason to take this patch.

Just my 0.02 €,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
