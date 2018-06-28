Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911F227188
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911F227188
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeF1Jiw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:38:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935152AbeF1Jiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:38:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2673280D;
        Thu, 28 Jun 2018 02:38:51 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBFED3F266;
        Thu, 28 Jun 2018 02:38:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0D59A1AE4FEC; Thu, 28 Jun 2018 10:39:29 +0100 (BST)
Date:   Thu, 28 Jun 2018 10:39:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, mka@chromium.org,
        Greg Hackmann <ghackmann@google.com>
Subject: Re: [PATCH] arm64: remove no-op -p linker flag
Message-ID: <20180628093928.GB10751@arm.com>
References: <20180627194614.188210-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627194614.188210-1-ghackmann@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:46:14PM -0700, Greg Hackmann wrote:
> Linking the ARM64 defconfig kernel with LLVM lld fails with the error:
> 
>   ld.lld: error: unknown argument: -p
>   Makefile:1015: recipe for target 'vmlinux' failed
> 
> Without this flag, the ARM64 defconfig kernel successfully links with
> lld and boots on Dragonboard 410c.
> 
> After digging through binutils source and changelogs, it turns out that
> -p is only relevant to ancient binutils installations targeting 32-bit
> ARM.  binutils accepts -p for AArch64 too, but it's always been
> undocumented and silently ignored.  A comment in
> ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
> compatibility".
> 
> Since this flag is a no-op on ARM64, we can safely drop it.

Makes sense:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
