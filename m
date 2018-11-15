Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34658C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A9E20858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nV4WdalD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A9E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeKPGHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:07:50 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45662 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:07:50 -0500
Received: by mail-pl1-f176.google.com with SMTP id a14so5375223plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=x1UE4XpoRp5UFNDTgUwi3hDsHmVbuvxvUHmzcGNpguU=;
        b=nV4WdalDizabMIMauVeKFfE1Gw/YrKth17jUNCDCdfPcG1XMbkcvuyeCf5i52DqKr5
         4lafgyWSHBKXh/XeuYFk8ELMwQJsmB0R/eg7JmJJ/jv0mG9OigFNJ5F6u4hiiyPd+d28
         znjleobbTeWwbv5ZOqSD+A9RRUK6ECNgyjBgmD/m3Lt0wofWHmTL1X4XTCHpoSeAQcJb
         g2+Es2357lOVpuv5ABR+GCtA43EcTkfxUwOLLH8De8mFTJ2Mgf2qwgqxCeAt6N1RsQGP
         pqYEMsj2yK3rK5uPhx1BMWoPFDsKNqKdvc2qM8VyJo+81fK50d9j+ZiOoEhoM5mKBCQE
         oMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x1UE4XpoRp5UFNDTgUwi3hDsHmVbuvxvUHmzcGNpguU=;
        b=L6QvwqSBBUCJZA3k7PNmhIPbb9eymTywVplhu5rOyF9DkBS+wW9ch/vlVeqskpp8gu
         SmyDPpT3M9rTbqvMH3RZGtrIILQIynTYmMoMFO4ZnFStBR8pob2AR5+7+X0j1Ig+FM3J
         W+Qo9ZavCHawH8udV5UqyLDSRt+eIfcESydBhJoNNWwY3Q2G/ABuFOJ+exw7dslfWzV2
         Wdj2dGl7Mc7JJp+Fu06hAYFlUQQrTIu+DrnMD2eZhmE0IzcupMpkizQpzHZzFGmaf2Sa
         RBxry1tLr/l3fDia6q2UBV8iN/05to4RtvbaiezyRiS3C7pTdg6W+VSgR4ukbOF6X+BQ
         Jx8A==
X-Gm-Message-State: AGRZ1gKtz5BwCQohrHW1LyKGE68wVhx6nBe8+3QUvSH2BH4Fi+L42j4I
        3koBKHm4COmA618PvXzibzdxzA==
X-Google-Smtp-Source: AJdET5cezNDpAqkA0YfhSqhW49IUBEd76D6yCP9NbeUQ71BM/EBKsFV4+7h6x+3Fxd1dSW1ITb67Mg==
X-Received: by 2002:a17:902:c01:: with SMTP id 1-v6mr7702597pls.15.1542311916393;
        Thu, 15 Nov 2018 11:58:36 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id a17sm33138467pgm.26.2018.11.15.11.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:58:35 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg: add secure monitor
In-Reply-To: <20181108130744.32323-1-jbrunet@baylibre.com>
References: <20181108130744.32323-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 11:58:34 -0800
Message-ID: <7hr2fmdset.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the secure monitor device to the axg platform.
> With this, we can read the SoC serial number.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v4.21 with Neil's tag (branch: v4.21/dt64)

Kevin
