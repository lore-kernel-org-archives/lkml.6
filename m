Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FDFECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0761E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbeGPIHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43519 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:41 -0400
Received: from wicke.hi.pengutronix.de ([2001:67c:670:100:2e4d:54ff:fe9d:8eb7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fexsk-0006Eh-48; Mon, 16 Jul 2018 09:25:18 +0200
Received: from mfe by wicke.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fexsi-0006Y0-Kq; Mon, 16 Jul 2018 09:25:16 +0200
Date:   Mon, 16 Jul 2018 09:25:16 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180716072516.bvsp54yoeqp3ih6s@pengutronix.de>
References: <20180713125002.24331-1-m.felsch@pengutronix.de>
 <20180713125002.24331-2-m.felsch@pengutronix.de>
 <20180713150314.GD16228@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713150314.GD16228@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:2e4d:54ff:fe9d:8eb7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

thanks for the review.

On 18-07-13 16:03, Mark Brown wrote:
> On Fri, Jul 13, 2018 at 02:50:01PM +0200, Marco Felsch wrote:
> 
> > +Optional properties:
> > +- fsl,pfuze-support-disable: Boolean, if present disable all unused switch
> > +  regulators to save power consumption. Attention, till 4.18 these regulators
> 
> The property name sounds like it affects all the regulators but really
> it's just the sw ones - how about adding -sw at the end?  Bit of a
> bikeshed but it does end up in an ABI.

You're right, it sounds better. So the new binding will be
fsl,pfuze-support-disable-sw. Are there any other comments about the
implementation?

Regards,
Marco
