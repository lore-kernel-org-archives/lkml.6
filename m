Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114BF208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo8vkOf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114BF208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeGOObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:31:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeGOObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:31:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so20124794wrt.2;
        Sun, 15 Jul 2018 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wuhkdq9p3uXH3jdQT2YcjCriTORbQIHibmu/zN1R1z0=;
        b=Jo8vkOf2JrhcV2e1D0UUUb6M+fGm42Lr6Q+hqIBgLOAHRJPYqFffPmJil2rG/do4na
         ckoS4AKrjVAyjl+5MzWoWr7vqeQVeRDoWHM9hIBTOLfSaUNotfgy+elvQaeC59nR8U1J
         8pFAk2VecC2UGOSbJyivSPSlMXLujmKS7Y/W6Obipkj7ieHywHl9nolFK0e/QboxMHlP
         M6GI1fcVDEQ5wY4b1LXEzCVAx0Uh85VOl+pooyLuvIm9Ght0+K8XNAtjKSj02SX6Kq6o
         H0GKfz7za3HgNkunjgfj3KYY7Q9yoy3s09Lndd/iOaqx7Ogyee4fLzCRe3pO688D2Bij
         xKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wuhkdq9p3uXH3jdQT2YcjCriTORbQIHibmu/zN1R1z0=;
        b=axHKWve921teKd0BuWlOVpvTOMpn4PNoX82yd29mxZ4iTundwoErnt7bL/pnEv17OH
         XrvvpWp+z1oz2cN/wFylUGuj6dECZe3eS8ySbp7uWP5s9Xm1JvHtcLLuQSe6Pru+0mrI
         RYoPL18qFmEfLTNvfNZ6hcbd03hZacoRS0V5BDVcJrES1Jwto0ogn8iaFu3orSIpTLVO
         F+6CWiz8Y5PPmdVan/3yqyQZR3A/4xGoWVfSYbqRPipHpJPUN/FU8f3hS04VJLoOb6qV
         1E2j4SP6BPCZDPRbpvhYWHY9VVKAf0p2ky3zWrAKNppGRKQsXZGHUSxZ0CMKh0tDnpXi
         jm8A==
X-Gm-Message-State: AOUpUlHHrEueJNcTie0lH6zcjFXUUfzChHMWoblfVCmIvQ95kOOlekfg
        zGA5OzQw2QAkbSeJaEvzPVU=
X-Google-Smtp-Source: AAOMgpeJOALP02N3JlpthlllmaNhGzErrkqZrB+CoptfhlGwTw/MzJViQ6M9BYGfvKIu0NEVy+4XTw==
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr9711610wrn.269.1531663694601;
        Sun, 15 Jul 2018 07:08:14 -0700 (PDT)
Received: from [192.168.2.67] (p578F0EE7.dip0.t-ipconnect.de. [87.143.14.231])
        by smtp.gmail.com with ESMTPSA id q14-v6sm10644285wmd.20.2018.07.15.07.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 07:08:13 -0700 (PDT)
Subject: Re: [RESEND PATCH v5 0/6] IR support for A83T
To:     Sean Young <sean@mess.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, p.zabel@pengutronix.de,
        andi.shyti@samsung.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <20180213122952.8420-1-embed3d@gmail.com>
 <85ddc129-d0f8-6299-dca0-81f79f3d04a9@gmail.com>
 <20180710083637.6s36rfbi2old5uxo@gofer.mess.org>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <aa2d50b1-9ff5-01e7-8202-e35dc6e039ea@gmail.com>
Date:   Sun, 15 Jul 2018 16:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180710083637.6s36rfbi2old5uxo@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that got lost...

I will resubmit / update the patches next week.

Philipp

On 10.07.2018 10:36, Sean Young wrote:
> On Fri, Mar 02, 2018 at 01:11:34PM +0100, Philipp Rossak wrote:
>>
>>
>> On 13.02.2018 13:29, Philipp Rossak wrote:
>>> This patch series adds support for the sunxi A83T ir module and enhances
>>> the sunxi-ir driver. Right now the base clock frequency for the ir driver
>>> is a hard coded define and is set to 8 MHz.
>>> This works for the most common ir receivers. On the Sinovoip Bananapi M3
>>> the ir receiver needs, a 3 MHz base clock frequency to work without
>>> problems with this driver.
>>>
>>> This patch series adds support for an optinal property that makes it able
>>> to override the default base clock frequency and enables the ir interface
>>> on the a83t and the Bananapi M3.
>>>
>>> changes since v4:
>>> * rename cir pin from cir_pins to r_cir_pin
>>> * drop unit-adress from r_cir_pin
>>> * add a83t compatible to the cir node
>>> * move muxing options to dtsi
>>> * rename cir label and reorder it in the bananpim3.dts file
>>>
>>> changes since v3:
>>> * collecting all acks & reviewd by
>>> * fixed typos
>>>
>>> changes since v2:
>>> * reorder cir pin (alphabetical)
>>> * fix typo in documentation
>>>
>>> changes since v1:
>>> * fix typos, reword Documentation
>>> * initialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' & remove if statement
>>> * change dev_info() to dev_dbg()
>>> * change naming to cir* in dts/dtsi
>>> * Added acked Ackedi-by to related patch
>>> * use whole memory block instead of registers needed + fix for h3/h5
>>>
>>> changes since rfc:
>>> * The property is now optinal. If the property is not available in
>>>     the dtb the driver uses the default base clock frequency.
>>> * the driver prints out the the selected base clock frequency.
>>> * changed devicetree property from base-clk-frequency to clock-frequency
>>>
>>> Regards,
>>> Philipp
>>>
>>> Philipp Rossak (6):
>>>     media: rc: update sunxi-ir driver to get base clock frequency from
>>>       devicetree
>>>     media: dt: bindings: Update binding documentation for sunxi IR
>>>       controller
>>>     arm: dts: sun8i: a83t: Add the cir pin for the A83T
>>>     arm: dts: sun8i: a83t: Add support for the cir interface
>>>     arm: dts: sun8i: a83t: bananapi-m3: Enable IR controller
>>>     arm: dts: sun8i: h3-h5: ir register size should be the whole memory
>>>       block
>>>
>>>    Documentation/devicetree/bindings/media/sunxi-ir.txt |  3 +++
>>>    arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |  5 +++++
>>>    arch/arm/boot/dts/sun8i-a83t.dtsi                    | 18 ++++++++++++++++++
>>>    arch/arm/boot/dts/sunxi-h3-h5.dtsi                   |  2 +-
>>>    drivers/media/rc/sunxi-cir.c                         | 19 +++++++++++--------
>>>    5 files changed, 38 insertions(+), 9 deletions(-)
>>>
>>
>> I talked yesterday with Maxime about this patch series. And he told me if
>> the first to patches got merged, he will apply the dts patches to the sunxi
>> tree.
>>
>> Sean, can you merge the first two patches through the rc-core?
> 
> So I merged the first two patches, but the rest never made it upstream.
> 
> Should they be resubmitted?
> 
> Thanks,
> 
> Sean
> 
