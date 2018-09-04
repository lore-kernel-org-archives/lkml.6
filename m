Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78592C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39872086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39872086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIDHlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:41:08 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38708 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:41:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx1qt-0007AR-Id; Tue, 04 Sep 2018 11:18:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx1qN-0001jx-Hf; Tue, 04 Sep 2018 11:17:31 +0800
Date:   Tue, 4 Sep 2018 11:17:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@google.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] crypto: x86 - remove SHA multibuffer routines and mcryptd
Message-ID: <20180904031731.ehi2jzx3retkhyql@gondor.apana.org.au>
References: <20180822085144.4872-1-ard.biesheuvel@linaro.org>
 <a877e275-4dd7-6580-2351-db8d3a4ba1a2@linux.intel.com>
 <1535411993.3516.4.camel@megha-Z97X-UD7-TH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535411993.3516.4.camel@megha-Z97X-UD7-TH>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:19:53PM -0700, Megha Dey wrote:
> On Mon, 2018-08-27 at 15:28 -0700, Tim Chen wrote:
> > On 08/22/2018 01:51 AM, Ard Biesheuvel wrote:
> > > As it turns out, the AVX2 multibuffer SHA routines are currently
> > > broken [0], in a way that would have likely been noticed if this
> > > code were in wide use. Since the code is too complicated to be
> > > maintained by anyone except the original authors, and since the
> > > performance benefits for real-world use cases are debatable to
> > > begin with, it is better to drop it entirely for the moment.
> > > 
> > > [0] https://marc.info/?l=linux-crypto-vger&m=153476243825350&w=2
> > 
> > Sorry I was out of the loop for a while and haven't been following
> > the code too closely.
> > 
> > Megha is maintaining the code now.  Before we pull the code,
> > please give us a chance to fix it first.
> > 
> > Thanks.
> > 
> > Tim
> > 
> 
> Hi,
> 
> I am working to find a fix for these corner cases. If possible, we would
> like to fix the issues instead of removing the code altogether.

I think it has taken way too long to fix these issues.  The fact
that these issues have existed for so long also means that hardly
anyone uses these mb algorithms.

So I think it is best if we remove everything and then add them
back after a proper review process.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
