Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C09C24003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1qvRqWtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C09C24003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeGFOqp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:46:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbeGFOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:46:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so4460047wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2Qbq2ayCkPQgp0CgsFE1epnzke9aueQW5O1HumK430=;
        b=1qvRqWtfERtUACosBDDrCqLm8wY4hXkcdIBRGE8zAvNmgo4lZ+yIf6VoKQBofZYkZz
         osJBnoSqxWXHLIcdHHgUsR9CqfNZFa4sX+YTeEpg53t4CDB0MLzUT0DeL0vU5uAzIQfg
         sLevVhSF+g3K0VVjP1yEw0flijXqxi+YJnCbh760yditB5mRLhA2x4dJ/WXQ3+WLmMrm
         CXmRZqygT7ApaZBiJJmrVUA4BLDdWQMvFqLWWLT915qv9VXrHr2lJAQLJhZ/mu6wEW3g
         ryJUCK0S80iUzAcvDpZXdu84l7crbR+dVrr/L4hdYs+OEsIof+hi5ZGJ77bO5WDgmuQg
         jzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2Qbq2ayCkPQgp0CgsFE1epnzke9aueQW5O1HumK430=;
        b=DlEoOtv1RX3FbCuEQzdlibdhvy0SGSJ0BBSY4sqJw/ITAO1S9yf05h0qv00eF2MmT0
         R5oCsXRGZ1InUmbuG+xqFp2HShld/4ThQVcdMccl9YuXt2OG5Rvk/dkuNkAKE3U+gMyO
         YUnYz0bqHdjC+oM4wAfrPQ/TAEWxl00wspGBfGQdJC85xWwK2RfT8mXZi7WJt6/sugSt
         8Fj8U5y1Go9trExF7SgHG4y7qmJd1CjT82BejDZvuCbqjUg/Z2bkuMNEL7wtVzOtNyNn
         sK5jPvzUSSdpOTuVivQnayllE4YEpte+9APxx+6LRK3tYKVpUlSW+oUsib1Adl/E5Ftk
         scVg==
X-Gm-Message-State: APt69E1K//EvkbXD7sLfBHSVDN9apRua61Tc1cEmRZKcwzJfmRubUY4t
        5f7tcdlZsEj184nBPuEX++BKoQ==
X-Google-Smtp-Source: AAOMgpehtIOK3BYNMlWFuRJJ6bNrWr0ql/0RO9Qh4gItFQmEgcP1Ju0b7CbJYFBlZD1MP/x8wZQ7tw==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr7577491wrr.104.1530888402763;
        Fri, 06 Jul 2018 07:46:42 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t10-v6sm9161674wre.95.2018.07.06.07.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:46:42 -0700 (PDT)
Message-ID: <1530888400.3023.10.camel@baylibre.com>
Subject: Re: [PATCH 0/2] Add support for S805X based P241 Reference Design
 board
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Date:   Fri, 06 Jul 2018 16:46:40 +0200
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 11:50 +0200, Neil Armstrong wrote:
> Neil Armstrong (2):
>   dt-bindings: amlogic: Add support for GXL S805X and the P241 board
>   ARM64: dts: add S805X based P241 board
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      | 218 +++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts

Looks good to me

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
