Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27020857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaMmXxyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIFO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:57:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42086 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIFO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:57:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5054421pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUV3jnVtIfcmlpjpbZ7tv+73twNtVA8egCP+4hxOgSQ=;
        b=ZaMmXxyF8ITJN+h/1LiB3qwm7g69o/xFjx9rRzlANmjeJ66jhHwNJq2ZWoIuUEKxBK
         PpmjYAwWTaYckSzF5Pv8IWvPlgeTSGw4b1uV51swJ6uoZIrRVHDIQKc2e5mM3BZT7szF
         G2/ooObiiIxJ85bBy+04DRz/l7qjMjU9Zpo8ZEI9AR6uRUPqxKQ671sSEgsyQ97Y6wLK
         66J9gwK/6EZnT4TFFL1xCUeovwRmAxu9kZ4zsTbocFCVhEwgP2UrNy960XsYHbF5rOQm
         3/bxqGREvzymCULSXf1v0ZAoZbc5k0owGq4CsU7izRE0NpYZ84g5U00/8zJnpYD8LUXr
         vYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oUV3jnVtIfcmlpjpbZ7tv+73twNtVA8egCP+4hxOgSQ=;
        b=D+KJVkq4HAEWh0avgEGisd2xv5KkDIi0/N+OGoRz3WLByxKpNIV3jNuLeG0LhdICcU
         x76z1C62U+rQved2HjfbLvlYfjRO2hIVvpvXkeJaGOrOZBClkzORwMq/4eR0YtLrkaTV
         JoqrfuUuDwKa5sfd5B5ZnIkhBNI2csoGZD3EMP1X9pa7+4HyUnj+r5EfaotajpvztMc+
         aw3js/GsCmGNwAtvIvIZdgi/n/vG80TUt+er23Prv/T3OPK0Tmf/wfFriMsdDtQTU4b+
         hjI5IcCnOsTLgUm9VlJv8tbi0rhF1NnSvHU8wp0W3DfHAq918fRB34RiQHSDenHGoB0n
         9OcQ==
X-Gm-Message-State: APzg51CL/1waF6dsd5JRy5nFGx8OjM9qI/EzhxB7yfn7mpsov97QvX8W
        ZMJCOL9jjHUGBjaHnpTwhso=
X-Google-Smtp-Source: ANB0VdamdUG0YGTN2sft+92C4x3kBY7vCWEhwpLLYSvCQK6hBoxWzKAv8vExC5qAYgW2iTPqUF93zQ==
X-Received: by 2002:a63:706:: with SMTP id 6-v6mr1948594pgh.137.1536229348392;
        Thu, 06 Sep 2018 03:22:28 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7909555pfa.173.2018.09.06.03.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 03:22:26 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        android-treble-mediatek-ext@partner.android.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 0/3] arm: support get_user_pages_fast
Date:   Thu,  6 Sep 2018 19:22:09 +0900
Message-Id: <20180906102212.218294-1-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I got a report get_user_pages_fast helps app's launching time
due to reducing uninterruptible sleep time because it could reduce
mmap_sem lock contentions when app is launching.

To support gupf in ARM-non-LPAE, first patch reorders memory type table
to use 5th bit of the page table. It seems we don't use the bit in ARMv6+
but it needs double check from maintainers.

Second patch introduces L_PTE_SPECIAL for arm so that last patch can
support get_user_pags_fast.

I would greatly appreciate if guys review that I screw up something,
especially, architecture stuffs.

Thanks.

Minchan Kim (3):
  arm: mm: reordering memory type table
  arm: mm: introduce L_PTE_SPECIAL
  arm: mm: support get_user_pages_fast

 arch/arm/Kconfig                      |   2 +-
 arch/arm/include/asm/pgtable-2level.h |  16 +-
 arch/arm/include/asm/pgtable-3level.h |   6 -
 arch/arm/include/asm/pgtable.h        |  13 ++
 arch/arm/mm/Makefile                  |   6 +
 arch/arm/mm/gup.c                     | 221 ++++++++++++++++++++++++++
 arch/arm/mm/proc-macros.S             |  16 +-
 7 files changed, 261 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mm/gup.c

-- 
2.19.0.rc1.350.ge57e33dbd1-goog

