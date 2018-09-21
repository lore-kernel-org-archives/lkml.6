Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC581C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A917321522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A917321522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbeIULeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:34:10 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46414 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIULeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:34:10 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g3EGx-0005Zw-Ni; Fri, 21 Sep 2018 13:46:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g3EGt-0000bV-2f; Fri, 21 Sep 2018 13:46:31 +0800
Date:   Fri, 21 Sep 2018 13:46:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Agner <stefan@agner.ch>
Cc:     davem@davemloft.net, ard.biesheuvel@linaro.org,
        linux@armlinux.org.uk, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufeature: avoid warning when compiling with clang
Message-ID: <20180921054631.m573qaxoqhql3juj@gondor.apana.org.au>
References: <20180916043825.23247-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916043825.23247-1-stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 09:38:24PM -0700, Stefan Agner wrote:
> The table id (second) argument to MODULE_DEVICE_TABLE is often
> referenced otherwise. This is not the case for CPU features. This
> leads to warnings when building the kernel with Clang:
>   arch/arm/crypto/aes-ce-glue.c:450:1: warning: variable
>     'cpu_feature_match_AES' is not needed and will not be emitted
>     [-Wunneeded-internal-declaration]
>   module_cpu_feature_match(AES, aes_init);
>   ^
> 
> Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
> ("modules: mark __inittest/__exittest as __maybe_unused").
> 
> Fixes: 67bad2fdb754 ("cpu: add generic support for CPU feature based module autoloading")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  include/linux/cpufeature.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
