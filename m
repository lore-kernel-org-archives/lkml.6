Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCE9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616C32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TaxqauaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfARV4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:56:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfARV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:56:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so15732454otk.8;
        Fri, 18 Jan 2019 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mELmeoo6i0AmfR+AUOVDwxlIWFbCQN4kYA4tF5V65YA=;
        b=TaxqauaZwUY0qbh6EyRPz+THNbqZavywIh4F7TwBaS6u9AP5q/61dTxeibsdnfEFOl
         Ur5IMi87M0liwhnIGTQk2fZrtPHy/n8kH5byLvLwiArKndHBy2+kmpl4xYw/0fVkmE6Y
         Qt02ftSJotO8Wsm4mkSO4QSLmOCGs8Wh6PxI5mjFPrw8cgwbKNyTx7t1uhzmLczQLVUM
         UugNLVQuEBd+nm/P+8FIUuSXO+EjCjNojmahaDWNjw3bl8sqGjL5KuuL4TSVmAavPtmr
         BQgNt5SaD0pPy9CLC42zcr07TmREmN+3dpqOSdkyBCU5DgLiWmAgqrYaV59b7Z1N7id2
         BRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mELmeoo6i0AmfR+AUOVDwxlIWFbCQN4kYA4tF5V65YA=;
        b=pCjQ0yksz8dlcdE+Z9EcQYLqfyADzNvmscVotokd9OBBZd9ra7ZfBR9ZqXK1pVcENr
         luaBmFloQ55xXWoO8AUJIi1KeCxp1OCN8+YM+cKPrfRxQgggyQ0FqfhYahXybtCPx7g0
         862aBAxag65DaSY+CMsAnepgYIyvEdA4WIkCYZbzs/U0nHpfhhcp+2cmoPMSmO3hzVWy
         SXFRMD87NHQX8n8vqO5vHr1nCwB+sQKoNLDkwffyd3+2Ei86uLejy4GrL2Q2NH+eiWMa
         ixgDWS46J/D2knLAwojKnl3WN7KaCz9jOeTO61mxKra2ME/GbPWj9PNQ3bOVY4UDxyxO
         Sn7A==
X-Gm-Message-State: AJcUukd4r/73M/Hhe7Ypehfp2ktiTKEtOD5gRXFBeyBW3M/OeugKebwz
        mTXOsOI4xIWu+jAXYl4mgNQKxhfmJhTyCdZNp3k=
X-Google-Smtp-Source: ALg8bN5Q0JRI41u5cxmCRdQ6+Dg2kGNuhfKiudy4uooDptDAzy3Yr117FXGDLtC3VGhcrT7c1pv3S7xsdOV27JzuEoU=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr12322539otp.86.1547848611415;
 Fri, 18 Jan 2019 13:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20190118103423.15075-1-jbrunet@baylibre.com> <20190118103423.15075-2-jbrunet@baylibre.com>
In-Reply-To: <20190118103423.15075-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jan 2019 22:56:40 +0100
Message-ID: <CAFBinCDzvQ6BhkQmCt+OJs7L+xydq7QVy5QB6MYBFaAc3fzpmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: amlogic: add new compatible devices
 to clk_measure
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:34 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the axg and g12a SoC family compatible to the clock measure bindings
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

this is certainly going to make it easier to fix potential issues with
the clock controller drivers!


Regards
Martin
