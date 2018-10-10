Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C769C2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGsMKYEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C769C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJKC30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbeJKC3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:25 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A503721523;
        Wed, 10 Oct 2018 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539198355;
        bh=9kU8lEfY+pFBkeIvnjWBeCC7LfKm5FBcujGKGZpWs2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vGsMKYEFMECreLszrJvZo71vs89k5sL5nZqXsKGKQ14577MllNe1GmEbEM+1GqYIF
         xx0pqmHPJfmvqOoB5witQlHaptwnqZiM/JfcwQEC7F1D6icuHFNTXlBW919gEqlP9G
         cltz8iDdOu/Ldho/MyZ0jLcvs5bUU07ld2o3o2Vg=
Received: by mail-qt1-f181.google.com with SMTP id u34-v6so6985542qth.3;
        Wed, 10 Oct 2018 12:05:55 -0700 (PDT)
X-Gm-Message-State: ABuFfoiv7BjL/X3oBZ/09t5cNyHN/ei/tt99cGwpuV7FU49I1ZexQKTB
        qVddrZ6SyKf9zh54eK/5/nrQG5jOIEl9ZmHlXA==
X-Google-Smtp-Source: ACcGV62bP6zVeiDg25bCL1EZNE5UYErlFQ+buaNu1PNX+5nBfqmaSD/ZDCCRcZQyuaQlGeXqs3/lOmILSijZ44yQMig=
X-Received: by 2002:aed:3ec2:: with SMTP id o2-v6mr20035773qtf.26.1539198354838;
 Wed, 10 Oct 2018 12:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <1539080245-25818-2-git-send-email-svellattu@mvista.com> <20181009174428.GB2182@xps15>
 <CALabi0FgQWGL8KMpCKt9N6Kkoig77LxOsea3Oe47tk5nOH10-Q@mail.gmail.com>
In-Reply-To: <CALabi0FgQWGL8KMpCKt9N6Kkoig77LxOsea3Oe47tk5nOH10-Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Oct 2018 14:05:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsF0Zr=chBQ_Euq+27TJftpSR5dpi-tYyiwEFdsEh6vQ@mail.gmail.com>
Message-ID: <CAL_JsqJsF0Zr=chBQ_Euq+27TJftpSR5dpi-tYyiwEFdsEh6vQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] treewide: use bus_find_device_by_fwnode
To:     svellattu@mvista.com
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-rdma@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, oulijun@huawei.com,
        xavier.huwei@huawei.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 9:59 PM Silesh C V <svellattu@mvista.com> wrote:
>
> Hello Mathieu,
>
> On Tue, Oct 9, 2018 at 11:14 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> >
> > This doesn't apply on linux-next.  This late in the cycle you may want to rebase
> > your work on that tree.
>
> OK. Will send v4 after rebasing onto linux-next.

That doesn't help anything unless you are targeting 4.21. If you are
it would be easiest to apply patch 1 in 4.20 and split this patch by
subsystem for 4.21. That avoids any cross subsystem dependencies.

Rob
