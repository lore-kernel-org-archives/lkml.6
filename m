Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93377ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266FB21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwgsQaUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266FB21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbeIUDsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:48:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45744 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUDsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:48:00 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so9983180iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuQCgXPtpGkfWtNIMsl/6zQgm3UEhLeMXuufIi2oPDc=;
        b=iwgsQaUHVcVo+XPfEXd6VNP2xRxiY8JN1HM1dx2fbaKVy1LzXnT2Rymyw8JBpb7wF5
         Sd0CcL/A5/bcQMpx20upjFu/9HzG/n6XdVwz+ADh3rlLhB+dR9ux3O8CqAP/53o0YcQ3
         n0bFSYubiaIojFonaEueNEWM4fvkA6ospAozw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuQCgXPtpGkfWtNIMsl/6zQgm3UEhLeMXuufIi2oPDc=;
        b=U6BvAW46F4GcP2EgZFVYr+xYzaluP7I0L5Uuix7VCF8VhfdE70W13wILTZn+JpuY+b
         oDdqjx1SbVfEB6CmdhJK/snGfJfW7DxCPFF9QfNLl9VBHKLf3CUnA8JQAQf/8QJNHG9I
         CyS/i/PrM7LDGy82bvU3JO0t6oql7vcjfwPAQ0oH6WEjMRfEJiNJ0CMRJfUY45+1NQjD
         wnFGp3p9R2kUtbLlNrKrYPOFo/YdTcAzPifkBlcLNSr1F8cWExXZbpxoCB54+MIFRQ8/
         oqos1//xaxbSJJDBSz2QkGN2rjIwU+2nXTnZMhz4nw0p9wVUL6aHm2Au8N9QvdLOxMDc
         DiGA==
X-Gm-Message-State: APzg51BoHoVBk5UqdIcZhe6vt8Wat2A4L/DuUy6DX8AmyHXIzEDUZyuN
        z/s5QjnQ6yPJD12qhG+IyjsBiI61nfISUyFAlz+upg==
X-Google-Smtp-Source: ANB0VdZGdkmzQ2n39p88UdKI+KEHTC9sZnQHoztw8oM3/COwXAsd4YZUOnblpRYh36pi6oQhLqmNl0IePfI/4B2S+lE=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr22417903ioa.277.1537480943596;
 Thu, 20 Sep 2018 15:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180912135352.19722-1-suzuki.poulose@arm.com> <20180912135352.19722-12-suzuki.poulose@arm.com>
In-Reply-To: <20180912135352.19722-12-suzuki.poulose@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 15:02:11 -0700
Message-ID: <CACRpkdZ8HnbLKMcFcROa1h6+SN9zH_QKE=1LMFiiaNUmTnzV4w@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings
 for hardware port
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mathieu poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:54 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Switch to the new coresight bindings
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied to the ux500 tree.

Yours,
Linus Walleij
