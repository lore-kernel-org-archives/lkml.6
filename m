Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B62CFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619F6208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LPTf9j5s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g605IYLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619F6208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbeFMSxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:53:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFMSxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:53:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24D0360385; Wed, 13 Jun 2018 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528916019;
        bh=W5FRghg4zx/HbWPx294DPBbbPXhUiuJDO2DhtQAdwYk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LPTf9j5sQ5HROGKaYVqex+5NQhbGuFHOXT0yiU+YpicNlaulw9wV3AGdzYtuhJvyb
         szBFBbF84l72o8Me96uho7FG3O8z/XrxAeciAGRws5pMulPiATYlrQL8G0jhCHv4qi
         pWs4fvXs4MZjmUA1yviNwbWhiU+AOPgRNRc2X/XY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 536DD601D2;
        Wed, 13 Jun 2018 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528916018;
        bh=W5FRghg4zx/HbWPx294DPBbbPXhUiuJDO2DhtQAdwYk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g605IYLbGoCht5um2CEll+cXa/NuqrXQBkWBT3AgXwAewXOMlrZsi2MIuVE69PqTQ
         hJLVlSbHBg9WfTjR0j64stQmAlAqG71Y3qbMUCaOgiHXotdfsmH2DGAC5Zg4/ko/PR
         G+6+OU4RDRRCi8vgUnVv9QP4DJycWHR0UfvbVB0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 536DD601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eyal Reizer <eyalr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
References: <20180613151305.17240-1-ryan@edited.us>
        <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
Date:   Wed, 13 Jun 2018 21:53:32 +0300
In-Reply-To: <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
        (John Stultz's message of "Wed, 13 Jun 2018 11:30:00 -0700")
Message-ID: <87tvq6a577.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz <john.stultz@linaro.org> writes:

> On Wed, Jun 13, 2018 at 8:13 AM, Ryan Grachek <ryan@edited.us> wrote:
>> These properties are required for compatibility with runtime PM.
>> Without these properties, MMC host controller will not be aware
>> of power capabilities. When the wlcore driver attempts to power
>> on the device, it will erroneously fail with -EACCES.
>>
>> Signed-off-by: Ryan Grachek <ryan@edited.us>
>
> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> Tested-by: John Stultz <john.stultz@linaro.org>
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> Wei Xu: This fixes a functional regression with wifi on the HiKey
> board that was introduced in 4.18-rc with commit 60f36637bbbd
> ("wlcore: sdio: allow pm to handle sdio power").
>
> Could you please be sure to queue this for the 4.18-rc ?

Adding linux-wireless so that wireless folks are aware of this wlcore
regression fix as well.

-- 
Kalle Valo
