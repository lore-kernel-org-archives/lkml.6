Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2409C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE4021CDA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE4021CDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeGGGQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:16:42 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35555 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeGGGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:16:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1416438|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CNM-2hy_1530944166;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNM-2hy_1530944166)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sat, 07 Jul 2018 14:16:06 +0800
Date:   Sat, 7 Jul 2018 14:16:06 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180707061606.GA26276@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
 <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
 <20180706122631.GA30265@guoren>
 <20180706162100.3iimik242cied2c6@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706162100.3iimik242cied2c6@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:21:00PM +0100, Mark Rutland wrote:
> Please don't open-code this. Use of_device_is_available(), which checks
> the status property itself. e.g.
> 
> void __init setup_smp(void)
> {
> 	struct device_node *node = NULL;
> 
> 	while ((node = of_find_node_by_type(node, "cpu"))) {
> 		if (!of_device_is_available(node))
> 			continue;
> 
> 		...
> 	}
> }
Ok, approve.

> Please use the reg property, you need it to describe which particular
> CPUs are available.
> 
> You probably also want a mapping from Linux logical CPU id to your
> physical CPU id, and a sanity check on this. See arm64 for an example.
Yes, you are right. Reg property could determine which bit of CPU in
cr<0, 29> could be booted.

Thx for the tips.

 Guo Ren

