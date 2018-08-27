Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E041208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xc0f+7jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E041208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeH0SPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:15:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38547 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeH0SPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:15:18 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so10679336ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42/ScWLvAP9LfW07MP/hdiJQ3oXxk/1eFTh4ZJpia8s=;
        b=xc0f+7jbwgpX2BkxpSFBua4vyoKZPW9XZKDYU4GVas1BfI/yT+PUKT0OF5Un+EBWUV
         ihmlO25AcUoS+ADWg77ZOxI6fW5kP3xLbgKtBY2y5OECZyaJY9zbipCvouMib6IHdbru
         1Yx7ZbmqxpMCgCyGqUlHiYWs5Igh9AyT9rQddX8teL7MNIUKKRj6+vWIXX8zebV8IHKp
         0TERpBlby3u6tD64BrZkGCdy/geoITBVL7hZNErY59SbXr4CCkP50UzElkp4YyJFT6eL
         Xr/6HHOOHh2fOdnz1hNjJIFG/aL1ok60x71tBUKHbveMF7QKwjSaflAKnjDI12+lkVTC
         9N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42/ScWLvAP9LfW07MP/hdiJQ3oXxk/1eFTh4ZJpia8s=;
        b=LLhVlJAZAWcDecCo8GJT7Vcyhm8pqYyB8BnadG1Hfzsa1OfYyg61Yc3FAK4Aauf7yQ
         hwD17ZoyZjVFrwzbZcoOFfwUdabSZsMEkBiLS2ec9lCbuRCQfdTUOIvyfUSLq/ZJZXh4
         U/8Du11Mrz1HAkRCt5CSraLoUxS4D2fd8ebiN8qRLOflO8Pf6nLtgFxR6oh7yzEkDIOz
         fLV1lHb/7VoKtgj8DaPz6v97V/KO8orXhamk+olGUtG4djQTlYNhL9RkdoyMy6PdBVHr
         yaDP2VdAVUkhzKMONVR2be/j/t3tMpiQAcr7wZpzMo/vCV5ZEqD5Jxx/Ifnda/5MeSA5
         cz2A==
X-Gm-Message-State: APzg51D+d2P+YKu/gCJ3WWpmaLYiqvoDaxQ0swkc1RU+2svVunitPiw0
        kzC8MtSm3ESCnkvQ3flVIAETzkuiZ1Q=
X-Google-Smtp-Source: ANB0VdZ5VkH5LHyhvrsPAcpbk+Ey0xvCOIJgbbYwFzMfUgzF27uOt5gWrQ1v6RI7ioJsLxur50UzUg==
X-Received: by 2002:a02:8a05:: with SMTP id j5-v6mr10334556jak.59.1535380106325;
        Mon, 27 Aug 2018 07:28:26 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i139-v6sm8879702ioa.26.2018.08.27.07.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:28:25 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: libata pata: fix Jens Axboe's email address
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3d1c1b3-94af-3ea2-22ce-afaa1948ba1e@kernel.dk>
Date:   Mon, 27 Aug 2018 08:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/18 10:29 PM, Baruch Siach wrote:
> Commit 7634ccd2da (libata: maintainership update) added an invalid email
> address. Fix that.

Hah, what a mess. Outside of that, the git trees should also
be updated. Something like the below. I'll send in an update.

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..9ad052aeac39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8255,9 +8255,9 @@ F:	drivers/ata/pata_arasan_cf.c
 
 LIBATA PATA DRIVERS
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-M:	Jens Axboe <kernel.dk>
+M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/pata_*.c
 F:	drivers/ata/ata_generic.c
@@ -8275,7 +8275,7 @@ LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/ahci_platform.c
 F:	drivers/ata/libahci_platform.c
@@ -8291,7 +8291,7 @@ F:	drivers/ata/sata_promise.*
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/
 F:	include/linux/ata.h

-- 
Jens Axboe

