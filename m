Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1987C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40D82054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40D82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeH3PGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:06:38 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:43684 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3PGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:06:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 490A02B52071;
        Thu, 30 Aug 2018 13:05:01 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QNAqreNRWMgs; Thu, 30 Aug 2018 13:05:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 107AC2B520EA;
        Thu, 30 Aug 2018 13:05:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X20nvVVJiQ5k; Thu, 30 Aug 2018 13:04:59 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id CC2EB2B52071;
        Thu, 30 Aug 2018 13:04:59 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id B14D560228; Thu, 30 Aug 2018 13:04:59 +0200 (CEST)
Date:   Thu, 30 Aug 2018 13:04:59 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     paulus@samba.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, mitch@sfgoth.com, mostrows@earthlink.net,
        jchapman@katalix.com, xeb@mail.ru, davem@davemloft.net,
        viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH net-next 3/5] ppp: move PPPIOCSCOMPRESS32 to ppp-generic.c
Message-ID: <20180830110459.GA19111@alphalink.fr>
References: <20180829140409.833488-1-arnd@arndb.de>
 <20180829140409.833488-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829140409.833488-3-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:03:28PM +0200, Arnd Bergmann wrote:
> PPPIOCSCOMPRESS is only implemented in ppp_generic, so it's best to move
> the compat handling there. My first approach was to keep it in a new
> ppp_compat_ioctl() function, but it turned out to be much simpler to do
> it in the regular ioctl handler, by allowing both structure layouts to
> be handled directly there.
> 
Acked-by: Guillaume Nault <g.nault@alphalink.fr>
