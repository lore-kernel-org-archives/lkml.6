Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC22176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plmYyPhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBC22176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeHCRgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:36:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeHCRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rcYW00EPRzJ0guOzt7pvlKPhrwfclY5BI3gjhg5MrlI=; b=plmYyPhXPJTCLUU63neGp+7kAM
        FGcNEEvxkK2bOpC8dEjcDHqmjb4E0hcyyzqrQUlR8ymrg4xa9uCijgUsW6SvrfY6BIvLhM9KGnO3B
        98hgYdrwrU5ECV3cc/G0RuVyim3YbDeyAm4WnjTasgHF5LvqL5hUgL51gVXJzW23REwuRLYUnBsSM
        q1O7DDQ9iFtUfrM9EAIGaFdulpHMG9QGteDIa48eC0zQRi4aGB4J055z3/WAicSZuvqh0a8kb46g4
        ql1+8P27cJbwOI0CWdd9po6ELBiY3w9aC9pTMSb19WjHtaC0PlST/RrzQEISiTSJAzhDijVE80Yth
        O5QTc+jA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flcBC-00070n-QC; Fri, 03 Aug 2018 15:39:51 +0000
Subject: Re: linux-next: Tree for Aug 3 (watchdog/menz69_wdt.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-watchdog@vger.kernel.org
References: <20180803192942.6975df0c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9d17144d-6f19-781f-8abc-1ee1c6f840bd@infradead.org>
Date:   Fri, 3 Aug 2018 08:39:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803192942.6975df0c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:29 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180802:
> 

Hi,

On i386 randconfig with COMPILE_TEST=y and MCB not enabled, I see:

drivers/watchdog/menz69_wdt.o: In function `men_z069_remove':
menz69_wdt.c:(.text+0xa6): undefined reference to `mcb_release_mem'
drivers/watchdog/menz69_wdt.o: In function `men_z069_probe':
menz69_wdt.c:(.text+0xdb): undefined reference to `mcb_request_mem'
menz69_wdt.c:(.text+0x14a): undefined reference to `mcb_release_mem'
drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_init':
menz69_wdt.c:(.init.text+0x15): undefined reference to `__mcb_register_driver'
drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_exit':
menz69_wdt.c:(.exit.text+0x9): undefined reference to `mcb_unregister_driver'


The Kconfig for MENZ069_WATCHDOG says:
config MENZ069_WATCHDOG
	tristate "MEN 16Z069 Watchdog"
	depends on MCB || COMPILE_TEST
	select WATCHDOG_CORE

Looks to me like the driver really depends on MCB, unless someone wants
to add stubs in <linux/mcb.h>.

-- 
~Randy
