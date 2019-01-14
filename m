Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091112063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547478301;
	bh=ycU8Hx6nKJOGNt3+gyc4eKYaY8x+w/Xiv+70PGiTH2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R21JpsllXfbRv58Tw+7SOXANGlrr90m0Yj4hZBIRNipFfOBVInnMLMesF2F3/LOtC
	 dNa3kMV1kEAgrTrfl0AAlq2XUf4dBgZEG3cB78HDYoeZyL9pa+h/im2N3wTb5jfbDc
	 RxtqWz4GOQoZzCVvcpk1OMdzpISA279FKFoM3Mbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfANPE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:04:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39589 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:04:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so15842212lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awlson0gsOtfv/POYCpFPNU023LAoTzQuQDcTurNL8w=;
        b=uLMSuchyaUusqVJfOte4+vehVIOvO1g3p5bYDv1xqWYfVOX2pydpp5a1qgcOTpg8fg
         vQqtGkhIg+3wedRgIfjBGPCP0onBpYbA7GuX/Q3mkuqXgzZuxAXmnlPFfjyNUlfQVQ5V
         9dffXOaKsnD+QjlcA5r/LUDB8BK1yI5RBF9nJGxFBMVHyhHVAXt5A3ZQvA7SuNAddDup
         KIPhLpujr8MITN9q/njgtmo/nMyeZQf7gZzpG8+ZAfo4KOMDS4vADgue6b+eLLBNoPrT
         zSGZlSBf5sHOLoXLOmlDK0Uuu5ldJTCzukHohpX4JDJwy2ZX+uyMhR/G6JJupkZGorNF
         895g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=awlson0gsOtfv/POYCpFPNU023LAoTzQuQDcTurNL8w=;
        b=PdDOxCgQNC6j7xNmRbcN+a9CVCT0QZhz/tv5ek/avVz3gKb890uibytkICclbGAApa
         qG5knAloZ6IEbyrOfvfXs9Yu7sJsMZxp47xYwr3uCN6b94ci3QMyJoyZm5HsG9oelKfZ
         jT34OaKRrXcF5WXSYy6AAjlQNzopxbAvB2DH59E1iADBGN3FJkRx1p5e1GUa4LhMaJSE
         x1NZKXGVjHPAWd47Ld+rGG+hlX9yepQwJoRebSbBPy47ZNUJF0BTh+YwoqPlZaBmu6qN
         Fk+/YvHeVcpQ0qukyHSqy5eF8y3UlMnb+i2jalpdN5Jqf5v3FYl85EZV5dj7fswujXTW
         oUgg==
X-Gm-Message-State: AJcUukcRVzqglcnIA24+mP7RKDgCqgnJasxDwi8PwWSnUY8QeklHth0x
        bclp4CdCzCQFJm5QWnLLKLw=
X-Google-Smtp-Source: ALg8bN6ulzMZ0onHHCQ7wh+mCW50hhfRM+i6hxUukrusRHFfhXSvlciCzgbYC6I4YHeNC2ePbdXIBA==
X-Received: by 2002:a19:2c44:: with SMTP id s65mr13308951lfs.41.1547478296615;
        Mon, 14 Jan 2019 07:04:56 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q10-v6sm127303ljh.72.2019.01.14.07.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:04:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gj3nL-0000K2-Do; Mon, 14 Jan 2019 16:04:55 +0100
Date:   Mon, 14 Jan 2019 16:04:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] greybus: gpio: Switch to the gpio descriptor
 interface
Message-ID: <20190114150455.GI3691@localhost>
References: <cover.1547476997.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547476997.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:25:07PM +0530, Nishad Kamdar wrote:
> This patch series converts uses of the old GPIO API to the GPIO
> descriptor API. It also converts the GPIO driver to use the
> GPIO irqchip library GPIOLIB_IRQCHIP instead of repimplementing
> the same.
> 
> Chnages in v7:
>  - Combine the three patches together.

Thanks for resending, all looks good now.

Johan
