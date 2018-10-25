Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055852084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="HBquxzpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055852084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJZAEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:04:44 -0400
Received: from vern.gendns.com ([206.190.152.46]:36550 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeJZAEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SQL/7z0T1FppHZ3MDprYYl9iB96lWCcenFVBmGSkzoQ=; b=HBquxzprUZlsuSIxaZREkFNVbV
        R6pTEfAizgjkR9HjxKyEAVJpfC1iRC9TD6rsniM82ezPM1Fa2F3t9nCwOPj/aF3QcsZcVAlbH4aB9
        GxdOu+nj6eegwL3hHM+JZjwtJLANTqFBMfyPkHePKVKn1TYtMFZ2eSaZHOqusmPyV3r6/+/+plSV7
        PSwxv8djvZEu1ga8NhrywOkOOSLaSuFesNzxHVwnl/BBcrWCfY2HzhNpjd7WQZLf0cX2gkO0fS9SR
        RnFSh8SBBjukeXNWsB6Do3xj7bQWgTSX1da0mKlULwGrGiTyd+n+3OPcvJuVbvaBeh9hU2X7mf9Hn
        B6mI8djg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48694 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gFhb0-007wD6-Dd; Thu, 25 Oct 2018 11:30:50 -0400
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
To:     thesven73@gmail.com, svendev@arcx.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181025135515.8397-1-TheSven73@googlemail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <68f2d881-0c22-60e3-e79f-b8c7c2c02d06@lechnology.com>
Date:   Thu, 25 Oct 2018 10:30:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025135515.8397-1-TheSven73@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 08:55 AM, thesven73@gmail.com wrote:
> Hi Linus, thank you for the patch review !!
> 
>>> +  - pwms : the pwm connected to the bridge's 'pwm input'.
>>
>> That is really unintuitive and needs a detailed explanation. What
>> is a bridge doing with a PWM? Is it 100% certain this is a PWM,
>> it's not just a .... clock? A pwm is a pule WIDTH modulator and
>> I can't for my life understand why a bus bridge needs a signal
>> with variable pulse width, but surprise me! :D
> 
> You are 100% correct, this is a clock !
> The hardware designers attached the bridge's clock input to an iMX pwm output,
> and instructed us to provide a clock with 50% duty cycle and a certain freq.
> 
> The only way I know to activate a pwm is to connect it to a driver in the fdt,
> then inside the driver enable the pwm, like so:
> 
> +       /* PWM */
> +       pwm = devm_pwm_get(dev, NULL);
> +       if (IS_ERR(pwm)) {
> +               dev_err(dev, "pwm not found\n");
> +               return -EINVAL;
> +       }
> +       pwm_get_args(pwm, &pargs);
> +       period = pargs.period;
> +       err = pwm_config(pwm, period/2, period);
> +       if (err)
> +               return err;
> +       err = pwm_enable(pwm);
> +       if (err)
> +               return err;
> 
> This is why the bridge driver has a dependency on a pwm.
> If the pwm could be enabled individually, I could drop this dependency.
> Can you think of a way?


How about using the pwm-clock device tree binding to turn the PWM into
a clock?

Documentation/devicetree/bindings/clock/pwm-clock.txt
