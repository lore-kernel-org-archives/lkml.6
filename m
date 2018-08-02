Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28B0214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B+E92cZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28B0214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbeHBND4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:03:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbeHBNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:03:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so1694341wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx6iuheRoBiUZXV8SYSbyxNffDjxPxHXHOYMRcWTeSE=;
        b=B+E92cZuMbMVNTFVqyiB5JpIcAhvNczU/maROVU0cEFg04o823BkDGjs5aEOq7yLvQ
         7kW12lg0IPJds+xyGUXt1mgRt9tqPkkxkPVQTWcSdegSXkBTmTXOFqo8Jaya06ERVNPy
         9CsKJ3p+PxPibqkkYQlnjC3zALzs8uDe8BVTgcTpLDxlfoTSEtav/ngUvOxUL78NtFeW
         qg8h4Y7kTv01D7fKygwlh7h8x/0gtw1WT5CXWWMwjopQIG35LUu5nlWQNzdzeV8aJyid
         zTJ2cI71wDPbrPKJCilO5WwCVw7TGEC/wHz4BTpJOdq5u4vIM4fKVzGxSdwbwPDYE5pv
         3b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx6iuheRoBiUZXV8SYSbyxNffDjxPxHXHOYMRcWTeSE=;
        b=NpICCRzMyHYgiHqihYjN4c+369HXf+dre7Ilj54jYFvfKzrX96MUNpaGvpoc4ltcZ+
         LxKMxnc3OZaT54g9/uBZIpUxe+32wH/t+oVbitSpeuo9wLS18/GYe0MvMAh5rY8tAQSr
         VJLvvdBM0/2pSp+k982Sd7Dii6T3Pqe92FMZ0Gfeh3oLyATI72NaoJyHD8bQ9WE+OtTZ
         kmrQALW0IxjKoroAt7c3cCrZ3XB9noBiV58D2nok7a4BxObeihD/67vxqzFrgLkk7CdX
         14IUSxj2+Zz7maYGB6BHVA7xuMqUqfGGG2jEhYPjLPzwN6iLf78iEG4InG2fpfqEabYH
         v7qA==
X-Gm-Message-State: AOUpUlGZmqX45Le0c/+Q5rzb++tEUrXxTMrWdjF9A++mHDrLOSbM1G5/
        PrITUpph1nEthbanMZ3yF7FTLw==
X-Google-Smtp-Source: AAOMgpfLM2vw8E5gp8ZuPKt2PDQALofZjpEs/TkEF7eZBVpSROdSKRtAdE6HH9v2wxBwTe1xVK5zYw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr1787498wrt.232.1533208394234;
        Thu, 02 Aug 2018 04:13:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x82-v6sm943771wmd.11.2018.08.02.04.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 04:13:13 -0700 (PDT)
Message-ID: <2313ab25059d64362a058991969773cda9c7c37c.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] reset: meson: add meson audio arb driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 13:13:12 +0200
In-Reply-To: <1532103549.29751.0.camel@pengutronix.de>
References: <20180720152633.6227-1-jbrunet@baylibre.com>
         <20180720152633.6227-3-jbrunet@baylibre.com>
         <1532103549.29751.0.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 18:19 +0200, Philipp Zabel wrote:
> Hi Jerome,
> 
> On Fri, 2018-07-20 at 17:26 +0200, Jerome Brunet wrote:
> > The Amlogic Audio ARB is a simple device which enables or
> > disables the access of Audio FIFOs to DDR on AXG based SoC.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Thank you, both applied to reset/next.

Hi Philipp,

I know it missed your first PR to arm-soc but I can see it 'next', so I was
wondering if this was going to make it into v4.19 ?

Thanks
Regards

Jerome

> 
> regards
> Philipp


