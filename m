Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D1DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DD4214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7H5HjFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAJJum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:50:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39388 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfAJJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:50:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so9123529ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+mgEpehwQtRm1VaqM2ytGzaq+6JKimat4K6WcvNJrQ=;
        b=B7H5HjFIKCJQMjo99p+hkQpmllKjTsNXeyPfIFpP/y1ZpthWnPgj/nBO6hBlsGUDZ2
         qQ4EU9+U9heQrq7tegSYwMx/gAZ8/6lkxvfYH/2YHkSd139q16rhY7x9c9n2J3UViXMZ
         bpybY4LdCJgvLciuAjlw8ByJWfY/tHBk9v/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+mgEpehwQtRm1VaqM2ytGzaq+6JKimat4K6WcvNJrQ=;
        b=LLYLOxOQjAiB6T6eCBbNemXZpCkD+kO8mHOmM1H0ipSIQZGRzBdpWGVj8vFnulGbfs
         MQ8xlU5u06HynxuPQPcbvY33aNyoFI1tMlJR7bbxAwJs6IdJM1hG5+5348PZ3IE87rk9
         rw3WYGfW1Itt5fYZa8pRh0CICMm/Vv34Cc8DHBNkte64xkunVNLdSuyH7awYksajMYNV
         HO73Dr73I6GCPcMM/lahpv0V3smyG48YCIJTuA6361HGWnbpXF4hMAsD6EXgT5mou/52
         UTUYj12O0Y91zPyTpyu8umFIm4T6lFfYYQE+QnFEm/afaJdnUTbvF5ZY3XtJ/Yk/8Ycb
         SFcA==
X-Gm-Message-State: AJcUukfDlCSPXmPM8v350I46oZws8xlf/+YqyNQGhJk784c/ZCB/vKSo
        44mZsuMf7fUchWFG2I2H5fYjdE4s7CimAS/1F3agYw==
X-Google-Smtp-Source: ALg8bN4QGP/xpZwtpHWq6GnFSnP1afF5CyDI1fHpn99TRCtvSkpQPfA1eMsoFPbNIo9Ygv2za5fK5EgeRq9sItNA760=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr5499773ljg.23.1547113839345;
 Thu, 10 Jan 2019 01:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109134208.5660-1-dev@pschenker.ch> <20190109134208.5660-2-dev@pschenker.ch>
In-Reply-To: <20190109134208.5660-2-dev@pschenker.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Jan 2019 10:50:27 +0100
Message-ID: <CACRpkdY97wU8UsEpHWNHzpv0LzoM7rQWaNsHoi_WrNy7dkvoyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 2:43 PM Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
>
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
