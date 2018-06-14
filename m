Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A41CEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593A4208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fg4qGBAS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hBaf01Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593A4208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeFNGVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:21:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeFNGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:20:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CEB56055D; Thu, 14 Jun 2018 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957226;
        bh=9Q7Ofx0OLqr2GZt8WobQLmAYVHTjQRhBL9DIpzNbDes=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fg4qGBASjqG+QuuazvVnx9Lu1L0kVeu0w0uyf49eCgnYtddGuvmGE/OvY3vQfEP6M
         9wKOPzHaDHfbO8jFAytJOO6ZItAY+h1OvcgQcbZrO/40EKq9cPk4deSAeejCGnCDS0
         nfo8keuU40rwIOuapR0xyJWUPtUDwf/0i1zidh8U=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 996EB60116;
        Thu, 14 Jun 2018 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528957224;
        bh=9Q7Ofx0OLqr2GZt8WobQLmAYVHTjQRhBL9DIpzNbDes=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hBaf01PasweG/mjStVHeur3zdGJDJFp30lL8S/PT+aa0A/UhiJjWq5WTqIZIKyA2T
         nuLyH/lis1DdWDIVhWcUXPc5nZFjjzFEpIipvFz/xqoyJwqhFjHXGydV3i5oxA1jRb
         aEKUQeJj3keHP5P8MKIeJD03OGSUVOpkGv/2MNyg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 996EB60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, Eyal Reizer <eyalr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-wireless@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
References: <20180613180321.16745-1-ryan@edited.us>
        <CALAqxLWuUJYfXszaO01KODbom8WykKQKm0X3fzPTwSRK+G3zqw@mail.gmail.com>
Date:   Thu, 14 Jun 2018 09:20:18 +0300
In-Reply-To: <CALAqxLWuUJYfXszaO01KODbom8WykKQKm0X3fzPTwSRK+G3zqw@mail.gmail.com>
        (John Stultz's message of "Wed, 13 Jun 2018 12:36:40 -0700")
Message-ID: <874li5c2jh.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz <john.stultz@linaro.org> writes:

> On Wed, Jun 13, 2018 at 11:03 AM, Ryan Grachek <ryan@edited.us> wrote:
>> These properties are required for compatibility with runtime PM.
>> Without these properties, MMC host controller will not be aware
>> of power capabilities. When the wlcore driver attempts to power
>> on the device, it will erroneously fail with -EACCES. This fixes
>> a regression found here: https://lkml.org/lkml/2018/6/12/930
>>
>> Signed-off-by: Ryan Grachek <ryan@edited.us>
>
> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> Tested-by: John Stultz <john.stultz@linaro.org>
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> Wei Xu: This also fixes a functional regression with wifi on the
> HiKey960 board that was introduced in 4.18-rc with commit 60f36637bbbd
> ("wlcore: sdio: allow pm to handle sdio power").
>
> Could you please be sure to queue this for the 4.18-rc too?

CCing wireless folks as well.

-- 
Kalle Valo
