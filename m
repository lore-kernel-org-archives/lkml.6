Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544483789;
	bh=YfruPHxK3gq31tdMVF/8RtysSwoh5AJIOhqkQJ9Wa9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dZFhLvS6Q9wczV/9+xQg/BDrw4g64syngsz+TWw0emR6j+q4Vs950VMpsValDkgev
	 TXcjH3gsdvpx5w2B5VKhFRrVwOdxCgIHMGlZihEkIeNBJ+vqGk2m2u1B7t8zx8rh9j
	 14ZX8pxnVuP4dziEsccG50Gp3ekuPs8AINwSzqbc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeLJXQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:16:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36220 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:16:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so10501981oix.3;
        Mon, 10 Dec 2018 15:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZdIZCn0Z+N0bI+7xIvRXkPlzixl7RiQZZ2uF4EiDXww=;
        b=onM9UL21lc8i9q1LyJ045cDfDvlq5lG+KBvo4feQxIsiV8RbqHPjIOwiJ1+9wT5UYE
         kaqACgtlJLjOeyuRKLclIBUF+wZnWgafiT8UUpfA/6unwhExNm5eDar+pRrRLAgU3bPA
         AiyROZpx2sqPkU638MDFUHb460/WzQHRqS+5rZfuwS9gCxcVKXiejIzbE/8mquZ50o76
         la8qLz+hPIU09IoLQCTdeW4Wk77FXo6FBSAeF5XFFQj7QpC5cVaP7XoktCdbna2K7zuf
         EmrfEwvBJIOhqxVQ4YrspwSvZi99TE1fdpEuCTfL9QFLQvH3YTu1Ul7/PGHMsZ4sKDBe
         T+QQ==
X-Gm-Message-State: AA+aEWY9DAH5efxh3hGnuDXl5NIooWvOa160j2LlTKwLS86k1S8eEvU/
        tDb2Rh/90BG4IOhMkw2dJg==
X-Google-Smtp-Source: AFSGD/VHNJzlUgfc4sAjQNiSat7GpjVsh7gqaH2ljxU3J7VinMUqz/+l2TI2zLdOuYwQNTHiftMdhA==
X-Received: by 2002:aca:5d57:: with SMTP id r84mr11623oib.243.1544483786696;
        Mon, 10 Dec 2018 15:16:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm8688151otj.2.2018.12.10.15.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:16:25 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:16:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output  between PWM and GPIO
Message-ID: <20181210231625.GA30721@bogus>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 13:41:30 +0000, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= wrote:
> Output of the PWM block on i.MX SoCs is always low when the block is
> disabled. This can cause issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle = 0% corresponds to high level on
> the output. Now, when PWM is disabled its output instantly goes low
> which corresponds to duty cycle = 100%.
> 
> To get a truly inverted PWM output two pinctrl states of the PWM pin
> can be used. Configure the pin to GPIO function when PWM is disabled
> and switch back to PWM function whenever non-zero duty cycle is needed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Slightly different description of the pinctrl and pwm-gpio.
> 
> Changes in v2:
>  - Do not use the "default" pinctrl state for GPIO.
>  - Use two new "pwm" and "gpio" pinctrl states.
>  - Add a new pwm-gpios signal.
> 
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 49 +++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
