Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E735C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244DF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244DF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeILPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:36:24 -0400
Received: from foss.arm.com ([217.140.101.70]:57294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:36:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65077A9;
        Wed, 12 Sep 2018 03:32:28 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DD03F614;
        Wed, 12 Sep 2018 03:32:25 -0700 (PDT)
Subject: Re: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <641119b9-3466-817d-3d6b-dd710c646b49@arm.com>
Date:   Wed, 12 Sep 2018 11:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> For EL0 entries requiring bp_hardening, daif status is kept at
> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
> are enabled through local_irq_enable().
> 
> Before using local_irq_* functions, daifflags should be properly restored
> to a state where IRQs are enabled.

> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.

Is this just for symmetry, or are you going on to add something to the daifflags
state that local_irq_* functions won't change? (if so, could you allude to that
in the commit message)


Either way,

Acked-by: James Morse <james.morse@arm.com>
