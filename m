Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103D20C10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103D20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeGDKzn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:55:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56613 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbeGDKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:55:42 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 084f0604e8ddfd3d; Wed, 4 Jul 2018 12:55:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, stewart@linux.vnet.ibm.com,
        benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v3 0/2] powernv/cpuidle Device-tree parsing cleanup
Date:   Wed, 04 Jul 2018 12:54:16 +0200
Message-ID: <1970525.ZJ2QEpmLmV@aspire.rjw.lan>
In-Reply-To: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 3, 2018 11:20:54 AM CEST Akshay Adiga wrote:
> 
> Device-tree parsed multiple time in powernv cpuidle and powernv
> hotplug code. 
> 
> First to identify supported flags. Second time, to identify deepest_state
> and first deep state. Third time, during cpuidle init to find the available
> idle states. Any change in device-tree format will lead to make changes in
> these 3 places. Errors in device-tree can be handled in a better manner.
> 
> This series adds code to parse device tree once and save in global structure.
> 
> Changes from v2 :
>  - Fix build error (moved a hunk from patch 1 to patch 2)
> Changes from v1 :
>  - fold first 2 patches into 1
>  - rename pm_ctrl_reg_* as psscr_*
>  - added comment stating removal of pmicr parsing code
>  - removed parsing code for pmicr
>  - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
> are valid combination,
>  - Change function description of pnv_parse_cpuidle_dt
>  - Added error handling code.
> 
> 
> Akshay Adiga (2):
>   powernv/cpuidle: Parse dt idle properties into global structure
>   powernv/cpuidle: Use parsed device tree values for cpuidle_init
> 
>  arch/powerpc/include/asm/cpuidle.h    |  13 ++
>  arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
>  drivers/cpuidle/cpuidle-powernv.c     | 154 ++++--------------
>  3 files changed, 177 insertions(+), 206 deletions(-)
> 
> 

I am assuming that this series will go in via the powerpc tree.

Thanks,
Rafael


