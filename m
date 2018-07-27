Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57420873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE57420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeG0Ibz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:31:55 -0400
Received: from regular1.263xmail.com ([211.150.99.133]:47654 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0Ibz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:31:55 -0400
Received: from djw?t-chip.com.cn (unknown [192.168.167.239])
        by regular1.263xmail.com (Postfix) with ESMTP id 503EA283;
        Fri, 27 Jul 2018 15:11:09 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id AA2EA3B2;
        Fri, 27 Jul 2018 15:10:59 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: ezequiel@collabora.com
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <63236d72e6470db072b80876bcfbe51b>
X-ATTACHMENT-NUM: 0
X-SENDER: djw@t-chip.com.cn
X-DNS-TYPE: 0
Received: from localhost (unknown [183.57.25.242])
        by smtp.263.net (Postfix) whith ESMTP id 22862TZW6Y;
        Fri, 27 Jul 2018 15:11:03 +0800 (CST)
From:   djw@t-chip.com.cn
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     djw@t-chip.com.cn, linux-rockchip@lists.infradead.org,
        Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: add support for ROC-RK3399-PC board
References: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
        <cd4706970b40b49373ad169e3f9651f29508194a.camel@collabora.com>
Date:   Fri, 27 Jul 2018 15:10:32 +0800
In-Reply-To: <cd4706970b40b49373ad169e3f9651f29508194a.camel@collabora.com>
        (Ezequiel Garcia's message of "Thu, 26 Jul 2018 10:41:58 -0300")
Message-ID: <871sbpm9w7.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ezequiel Garcia <ezequiel@collabora.com> writes:

> On Thu, 2018-07-26 at 15:13 +0800, djw@t-chip.com.cn wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>> 
>> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
>> computer with USB 3.0 and Gigabit Ethernet in a form factor
>> compatible with the Raspberry Pi. It is based on the Rockchip
>> RK3399 SoC, powered by the Type-C port.
>> 
>> The devicetree currently supports peripherals of:
>> 
>> - Ethernet
>> - HDMI
>> - SD Card
>> - UART2 debug
>> - TYPE-C
>
> Hi Levin,
>
> Last time I tried to make the mainline fusb driver work, it really didn't.
> Is USB 3.0 Type-C actually working with mainline on this board?
>
> Thanks!
> Eze

That's what I added in the end:

  USB3 in type-c port currently only works with normal orientation,
  not flip one.

Adding 'extcon=<&fusb0>' to make the dwc3 core failed to initialize.

Regards,
Levin

