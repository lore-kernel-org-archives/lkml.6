Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12AA2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12AA2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJBKUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:20:19 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49834 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJBKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:20:19 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g7BWh-0005DN-Ti; Tue, 02 Oct 2018 11:39:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g7BWe-0002JK-CD; Tue, 02 Oct 2018 11:39:08 +0800
Date:   Tue, 2 Oct 2018 11:39:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jason@zx2c4.com, ebiggers@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Message-ID: <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 28 September 2018 at 07:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>> If an implementation enters Zinc, it will go through my tree. If it
>> enters the crypto API, it will go through Herbert's tree. If there
>> wind up being messy tree dependency and merge timing issues, I can
>> work this out in the usual way with Herbert. I'll be sure to discuss
>> these edge cases with him when we discuss. I think there's a way to
>> handle that with minimum friction.
> 
> I would also strongly prefer that all crypto work is taken through
> Herbert's tree, so we have a coherent view of it before it goes
> upstream.

I agree.  I don't have any problems with the zinc code living in
its own git tree.  But any upstream merges should definitely go
through the crypto tree because the inherent ties between the two
code-base.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
