Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E045C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606122082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606122082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeH3PGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:06:43 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:43710 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3PGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:06:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id C22B92B520EA;
        Thu, 30 Aug 2018 13:05:05 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yycRX_faGzWG; Thu, 30 Aug 2018 13:05:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 73F112B5210F;
        Thu, 30 Aug 2018 13:05:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LVGS7t9ppnhX; Thu, 30 Aug 2018 13:05:04 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 3E0312B520EA;
        Thu, 30 Aug 2018 13:05:04 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 253C160228; Thu, 30 Aug 2018 13:05:04 +0200 (CEST)
Date:   Thu, 30 Aug 2018 13:05:04 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     paulus@samba.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, mitch@sfgoth.com, mostrows@earthlink.net,
        jchapman@katalix.com, xeb@mail.ru, davem@davemloft.net,
        viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] ppp: move PPPIOCSPASS32/PPPIOCSACTIVE32 to
 ppp_generic.c
Message-ID: <20180830110504.GA19457@alphalink.fr>
References: <20180829140409.833488-1-arnd@arndb.de>
 <20180829140409.833488-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829140409.833488-4-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:03:29PM +0200, Arnd Bergmann wrote:
> PPPIOCSPASS and PPPIOCSACTIVE are implemented in ppp_generic and isdn_ppp,
> but the latter one doesn't work for compat mode in general, so we can
> move these two into the generic code.
> 
> Again, the best implementation I could come up with was to merge
> the compat handling into the regular ppp_ioctl() function and
> treating all ioctl commands as compatible.
> 
Acked-by: Guillaume Nault <g.nault@alphalink.fr>
