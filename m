Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CC206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K1vJ+KOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1CC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeK2Ldt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:33:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33307 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeK2Ldt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:33:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so103403pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=j7VEJMdNX3hizvEBqZU8Msuu6SpXqlrBimcD91WS/2s=;
        b=K1vJ+KOcNUijDNowf0VDfHgSXs0HZOm0prHNAXFEa63i0EgdZMR+uHsR+pySBjU/A9
         ZRQkhphJ2KtNN9+HnDYZBnggOf+zid33EmKVU/dcoby3sO1ptxshq99dKh8LznEiMG8a
         ziOkAsz9XrBIqtM4M2ybvogGlYQiRNtjdJZAVAuzL3r2TzeeGiCZLXH409ZK8Rf8aeOK
         r/VJ51udWmcXdL1iAjQ0bZPRvjh4sCYumJ84qZXfOkPIXgLaUSFEtGxKUrOUvsYCPHbo
         7tM3aR0evmJb2t9B1B4vCFhyCR68bZvhlp2D6mBjp3GCbvpphrUMxPOCnHHicGutxegs
         dJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j7VEJMdNX3hizvEBqZU8Msuu6SpXqlrBimcD91WS/2s=;
        b=kfOmnJUWb8VoFt6qs740j7uM5PGuhAAjDVDvQQaZC9UkxiHObM3Sa8MLNM3w2JN7Yy
         QNSsaoEpcHJeoEbJjwkIv2CNGqg6YWq17PL6ntH34GyOF0DoV6yqlePnN9RNbVEM4n+Y
         kSfCgPn9m2fYEzSjnfacb7LiuGVrXK6JNF280i0A1HUVFicFtxhxSRzjpdvVWP1EPg6Y
         jvTDPJRFDZ8+/Rw4eQvRdFm6RWb97/so1ZBFHXMWpdqjrl/1Q1P0JsKIWOnTU9EjeLIo
         O8lFU86i47hxwjgSkUed/64i8WO6Pi0Sfas/hOG1LFuvCzQ04BvMDT8CApZT+05QToDe
         I6VA==
X-Gm-Message-State: AA+aEWap5GuVV3duAZR8hSeFww0PaRsPmxqy9w4gEOqnB0RKILQNtirs
        8IgJaKR4ToVhixDAzz02FmSZvaTlRH4=
X-Google-Smtp-Source: AFSGD/UhBRGnde3309CukOWscSE8Gpa9u1XGuEY/1aBAbLQ1QEXq+LtUqTODeDCPBxq3dL2NakStRQ==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr35746159pgg.429.1543451421268;
        Wed, 28 Nov 2018 16:30:21 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 184sm151695pfe.106.2018.11.28.16.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:30:20 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
In-Reply-To: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Nov 2018 16:30:19 -0800
Message-ID: <7hh8g0d8tg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> voltage supply of the CPU cores (this regulator is typically called
> "VCCK").
> Now that we are preparing support for CPU frequency scaling on Meson8,
> Meson8b and Meson8m2 we should build the pwm-meson driver into the
> kernel so we can configure the CPU voltage early in the boot process.

Can you explain a little more why the configuration of CPU voltage
cannot wait a bit so this could be properly probed?

Kevin
