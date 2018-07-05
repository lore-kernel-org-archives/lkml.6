Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A5C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B675F23D80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B675F23D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeGEFjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:39:17 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56627 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbeGEFjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:39:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2390907|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CMUzQM3_1530769123;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CMUzQM3_1530769123)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 05 Jul 2018 13:38:43 +0800
Date:   Thu, 5 Jul 2018 13:38:43 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V2 05/19] csky: System Call
Message-ID: <20180705053842.GA11749@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
 <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com>
 <20180704114952.GB22857@guoren>
 <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:04:37PM +0200, Arnd Bergmann wrote:
> Right, I do understand what it's used for, my point was that you
> don't really need a separate system call number for it, just redirect
> the entry point using the same trick that nds32 has in
> arch/nds32/kernel/syscall_table.c:
> 
> #define sys_fadvise64_64 csky_fadvise64_64
Thx for the tip :)

 Guo Ren
