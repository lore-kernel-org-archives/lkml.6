Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF29C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B6C208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B6C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJPSuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJPSuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:50:23 -0400
Received: from arrakis.emea.arm.com (unknown [95.150.13.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4472086E;
        Tue, 16 Oct 2018 11:00:29 +0000 (UTC)
Date:   Tue, 16 Oct 2018 12:00:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        pelcan@codeaurora.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, shankerd@codeaurora.org
Subject: Re: [PATCH v2 0/3] arm64: cpufeature: Fix handling of CTR_EL0
Message-ID: <20181016110005.GF108539@arrakis.emea.arm.com>
References: <20181009134707.3479-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009134707.3479-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:47:03PM +0100, Suzuki K. Poulose wrote:
> This series makes sure that we handle the CTR_EL0 field mismatches
> properly, especially for the IDC field. Also, skip trapping CTR
> accesses on a CPU if it matches the safe value.
> 
> Applies on arm64 for-next/core.
> 
> Changes since v1
>  - Fix wrong hunk in has_cache_idc()
>  - Allow a late secondary CPU with raw CTR_EL0.IDC = 0 and effective
>    CTR_EL0.IDC = 1, to boot on a system without IDC available.
> 
> Suzuki K Poulose (3):
>   arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
>   arm64: cpufeature: Fix handling of CTR_EL0.IDC field
>   arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

Queued for 4.20. Thanks.

-- 
Catalin
