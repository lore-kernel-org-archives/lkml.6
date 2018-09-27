Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201E20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7201E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeI0P0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:26:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40143 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeI0P0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:26:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id e9-v6so1907887qtp.7;
        Thu, 27 Sep 2018 02:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkwvlU1siNswCCz3XnJx7i4xL16Ww3Vfcyoy5r64mF4=;
        b=bq2TPeXSJVUrNQZ6GVj7tWVFBKUewFaj04hEZopXGysAUK+zg9j6TRYl4AxoxZcrfT
         t2sCzUtGiKbJYlEAzICFjrwGvG+SUU0xlu1hxMNfchmIbdzJIgg//V+Tk/6sDZbZjTMB
         oUYAKE6IpP54lhHKwp8JbyAFv2j5d2EA7+zR6giVT3HyfKEU7uj2B6bVbHgRCoTFi+ul
         5ubE4Ux4gSL2Heubn6h5CdfuUMWnI32S0e7d+ESnAP87HKtabYCgBX+Utnj5nHB+FL6n
         kEqY9mhK4FvRYADaUisu3dfgOdVnK9fZakbpvOI3aoRH9LO9JmWxic0rJN7uESuCP1bs
         KfHA==
X-Gm-Message-State: ABuFfoiBcYFLkGlxeDQlAa4sESsSPHOQsRJ7fQsNIgVqUCQa8//tFmlA
        IUM9VASmTKInGPF8C6zKQt4gROTlM9V2FkkLXeE=
X-Google-Smtp-Source: ACcGV61EHa315fbzH5oHPM0hP5hQyG7bbu88ommYCVBL3Cet9XrnIcBEjMzmX5IZYHGYco4RA0REZRSIieiWDfl6dpw=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr7742004qtb.75.1538039335598;
 Thu, 27 Sep 2018 02:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com> <1538000414-24873-3-git-send-email-alcooperx@gmail.com>
In-Reply-To: <1538000414-24873-3-git-send-email-alcooperx@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 27 Sep 2018 11:08:39 +0200
Message-ID: <CAK8P3a0rN=E7vnK3Ri8srXBDT7cdsVj-n=G6VGBROc0o8vrcpw@mail.gmail.com>
Subject: Re: [PATCH 2/5] usb: host: Add OHCI driver for Broadcom STB SoCs
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        sunjianguo1@huawei.com, James Hogan <jhogan@kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        USB list <linux-usb@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:20 AM Al Cooper <alcooperx@gmail.com> wrote:
>
> This driver enables USB OHCI on Broadcom ARM and MIPS STB SoCs.
> The drivers depend on a matching "brcm,brcmstb-usb-phy"
> Broadcom STB USB Phy driver.
>
> The standard platform driver can't be used because of differences
> in PHY and Clock handling. The standard PHY handling in hcd.c will
> do a phy_exit/phy_init on suspend/resume and this will end up
> shutting down the PHYs to the point that the host controller
> registers are no longer accessible and will cause suspend to crash.
> The clocks specified in device tree for these drivers are not
> available in mainline so instead of returning EPROBE_DEFER when
> the specified clock is not found and eventually failing probe,
> the clock pointer is set to NULL which disables all clock handling.

Both of these sound like fairly minor differences, I wonder if the
generic code could be adapted to have a special case for these
rather than duplicating it.

        Arnd
