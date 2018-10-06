Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E52ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75B62087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75B62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJGDLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeJGDLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:11:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEC2981DE5;
        Sat,  6 Oct 2018 20:06:23 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF25A19940;
        Sat,  6 Oct 2018 20:06:17 +0000 (UTC)
Date:   Sat, 6 Oct 2018 22:06:49 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, green.hu@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V7 00/20] C-SKY(csky) Linux Kernel Port
Message-ID: <20181006200649.GL32759@asgard.redhat.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 06 Oct 2018 20:06:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:41:42PM +0800, Guo Ren wrote:
> This is the 7th version patchset to add the Linux kernel port for
> C-SKY(csky) based on linux-4.19-rc3.
> 
> In this patchset some fixup patches are folded into original patch in
> order to make review clearly and reduce the patches' number for upstream
> patchset. The changelog is added in the every patch's commit-msg.
> 
> Here is the LTP test report for this patchset:
> (and add "V10 C-SKY(csky) Linux Kernel Driver" patchset)
> -----------------------------------------------
> Total Tests: 1298
> Total Skipped Tests: 280
> Total Failures: 11
> Kernel Version: 4.19.0-rc3+
> Machine Architecture: csky
> Hostname: buildroot
> -----------------------------------------------
> 
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> 	 SMP ...)
> More information: http://en.c-sky.com
> The development repo: https://gitlab.com/c-sky/csky-linux

I'm sorry for my ignorance, but I'm struggling to find ISA reference/manual,
architecture programming manual, and System V ABI definition;
may I ask to give links to them?
