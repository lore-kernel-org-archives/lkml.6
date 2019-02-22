Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71BAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72224206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878968;
	bh=WZX1bZ1T0ylnBxg+L+99s74Jlr2svtJxrcpJ5Rb6TvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zii2inq0lxFj7CGfPFrkdz3OA0BQ4QhcoAWZXnpmEkAxM7KYFaGNYZLgrleshWqZ3
	 PaziWWJxaxDItsB3hl25cYLaWlW9P3MMpwhcjqKql+RqIOtZvVpY1IhNuCmsmYm6BL
	 5p1FodOEomJAy8g+fd4j4XCBp1/O4slO63d8X0hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBVXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:42:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33510 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBVXmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:42:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id q24so3388939otk.0;
        Fri, 22 Feb 2019 15:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPGqaaOkgu8Fir6DYbPu8XM0llagMGL77gXaVUEfptk=;
        b=kEbsrK/DmHtaVHONb5TBhY+nzbdn3GmWaHraFCKlaYLGIT5wu/TlTM7JPjg/1nTehg
         VIzmERZe9um4P6y+3adJTHg3S2VGLWSaHldJoRJk2wJY/02VoczPL5Yqoa5ybL6WV932
         F7qjq+Fyl9ZKi8MiXGw48pQ5ybWHDQaIVUNGwPUoLsX6mWweT1rTeWnpcYk75puqky3S
         edenrcq5ZfLCycyySpW9Dda1cx3pIn/fhoLuO+6otol2ZO8WYedsUIvdRVV7izFF109L
         6YcakxWtnxU7YGBefPvlXLWpkehUhqpOmSN4CfRVP1PcdNNdkyM9IrIoiigeoxY4bPnr
         amQQ==
X-Gm-Message-State: AHQUAuZD+setZ3lUKogk+zY2EqoTL3ByioJlw1cGaAxCtGLlmsjMPmKt
        HfgCxesqKZ3oWSfnb9FA+A==
X-Google-Smtp-Source: AHgI3IbNrhtoFynvnbADfbp6RO+C3zIpdEq8vv6GwN4ZBcoJtz8/yQTH2pDC3xTJoFQ6SZ9Rl+xckA==
X-Received: by 2002:a05:6830:1648:: with SMTP id h8mr4542040otr.50.1550878965464;
        Fri, 22 Feb 2019 15:42:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm1256621oie.52.2019.02.22.15.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:42:44 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:42:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
Message-ID: <20190222234244.GA19838@bogus>
References: <cover.1550768574.git.hns@goldelico.com>
 <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:47 +0100, "H. Nikolaus Schaller" wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The mounting matrix for sensors was introduced in
> commit dfc57732ad38 ("iio:core: mounting matrix support")
> 
> However the device tree bindings are very terse and since this is
> a widely applicable property, we need a proper binding for it
> that the other bindings can reference. This will also be useful
> for other operating systems and sensor engineering at large.
> 
> I think all 3D sensors should support it, the current situation
> is probably that the mounting information is confined in magic
> userspace components rather than using the mounting matrix, which
> is not good for portability and reuse.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
