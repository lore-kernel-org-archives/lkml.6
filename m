Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5490C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDA4206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3cLmGd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDA4206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeIZNbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:31:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54144 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:31:12 -0400
Received: by mail-it1-f194.google.com with SMTP id q70-v6so1619679itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kleCjf8eSknErXrMU419yqGLgp6v0Ofb7uVkNpsBiVw=;
        b=I3cLmGd9tpEwwrz9pMK0jL5xGTDcyzZd6V9S3LWMopT6BqekrPHswSWs24ei0eis1S
         BCVV0dk+KyQ0QcgQW71DTXDcH/QGWTab255Fpk0TXeW0NMwiLbhMrPSxMbCLhVCbUO3l
         uaAYw4yq5yqBueyv5MDzWqOfJwx5bQtL5CyYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kleCjf8eSknErXrMU419yqGLgp6v0Ofb7uVkNpsBiVw=;
        b=Jlp/9TWMBpm4jfGd49m8k7nvOvIUTho9kJxBDs0S7C4WT/sMe2WHykzWiC21CVyoaf
         JmYWKWW4YBBIBMm5XiIbVGpaQfcGKHkwr192r61gRhstC04bDJ4hQeQ5iNfslH0jGFKU
         BHRQF4Q7mteKCWCTZ7Ebm+/VHomM6gAyq9aSNIctUX+oq2DLndC7QC0JAjqnBNLtPk5v
         4cQtFlUdpI9Pek1Uzjb8CLHPfmmOh6KQIhGayif3UJW9bkP1bKFfyei//qfvkwtstAIl
         D+7Pxdk2sFloRhzLUunvUtjZY7ha2VlunPL3XezFc4l6+27YtirTdF6zqELpxskwDdM9
         yNZQ==
X-Gm-Message-State: ABuFfoiDoJPKOWX5+NcOnbi8EEqXVfpLFTf9VAbXLYoEo+mY6L9aZS4p
        SYSU/aok8bf/9fIKaCI+/aB5YLjmTzfzCGmnmws6qYFg
X-Google-Smtp-Source: ACcGV60o+g8FViZN7FO0TaGd3TeYBQAup7O+bZIs/BLne/+MDkNI5lfhcIt5lxfQI6NoUlqX8EOZ5Bqt1FNRM2AnO38=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4433363jab.87.1537946381801;
 Wed, 26 Sep 2018 00:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com> <20180911150925.19460-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180911150925.19460-3-Eugeniy.Paltsev@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:19:30 +0200
Message-ID: <CACRpkdYVyK3p639OeHmh17Ni3T+h1YaMYd=GqJ+aR6PexFU1kQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:09 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:

> This patch adds documentation of device tree bindings for the Synopsys
> GPIO via CREG driver.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is fine, just waiting for the final version of the driver.

Yours,
Linus Walleij
