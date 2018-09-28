Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C43E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C43E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeI1Wvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:51:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:40195 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeI1Wvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:51:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8SGQShG028469;
        Fri, 28 Sep 2018 11:26:28 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w8SGQQr0028459;
        Fri, 28 Sep 2018 11:26:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 28 Sep 2018 11:26:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/32: add stack protector support
Message-ID: <20180928162625.GT23155@gate.crashing.org>
References: <d6c43ab708bf9ae1266c745fece457ed2da43d7c.1537961921.git.christophe.leroy@c-s.fr> <20180926191615.GO23155@gate.crashing.org> <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr> <20180927074525.GQ23155@gate.crashing.org> <28451b6a-e302-691e-ee28-16521997fb07@c-s.fr> <8736ttu6fs.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736ttu6fs.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:56:07PM +1000, Michael Ellerman wrote:
> The problem of low entropy at boot on systems without a good hardware
> source is sort of unsolvable.
> 
> As you say it's up to the core kernel/random code, we shouldn't be
> trying to do anything tricky in the arch code.
> 
> You don't want your system to take 3 hours to boot because it's waiting
> for entropy for the stack canary.
> 
> If we can update the canary later once the entropy pool is setup that
> would be ideal.

Yup, I agree with all that.

But we should *also* not say "oh, there may be cases where we cannot
do the right thing, so just do not even try, ever, anywhere".


Segher
