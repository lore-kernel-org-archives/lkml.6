Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF1C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FF121BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FF121BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeHIJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:01:39 -0400
Received: from verein.lst.de ([213.95.11.211]:41675 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeHIJBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:01:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0FFAE68D60; Thu,  9 Aug 2018 08:43:54 +0200 (CEST)
Date:   Thu, 9 Aug 2018 08:43:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     robh+dt@kernel.org, atish.patra@wdc.com,
        Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180809064353.GA19566@lst.de>
References: <CAL_JsqKVTGcJP=AJR+6h1Brv8MW9xjD=v2__Xtegkd-+Hnua7g@mail.gmail.com> <mhng-cfa17eb2-3548-48ee-9216-74a3607a3091@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-cfa17eb2-3548-48ee-9216-74a3607a3091@palmer-si-x1c4>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:29:17PM -0700, Palmer Dabbelt wrote:
>> So I guess to answer my question, you are just making up version
>> numbers. Unless you are doing the IP verilog too, don't do that.
>
> Well, in this case my proposal would be that we change the hardware team's 
> versioning scheme to match whatever we decide on the versioning scheme 
> should be as a part of this discussion.  I proposed accepting whatever 
> versioning scheme is decided upon hereto the hardware team before 
> discussing changing the naming scheme and they agreed to do so.
>
> So we're really in the drivers' seat here.
>
>> If you want to use just 'sifive,plic' then I'm fine with that. I've
>> given you the potential problems with that and they will be your
>> problems to deal with. Maybe you'll get lucky. Plus it won't be a
>> problem for the 1st implementation.
>
> I'd prefer to have some versioning scheme, that's why I'm talking so much 
> about this :).  I really just want to learn how to get the right one, as 
> I'm quite new to all this and we'll have many of these.

Based on the discussion so far I think we should settle for sifive,plic +
an actual implementation string suggested by Palmer and Andrew.

This is what I have right now:

http://git.infradead.org/users/hch/riscv.git/commitdiff/1972707029f8f1216dbe14bd7791295e4b37f560

and which I'd like to send out before it is too late.
