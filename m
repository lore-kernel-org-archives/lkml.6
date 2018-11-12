Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F122503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAjNUMGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81F122503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeKMBL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:11:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38847 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:11:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so6437762lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yJzZzu4l/GzcmzzhCEPtk7cQimxwv9IYN7JlcYNfDqE=;
        b=dAjNUMGALkaPm2M7j6Tz5pOwFLqbvBN3sckwW/6Hj/9dE0QRv2oyla6EapAD8kHn2a
         KalIuE+V3nq+OKG4xTIuswMcWk2XbpYe8WX2uyUEePVcMsVbbSyuTRmGsy05o0kzQUn3
         kKBkpCg36DCC0oHMLzBfGaU5RRlksqGoIhmlryQVg8WqTq7IEonaSbtMRjM/99jKNa8i
         PDgwbiWoG+DJmtwgSidBGjMvsskt5CvV9KAOjMtXgi5v4Df+apozNf109SD/jeDIDXXT
         1McWokzwTcYGYyECh4fd+rpIClcMapdkmTLHE4MpuUO5qwdHzFYtpEGAhhohQB9cyAFL
         w4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJzZzu4l/GzcmzzhCEPtk7cQimxwv9IYN7JlcYNfDqE=;
        b=ZruCjShw0+eYvkH5kAfs+zmrd1vmUpzeaWS+4gpouSDfmBNRFpNUxzoO7N3XqahVMm
         R/dyD4oRHooJjAegfAXNonN3vrh/4BeWeYime7UvtSBd6mp7hLZhJ519gD3qSn29F8DA
         Gx3LQwvJRjM+2pguhgSmycBF7yk5PU9eaV6aPpCX7bOb8JwdCc0HTDPllyAA1bNp2VP4
         HCfbtiycy8ZiG8QsnAUqAbmjkAmZX5BOx7jv71SDdJ18NqPj6fSTvYDZBg1CEB135X4P
         PLC1s0mUPAzjAprcux64KnS1Tcm5HQqP+uZLGJiWzYcxzCLNWBTD19fncWRlrq8t/1p+
         p/Vw==
X-Gm-Message-State: AGRZ1gKhtuPsGGa1THXxYekyNm8lbQpQs+34I12JXQmi4vn+ZovCodNs
        Zku05tp7TItgvYpOYG2SpBk=
X-Google-Smtp-Source: AJdET5fHI2+l0GzbrIEzt+YB5hV2b8cdeW4AfXss58m6fK3MfYd4eHivCN4htFb2b9pzlrahDDHfcw==
X-Received: by 2002:a19:c954:: with SMTP id z81mr849436lff.150.1542035865866;
        Mon, 12 Nov 2018 07:17:45 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b69sm3088299lfl.28.2018.11.12.07.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:17:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMDy7-00034i-Op; Mon, 12 Nov 2018 16:17:39 +0100
Date:   Mon, 12 Nov 2018 16:17:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-apb-ctrl.c: Switch to the gpio
 descriptor interface
Message-ID: <20181112151739.GI13311@localhost>
References: <20181111054405.GA32548@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111054405.GA32548@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:14:14AM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/greybus/arche-apb-ctrl.c | 158 ++++++++++-------------
>  1 file changed, 65 insertions(+), 93 deletions(-)

> -	apb->pwrdn_gpio = of_get_named_gpio(np, "pwr-down-gpios", 0);
> -	if (apb->pwrdn_gpio < 0)
> -		dev_warn(dev, "failed to get power down gpio\n");
> +	apb->pwrdn = devm_gpiod_get(dev, "gb,pwr-down-gpios", GPIOD_OUT_LOW);
> +	if (IF_ERR(apb->pwrdn)) {

Looks like you didn't even compile test this one. :(

> +		ret = PTR_ERR(apb->pwrdn);
> +		dev_warn(dev, "Failed requesting power down GPIO: %d\n", ret);
> +		return ret;
> +	}

Johan
