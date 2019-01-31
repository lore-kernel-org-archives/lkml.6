Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB24C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF471218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548955619;
	bh=hoVKnWiEPCXYjt8XO0AVUKrPsNfz8S5p7fA/qbZ/mSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tn4JGdWnC+0fJjPMkbwuhwNpWRrOidqWS9UX7RU3+BKyIERjOVAYvuYydG28PFmxB
	 Eg/cLBUwkyL1TOeN+j1FVfx6xWXmOXoSD4r8Kz1EA8E7MJbxRoIvDTdC5IxjhFG/1K
	 vFQ0BZh5HuZUoUlSpyzfc/10icbr/phu58wCoP2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfAaR05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfAaR05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:26:57 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525DE2086C;
        Thu, 31 Jan 2019 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548955616;
        bh=hoVKnWiEPCXYjt8XO0AVUKrPsNfz8S5p7fA/qbZ/mSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQlmALGr6m+AF2rXvc4pXWUuntU2PV6Ca2YR387qZlPdOEhwQf1sTPOYUQdmoQbJc
         zxShWHDCsbow92FUZFU1XYwtPQ/gkNWWq+oTYaXOjO3mO1pll10VxSUBYi7LTI3iKH
         mFVblEv7x28vID31FHObDylk9Ytos8ivjGeHfvzA=
Date:   Thu, 31 Jan 2019 18:26:44 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock
 support
Message-ID: <20190131182644.366a54a5@bbrezillon>
In-Reply-To: <da2ea926-30e9-c7b9-8b1f-ee65ccc0fb7a@kernel.org>
References: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
        <20190115092229.59e09c2d@xps13>
        <CAK7LNATnfTQXHrXJQp7732-e7hvd8ORcYubyDmz0KHaRXRMDqQ@mail.gmail.com>
        <20190128112007.440046e6@xps13>
        <da2ea926-30e9-c7b9-8b1f-ee65ccc0fb7a@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Thu, 31 Jan 2019 11:24:16 -0600
Dinh Nguyen <dinguyen@kernel.org> wrote:

> On 1/28/19 4:20 AM, Miquel Raynal wrote:
> > Hi Dinh,
> > 
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Wed, 16 Jan
> > 2019 10:27:11 +0900:
> >   
> >> (+CC Dinh Nguyen)
> >>
> >> On Tue, Jan 15, 2019 at 5:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> >>>
> >>> Hi Masahiro,
> >>>
> >>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 15 Jan
> >>> 2019 17:11:34 +0900:
> >>>    
> >>>> Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
> >>>> on IP datasheet") introduced a more correct binding that requires
> >>>> three named clocks.
> >>>>
> >>>> Now that all upstream DT files migrated over to it, remove the single
> >>>> anonymous clock support.    
> >>>
> >>> I would love to do that but I think this is against the "DT backward
> >>> compatibility rule".    
> >>
> >> Yeah, I know this rule, but we break DT binding from time to time.
> >>
> >>
> >>  
> >>> Anyway, IIRC it is accepted that this kind of
> >>> rule might be broken if decided per the arch-maintainer (in this
> >>> case, you I suppose). So if this is really what you want, I'll queue
> >>> it.    
> >>
> >> My platform is fine, but this driver is used by SOCFPGA boards as well.
> >>
> >> I CCed the SOCFPGA maintainer, Dinh Nguyen.
> >>  
> > 
> > Gentle ping on this topic.
> >   
> 
> This patch looks fine to be. Feel free to add:
> 
> Tested-by: Dinh Nguyen <dinguyen@kernel.org>

I think Miquel is waiting for an Acked-by to confirm that you're okay
breaking backward compat with old DT.

Regards,

Boris
