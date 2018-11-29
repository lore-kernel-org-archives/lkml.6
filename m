Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC67C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE2920832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CoAwwA8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2920832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeK2LxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:53:19 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:41058 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeK2LxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:53:19 -0500
Received: by mail-pl1-f177.google.com with SMTP id u6so100802plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VDsk+R9UcyB7GaXXGjWWR4aS3VEHJ/14IPA2HoPmq/o=;
        b=CoAwwA8BlLpd8qJFKiiPBniZ1v2L/b1IRqeIOw+Jw7VMmqfJY77k3Ki7XUHgNXHNXj
         H2apkDSrNo1XIjCvC190xGimjz9lnLC0xBSgVXdrKOf71C5PsbuPdZZVoRP8ffUnfIzU
         0SKBk8lc+8uUx0Y0vAFDkgYMqnX4S5x6PysSIdw02yxOxcKO8D+rlaWcW0D0q2j2S+jK
         onRZH2DeUHK7KD01Q6/050g0kG3tQi8GC6aJ2bQVQmKGI52kV94FoemLqS79ck2LdTeI
         M7kGpzFaNFRGqtm3PEjNL0GnXktd5RKCuVqsLAHVrvjpUEyjSDRQaqPO2hAZnXhzM/wU
         iZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VDsk+R9UcyB7GaXXGjWWR4aS3VEHJ/14IPA2HoPmq/o=;
        b=HgutP9VH4Rn3tIEUBjO1h8dvWMLGeUcMecu6NTIM5rFh8gKdzKpyScBJFtil9R4d1n
         OHGCa8otyGZRwM8r0a2glRiCKhJGuI2yYebfBD7NPGpALTfbnkxWKHtlFoonF6vO+Jo9
         X84uKRehm9g50bLvTELGnfTmMFrtvY1Tu2N2XhYtA/DnrLThPiOhtrDQRYr2tnvtGFTL
         cGImjXoBy0UYbZqmK0fsmSuxSsmYXucHTmQsmWR3wJZZioccUJC28A2C4mRkYsO8aqrU
         lACeLzV50ctWYyC5PkrfM5dFYWFM5N9HW/Z+LtsDMDshudE77/lm5oFR1xCNqFU8iIKx
         5OmA==
X-Gm-Message-State: AA+aEWZor1w+/T0sVHjRBqrepbdF4gmWNujAFgHMZVs1tx07cjf1nOH5
        yGMJ1LrhIIu6Sxm0Uw4AL55o6A==
X-Google-Smtp-Source: AFSGD/XxigFP96pEQkmXQ5N5cs9Jq7Gb59zlfI1OWeHq3ocDTPKR9SuKkHe0x/4EiTA67e1cmnPotA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr37981199pls.322.1543452588253;
        Wed, 28 Nov 2018 16:49:48 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id x19sm220529pfk.14.2018.11.28.16.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:49:47 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, carlo@caione.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] ARM: dts: meson: add the timer interrupts and clocks
In-Reply-To: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
References: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Nov 2018 16:49:46 -0800
Message-ID: <7hzhtsbtcl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This is a follow-up of my series "meson6_timer: dt-bindings updates"
> from [0].
> We were missing the interrupts for timer B, C and D. This is harmless
> so far because the meson6_timer driver only implements timer A. Timer
> E doesn't have any interrupt.
>
> Additionally the timer IP block has two clock inputs. This also adds
> them.
>
> NOTE: the alias "timer_abcde" was chosen because there's a second
> timer instance (F..I which are similar to A..D and J which is
> similar to E).

Queued for v4.21 (branch: v4.21/dt)

Kevin
