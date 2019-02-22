Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF420C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C120651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550876211;
	bh=PcIqB+aVAFyVSwW0dREdhZaR0Ihyl/7OoK9Kw1XUJFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ck/USCNqsaDshXmi8jxMg4r+TicHO34YRBU+KZOU69DOLTAT0+Jvk+UxsRoztKqQf
	 /TTczv6Dt6ZdaB5wHmwX3s2UArbQj+89Xet8NA3+aWI9E2R5HwIObz89Xl+rWwBIMB
	 fwxt/WPBP1TAJtWOJTURqeR6kotiZ4ImJTzGqsyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBVW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:56:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35422 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:56:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so3299535otm.2;
        Fri, 22 Feb 2019 14:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HD5FTT9hBZ0bM+NIU9EAFNjfYPH1ctaCbugogqgW418=;
        b=tU9iuhpSG7NflKzdCWxGlQmGfA3DVFJgKuv3T45RQz2qLRIMBZawL5vw5TgJq7CJ61
         QqdoBTzvW83P62TKKjT9yka8Nm1Dk1WvTb/RrjjqyVOHo/pgPUJbzn2oBvSSwVokKtx5
         8J0X72jTWj66tHVHWKS2PwL2Yw+Gdht9I3T/7Y/K2VH+56Nkuil8bLaYvQP2uK8LzGaf
         9AVkVP31lbVvbVYuJcUCz/gwKIaSmcgmhpk5BmrRTwA+8QvOjUT6owaBpz0cA250laYu
         3E6zbDejO7OXd322L03ZT3frWzrIeAsICn1qP6VMeoXluC/kfZS3GWmKO4e/YaHYVsV6
         L4VQ==
X-Gm-Message-State: AHQUAuZUr4pePgTOi5JTe5c6Hhut9E5f40NtmMI9ty+b+80gA+D7LgBe
        eK3Ajz3TV4vGAXUOX6XKVA==
X-Google-Smtp-Source: AHgI3IZbklDTTQcxAdjp7izHyogLJLCYpL8hvM/VH7fs1gC5KVa6CNivqJIexD1vHtilA9NI0dXZdg==
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr4294810otl.175.1550876209151;
        Fri, 22 Feb 2019 14:56:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m84sm1133812oig.49.2019.02.22.14.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 14:56:48 -0800 (PST)
Date:   Fri, 22 Feb 2019 16:56:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        Stefan Popa <stefan.popa@analog.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: imu: adis16480: Add docs for ADIS16480 IMU
Message-ID: <20190222225647.GA14942@bogus>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
 <1550754906-24640-6-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550754906-24640-6-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 15:15:06 +0200, Stefan Popa wrote:
> Document support for ADIS16480 Inertial Measurement Unit.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
