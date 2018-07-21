Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFECECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B4820858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1XDHhgXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B4820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeGUVVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:21:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36545 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeGUVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:21:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so12857054wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e2ZTibZ0CduOP/Ypk3/OYiNHlCMMZUOw6DF9zKAuvE=;
        b=1XDHhgXAc4HV0wC8XcN7/GzPZlYIlKKfLYmyQoVeFjlMWp/0irvQl2zdSbmTzlkb0w
         vh4ysC3so9PMMXvAWvOW5BY+/PKGUQhZ+OODt1Grp0Mwsw8zhRaa8c7DllVCFQ4VS5km
         ctEP/n5bc6k92EdzG6enFjS8lLBCMO+ygL3NFbwXMeAFWqD35/dRVd2k/lz2iJ2Brhw/
         6lwwwWNqcNesdiUk/gDQzcbVAi7DFvKMRdfNvkjBQQnnfKf5zIVa+3Q1S28xCIejSDHs
         GAHny6oj3cdg26tBiDQSJqkXIUEYtPYjY9u8Z26mN4kpB+Kk7CaHa3pLzMGSVfo8qitn
         3W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e2ZTibZ0CduOP/Ypk3/OYiNHlCMMZUOw6DF9zKAuvE=;
        b=LtWfsewebAF0kxXon3jsTH1y1UqufyZiTHcVYqEda0YvWssfK638U9M10hH/D14Q1t
         8PQFW3xUfRH37Evn7KUXzY89OHJcKe8HDa9FjiVaMCZsI326sqZzkPQ3vFSj+E+y2kG1
         h17H9/zNGhRke/18pvSRGNfT/y3sxlSCJc8SfwI30oE2pMJN5Y2ctepUaGnpfxExA3cC
         e3b0dwIYSortJOOqBCYw+7UTxen/OBnGTsx231ITUDGZZ/HdxvcOejV/cVtyWP14G/Xo
         yKvUAZ0pfRkyX3ofK8rhNh6sWlrnxxaQMgtP97ro5ZyoqiPdcgKnw8EH/Uh6UvpVzbpW
         Vp1w==
X-Gm-Message-State: AOUpUlHeIToC4zOEPgfNQvXp642Bq9aE/3YSvgf2EQeAmMdJCqbkLpiR
        Jq+uOdd0+jgKr2oTN0XNRZbCTg==
X-Google-Smtp-Source: AAOMgpfLRljzVICuL7434SqXWblzOy6wfkFYjHk3QPvvFZxeZyMD/VYlcoviXYmzBGi+qzh5SFpevg==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr4501981wmo.84.1532204821930;
        Sat, 21 Jul 2018 13:27:01 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id r140-v6sm7170177wmd.27.2018.07.21.13.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 13:27:01 -0700 (PDT)
Message-ID: <1532204819.26720.68.camel@baylibre.com>
Subject: Re: [PATCH 1/3] clk: meson: clk-pll: add enable bit
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Sat, 21 Jul 2018 22:26:59 +0200
In-Reply-To: <CAFBinCCDGKu5U1xY1WG2BHF28YEWd1HbKdDeTCc9fEV_YjSNew@mail.gmail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-2-jbrunet@baylibre.com>
         <CAFBinCCDGKu5U1xY1WG2BHF28YEWd1HbKdDeTCc9fEV_YjSNew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 21:48 +0200, Martin Blumenstingl wrote:
> > @@ -250,11 +264,15 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
> >          { .reg = HHI_HIFI_PLL_CNTL3,    .def = 0x0a6a3a88 },
> >          { .reg = HHI_HIFI_PLL_CNTL4,    .def = 0xc000004d },
> >          { .reg = HHI_HIFI_PLL_CNTL5,    .def = 0x00058000 },
> > -       { .reg = HHI_HIFI_PLL_CNTL,     .def = 0x40010250 },
> 
> is this change on purpose? this line set en, m, n, l and od before
> maybe you can document it in the commit message

Yes the change is on purpose, but as you pointed out it is worth a comment

Actually, when taking od out of the pll driver, I remembered this 'initial
setting' and it kinda bothered me

If the od divider registers after the DCO, the value could have changed with it,
which is why I wanted to remove the write on this register

As you pointed out, in this register, we find m, n, od ... and enable. In a way,
removing this register setting was the reason why I wanted to add the enable bit
to begin with :)
