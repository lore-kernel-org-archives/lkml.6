Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCA214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Bub4FOuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCCA214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJJKPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:15:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42837 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:15:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id y71-v6so3445274lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agKc4SCKSR0hBU0V7ZiPWY48eVHIX6JO8ZhZxYctZC0=;
        b=Bub4FOuySpb0+NzMs4q6HMk4yuhyUMuefnjKzZT5O81fGyFv/XzTMqKlVL4YEDBtQT
         ZqDmS3dxgIkcPcObi91EVLDUhpqF+NRujJs2H7HVZB0PZH8G5aY7qxHao4fSXnekpv1b
         t8J1u4j2R7/+tZg/CUTnel1PZxGGRBI5JG0xmolplwRbyS0LFw2w38hB8JmQVwqhAAUe
         03dJDssrMrQGVwAGIsD7TsMfwBwqlHPe79kRZWXyu3Ug5A2PzVwdL40uW/UUfVJZRZ/E
         IKbDMUSSoWkJckRS3tZJM50H+fJvXwQhq3CMlqmjgZOnUF3CShbnhZTQtghZGcS1N1hU
         ds+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agKc4SCKSR0hBU0V7ZiPWY48eVHIX6JO8ZhZxYctZC0=;
        b=ZNgQ7tNsjDjIZECj3iZvwkGOveX1rIV3Za1HGt9Yf5bi5hCYZVKH8VaBHPdJO4JnHv
         SdscspWbVgYwaZ95cpcuatYb4DiB+h8Eljb4NLStmULouB8AQK7fh43qiQ4P8H6tX4yu
         5eBmCjJZlvh+aQDNcoqeTrOrH/sQVALnT0ovMjJWsVNCwgmOFEKZrPXBS84rlVUXFBsO
         0JhHON9DX0Ke/WtfmV4LkCNXGSZBIHKYrNTpKjQ779bmxv0YMY+Xt65CRIvL/BUWESne
         NZN7Y6m/PINKw8t6Apf8B4RuGsK56/9emwptSyjifI6fOxy6gY+Mz3x82s6U5mGDQuMS
         XC/Q==
X-Gm-Message-State: ABuFfoiS0/kMHj2pW2oVdWQQxSX/Wz0LHCEYTmIc0Og9Tdqpz9gDlkb1
        5mjDzBw9Az9jiYE7UYQDY+feCOZVpJWillYZgfbDSA==
X-Google-Smtp-Source: ACcGV63aEqLURxJwssNoZrCgW+D2v90QmHXWNi8nNX09mNz/9G6N4IZ8oCEHo1WCoqvEtAyQfGaEBGXBBT3NnsyuiVo=
X-Received: by 2002:a2e:8703:: with SMTP id m3-v6mr18742007lji.109.1539140152201;
 Tue, 09 Oct 2018 19:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009172726.GA2182@xps15> <CAJZ5v0gckkg0jyTc7=JYPpUruQQXL_FhEjm03-0mrFcxH60cHA@mail.gmail.com>
 <CANLsYkxcUvBBFRFD9Vco559Y5LFw=X0H3Lyzm=nFat6z5yH44g@mail.gmail.com>
In-Reply-To: <CANLsYkxcUvBBFRFD9Vco559Y5LFw=X0H3Lyzm=nFat6z5yH44g@mail.gmail.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Wed, 10 Oct 2018 08:25:40 +0530
Message-ID: <CALabi0FxU6GQVhKUWFzGF8qLS2YrQNh6Nok+RMS3Q_7B4NRH-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

Thank you for the review.

On Tue, Oct 9, 2018 at 11:18 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
>
> In this case I don't see a reason not to abide to the guideline.
> Wrapping the function declaration to 80 characters would be easy
> without effecting code readability.
>

I had seen this warning but thought it looked better as is. But now,
as I have to resend the patches after rebasing on linux-next, I will
fix this too in v4.

Thanks,
Silesh
