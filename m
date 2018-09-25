Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E74C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EB20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3EB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIZBKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:10:49 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:60906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbeIZBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:10:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C76D6180A8867;
        Tue, 25 Sep 2018 19:01:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: baby30_102ac80917408
X-Filterd-Recvd-Size: 3159
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 19:01:50 +0000 (UTC)
Message-ID: <2f93ac5324ef3a229f2b8e855222a5fdd7b32f90.camel@perches.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in
 sd.c
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?ISO-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 25 Sep 2018 12:01:50 -0700
In-Reply-To: <20180925184947.GC16455@kroah.com>
References: <20180923093805.GA20870@nishad>
         <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
         <20180925184947.GC16455@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 20:49 +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 23, 2018 at 06:31:32AM -0700, Joe Perches wrote:
> > On Sun, 2018-09-23 at 15:08 +0530, Nishad Kamdar wrote:
> > > This patch fixes a few single statement macros in sd.c.
> > > It converts two macros to inline functions. It removes
> > > five other macros and replaces their usages with calls to
> > > the function being called in the macro definition.
> > > Issue found by checkpatch.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
> > >   - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
> > >     msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
> > >     with calls to the function being called by these macros.
> > 
> > Nishad, do please look again for uses of these functions
> > you are changing.
> > 
> > Please try removing all the #if 0 blocks instead, and then
> > see if there are also now unused functions from those removed
> > blocks that could also be removed.
> > 
> > And Greg, if you look at this, look at the odd license of
> > these files.
> > 
> > It's possible the license is incompatible with the GPL.
> 
> It is odd, but the GPL at the bottom of the file kind of implies it is
> ok.

Implications are not licenses.

> Given that it was published by mtk, I am assuming all is good, but
> it would be a good idea to check with the authors to fix this up
> properly.

The initial patch was submitted by
John Crispin <blogic@openwrt.org>

I do not know John's relationship to mediatek.

commit 8b634a9c7620b15691322cd53071122d2ab249a7
Author: John Crispin <blogic@openwrt.org>
Date:   Thu Mar 15 07:22:35 2018 +1100

John?  Any idea of the providence of these files?

I do not see anything like it in
https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=target/linux/mediatek;h=ad50ab7e407372a482aafb4183c4e49e25f93739;hb=refs/tags/v18.06.1


