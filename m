Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADE620820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lb9oXBOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADE620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407588AbeKWI0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:26:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37111 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404988AbeKWI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:26:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so8471410oia.4;
        Thu, 22 Nov 2018 13:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CLIN8puokknbxrAj+/ZjxfShLAif/OcRoWopnz99GQ=;
        b=lb9oXBOtfGJAcyJIe4QJyd8RJ1pt94PmxyzAxC05Lb7UjDW6pGi9MjMQnbuf/dRIkX
         Vh0rzapNXAVJ43fQbR5o61PjeJQW3k61P0T5gvK4ERKzlpSXHUhIXWW9STramYFYkRBk
         sP5hyB10KAboa7LxmPeQjX1izsjeHWWrHkWurHrN0fkysv+vBJPo5OdlDcvsi2sgYwTO
         s8zy2LUiVXiM8Yj9XHOZymtW7Q9dEljPZ50bcemqx8iSZX9Q5n4W3L2p/G+EQfjmlSIX
         ZGt4uheven64G6mxUq/wMcaQQ+BZ3ox5e3nWqq+j210ZQmdsc3IngZRrvbtrOMoopVzm
         N5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CLIN8puokknbxrAj+/ZjxfShLAif/OcRoWopnz99GQ=;
        b=oDUTzgs/9z+WmUty/+p23JCRmQsVrH/EcomaMXvmrCq+Kos0hfpYIAIr7wPcOKLkqy
         a5YP0TqdfJwGJysy9tCBMnKILbvgf+M7H7CdaLqkcILZB/00FBi3V2a53szh3QJt2lEt
         tXnZuUIASUBb7H/dDtc1Pu6lnRaRuzF4Rlsk1cwgopaRVw1NHyA/W9HQXGI3vu7tGv4Q
         3KWL25RLEjixBWFuvZGWnhNS8IJ4gg9JbR6UBX4Qji+3kidqzr2+w1Jwh38W8dGtaukG
         tS2y3X4uYSHWTD9zXq9p5Xgg/lfFat6Ab9+B5RBfYnMgtIj6Qyo7r14KQtOuyMJYIYNO
         EW/g==
X-Gm-Message-State: AGRZ1gLxS+FsfNRddSVcryNl/iYBtpFz7oZqwWj18VqaibZl6vJSbQY3
        YQ9sf+G+WE5/re7INVxWIJUY4C17sr/bwWT6Ioo=
X-Google-Smtp-Source: AJdET5fXe5gUCxbKq3ZtpCuk7YUEdys0SSgX2Tepo4h89isC8eYm5hZoTFR6eh805vGzdw9SwZ6nCK/9trivvunlT40=
X-Received: by 2002:aca:bdc1:: with SMTP id n184-v6mr7364843oif.321.1542923106072;
 Thu, 22 Nov 2018 13:45:06 -0800 (PST)
MIME-Version: 1.0
References: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Nov 2018 22:44:55 +0100
Message-ID: <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf failure
To:     hofrat@osadl.org, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        carlo@caione.org, khilman@baylibre.com, yixun.lan@amlogic.com,
        xingyu.chen@amlogic.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 8:52 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for the patch!
I tested the non-error case on my Odroid-C1 and it still works fine.


Regards
Martin
