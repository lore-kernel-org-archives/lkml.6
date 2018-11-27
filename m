Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244F12086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244F12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbeK1FUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:20:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbeK1FUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:20:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F176E2379;
        Tue, 27 Nov 2018 10:21:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C072B3F575;
        Tue, 27 Nov 2018 10:21:45 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 981131AE0A0D; Tue, 27 Nov 2018 18:22:03 +0000 (GMT)
Date:   Tue, 27 Nov 2018 18:22:03 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ast@fb.com, daniel@iogearbox.net
Subject: Re: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate
 kernel addresses
Message-ID: <20181127182203.GA19721@arm.com>
References: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Nov 23, 2018 at 06:29:02PM +0100, Ard Biesheuvel wrote:
> On arm64, all executable code is guaranteed to reside in the vmalloc
> space (or the module space), and so jump targets will only use 48
> bits at most, and the remaining bits are guaranteed to be 0x1.
> 
> This means we can generate an immediate jump address using a sequence
> of one MOVN (move wide negated) and two MOVK instructions, where the
> first one sets the lower 16 bits but also sets all top bits to 0x1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Denial, Alexei, shall I take this via arm64, or would you rather take
it via davem?

Cheers,

Will
