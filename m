Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328324658
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2328324658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeGCIcg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:32:36 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49576 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbeGCIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:32:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2246823|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CLgcNMA_1530606719;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CLgcNMA_1530606719)
          by smtp.aliyun-inc.com(10.147.41.199);
          Tue, 03 Jul 2018 16:31:59 +0800
Date:   Tue, 3 Jul 2018 16:31:59 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V2 02/19] csky: defconfig
Message-ID: <20180703083157.GA29472@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
 <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:16:27PM -0600, Rob Herring wrote:
> 
> Are these configs mutually exclusive? We try to have one kernel build
> serve many platforms. So you'd probably want to divide things between
> the 2 ABIs.
Yes, they are mutually exclusive, and may I prepare defconfigs like
these:
 abiv1_defconfig
 abiv2_defconfig (ck807 ck810 ck860 are also mutually exclusive in
 -mcpu=ck807/ck810/ck860, you need "make menuconfig" to select correct CPU,
 so they couldn't be determined from DT. just like ARMv5, ARMv7-A and 
 ARMv7-M)

> It looks like you still have lots of options enabled that I wouldn't
> expect you to need. Start with something more minimal for what you
> need to boot and support upstream.
Ok, I'll clean them up in next version patch.
 
> For a full config, you can use allmodconfig at least to build test.
Thx for the tip.

Guo Ren
