Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C52FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDFE208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGPe14Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDFE208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbeHWRHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:07:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbeHWRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dMwBTZSDkUaUSoGf+xtrmRVPsoiGs+kT8Ckx2W2nAn4=; b=mGPe14BqKO51UPAnVNSZC9AYs
        Ixpp/VbsjJ9lod8g3G1Rn4Bn4ZCoeEBn8+0l31GAWL9shGSxYo1xb0w1/rOo16Eeu7qXjV9ig/CUX
        uis14uhAIB9ypV7RATNrVhRcfjYZGRkqYVrb5u/83rf4o6n18lwX38Wz1vx7KWt7jBCE8Q2kkPpJ/
        j779vTj+PtDaKFsUQeKGPckLnAXAN9zl+iGy4SX85ueM9UQy8VI0JAOuYSfM8uFvEGEALDKaDStPW
        IC2oIMahlVezWlh0uj8rCxwjV8+fbWO6xk4fIP+PA8Ei4ksVQzOhfG6k97yRBsZ2tUp6xo0uAZGAZ
        ekT6PiVTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fspni-0000Gg-LR; Thu, 23 Aug 2018 13:37:26 +0000
Date:   Thu, 23 Aug 2018 06:37:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
Message-ID: <20180823133726.GA28059@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
 <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org>
 <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
 <20180822060353.GA27106@infradead.org>
 <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 08:54:51PM +0530, Anup Patel wrote:
> IMHO, rather than waiting for new CPU ON/OFF methods to come-up we
> can keep the cpu_operations ready. Also, we are not re-inventing anything
> here which we might have to discard later because cpu_operations are
> already tried and hardened for Linux ARM64.

Which is a different cpu architecture, and has shown to actually need
it.  IFF we end up needing it on riscv we can still copy and paste
it from AMD64.


> I agree with you that in long-term SBI-based CPU ON/OFF will be widely
> used. Most likely we will have at-least two CPU ON/OFF methods:
> 1. Existing lottery based spinning
> 2. New SBI calls

And in this most likely case there is no need for an ops vector,
a simple if/else will be much simpler and cleaner.
