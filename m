Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A54C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497221655
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497221655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHYRIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 13:08:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47278 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeHYRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 13:08:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ftYcp-00038b-QV; Sat, 25 Aug 2018 21:29:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ftYcn-0003QY-Us; Sat, 25 Aug 2018 21:29:10 +0800
Date:   Sat, 25 Aug 2018 21:29:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgadam@cavium.com
Subject: Re: [PATCH 1/1] crypto: cavium/nitrox - fix for command corruption
 in queue full case with backlog submissions.
Message-ID: <20180825132909.koxcal2ke2eggv5i@gondor.apana.org.au>
References: <1534921852-20954-1-git-send-email-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534921852-20954-1-git-send-email-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:40:52PM +0530, Srikanth Jampala wrote:
>      Earlier used to post the current command without checking queue full
>      after backlog submissions. So, post the current command only after
>      confirming the space in queue after backlog submissions.
> 
>      Maintain host write index instead of reading device registers
>      to get the next free slot to post the command.
> 
>      Return -ENOSPC in queue full case.
> 
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
> Tested-by: Jha, Chandan <Chandan.Jha@cavium.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
