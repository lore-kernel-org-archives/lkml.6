Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2363C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659942082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vATIzaBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659942082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeJaDy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeJaDy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:54:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9937D20657;
        Tue, 30 Oct 2018 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540926015;
        bh=moN2+CND0ubFl5noAMkfbvubmKGiI9OrJd4zx9qOdA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vATIzaBzbOW9crpYKIxO3FNUl8Vp4rtb0z+CK+7BV5lGV8Rr2g2vF0OnTXEebL7lN
         ch+oL0RKFEjc0em3VzvTYH715iQYy9c57i3DFv2EzSF7kroRqe7A2LS2r0SOxEq/Nq
         shacS98Z6HjK5aflwJXcUgJD2abDG/MVTaL0CsGQ=
Date:   Tue, 30 Oct 2018 20:00:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
Message-ID: <20181030190051.GA1697@kroah.com>
References: <20181030111103.12110-1-marc.zyngier@arm.com>
 <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:18:08AM -0700, Santosh Shilimkar wrote:
> Hi Greg,
> 
> On 10/30/2018 4:11 AM, Marc Zyngier wrote:
> > The Keystone QMSS driver is pretty damaged, in the sense that it
> > does things like this:
> > 
> > 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> > 
> > where cpu_map is a local variable. As we leave the function, this
> > will point to nowhere-land, and things will end-up badly.
> > 
> > Instead, let's use a proper cpumask that gets allocated, giving
> > the driver a chance to actually work with things like irqbalance
> > as well as have a hypothetical 64bit future.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > I found this one by inspection after finding a similar bug in an
> > unrelated driver. It is only compile-tested. It would probably
> > a Cc stable, but that's Santosh's decision.
> 
> Would be able to apply this fix from Marc for stable or it needs
> to be re-posted with CC to stable ?

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
