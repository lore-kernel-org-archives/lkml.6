Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FDC20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="us3axl+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FDC20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeGQQOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:14:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45518 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbeGQQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:14:50 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so1356760ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=sueasnJ/FMuLC42Z/rR6o+SxOZUpk78BiwRNki+4gGI=;
        b=us3axl+G1PsMecqSwXXqjOQYbcJ5IjJLJvRf2CjD1odeO2zi6K1oPVpESozxULM5me
         vCg5fJDRVEjXng0ry9O0AmnBy/14C19VxIZBO3wLZhPmWQnMlmP7Dk/+6KTCEnixKY1p
         Ic86qdbfauSUKGetyxIN5/SKKZ6GQkJDxx6OEF105Vz/BgIhzDrb58dghPm1jDmI0AJb
         dArtyLQamGmfc2KixjpoFLmDinKqUNXQwHgWI618L9TVF6foKXxhZkc03s/RjnUJjqe3
         XbrEUokjWkJpy3S7YzsFGgC727qEJhT4DTEExXX7l0rwtllEMVVpnRH6LGQoJ1UKwCqW
         1c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sueasnJ/FMuLC42Z/rR6o+SxOZUpk78BiwRNki+4gGI=;
        b=k96CcDkA8ziKWwwThF6ytQaQqUgwTWgAQ3ZzBBUlVkWJehLyxOmgfwVqFfT+GZw2vY
         cSTGB4+1PqeYGK1Ep40suEH14nWj7xNCdWDA1KkbjfrZkCZHQHImVw6fnS3tS4qG6aSS
         k00MKQodfTzYt0kGb6OmBwGH2j9w4cy7a4/e7irH+FwzHys/8DGaGCsoB2q5Gd5zKl+1
         Q09Ylc+Tybgv6iwebVjCCzApI/3cpKnmxT8zwnaQSDBFSlwGiKsPknpMGByfOuSdhrUt
         nt0070ksKX3mFnxVjAizxA7/t89SnybDT6gVMyj2ybx7/x6SSbB5WYlY66MnGlqQypC6
         +yJA==
X-Gm-Message-State: AOUpUlFMertDuMrFt9Q0woB675hXHxpGfd/g5E+gLVbkwJmGN/9W6wAA
        xBEPak0yyhQ1Y9o5DdLbSnT32w==
X-Google-Smtp-Source: AA+uWPzYEio+MhHML7P2jflFRHL8V79QF1S9QM1uFU5+dywaZpolXFQ+2vonDU5Sp/3CqsIXeBfmMg==
X-Received: by 2002:a6b:bbc1:: with SMTP id l184-v6mr1841328iof.83.1531842096348;
        Tue, 17 Jul 2018 08:41:36 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id z71-v6sm1274348ioz.34.2018.07.17.08.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:41:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] ARM64: dts: meson-axg: updates
Organization: BayLibre
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Date:   Tue, 17 Jul 2018 10:41:35 -0500
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Mon, 16 Jul 2018 12:11:45 +0200")
Message-ID: <7hzhypna34.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset groups several updates targeted on amlogic's AXG
> device tree. Patch 1, 2 and 6 had been posted previously but I thought
> it would be more convenient for Kevin to get them as a single series.
>
> Jerome Brunet (6):
>   ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
>   ARM64: dts: meson-axg: add adc buttons the S400
>   ARM64: dts: meson-axg: remove spdif out from gpio a7
>   ARM64: dts: meson-axg: add spdif input pins
>   ARM64: dts: meson-axg: add pdm pins

Applied to v4.19/dt64, queued for the first DT64 pull to arm-soc.

>   ARM64: dts: meson-axg: add the audio clock controller

I'll queue this for a follow-up pull with the dependency tag from the
clock tree.

Kevin
