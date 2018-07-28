Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E52DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFAB2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/vfeJgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFAB2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeG1Iee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:34:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45786 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeG1Iee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:34:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so3235753pll.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vIVuDqYpoC/mKnfkt8QsUZlup/Mm78m6BwvQxTn+MrY=;
        b=g/vfeJgfi1wAjY8YY+uKyKHxP4zlv83LbTya+rQfWTw0jMQxCXvfj45GF0M31Bw23V
         8vtNooeI3oJWf55rQlVmwO9XPFMslGnbzR/7BTgsODHGKT203oNMCoyqX/j7TuIvFnXF
         F7VRXZpmp10UhzV784aV18j3jaD/6EhqSAr6vlMntKpW5AFzJ6Z60yNzV+0IBiMZBlUW
         I8auYdcwZwU82HYNaaWG/aD2ZYBQ49KZLlSHLHp4yDyOuY7PQcng8GR+/6MiB6fr94sj
         rDUEwLICDsOOpljA/c+tgqVwuF2620V5Jt9VK0pomaL1LrK9gyVkisNBnOJthjN1acbd
         PQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vIVuDqYpoC/mKnfkt8QsUZlup/Mm78m6BwvQxTn+MrY=;
        b=kw7439sTnbDF7g5eKk5INXOGYJ49XhyYr3S9Dak5XjHAg40hjZs3X8ffZxSoGl2B1F
         /Cl7nIJ58jYwTXvzyjx1RTBEpe4fcbI4JNx1xznyXWMEJO/ufIPBWwaFrCAtlwzFfUae
         83YFXpUt+hvo0RXWo8lTfr/r9VzgP+F2eDnQAShafFQjFXWy5TUEWTkRCwRQ7iZwxyLF
         JgJwpEnIqnjuMIDVAK322qbgJdah04IZ0Y03aCjE7CRv1Hh7OpYSijvb8wLbHjLWs/bj
         pUej9KCVDpZjdIqifcfbfBA2G2/MyP5KCIi3xzbl65eRXcVI3Pla6ziQdz2RWrwzMbxP
         uowg==
X-Gm-Message-State: AOUpUlEUqTD9XHArZb1jQRBcs9hFEwedHMDkGU1tcdSTQK3cyiFmpFpm
        OHp0/UZPLKu3lxUBmGg8GpnLYNXa
X-Google-Smtp-Source: AAOMgpeGPXmCj9LyhbxzP9XzaZXQNqd3BIQWy3eIfXzJ2zPw2MCwa9Rp6jWG0um7ERzZdvgCD2e0/Q==
X-Received: by 2002:a17:902:e28b:: with SMTP id cf11-v6mr8871958plb.86.1532761746678;
        Sat, 28 Jul 2018 00:09:06 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.sparkbb.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id t19-v6sm13337127pfk.182.2018.07.28.00.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 00:09:05 -0700 (PDT)
Subject: Re: [PATCH v4 00/11] macintosh: Resolve various PMU driver problems
To:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <155756b2-d3cf-e47d-2ea1-58115a4cadc5@gmail.com>
Date:   Sat, 28 Jul 2018 19:08:53 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No regressions on my PowerBook G4, so for this series:

Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Am 02.07.2018 um 20:21 schrieb Finn Thain:
> This series of patches has the following aims.
>
> 1) Eliminate duplicated code. Linux presently has two drivers for
>    the 68HC05-based PMU devices found in Macs: via-pmu and via-pmu68k.
>    There's no value in having separate PMU drivers for each architecture.
>
> 2) Avoid further work on via-pmu68k that's not needed for via-pmu.
>
> 3) Fix some bugs in the via-pmu driver.
>
> 4) Enable the /dev/pmu and /proc/pmu/* userspace APIs on m68k Macs
>    by adopting via-pmu.
>
> 5) Improve stability on early 100-series PowerBooks by loading no PMU
>    driver at all. Neither via-pmu nor via-pmu68k supports the early
>    M50753-based PMU device found in these models.
>
> 6) Assist the out-of-tree NuBus PowerMac port to support PMU designs
>    shared with the m68k Mac port (e.g. PowerBooks 190 and 5300).
>
> This patch series has been regression tested on various PowerBooks
> (190, 520, 3400, Pismo G3) and PowerMacs (Beige G3, G5). These patches
> did not affect userland utilities. (Note that there is a userland-
> visible change to the contents of /proc/pmu/interrupts.)
>
> Changed since v1:
> 1) Added blank lines after 'break' statements in patch 10.
> 2) Improved patch description for patch 3.
> 3) Added reviewed-by tags.
> 4) Split patch 8 to make code review easier.
>
> Changed since v2:
> 1) Added reviewed-by tag.
> 2) Retained PMU_68K_V1 and PMU_68K_V2 symbols.
>
> Changed since v3:
> 1) Rebased on v4.18-rc2.
> 2) Omitted patch 10/12, since these RTC changes now conflict with mainline.
>    It will be reworked once the mainline m68k/powerpc RTC code stabilizes.
>
>
> Finn Thain (11):
>   macintosh/via-pmu: Fix section mismatch warning
>   macintosh/via-pmu: Add missing mmio accessors
>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>     state
>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>   macintosh/via-pmu: Add support for m68k PowerBooks
>   macintosh/via-pmu: Explicitly specify CONFIG_PPC_PMAC dependencies
>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>   macintosh/via-pmu: Clean up interrupt statistics
>   macintosh/via-pmu: Disambiguate interrupt statistics
>
>  arch/m68k/configs/mac_defconfig   |   2 +-
>  arch/m68k/configs/multi_defconfig |   2 +-
>  arch/m68k/mac/config.c            |   2 +-
>  arch/m68k/mac/misc.c              |  54 +--
>  drivers/macintosh/Kconfig         |  19 +-
>  drivers/macintosh/Makefile        |   1 -
>  drivers/macintosh/adb.c           |   2 +-
>  drivers/macintosh/via-pmu.c       | 346 ++++++++++------
>  drivers/macintosh/via-pmu68k.c    | 850 --------------------------------------
>  include/uapi/linux/pmu.h          |   4 +-
>  10 files changed, 235 insertions(+), 1047 deletions(-)
>  delete mode 100644 drivers/macintosh/via-pmu68k.c
>
