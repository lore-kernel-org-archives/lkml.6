Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E2C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE5E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJQF0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:26:15 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59238 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJQF0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:26:15 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E2A2272CC5A;
        Wed, 17 Oct 2018 00:33:53 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id CAF694A4A16;
        Wed, 17 Oct 2018 00:33:53 +0300 (MSK)
Date:   Wed, 17 Oct 2018 00:33:53 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: streebog - add Streebog test vectors
Message-ID: <20181016213353.z2v3kqshhunmb77g@sole.flsd.net>
References: <20181010121254.12220-1-vt@altlinux.org>
 <20181010121254.12220-3-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181010121254.12220-3-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:12:52PM +0300, Vitaly Chikunov wrote:
> Add testmgr and tcrypt tests and vectors for Streebog hash function
> from RFC 6986 and GOST R 34.11-2012.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  crypto/tcrypt.c  | 27 +++++++++++++++++++++
>  crypto/testmgr.c | 12 ++++++++++
>  crypto/testmgr.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
> 
> diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> index bdde95e8d369..d66cb167daa2 100644
> --- a/crypto/tcrypt.c
> +++ b/crypto/tcrypt.c
> @@ -1914,6 +1915,14 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
>  		ret += tcrypt_test("sm3");
>  		break;
>  
> +	case 53:
> +		ret += tcrypt_test("sb256");
> +		break;
> +
> +	case 54:
> +		ret += tcrypt_test("sb512");
> +		break;
> +

I am requested by Dmitry Eremin-Solenikov off-list to also add
hmac(sb256) and hmac(sb512) tests. I think this is a reasonable request
since IMA have such a mode of use and IMA is planned as one of the main
users of this hash. I may resend v3 with this, or as follow-up PATCH as
maintainers would prefer.

Thanks,
