Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D2CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56E02133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pKjZVtua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56E02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeIMKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:00:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:00:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so2085090pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NHmgKxJ7ZZh7wXprJPQOjDqeMDY2abioSveD+MuzA/o=;
        b=pKjZVtuaEHY3nmBbqVvjJY9iMESQWMfSmnmQTrvlrz8nnJm6Buh+CtEO32U6i2vSO/
         3lErPRX9ErmzJ8BGrwLuRFX6U7DbjTeg2VJFy0d29f3GjB40UafopVoPs9+uqk22L3k2
         OICIDW5pgM+odT+oNbhd4qteHVRx6tj4lSJkyEtuJJMndUQ0XemawZJjrnuF3QGZd2WU
         O/TNZHpnAw1XLppD62vXbJznwHyzZp0CWZfGkb54LHSq6l9/tMjjvcgzrosszzD7loq9
         A5CeGBRq1uzBWN9vmVDKcu5dybCoL8+58UOm7xtUjWhmH0Kir7pNUduNm7O93X+xeWhC
         gW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NHmgKxJ7ZZh7wXprJPQOjDqeMDY2abioSveD+MuzA/o=;
        b=eDk/0LNZ+C8iStE3xCjyXwBkRTYA9a5FdcgX6K5b/J9SegMaUVXu/JxjLWqW9v4W9I
         W+JWNaGPqJjyPKVWWG9czIdknR5YgteihIn9S3GwflC2qyyI314fyTLKGtbEA5nZuX4R
         E+Kbai7Ta0bl+u9oAzMwBrClD2fvCi3ARwp9Qo3joarLIrAnzF0qBoEWIOP9/KE8+Ki1
         LJ7t/7yzkEAiG1lqs9ZrMwCajQTXF77O1ANGaA2SMftSTRohYr6lSA2E1066qHU9oAF0
         /of3dkLGLXGn4hdvqS/H85hZ2DBDyWyFNLnkrN7jMhAJFtrt0+zXihsOC61Yi9Boi0SU
         Guww==
X-Gm-Message-State: APzg51APhcWScnG2c4C0Nf1mS9Nvxozyk3bCnUyh6i6uvM8Dbcl2HnpO
        A8SQOqYjxnpvwj8xmtbKEPsWS96d4tc=
X-Google-Smtp-Source: ANB0VdYKSPkZzQalzxzLEPHPrpPpEHabuy0Lk0sc7aJ9E2lLqQA6UEYJ8KjSS+35D7o9pTxxEqkvHQ==
X-Received: by 2002:a63:4b1f:: with SMTP id y31-v6mr5298899pga.14.1536814347711;
        Wed, 12 Sep 2018 21:52:27 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 5-v6sm3687386pgc.86.2018.09.12.21.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:52:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: dts: meson-axg: add pdm support
Organization: BayLibre
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Date:   Wed, 12 Sep 2018 21:52:24 -0700
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 31 Aug 2018 17:02:15 +0200")
Message-ID: <7hftyevw1j.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds pdm support for amlogic AXG SoC.
> It applies on top of the DT clean-up [0] I sent earlier

Applied to v4.20/dt64.

> The related ASoC PDM patches can be found here [1]. While the ASoC patches
> [2] are obviously needed to for the PDM to work, this series can be safely
> applied without it.

Thanks for the clear explanation of dependencies.

Kevin
