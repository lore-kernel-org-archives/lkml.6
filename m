Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD77C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2A20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A2A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJEJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:23:40 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55674 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJEJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:23:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8Fpb-0007EG-4M; Fri, 05 Oct 2018 10:27:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8FpZ-00013o-7M; Fri, 05 Oct 2018 10:27:05 +0800
Date:   Fri, 5 Oct 2018 10:27:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Message-ID: <20181005022705.v7jcz35oqaq5usao@gondor.apana.org.au>
References: <20180924172615.25591-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924172615.25591-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:26:15AM -0700, Nathan Chancellor wrote:
> Clang emits a warning about this construct:
> 
> drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
> definition assumed to have one element
> static const struct acpi_device_id sp_acpi_match[];
>                                    ^
> 1 warning generated.
> 
> Just remove the forward declarations and move the initializations up
> so that they can be used in sp_get_of_version and sp_get_acpi_version.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/crypto/ccp/sp-platform.c | 53 +++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 28 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
