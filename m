Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5948FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D3320870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D3320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeG3IUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:20:45 -0400
Received: from ozlabs.org ([203.11.71.1]:59337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeG3IUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:20:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41f99F3hHtz9ryt;
        Mon, 30 Jul 2018 16:47:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
In-Reply-To: <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au> <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
Date:   Mon, 30 Jul 2018 16:47:13 +1000
Message-ID: <87tvohi5ji.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> writes:

> Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> switch over to that driver and remove the via-pmu68k driver.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/configs/mac_defconfig   |   2 +-
>  arch/m68k/configs/multi_defconfig |   2 +-
>  arch/m68k/mac/config.c            |   2 +-
>  arch/m68k/mac/misc.c              |  48 +--
>  drivers/macintosh/Kconfig         |  13 +-
>  drivers/macintosh/Makefile        |   1 -
>  drivers/macintosh/adb.c           |   2 +-
>  drivers/macintosh/via-pmu68k.c    | 846 --------------------------------------
>  include/uapi/linux/pmu.h          |   2 +-
>  9 files changed, 14 insertions(+), 904 deletions(-)
>  delete mode 100644 drivers/macintosh/via-pmu68k.c

Geert are you OK with this and the other one that touches arch/m68k ?

cheers
