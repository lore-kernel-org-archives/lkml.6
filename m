Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170B4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14B220693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QVw/CTw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14B220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGSJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:41:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33601 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeGSJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:41:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so1189667wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9lzTN8eC/uICf+1QsHWU5ES51NDB4d8Goe6xCTFRBE=;
        b=QVw/CTw37ayvmrNW/EiIkEh6rtW2tqexppu/Z0IUGmXQtVPteDOWfMSaUzx9ZeA73q
         RHZsVXW2MtA0Ovq3muPACP3LSq+25ACLMJ41GFp6+CjX2v/qI+izWvYKq4eUyj6yIBz4
         kYNcvSyua/oWEPT7uRA8Gtp9q9YSA6pL/PXIDBkrGhGRktJibhSJCehZ/Zi+th0z9Bix
         5PnKfSqUsw5cZb1n6XfQhlA7bRQHZ4ZS2nrDBpl/YOY87xqc2Q8hZX10MadNbLMLL7wE
         YmihhT36IHlva8wkGl82ZAG/IvO9YfcInOZ/cN4MeBFbgViNAKBYH7zDtidmhIF+8WbG
         umLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9lzTN8eC/uICf+1QsHWU5ES51NDB4d8Goe6xCTFRBE=;
        b=nNDb3BqKfJyI/bqZrezf7ZQaT6r3++PabStov+Wzy3VoAUM4qxHG2rvAcoqqi1rjAR
         wYs6H/TPHDThKcNK/oV+9MmAbWSnqeIPeb8Bkw+t8OVjXI/+BDjwSRfYE5veb/3ekBaL
         lM90QvIaKBDfOpUfmjSrN1Hm0z+kGJHfljAxmoltUXervsxUUt0XFDGIDFohRFCtgr4w
         Q3H+Q+AT2QiSambHtr0jOOFjCpIXsD3n2hgEg60JDYgPyEMBekuoZJqwbrFTsFwY5G90
         NFlf0cAnvBfD2eA1qGga9vDvG6duQvWq4Khcf2Sqmw5C2c2xGgx5DTZdG1/ftaNjXePD
         ipPw==
X-Gm-Message-State: AOUpUlG9+ycQYlzwfgCr6YL55lrLIgi1bYViI5Ksj+aHINIsBfYn44wO
        ODefoQ58UCru/66NJ+riBGPzYg==
X-Google-Smtp-Source: AAOMgpd/kHiZEnNp3Kv4ZtWNVgMstdxPS+VVWfEYRaPnWnob4pIAr5K/7mBPMVLfVLJHVma73fkClg==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr3539958wmd.77.1531990747167;
        Thu, 19 Jul 2018 01:59:07 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4116408wmc.33.2018.07.19.01.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 01:59:06 -0700 (PDT)
Message-ID: <1531990745.26720.34.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: drop hard-coded rates from pll
 tables
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 19 Jul 2018 10:59:05 +0200
In-Reply-To: <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-4-jbrunet@baylibre.com>
         <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 10:44 +0200, Neil Armstrong wrote:
> We could even add ranges instead of table when we know the PLL supports a well-known continuous dividers range.

I was thinking about this too.
I did not went for it because it would mean yet another rework of the pll
driver, which I did not had time to do now.

I suspect that the min and max value of 'm' the pll can lock on might depend on
the input rate of the DCO, so past the 'n' prediv.

So, to replace the tuple (m, n) table with ranges, I think it would be best to
take the predivider 'n' out first and try to clarify the contraints on the input
rate of the DCO with amlogic ... we can also try and see ;)

> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

