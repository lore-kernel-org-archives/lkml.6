Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7442151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1hjnyCAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7442151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbeISW1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:27:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45772 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbeISW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AoFt2KLnMum6nhNXjdHcBEXsPHPsZU0R3MwlbjDSXH8=; b=1hjnyCAkUnbC300sPT0W4S4zky
        Fcl/6bDIjOBPtBDxsA93u4lJXaZ+UzR6gCiaKKY/LfIj/UBqNGr8SHibJH3dkyEVZvezDmhg/x2VV
        vxyhN3Fe4AEa6wSJnpUljDlcu8jF8hixZmqk2ZPyqxbiDREytlEOZnMj68O+KGl4q45plpgF3rreZ
        DtdYbmzGZ3LMewiq86ms15d5HViWhe8starTTjREEo3Ldsnc13xeLihWOcNQK7Ax7RL5h7da0BcGq
        xns/3YLCOeoKItVQIXEcdtWTML8jCLGIwNoYsQvix56ktVqSS/HG4ht8sYXtFq4vZ2PEJKvepGbJj
        9DNdx6CA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2fee-00046O-GV; Wed, 19 Sep 2018 16:48:44 +0000
Subject: Re: process? [Re: Crypto Fixes for 4.19]
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
 <20180919132324.GA24399@kroah.com>
 <d8c061a9-b415-e092-c28f-9e433d83b59b@infradead.org>
 <20180919164019.GA7195@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06e6fac1-6011-7117-454f-af930a288d75@infradead.org>
Date:   Wed, 19 Sep 2018 09:48:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180919164019.GA7195@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/18 9:40 AM, Greg KH wrote:
> On Wed, Sep 19, 2018 at 09:10:55AM -0700, Randy Dunlap wrote:
>> On 9/19/18 6:23 AM, Greg KH wrote:
>>> On Wed, Sep 19, 2018 at 02:22:01PM +0800, Herbert Xu wrote:
>>>> Hi Greg: 
>>>>
>>>> This push fixes a potential boot hang in ccp and an incorrect
>>>> CPU capability check in aegis/morus on x86.
>>>>
>>>>
>>>> Please pull from
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
>>>
>>> Now pulled, thanks.
>>>
>>> greg k-h
>>
>> Hi,
>> Just a process question:
>>
>> It looks like Greg is not adding Signed-of-by: <himself>
>> to mainline git commits, although the prior mainline git committer did so.
>>
>> Is that omission on purpose?
> 
> s-o-b does not get added to git pulls, I "trust" the subsystem
> maintainer got it correct.  That's what Linus has always done in the
> past, what am I doing differently here?
> 
>> submitting-patches.rst says:
>> The Signed-off-by: tag indicates that the signer was involved in the
>> development of the patch, or that he/she was in the patch's delivery path.
> 
> Yes, but not for git pulls.
> 
> I have not applied any patches sent in emails at this point in time, so
> there's nothing that I could have even signed off on.

OK, I see.

> confused,

no, that's me :)


thanks,
-- 
~Randy
