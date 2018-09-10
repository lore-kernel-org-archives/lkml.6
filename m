Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE6EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbYvqaO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A9B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeIJVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbeIJVMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:12:12 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC4D20882;
        Mon, 10 Sep 2018 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536596242;
        bh=xVT+Ejqc16oKg4jJputOgTk5Bgj4CitP/rSNjv25QCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LbYvqaO4RweiYLxGMGLjInwI2T+/V2l3k1LHSLUYLMXPoV70te2oTZ+S9OiAPGcWN
         mIvxxDd0M98NPHlodgn1MdMHUOtR9Eq/TYXQQf0AAQPTdmJnHWJVfaxdfm2aju7yla
         hWyLJjuTgHEDRj/vd4hSUtCYO5DZdly6oDSAwoos=
Received: by mail-qt0-f173.google.com with SMTP id g44-v6so24770469qtb.12;
        Mon, 10 Sep 2018 09:17:22 -0700 (PDT)
X-Gm-Message-State: APzg51Ds5XDV55maR1ZXURKP7fYIDv47I1440sFW6TEovx2v7XIUg0c9
        01iCP2RiPCrMbCdmsgevoDrY3v7Cpu4ms4DKGg==
X-Google-Smtp-Source: ANB0VdZkaC9eHyZ1jEi01HcW2oqRwIaQ7wJRa11oaKVBklrWHg51N9IRpsnqP8uT4JMPOHELWn3+bIQkVhEZwAfgUYg=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr15242471qvk.90.1536596241321;
 Mon, 10 Sep 2018 09:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com> <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Sep 2018 11:17:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4qwipnhhT=n3-sqh1rRXU4McJjR6WEAp+Tvnjvb5osw@mail.gmail.com>
Message-ID: <CAL_JsqK4qwipnhhT=n3-sqh1rRXU4McJjR6WEAp+Tvnjvb5osw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
To:     christianshewitt@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:16 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>

ttyAML1 has nothing to do with dts files.

> This change adds the uart_A used by the brmcfmac sdio module in the
> WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
> an alias (without it, BT is not working) so this is also included.

You should fix the alias being required. It should not be.

> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
