Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82808C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392CC214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Qv++4AX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392CC214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJJKSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:18:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38607 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJJKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:18:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id g89-v6so2813802lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuLNgn8fMpBEx8l23HBlGlNpqXZIrWqOkEHpx7KRq8w=;
        b=Qv++4AX4wktj4TsWSwk+VL/6BWV2MvpazDzQJ82izDtat70PLbxkSlOdnjLPtpehOL
         lH9m6K19qDmN5f6e4qd9S7J3DBzPTwG4w9XUOBY9M3D/9STsLmGX3uWdf3EKm3iO9fP9
         9DuWL2jH6+WBW+MTru/juBgSSOpnSgo4hMGmbI3QV1wRTRqC901Cb9Qs1FeeuYYfT5D7
         vhdgyZXcrAem85JblzodQihO/b0fY9QEh9LGKvCsqafAikOB1eqsnN29V4eaNN6y5rIi
         elFDrUZcpwgbbfo1ZbcO61JZKM70LwRgNLKvvvHnWJ6B+0LwHI/+TRIEZ4Awjbx2VNkC
         CnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuLNgn8fMpBEx8l23HBlGlNpqXZIrWqOkEHpx7KRq8w=;
        b=sEeuyrs8BSddxCI1P0gA9wy939ufXUn3O2cVb1wjRQRDowCv/TNZK0v/AyeJw8BrQx
         wyoMdTOydXeJ1qlsPaf022mn4pwAOutWXFctepXzyeOQZouswoP68lxLP5QQy+/XLoDd
         JJPYbTAvsT0PyWTe5ljRQImG2XTOpwEfQENbyIcEodEL0dEdEwtZ6q91xExQIFXQBHD6
         hvkWIkln/OlVGEDUOPbomk/HVAq6O0/oHQRwnfL8FawG65LxQIpx9ownhKWEPN4Llag5
         ClfdLGe1Y3CSgpnjJ7mGYMU1BbIhG3xW0FT6N7eV6aHiWpSJVa4VWMEsHhvzpuP6ov0E
         OcxQ==
X-Gm-Message-State: ABuFfogNEJOaUygb3flcZ/sv4gqd4GenKrrRwkALpEvmNjO75tPQrG0+
        dZjDC7+Oi2POljps663sj50TmfxfkG2W9aKjCu//bw==
X-Google-Smtp-Source: ACcGV62ADwhSEBxN3WINPX6NH8D0xxnBe3XQsTGUIcTTxOa6hKY9jxFlakD4lCIcWjPE3ng+29u5VbaQfc9M51oO9Mg=
X-Received: by 2002:a19:d988:: with SMTP id s8-v6mr17001618lfi.122.1539140311711;
 Tue, 09 Oct 2018 19:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <1539080245-25818-2-git-send-email-svellattu@mvista.com> <20181009174428.GB2182@xps15>
In-Reply-To: <20181009174428.GB2182@xps15>
From:   Silesh C V <svellattu@mvista.com>
Date:   Wed, 10 Oct 2018 08:28:20 +0530
Message-ID: <CALabi0FgQWGL8KMpCKt9N6Kkoig77LxOsea3Oe47tk5nOH10-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] treewide: use bus_find_device_by_fwnode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Oct 9, 2018 at 11:14 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
>
> This doesn't apply on linux-next.  This late in the cycle you may want to rebase
> your work on that tree.

OK. Will send v4 after rebasing onto linux-next.

>
> Otherwise and for the coresight part:
>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>

Thanks.

Regards,
Silesh.
