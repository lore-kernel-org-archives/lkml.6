Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BFF20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SB9dNYcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BFF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeISVtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:49:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45302 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbeISVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U41CMb1Q+4ghh4OLb8F1VrOZh4zgaWfrg6I5PMYxEM4=; b=SB9dNYcgOc9y9RTFT6QM/DwKqI
        3qHg62ghAqN5l17MglcCFyBJSZ7Ntmpdj5Tp4km14ZCdfAbuN13xk6cW7gpSyiSQOBa3Lyi2d7ga5
        qolR2rxRBeg6VNZdT/Y1uKLic35Xjv3sW0OFLgXEGHVvFMpoWEpbGKoLd4E7sMBjZd2xREOQaIk1u
        JTTDVaVqBAWu38h5yb25OH+AQJp9Qcu/oRKdToO5nQha/20uDJ9ClkTts16w3B3A7GhkaDjKR9CeD
        2JSZkbp3lYHgIrfR4D/185zlBFiq78xHsU2D7W5tuydfuXkhho8q5R2hb2+4of0DiZeEJ+6TlrPnX
        KuGGmdMw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2f48-0003eN-FT; Wed, 19 Sep 2018 16:11:00 +0000
Subject: process? [Re: Crypto Fixes for 4.19]
To:     Greg KH <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20170714141855.GA29426@gondor.apana.org.au>
 <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
 <20180919132324.GA24399@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d8c061a9-b415-e092-c28f-9e433d83b59b@infradead.org>
Date:   Wed, 19 Sep 2018 09:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180919132324.GA24399@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/18 6:23 AM, Greg KH wrote:
> On Wed, Sep 19, 2018 at 02:22:01PM +0800, Herbert Xu wrote:
>> Hi Greg: 
>>
>> This push fixes a potential boot hang in ccp and an incorrect
>> CPU capability check in aegis/morus on x86.
>>
>>
>> Please pull from
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
> 
> Now pulled, thanks.
> 
> greg k-h

Hi,
Just a process question:

It looks like Greg is not adding Signed-of-by: <himself>
to mainline git commits, although the prior mainline git committer did so.

Is that omission on purpose?

submitting-patches.rst says:
The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.


thanks,
-- 
~Randy
