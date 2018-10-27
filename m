Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4ABC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C54204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Rrw+JwLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C54204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeJ1Csh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:48:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39149 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeJ1Csh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:48:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id a28-v6so1033811ljd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ndG2gjPSJLdhIJWrsF1oAactEiKBZrwLKYFtS9jXhCI=;
        b=Rrw+JwLDGlKQy13vt4x5B0rPO/pn+qXdVgVVxNMkiWu5HkASxhpaTA3SgkKDOnB1Zk
         XfJj6WWaW8eoPvks0xfXVC7iKhpxXUOKC1NZU3ByCYwEk5fNzILezkZ2kX3cciOvzR/+
         h+9wx8aBolpeksHcTurjUDd3DIVXceL7Yag8oKnMABqvRPShyyk+da2fbzqGsn7pOF9L
         9DNsAzRupJchXIomuq+2JE4vxJxlryL9wvXcOdJrLogctsClIGNjDXbSmXR4GOD0o7KR
         HAENzBOxMRiWl+Iz22cqoHiT2LG83eIKxgTErx6jaLKlVuGcsoBTkGdsWjXKcharGwZ6
         ZD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ndG2gjPSJLdhIJWrsF1oAactEiKBZrwLKYFtS9jXhCI=;
        b=LvlrIcjn0TaIpxvlhz450vDOUbau+O7+PI5M7twSNLTFfQvDi9102CX9ELoXP270Z/
         BZM/ZB8b/ddTFgS8QnTpwK9lz0Rfro9vvlEDpQifyXC2I84YuZQmdE5lv4iOJOVN4US5
         JVUQOgrAc9dtybvwypLpAzDlC9uUqraXu5Y8cm+A5zRH0n8mqJlnoXqqu9L+uuHWIsZT
         EOWTcOtpV4cf1FNLqPRbqZqbH3pSoqaUQ3mBSJl38zbRzUqoGP3OCdsq2O1sAz+/Egvh
         MGrM36cywx/eW0nEGh0KJmePA5PCOFoPuqLTswrvXgO1rIZbjQuGkCbid7sIEzEUd9tD
         5kJQ==
X-Gm-Message-State: AGRZ1gLW+MQ5wx/SXmjYQLiOkPGdolnh4SuaoDfyhyCowgdJwpC+MxB6
        MATtHvp/OLy5e64HDkDB6t4AoQ==
X-Google-Smtp-Source: AJdET5fVGfQrGK4HAnllICfK/Tp52MkvDH4UOOLFEy1svYGOuwcvIlOoQ7lyb5zOhK16w0b25AC+Gw==
X-Received: by 2002:a2e:2a46:: with SMTP id q67-v6mr3720269ljq.38.1540663608978;
        Sat, 27 Oct 2018 11:06:48 -0700 (PDT)
Received: from [192.168.0.200] ([31.173.82.232])
        by smtp.gmail.com with ESMTPSA id b21-v6sm2275792lfi.17.2018.10.27.11.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 11:06:48 -0700 (PDT)
Subject: Re: [PATCH 03/10] dt-bindings: misc: Add bindings for HiSilicon usb
 hub and data role switch functionality on HiKey960
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-4-chenyu56@huawei.com>
Cc:     suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4872a689-bfdd-a8c1-f2cf-a2bba9e91fa9@cogentembedded.com>
Date:   Sat, 27 Oct 2018 21:06:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181027095820.40056-4-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2018 12:58, Yu Chen wrote:

> This patch adds binding documentation to support usb hub and usb
> data role switch of Hisilicon HiKey&HiKey960 Board.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  .../bindings/misc/hisilicon-hikey-usb.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> new file mode 100644
> index 000000000000..f94e990362c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> @@ -0,0 +1,24 @@
> +Support usb hub and usb data role switch of Hisilicon HiKey&HiKey960 Board.
> +
> +-----------------------------
> +
> +Required properties:
> +- compatible: "hisilicon,gpio_hubv1","hisilicon,hikey960_usb"
> +- typc_vbus_int_gpio,typec-gpios: gpio to control the vbus of typeC port
> +- typc_vbus_enable_val: gpio value that enable the vbus of typeC port

    The part of the prop name preceding the comma is supposed to be vendor prefix.
Also hyphens are preferred to underscores.

> +- otg_gpio: gpio to switch DP&DM between the hub and typeC port
> +- hub_vdd33_en_gpio: gpio to enable the power of hub
> +- pinctrl-0: pinctrl config
[...]

MBR, Sergei


