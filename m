Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B21CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4FF2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546892935;
	bh=uSoVt06IV64wjH7+r0GUBF35PXC2qUECsctnXaEn//4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S5ZW1Ig9XUZHjZ71mnzCwQCIhnlQzHQNOnpGBjHTujnwKJnyUN5aQWPAXBD8C7csV
	 feMjjGsd8L30nFxdnPbNedZtTB8qv9sdgTD4KZ3UP0uZHswpUZomoBRNRz/fQC9uGV
	 7iycBMtVP9LAql1fOf3b2jyPBTnNv7fE6pH4y86E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAGU2y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:28:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40742 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:28:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2132475edr.7;
        Mon, 07 Jan 2019 12:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5FUUy9QxOAvNRrn5yLSmlniZufkJ2IedBnmLzKvsHUY=;
        b=opl6Hxw4Ahw052sghIJfTXmfjb5JxqTtSxSi4mbSWV6q7qUy7Lom1rfQjIJc7luO/v
         1Ujo7ABGX16tXBgdWsTf33RRXX2dFRb/aOAw4cR3FpydrMrKROG71yeKHtW8i08rJuIm
         DNe+opF+8KqIa+hzTxuvOhDMOy0B0DK6qkZvvifomYZ0P1vhs+yFnqT+R+9W3vRAh/QY
         yh1cRIEOzsVOFGBH6bUOK0F9K8znr4WRB/22h7mJIwN/EvGz/dOo+DqLMApXnrjuOqBU
         N2IYVl+2G6sNYhmwB0WsB1zIh82x7lLHIaUEfS596GNDcHMqM3IanWlEh4xvaPENJwvm
         tyDg==
X-Gm-Message-State: AA+aEWaWaKgk7ljLM6vkpLvoJP6dlC+CEEMjaiV2o+5GM0VItpF00TaT
        RqOA+0wJudX/ty+1zRqJCfbCZ1HeIZk=
X-Google-Smtp-Source: AFSGD/W/pQSSnN79S40lIwsXQcy9RiqXDfJgZX5EruRIrCPU/s6LCQFeGElVQD/Qi2Ap5W9rz8iJHg==
X-Received: by 2002:a17:906:828b:: with SMTP id h11-v6mr47378031ejx.115.1546892931594;
        Mon, 07 Jan 2019 12:28:51 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id v20sm31461549edm.29.2019.01.07.12.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:28:50 -0800 (PST)
Date:   Mon, 7 Jan 2019 21:28:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
Message-ID: <20190107202848.GA21920@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:14PM +0100, Paweł Chmiel wrote:
> Since we have separate compatible for our SOC,
> let's use it rather using one from exynos4210.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 2 +-

Thanks, applied.

Best regards,
Krzysztof

