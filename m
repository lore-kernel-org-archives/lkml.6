Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BFEC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E2B255CE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z5JoCo2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E2B255CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeF0XK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:10:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42174 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeF0XK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:10:26 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so1565920pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5UFynkK03DMijjzgf7mLVpoMMuO5EBoRE0W05Ad9ZE0=;
        b=z5JoCo2rdwhhfWGYc30GRmPU+5nJVTLxwAsqgckrzV/wGGeBMFnrI1k0CP/LA0qpGR
         NVLu5Crwu4dgstAwy6jPvjRJMx2y+1RnYBv166WFiPUI/2Tc8icZg/y1kIJs7Bz7fpqx
         ijpKqOZ3X1lux7XnLpd+DqxIWkItqRbrHdRE1e8KxyIf/L1AzZzgD4+RuF2L7y9nVlxN
         OFoSw8SzxhYJkJL/9dRmx6IQoiXe5L7o2BOm2H3nfYU6S4vknYvhIiqbR8itcqoqDa4e
         wR9NmG9Lk9w2Ert+/F3edvBPjaQcF12O93j5ULvW7yb2NYUG10PL+g0YN/kyaAJZqul2
         ppOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5UFynkK03DMijjzgf7mLVpoMMuO5EBoRE0W05Ad9ZE0=;
        b=GuSuv+lu/1fvnLtlVx6WzPdX7P0BqaBkMAZPaAg2mFedxFXFTYCliEbPWU5fLpMj3+
         5fDubQOr7DZahewziI6g1c7J90UwPQDAN6HEJPYiUftsaKJxNUnbeFKsG8l4cnsaujXk
         H/WMtYN5WoczOECL1t6gJENWf+RjVDD9jsPnhpgeGwxJVYdSf75AaDl2PlZspwboL1S2
         tV1xFQA0lYovpkr9bVUkK8Dhsv2DqEuoUfgBeT9z0hFW9cdBbga6qY3zX5Xob9Y+Hy1p
         apPbfcT2JS8MZX+1mVQdLx8voxqP5ZEFhu3MQU7/ev2qtPzOAyWZKt8O+vx99ijYeyvL
         ARHw==
X-Gm-Message-State: APt69E1U9FsRhRUQodANxKnidSNPComOgRjfX7ZPq3f2AHvMt6H1d+BF
        BpfGj7181+RXNXOaVFQ0RHc8Ng==
X-Google-Smtp-Source: ADUXVKKkT2v9yVapEizuAv3m8cLHkbuCdsl7yvRpSkQZQMPEAqMSD0q3cLcVZO2lSkQO0ysFxYu4iQ==
X-Received: by 2002:a65:6031:: with SMTP id p17-v6mr6708354pgu.140.1530141026095;
        Wed, 27 Jun 2018 16:10:26 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id 14-v6sm11117707pft.10.2018.06.27.16.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 16:10:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM64: dts: meson-axg: fix ethernet stability issue
Organization: BayLibre
References: <20180625125653.3404-1-jbrunet@baylibre.com>
        <d59a60d1-d5fc-6d89-f89b-148c8e3f3521@baylibre.com>
Date:   Wed, 27 Jun 2018 16:10:24 -0700
In-Reply-To: <d59a60d1-d5fc-6d89-f89b-148c8e3f3521@baylibre.com> (Neil
        Armstrong's message of "Tue, 26 Jun 2018 10:07:26 +0200")
Message-ID: <7h6023keqn.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 25/06/2018 14:56, Jerome Brunet wrote:
>> Like the odroid-c2 and wetek, the s400 uses the RTL8211F and seems to
>> suffer from the kind of stability issue.
>> 
>> Doing an iperf3 download test, we can see a significant number of LPI
>> interrupts on the tx path. After a short while (5 to 15 seconds), the
>> network connection dies. If using rootfs over NFS, the connection may
>> also break during the boot sequence.
>> 
>> We still don't have a real explanation for this problem so let's disable
>> EEE once again.
>> 
>> Fixes: f6f6ac914b82 ("ARM64: dts: meson-axg: enable ethernet for A113D S400 board")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
> [...]
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.18/fixes (which I'll be sending upstream today.)

Kevin
