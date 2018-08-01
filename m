Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4602CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD72720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbeHAHHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:07:46 -0400
Received: from ozlabs.org ([203.11.71.1]:53855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733048AbeHAHHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:07:46 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDG3RdFz9s3q; Wed,  1 Aug 2018 15:23:58 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 73f4447d43484224d7abfba0d9468de4982ef889
In-Reply-To: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4,01/11] macintosh/via-pmu: Fix section mismatch warning
Message-Id: <41gMDG3RdFz9s3q@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:23:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 08:21:18 UTC, Finn Thain wrote:
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
> 
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.
> 
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/73f4447d43484224d7abfba0d9468d

cheers
