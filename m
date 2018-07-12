Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1520BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B1520BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeGLGg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:36:29 -0400
Received: from ozlabs.org ([203.11.71.1]:47549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeGLGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:36:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R5bn4LB1z9s01;
        Thu, 12 Jul 2018 16:28:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Mathieu Malaterre <malat@debian.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] powerpc: xmon: use ktime_get_coarse_boottime64
In-Reply-To: <20180711125338.1365368-1-arnd@arndb.de>
References: <20180711125338.1365368-1-arnd@arndb.de>
Date:   Thu, 12 Jul 2018 16:28:18 +1000
Message-ID: <877em17yt9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> get_monotonic_boottime() is deprecated, and may not be safe to call in
> every context, as it has to read a hardware clocksource.
>
> This changes xmon to print the time using ktime_get_coarse_boottime64()
> instead, which avoids the old timespec type and the HW access.
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally sent Jun 18, but this hasn't appeared in linux-next yet.
>
> Resending to make sure this is still on the radar. Please apply
> to the powerpc git for 4.19

I had applied it but forgot to push.

Should be there today.

cheers
