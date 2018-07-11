Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7320652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB7320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbeGKN2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:34 -0400
Received: from ozlabs.org ([203.11.71.1]:38311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbeGKN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:33 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Qft238h0zB4MX; Wed, 11 Jul 2018 23:24:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f6bd74fa084eb9ad573ffbb236a095454163f66d
In-Reply-To: <20180618095653.1538471-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: xmon: use ktime_get_coarse_boottime64
Message-Id: <41Qft238h0zB4MX@ozlabs.org>
Date:   Wed, 11 Jul 2018 23:24:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 09:56:24 UTC, Arnd Bergmann wrote:
> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
> 
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6bd74fa084eb9ad573ffbb236a095

cheers
