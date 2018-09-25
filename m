Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B539C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08BB2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08BB2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeIZA6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:58:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeIZA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:58:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63C6A107C;
        Tue, 25 Sep 2018 18:49:50 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:49:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in
 sd.c
Message-ID: <20180925184947.GC16455@kroah.com>
References: <20180923093805.GA20870@nishad>
 <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 06:31:32AM -0700, Joe Perches wrote:
> On Sun, 2018-09-23 at 15:08 +0530, Nishad Kamdar wrote:
> > This patch fixes a few single statement macros in sd.c.
> > It converts two macros to inline functions. It removes
> > five other macros and replaces their usages with calls to
> > the function being called in the macro definition.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >   - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
> >   - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
> >     msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
> >     with calls to the function being called by these macros.
> 
> Nishad, do please look again for uses of these functions
> you are changing.
> 
> Please try removing all the #if 0 blocks instead, and then
> see if there are also now unused functions from those removed
> blocks that could also be removed.
> 
> And Greg, if you look at this, look at the odd license of
> these files.
> 
> It's possible the license is incompatible with the GPL.

It is odd, but the GPL at the bottom of the file kind of implies it is
ok.  Given that it was published by mtk, I am assuming all is good, but
it would be a good idea to check with the authors to fix this up
properly.

thanks,

greg k-h
