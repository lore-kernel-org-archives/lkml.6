Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97132C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427B4208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0CYUqzU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B4208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeIYVrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:47:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeIYVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aBgD/pcqeLOMgh+w0gxQ6TAAJ84SbJL4bg5CYXoh464=; b=0CYUqzU5HIjUokRaJblwPq30fk
        mLkJrZKX9LG8TbI70/bzMifcMUU9vCGTBM9FekEthS953ouRC5dkDvKJevNzzJqN7k5gjhs4ugKL2
        aD6XQoz85xCpV/ZrnnhtX0dSfqSBoWUY8eUc/iK5LgoavDfMn59T6oSuMCkhq35wOLuhw1xpMzEAi
        22J1AmNeEhgaKPvkytZ5hJV50JMwdOa9qkPj7UVJYJwWXug+FI4JNCzjCCS5V8/P7vrRXI6sSjJ1r
        BPifFdtFvPAydqpjGh5d10FXhYIEEX79gjjO2N6Z6y/EZYZuvN6Gz242O5TW6hyuX2BGQbFqqN0bt
        GaNLthfQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4pQ5-0002Lc-1Z; Tue, 25 Sep 2018 15:38:57 +0000
Subject: Re: linux-next: Tree for Sep 25 (crypto/caam/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20180925153937.07660ca8@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1436714-629e-a6ee-9fbc-525914652064@infradead.org>
Date:   Tue, 25 Sep 2018 08:38:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925153937.07660ca8@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 10:39 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180924:
> 

on i386:
# CONFIG_NET is not set


drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_fqdan_cb':
caamalg_qi2.c:(.text+0x502): undefined reference to `napi_schedule_prep'
caamalg_qi2.c:(.text+0x50d): undefined reference to `__napi_schedule_irqoff'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_poll':
caamalg_qi2.c:(.text+0x9ee): undefined reference to `napi_complete_done'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_probe':
caamalg_qi2.c:(.text+0x68f1): undefined reference to `netif_napi_add'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_remove':
caamalg_qi2.c:(.text.unlikely+0x1ec): undefined reference to `napi_disable'
caamalg_qi2.c:(.text.unlikely+0x1f3): undefined reference to `netif_napi_del'


-- 
~Randy
