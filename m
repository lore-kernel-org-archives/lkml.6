Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7FDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D85255A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D85255A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbeGBHGn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:06:43 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39964 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeGBHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:06:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZsut-0002pl-9z; Mon, 02 Jul 2018 15:06:31 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZsuq-0000S4-Qx; Mon, 02 Jul 2018 15:06:28 +0800
Date:   Mon, 2 Jul 2018 15:06:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     neilb@suse.com, tgraf@suug.ch, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: rhashtable: Correct self-assignment in rhashtable.c
Message-ID: <20180702070628.lhi63kcgcfwj64y4@gondor.apana.org.au>
References: <1530493906-19711-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530493906-19711-1-git-send-email-rishabhb@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:11:46PM -0700, Rishabh Bhatnagar wrote:
> In file lib/rhashtable.c line 777, skip variable is assigned to
> itself. The following error was observed:
> 
> lib/rhashtable.c:777:41: warning: explicitly assigning value of
> variable of type 'int' to itself [-Wself-assign] error, forbidden
> warning: rhashtable.c:777
> This error was found when compiling with Clang 6.0. Change it to iter->skip.
> 
> Change-Id: I5abd1ce5ba76737a73bd6eca94b07b1bd5267523
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
