Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B17C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1421720824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4gFDdQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1421720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeJ3Dj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:39:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38052 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeJ3Dj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:39:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so3505389wmh.3;
        Mon, 29 Oct 2018 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/8uiv9/vWgybD1QFLYZgnSt3onBdRFwaOzmp8iqGht4=;
        b=a4gFDdQqdFcN5jbwjTr9oZzjo4km6iq6jW2S1HObI+yU7kVCi9HVGhZi3Sevl5lsrC
         hjo15G4tot+TxF8LgzBYSXcVqX88VbPwPTOgCbOkB0XnjKQKJGIBCJk1BlLG36+13Ihl
         q0MAdF5jRfaNx2PfFp5rs/UejvMra4C2zSUSKbdhgByufGAvR4ItxC6LCI9lpD1epUTG
         SraiaPPyA9PDbmL2Cbl1PIL0aXeABKtEUycHrvjqYMbp4H94kDBGHaaNwBhn3o9WK8wV
         1wZllqDmS+NtabnDm2kSVdXeyYqJ7MdZkVglkTWJZMHLjglc0OVWkZk3jBiKn7LovY87
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/8uiv9/vWgybD1QFLYZgnSt3onBdRFwaOzmp8iqGht4=;
        b=gtJFpXIsnHIu9bQGP2ujGFd+i1jqWOcil0ddWTH0/6+eOQg64LZTAvfAjnBqf8ogYY
         dh0Ot3cQDxLWSAl0bDc4wH1ieaLFSqidCLlaXE4O3li/LZNKFxn5Z+5icWjsi9ZIWGvc
         mD9R4bQMpPzGfD3g6zfOlkFS1YHlqX6LVEV3CiYJVhfmYoINeE/bhPR/5AtNdg4By4Qo
         Z1Bak8WVpd3r8onHnJfgL+FMJaS6mJlG9bjzIDCjXAla+4crt66HNWp2L/5N4klJz8ZJ
         M+1sbteZBjlT8+amvBXkCvYZRBG+HAT6igjiIQwTzgn5bsp8jdqa378xEdOJZIAVUWrc
         ce/w==
X-Gm-Message-State: AGRZ1gJbTl3CxaA4oSm1nZ8c3Vk46yAq3SXs3+2Lrln7QX7UqSSwXi/2
        h/nUXdgywIkzRn6ut9EYV0g=
X-Google-Smtp-Source: AJdET5dH88dFU8TlkbGslieQe0HYLgfKHGL1gRZv1ZJgsCraYBVHzgavf/PdNui/MgODUfQFw5Axzw==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10-v6mr12119129wmh.111.1540838970087;
        Mon, 29 Oct 2018 11:49:30 -0700 (PDT)
Received: from ?IPv6:2a02:8071:6a3:700:65d5:fcea:31c5:30bf? ([2a02:8071:6a3:700:65d5:fcea:31c5:30bf])
        by smtp.gmail.com with ESMTPSA id m16sm15851825wrx.75.2018.10.29.11.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:49:28 -0700 (PDT)
Subject: Re: [PATCH] arm: dts: socfpga*.dts*: use SPDX-License-Identifier
To:     Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Graham Moore <grmoore@opensource.altera.com>
References: <20181023190853.23252-1-simon.k.r.goldschmidt@gmail.com>
 <b7790735-c797-a5e3-ccf5-01080f652945@kernel.org>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <941ecf8f-ddf7-01f9-1eb8-4b3e33f71efd@gmail.com>
Date:   Mon, 29 Oct 2018 19:49:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b7790735-c797-a5e3-ccf5-01080f652945@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2018 16:33, Dinh Nguyen wrote:
> Hi Simon,
>
> On 10/23/2018 02:08 PM, Simon Goldschmidt wrote:
>> Follow the recent trend for the license description.
>>
>> This is also in an effort to fully sync the devicetrees with U-Boot.
>>
>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>> ---
>>   arch/arm/boot/dts/socfpga.dtsi                | 16 +------
>>   arch/arm/boot/dts/socfpga_arria10.dtsi        | 13 +-----
>>   arch/arm/boot/dts/socfpga_arria10_socdk.dtsi  | 14 +-----
>>   .../boot/dts/socfpga_arria10_socdk_nand.dts   | 13 +-----
>>   .../boot/dts/socfpga_arria10_socdk_qspi.dts   | 13 +-----
>>   .../boot/dts/socfpga_arria10_socdk_sdmmc.dts  | 14 +-----
>>   arch/arm/boot/dts/socfpga_arria5.dtsi         | 15 +-----
>>   arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 16 +------
>>   arch/arm/boot/dts/socfpga_cyclone5.dtsi       | 16 +------
>>   .../dts/socfpga_cyclone5_de0_nano_soc.dts     | 13 +-----
>>   arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 14 +-----
>>   arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 14 +-----
>>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 16 +------
>>   arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 16 +------
>>   .../boot/dts/socfpga_cyclone5_socrates.dts    | 16 +------
>>   arch/arm/boot/dts/socfpga_cyclone5_sodia.dts  | 16 +------
>>   .../boot/dts/socfpga_cyclone5_vining_fpga.dts | 46 +------------------
>>   arch/arm/boot/dts/socfpga_vt.dts              | 16 +------
>>   18 files changed, 28 insertions(+), 269 deletions(-)
>>
> error: arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts: does not
> exist in index
>
> Can you please rebase this patch after v4.20-rc1 has landed? The above
> board filename has been changed.
>
> Thanks,
> Dinh
>

Sure, I'll do that.

Simon
