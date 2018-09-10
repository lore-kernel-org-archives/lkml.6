Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFEF204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFEF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeIJNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:36:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbeIJNgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:36:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B3AA18A;
        Mon, 10 Sep 2018 01:43:35 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47CCD3F557;
        Mon, 10 Sep 2018 01:43:29 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt@codeblueprint.co.uk, hkallweit1@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, rajanv@xilinx.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Olof Johansson <olof@lixom.net>, Jolly Shah <jolly.shah@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <64fbd7ca-48a8-7cb0-af3a-131ee61aef5a@arm.com>
Date:   Mon, 10 Sep 2018 09:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/18 02:18, Olof Johansson wrote:
> Hi,
> 
> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>> From: Rajan Vaja <rajanv@xilinx.com>
>>
>> Add ZynqMP firmware IOCTL API to control and configure
>> devices like PLLs, SD, Gem, etc.
>>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> 
> This patch worries me somewhat. It's a transparent pass-through ioctl
> driver. Is there a spec available for what the implemented IOCTLs are?
> 
> Should some of them be proper drivers instead of an opaque
> pass-through like this? Could some of them have stability impact on
> the platform such that there are security concerns and the list of
> arguments should somehow be sanitized?
> 
> What's the intended usecase anyway? Just a debug tool during
> development, or something that you expect heavy use of by some
> userspace middleware?
> 

Thanks for pointing this out. My earlier attempts were ignored[1]
and I gave up.

-- 
Regards,
Sudeep

[1] https://lkml.org/lkml/2018/5/10/298
