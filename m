Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47840C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF4C2152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbOXF0uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF4C2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeHCB2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:28:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34827 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:28:08 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so3547366iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yhz+8swD3gt7zBR+mIY23nMIzPzScbh5K5hM2nrQSQc=;
        b=DbOXF0uSwBV5GXNJeBl79FotPz3PEKEwd7xJ8cz83q9eDirouYVdpkuQ9EhaY+Zrb2
         ZbvqYu9nChP8W2BTdiV5G3XocYc7MzZHQI/bLiYCqvCMSuP+Wj7mmcbkvlLAAnE+EK3j
         msp2dXQuJrmNN6AoTd+UA3hsKHSq24rP/vf/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yhz+8swD3gt7zBR+mIY23nMIzPzScbh5K5hM2nrQSQc=;
        b=KB4HyfLdtrKwgJUEmHNrh+CwpMqWK27tO/fRw9iXlFey9yvVaHgxd7rUiQOAxxoDDe
         e5Ss4Yfp0TKbEJNMO3OfXdyb6YJ1MzhzgjOXgtc6+gQSj4TBTdfQIJ98xR1Yx9XKqANi
         CDINzq3hHucpNQsDgbtx5ZqFWC08xMzW5NOYx/ku+k+RxsfODtcV2ihH0SZbsp82mkaC
         n0WkMEbfcen8HLjH8vMXMmcoR2r8salpHFl6oZGiASyxn/cmp5m/oqZxyrv+B8qHgUpZ
         BJA175RF0+G49pQ2debkWGTpgWlo3Je40rv5RbwrbUNLT445zYH8x2BjWjNYdUK8LwMm
         r8IQ==
X-Gm-Message-State: AOUpUlHmBqr4bYn38fpan1yvZVvk1WO5cUL+bj2kn6Q/fL7Y7BzAjw8c
        H51cXK2BfnNEiFVagc9B6jhVnKwZthoWYMlFcNacMQ==
X-Google-Smtp-Source: AA+uWPzUBEo7RATL/Xq/uaLFWz0FclsK26ikK+mCr/DrLjQ9IyZ0Po3rmNKEQsyeAvueJJ3vYoKr7Nfl+MzfuDiELHw=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3968920ioa.277.1533252882704;
 Thu, 02 Aug 2018 16:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180730093418.124648-1-tmaimon77@gmail.com> <20180730093418.124648-2-tmaimon77@gmail.com>
In-Reply-To: <20180730093418.124648-2-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 01:34:31 +0200
Message-ID: <CACRpkdYOiJhqXyYpRDSD5is=A7-7LEyUwJp2HtpYqbYGR9d5UQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mmio: add inverted direction get_set io support
To:     tmaimon77@gmail.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:34 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Add get_set_inv_dir and get_set_multiple_inv_dir I/O functions
> to call the data register when the dirction is input and
> set register when the direction is output.
> the functions will linked to the I/O get functions if the user set
> BGPIOF_INVERTED_REG_DIR flag in the bgpio initialization.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

I think you uncovered a bug. This is however not the best fix IMO.

Sorry for not understanding the issue at first, I am sometimes
pretty slow in the head. :(

I'm sending a patch that I hope fixes the real problem in an
elegant way, and makes it possible to just define dirin and
BGPIOF_READ_OUTPUT_REG_SET.

Yours,
Linus Walleij
