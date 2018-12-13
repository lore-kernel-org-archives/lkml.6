Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A85C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7417920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z38D6aXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7417920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeLMQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:49:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34369 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeLMQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:49:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so1395898pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9e9x3U0MfZ0tl9wJMH+qJPfAjABgmKqgJejMG0aExLM=;
        b=Z38D6aXCXZqSqTjQ6UDZH33YzFzNUpW3L6mbctIZjPfl5aVGIZcwauLPEqiRgOigk2
         LbL8O5nD+nwBtTiqfaL6LkIay18sYrQSpJe9V1uMbXfjLIsNdZXJGGnzmufpkksyx+mz
         q6e4LePlHav9T+/BRrR+PRq9br8t3aw+ZSfduFXSdQCT54ypb6XmJbEZeqcCiUYd9Let
         UVd79P2A0qKg7kuAPQY+WsEDqh/npD4EsYKXqQdOzvqEM34R72xQEE1NfF14OMAqmNm7
         Zed74nUIJVN0v/JjP59yUxC87WeemHVQacFyM6XrkaAlYzoC9oELEHBJ1s1Le0B3e8HE
         nTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9e9x3U0MfZ0tl9wJMH+qJPfAjABgmKqgJejMG0aExLM=;
        b=gWhQrE4SLbApylU55LlLW2hKVKzHQZK0e3+cCeukpVXf5WqTosiPNKLH1jaBNQqRO2
         5mwi5lI8NmoMISJS7GrUAx47TAXTf62A1xFN0+8MT/XCutsgW9SdTI3sI/w7l5ijXlM2
         O6QXWTOwxChl7w/cWd2ImlbCxCu/ktNSCa++OO49LMgErAwfFz2gXX92BPcPTyFnHf/8
         XN5SIjL1LBdy0e+YSg9rPyxdKc4ztEL6dNThBNVlbH9oH+hHNVbrxxH/ztIl8y2S3slr
         OCatd/V7bAflrmHriwBlmdzJW+hXttBjWhHFabaPcGL4pPw9pqsjbpRfsg2CQk7Qt4B/
         ULQA==
X-Gm-Message-State: AA+aEWaszkyWaLlZcfKydK2i8WAl17M8Q8s8n7qxDGCEa4B6eWE7Lc2g
        XhIAD7kPI3G11Dyfc4RI9GJzcw==
X-Google-Smtp-Source: AFSGD/WbhPkEbmFXr2PL6usEvAwDCzLLR/JiGFl52dFwwQFM3DU1zYLGy/CDkSsdC5eb9c6TsdA2vw==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr24436724pfl.120.1544719788504;
        Thu, 13 Dec 2018 08:49:48 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 85sm3359463pfw.17.2018.12.13.08.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:49:47 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
Date:   Thu, 13 Dec 2018 08:49:46 -0800
Message-ID: <7hlg4ts76d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested on the mt7623-rfb1 board which has been failing in kernelCI, and
this patch gets things booting again.

Kevin
