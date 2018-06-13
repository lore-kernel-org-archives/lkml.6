Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2A53EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3751208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gl1swXOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3751208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934873AbeFMJHx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:07:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52780 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933732AbeFMJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:07:51 -0400
Received: by mail-it0-f65.google.com with SMTP id m194-v6so2791388itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bi4Q0WQjTsimGF9Ul2NfyHkyQ/4f4hEOKAWHGI9Pfds=;
        b=gl1swXOlOPPr6OSh8YKAyogjWymVOpv/ljIraMVpka2FfBqE5VXeazLFxK6OUrT2mD
         +VfZ5uzbKyA2M49OMLF51tdTlpMTEKvU8jwbFbN4jpUMC4UBJIrllTTdtO3uIAEe1wCd
         JWOLH7ZFxwd2NXJlr3obwyLQjWvi8gasCA+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bi4Q0WQjTsimGF9Ul2NfyHkyQ/4f4hEOKAWHGI9Pfds=;
        b=YqcIIw37fK6FPcvJ5pe1asZ09cJHSdnl+2IxfYfes4JkSSe0Dd4k+T/PlYqquCq4Hm
         BGl+wy6b9Dn1mdPFThq5pW1kyc0x8TX3Hf3ydSRu1/nAqT8/O5jzueTU/aGTVovqjHOL
         ous3Epd3H+5zYxOy+aNZnN0VhDcwHoY6cEJCJL/eWCjnmIokzTdBsFAkbiU98gT8K2FL
         n4fuiW/0Xdepr2KM7wrCQ/5zHQn1ZQRRsK+A8atFHYyo0qiYA5a5fmkPMgYeYI9S3+6t
         WT08LwStdOSCAngYRAZyW6RB13DsfAFI8+Oqh9Dr/Lf62GtZm4nzNfM1us+kH2jMGnqt
         jNWw==
X-Gm-Message-State: APt69E2iKY8Yw+TP+gaZ1t8fTBjsN4gDK68DJoknVHfzVfkWqqHJRtbm
        t23jVBPhA/gYSQ8PyQz6RcjBq99yqRkm1cGFtgHHaQ==
X-Google-Smtp-Source: ADUXVKK5GLuh41qjSBLlXiAKLX0wstq69AITmJE7ZcT/PXh8oB6dfu59e7baBRpmN+kHqZ9QxGbweFXbtFVsTKmqwOE=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr3824127itc.70.1528880870678;
 Wed, 13 Jun 2018 02:07:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 02:07:49
 -0700 (PDT)
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jun 2018 11:07:49 +0200
Message-ID: <CACRpkdZkXQj9xxN-wBjT_Y4Q5Se-Ts488bZzunYyecTau1pOEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: ftrtc010: switch to devm_rtc_allocate_device
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Switch to devm_rtc_allocate_device/rtc_register_device. This allow or
> further improvement and simplifies ftrtc010_rtc_remove().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
