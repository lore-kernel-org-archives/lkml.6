Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9158E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkzf1A/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfA2Lfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:35:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2Lfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:35:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so21637871wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ORO3TrKIAzWO9aB3kfS29wajMpwl+h68Pqs9BM8uZZc=;
        b=jkzf1A/26NQR9QbSxW/vRKTUNlvjfwNOu2meqBjoEF1YEnQSAehLX9bLV+OU4gCjsj
         IM7f/SZnZFb/VY+t9LwiKYhoc+pRn9qS88B5iPTsKvKkqZJzB4ZO96vFTwhRJ1V6GMoq
         6OLZ0ftl1eqzKEea3j2W0qcV5SrkL02ggrlag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ORO3TrKIAzWO9aB3kfS29wajMpwl+h68Pqs9BM8uZZc=;
        b=pKcX4D1i15YwBJyDcIECj9k4QxXwtY2LCiNwgloa1ZvFBceWG6bpMa7XxN47G1z3dM
         hPxwZC45jiaYKVGlrGqz4IcpqMYEHubAhVoUBNywMNpbpTGarEnY3Bhw1KVZRQWS/uAh
         fzo204DU3P1Zkz20xiTDSiWno6krrRap9Zn0qt47BZcAl/5zLV+y5wRsx6mRJOA8khGz
         48lZxNHJrUyn3Q0VvEC08YM4JS/qhrnJ/9yOboHsdli5tiOV80rc3PRMwGIIiU9fKEIm
         dTEQZGgAVEwjKia4f6y0qBviRxNp2DF21HGlxZs+HWq2/Q9acljKZXSzhMp5LCJ/Pi0C
         /Ytw==
X-Gm-Message-State: AJcUukcKUPtKQ9OW6mp6gmfco6BLI/z1vWTSK48w2VYmcP6ISZOMv5cJ
        qh7l2Ey5ya78BeYC12I73JWrq+Bhzqk=
X-Google-Smtp-Source: ALg8bN4a89C6jq8KN6PcrOH14w1gVu95yk9V5lVBMG7DbTmb/RN8INqzNxIYV2jUgaNsjXA1gvo4/g==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr25166014wrr.201.1548761735405;
        Tue, 29 Jan 2019 03:35:35 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id d4sm134848239wrp.89.2019.01.29.03.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:35:34 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:35:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v3] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190129113532.GB24070@dell>
References: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019, Andrew Lunn wrote:

> The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> MFD which will instantiate the individual drivers.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
> 
> Drop setting i2c bus speed, which removes the build dependencies on
> the i2c ocores patches. This can be added back later.
> 
> v3
> --

You're going to have to resend this.

Mailers tend to use '--\n' to signify the start of the mail signature
(see mine as an example), so when someone (myself included) attempts
to reply to the mail, it is likely that their mailer will chop
everything from there down.

Please submit a [RESEND] with it removed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
