Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DB92081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VnEyX0CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DB92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeK2WHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:07:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeK2WHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:07:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so1744749wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 03:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M5G5wxj4I12myWfzJCN4MSkONDDbyUEFBq/6Ntuz/QA=;
        b=VnEyX0CFtnzTkmfAwwGOJFbLgLC7olQs74OYsk4CGMEwq+RwnFeL4KU15+rwdPxhFX
         Xlj6Xr2VG6r91lDhzpSUYGeSZXBv8OJ+w0GKHsImttcuYddj4Rr2Ry+ysSnLj6+Fs8Hx
         omfXdqZ2dUqhLIS0fGz0VGazeD+Rr27IkUWKhloCUCbZCy6MXn0WBHVYZPfTvSBg+Ba0
         4x6wqxYbiYKuDFCSBRz9p9h4VUP8FREPGzoQMeBealX+kYJubVmbl4XJQbtlR+LPqpG/
         WkScHLsE66TjyUTANk0Rm2OYCA2kk98CB/8AV8e+R72cWmEAGm2I7pgnf+DXz95rZtG4
         TLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M5G5wxj4I12myWfzJCN4MSkONDDbyUEFBq/6Ntuz/QA=;
        b=GQvhWO7JvzC8KOInL/O2FcYiOo1XTIdAdyXkmyz1fiTlC7PttWEec78loVdB1v3U+j
         ML1R4nz0RERpPfm8J/H1sfIZMmhAD3i/zvl+7WHs+JcLGhh/HKEfoLCjLu/GIMLnA7Cs
         gBbNaXsxP17mAE1zjj7nLVHsBvIvnEfjs3UMpWrrygSyUU0B2eh/7RIEw0uKjE7K1idc
         SnC7O3zFH10opXqHDUVRmFXtUTx+/v8mmAMG1vhxQee3Zs9WoeNcpATbMeNFenPDBDaI
         WyQ1F5FYjRrTG0zt2qoaQS7dz540R8tJJF9wlPqpqYv4+6OEuqGq/W0u/Ttqs7ADAb/p
         eRgA==
X-Gm-Message-State: AA+aEWYQdpVSjcWuqFqWzq1wrPds1s6TI63Jc1DYL5Izv6PWJeJ/Rzjd
        yePcpI8lHQA02r+9o29Ta87xqA==
X-Google-Smtp-Source: AFSGD/Wq9Q5zi7Pb80veLGexIklkZz0oSazkg6E2810legJItmqRiVSsv0K3wH6/gTsOlQMvuaFY0Q==
X-Received: by 2002:a1c:5702:: with SMTP id l2mr1390536wmb.31.1543489345602;
        Thu, 29 Nov 2018 03:02:25 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id x136sm1727048wme.0.2018.11.29.03.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 03:02:24 -0800 (PST)
Message-ID: <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com>
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c
 controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 29 Nov 2018 12:02:22 +0100
In-Reply-To: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 18:59 +0800, Jian Hu wrote:
> 1)Add G12A SoC i2c compatible string in dt-bindings.
> 2)Add compatible and data for G12A I2C controller driver.
> 
> Jian Hu (2):
>   dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
>   i2c: meson: add support for Meson G12A SoC I2C controller

Looks to me that the g12a is compatible with the axg. What is the point of
adding this new compatible string ?

> 
>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>  drivers/i2c/busses/i2c-meson.c                      | 5 +++++
>  2 files changed, 6 insertions(+)
> 


