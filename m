Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E081C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11D720652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11D720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbeGKN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:27 -0400
Received: from ozlabs.org ([203.11.71.1]:58481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbeGKN21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:27 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Qfsw3GCDzB4MP; Wed, 11 Jul 2018 23:24:04 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8449a4cb69ab6fbb873d653a82787a2ae6f352aa
In-Reply-To: <1511897374-27408-1-git-send-email-leitao@debian.org>
To:     Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Breno Leitao <leitao@debian.org>
Subject: Re: scripts: Add ppc64le support for checkstack.pl
Message-Id: <41Qfsw3GCDzB4MP@ozlabs.org>
Date:   Wed, 11 Jul 2018 23:24:04 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2017-11-28 at 19:29:34 UTC, Breno Leitao wrote:
> 64-bit ELF v2 ABI specification for POWER describes, on section "General
> Stack Frame Requirements", that the stack should use the following
> instructions when compiled with backchain:
> 
>   mflr r0
>   std  r0, 16(r1)
>   stdu r1, -XX(r1)
> 
> Where XX is the frame size for that function, and this is the value
> checkstack.pl will find the stack size for each function.
> 
> This patch also simplifies the entire Powerpc section, since just two
> type of instructions are used, 'stdu' for 64 bits and 'stwu' for 32 bits
> platform.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8449a4cb69ab6fbb873d653a82787a

cheers
