Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A916EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F6024F86
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F6024F86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeGAPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:45:55 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54426 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeGAPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:45:54 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZeXT-0005p3-QL; Sun, 01 Jul 2018 23:45:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZeXF-0008Je-M4; Sun, 01 Jul 2018 23:45:09 +0800
Date:   Sun, 1 Jul 2018 23:45:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ondrej =?utf-8?B?TW9zbsOhxI1law==?= 
        <omosnacek+linux-crypto@gmail.com>
Cc:     bp@alien8.de, linux-crypto@vger.kernel.org, efault@gmx.de,
        Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180701154509.2drdk6bhromkf3d7@gondor.apana.org.au>
References: <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180701131941.2dqkzg7az25qpc6b@gondor.apana.org.au>
 <CAAUqJDt+DyRj_Q1D05d0D7pJQYjCZas6uz8aZ0xsQVE=vSETxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAUqJDt+DyRj_Q1D05d0D7pJQYjCZas6uz8aZ0xsQVE=vSETxA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 05:24:39PM +0200, Ondrej Mosnáček wrote:
>
> I can see you applied this patch to your cryptodev-2.6 tree (which I
> believe is for the next release). Shouldn't this go into the
> crypto-2.6 tree so it gets into 4.18-rcX? I'm not sure, but it seems
> to me that it qualifies as a (potentially serious?) bug fix.
> 
> Also, I think you accidentally extracted the wrong part of the e-mail
> as the commit message...

Thanks, it should all be fixed now.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
