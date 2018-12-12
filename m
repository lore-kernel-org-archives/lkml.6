Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0320879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+d0N5JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE0320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeLLMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:06:07 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36538 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeLLMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:06:07 -0500
Received: by mail-lf1-f45.google.com with SMTP id a16so13341268lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRju6D8hKSW/7EhvaE+wC0UMnWD27aQyNJoeGpHwWe8=;
        b=B+d0N5JIEDxHLlkJpPJe9IyclHyV9LxBB/9Sw+fPZ6FVydxQnYOXa4wi394usSgShe
         cvT4FJOrPmKkBJ1m/s2DA+aHnBqeecmNqoTdLxlyQqXXi0WeMXXdc48LuwZtiSNCX3tE
         JF2AkOv32cA1Kn3EosElODXvug10yMaD4VStA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRju6D8hKSW/7EhvaE+wC0UMnWD27aQyNJoeGpHwWe8=;
        b=DWmAiMLDyHNQ5mvk9/XwrBOPSqQuNSjiwGbrL4JAwxmd+vfTB/9CRNUVX+MrHQagoK
         VAtSEdSLCUxX3Ycz/7fxt1SM4O7RTYT5bag04nQIkyC1TqrOdB0BXKpa1QI9wdlf5rjs
         AROqrB+CNsshXQYX+Mqp67oSZS9S+EDN8kKHKMEiXsv0DoOQmWC+zlFgbHpmvd4Ez5vO
         PdsZLVtsl8zSKYEfIxr/WWjTKFpDCq7Zt4GLuuIExNL7xuermcSJX3PlY5lsbN4eMeXY
         Tbodh6PNlR5X07Cy9tetelbkpPpiF25MwW8OHEodVaV2O8siu0JHwhg+C0+bEKeFNZzi
         ynkg==
X-Gm-Message-State: AA+aEWasBKyJyOPS/vG2yGeMNKB/Q7coIB7/IyHzH0e1a5zTss+uQkA2
        C/BMWyQWD0EmTNxOIK+yTV5BaL1CzIuYE2vVSiZLTg==
X-Google-Smtp-Source: AFSGD/XFMyi/hzpw5v3qubcoaZaOmCov+3VljtOBlMtPGHG3EyOWLRU9CqvUCRNDNmkvBHgTN4JOblHQQS/dD+XTCPw=
X-Received: by 2002:a19:c801:: with SMTP id y1mr11074089lff.53.1544616364319;
 Wed, 12 Dec 2018 04:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20181210072513.15960-1-yuehaibing@huawei.com>
In-Reply-To: <20181210072513.15960-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Dec 2018 13:05:52 +0100
Message-ID: <CACRpkdZgy3y05aWAagA-ow7RFBc3MU6VQmFsQV4BgcU6A8d9xw@mail.gmail.com>
Subject: Re: [PATCH -next] bus: qcom: remove duplicated include from qcom-ebi2.c
To:     yuehaibing@huawei.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 8:25 AM YueHaibing <yuehaibing@huawei.com> wrote:

> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
