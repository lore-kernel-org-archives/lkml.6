Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A3B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIDJnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:43:00 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38800 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:42:59 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3kR-00009K-VY; Tue, 04 Sep 2018 13:19:32 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3kQ-0003J5-IA; Tue, 04 Sep 2018 13:19:30 +0800
Date:   Tue, 4 Sep 2018 13:19:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     linux-crypto@vger.kernel.org, thomas.lendacky@amd.com,
        Gary Hook <Gary.Hook@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
Message-ID: <20180904051930.5kvyyu75ym5mubuz@gondor.apana.org.au>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 04:11:25PM -0500, Brijesh Singh wrote:
> Currently, the CCP driver assumes that the SEV command issued to the PSP
> will always return (i.e. it will never hang).  But recently, firmware bugs
> have shown that a command can hang.  Since of the SEV commands are used
> in probe routines, this can cause boot hangs and/or loss of virtualization
> capabilities.
> 
> To protect against firmware bugs, add a timeout in the SEV command
> execution flow.  If a command does not complete within the specified
> timeout then return -ETIMEOUT and stop the driver from executing any
> further commands since the state of the SEV firmware is unknown.
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gary Hook <Gary.Hook@amd.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  drivers/crypto/ccp/psp-dev.c | 46 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
