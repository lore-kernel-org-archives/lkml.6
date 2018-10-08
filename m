Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A78C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0D02077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qADtR4ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0D02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJHW6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeJHW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:58:04 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7312089D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539013543;
        bh=aeO375vpQoLl1PIcym8THOpO/5v4VDhXcJA/T06EaTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qADtR4typq6W1s6MrXD952wA9QbpjxTuM9FO/qCqXZ2C9Zcjp4vExOH1KO1ouLqvP
         uX8dc4yERjbrIcR2ctidA52ogFBj5OW3HJLSjrtjZZP5bz/2qT+DN9T4KhOg7NEzQn
         2NbwbYv7XaZHF6GChGN2SRqAVdijxXXBw9J/ruuk=
Received: by mail-qt1-f173.google.com with SMTP id b4-v6so13357874qtc.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:45:43 -0700 (PDT)
X-Gm-Message-State: ABuFfoiUpPNnJXPXKSb8zA6thZ60L1F4fldgdXqhic9JKwq0hrrF5lZ5
        np5woWh9t1qLfmVkm3c5u/kH1cR4MFPP8dvq2g==
X-Google-Smtp-Source: ACcGV60HJ9AGuQrKnmoMHY5mez8uzvLMNhIS8aW3t6uFsYcLtmNpxBhv+HocZKzlp4GxXNmYFcmyw/eIoZeD5qvo8G0=
X-Received: by 2002:a0c:b5d3:: with SMTP id o19-v6mr20108265qvf.218.1539013542852;
 Mon, 08 Oct 2018 08:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALabi0E=hBjzxarFcvSTtod4x4=efM+HcHKR8J3-i-+K2ntH=w@mail.gmail.com>
 <1537861288-3293-1-git-send-email-svellattu@mvista.com>
In-Reply-To: <1537861288-3293-1-git-send-email-svellattu@mvista.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 8 Oct 2018 10:45:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKwr-oVc126vYyTR16d_EQarZRTqvB8KHoUR2QrJbEP3g@mail.gmail.com>
Message-ID: <CAL_JsqKwr-oVc126vYyTR16d_EQarZRTqvB8KHoUR2QrJbEP3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] treewide: use bus_find_device_by_fwnode
To:     svellattu@mvista.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future, please use get_maintainers.pl and send to the right
lists and people. Perhaps the coresight, i2c, network, nvmem and spi
maintainers would like to see and be aware of this change.

On Tue, Sep 25, 2018 at 2:42 AM Silesh C V <svellattu@mvista.com> wrote:
>
> Use bus_find_device_by_fwnode helper to find the device having a
> specific firmware node on a bus.
>
> Signed-off-by: Silesh C V <svellattu@mvista.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c         | 14 ++++----------
>  drivers/i2c/i2c-core-of.c                          |  9 ++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  8 +-------
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  8 +-------
>  drivers/nvmem/core.c                               |  7 +------
>  drivers/of/of_mdio.c                               |  8 +-------
>  drivers/of/platform.c                              |  7 +------
>  drivers/spi/spi.c                                  | 10 +++-------
>  8 files changed, 14 insertions(+), 57 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
