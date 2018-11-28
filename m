Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8720873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFQsN66v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F8720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeK1Ors (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:47:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Ors (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EBIIQmZHQg+aPugrApd68w/z4kzHvGai56mPu1Neo9s=; b=cFQsN66vsXqxjTJzZkZI9g0btl
        91JK1tgyCGbKmM4KKAZGwhq0Aqwa4MbxR3KiJTMGkcUS0ShEomO1zwiGzMw25+hi0kUB3vLPxXVOV
        vvuBbRz2piKwCjO16bVxHQamoaLWT1TGPWOcmope5tKwcWSvW8roFJMMP69btNryfTlr+Kob/gQlu
        A+oKab5w7CLzLRclnHJb7eNTuEhbs3yhETngGolZeJchTvAETmj5zfsyXgPYSvHb+rPQSeV3y7UM+
        Vezx4bb6Dx5F6eGTSTl9tna7J7GIiU+H6norQe5u6Z/YKiF/rVrV4NK8H1ykVTI06tXbww1zBjS6a
        dtYoFCKA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRqp9-0000xG-OS; Wed, 28 Nov 2018 03:47:40 +0000
Subject: Re: linux-next: Tree for Nov 27 (net/ipv4/af_inet.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20181127152539.55426063@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f43a02d1-db24-369f-90df-8f7326144195@infradead.org>
Date:   Tue, 27 Nov 2018 19:47:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127152539.55426063@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 8:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181126:
> 

as reported for linux-next-20181109:
(see https://lore.kernel.org/lkml/499e91d0-7349-641f-9826-7535713176f8@infradead.org/)

when CONFIG_PROC_FS is not enabled:

ld: net/ipv4/af_inet.o: in function `inet_init':
af_inet.c:(.init.text+0x42d): undefined reference to `raw_init'


-- 
~Randy
