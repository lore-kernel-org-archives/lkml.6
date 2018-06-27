Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA854C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677AA23E8B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v82XmUHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677AA23E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeF0ITo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:19:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55351 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbeF0ITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:19:40 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so6245116itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4boI7Ni3ds2Y4BntI2WQmSunS/rtQo59JQW4ZED6v8I=;
        b=v82XmUHbv5umW6XQ3V8lSLdkFW82OOwocAVyEVhd6+z+BcLuMyIlF83a1de4Uji0eS
         xrxySWS41ttN8U1x16fI5gr++3j4POKxpBDuJnmoYCKd8g+miBTFpow/pULPXMc8lPBK
         Qn8OxUrkvC7On8yDHQ402twTQZn76bXW3e98NzEd3Ef65LY6PxQeL7OaYnOHX07JyISc
         2xr5ai97OgEeCT7iFGp7umfg3Xnd2ptFipTBYa0RBcYXkT3ac+Jnf6PQPr44RYBuJYO3
         SsRL3nGxKfho/Rf8o4dF6qZOs0/puFug56mP2juIbkrbF5fEp/TgI7i8+dabzfRUJRcj
         QJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4boI7Ni3ds2Y4BntI2WQmSunS/rtQo59JQW4ZED6v8I=;
        b=i0Za4B/9wMMPtwd1Qom0+HDPd0cBiXBpAWw7L4NwTCgc5CLAuJpwJm883M21jgoLtg
         Yd8PpZqlRg7tc67oSIE8xvuhKQq8IfGKxLvXUoonP2dE9QrFuXCnUtTGnD9YUML6g8at
         Lm4zaw1ugsbSYUXw7ONicgo2r2nVy2ZAwOZTZzG5sHoCDJf2SLOGsU+B+0SLTm/wshdD
         EnyGutlbaqd9jVc/c4Fnww5tKD+w7U6+79U2Pz0ZKufoe2d1xvFSAwmZ/b2Y2KEcxVwP
         69vD48Hno7OEOGI/O96pIoDhxMcPwVjbvk0yyA/sielHxCW2Gn9uqEL26iTQXf0WdkWa
         7Ugw==
X-Gm-Message-State: APt69E29YfrpnkcxVfss1vSg2af1+H4nQqdPC8q3Q1YddfM1ZOhBdJTl
        6epZSkOigqB/qV6rUDJ1QNH6i2+joimSxCvd+O4kyw==
X-Google-Smtp-Source: ADUXVKJx6zsxRBGZ214WyetVpKBmw8rh64QZMej6aqg3igamBzshts3EMUFzx3LHj86+nEUGPcGyA33Gj9v0JW6rvIo=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr4042177itg.141.1530087579241;
 Wed, 27 Jun 2018 01:19:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 01:19:38
 -0700 (PDT)
In-Reply-To: <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com> <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Jun 2018 10:19:38 +0200
Message-ID: <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
To:     alanx.chiang@intel.com
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        andriy.shevchenko@intel.com,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        tfiga@chromium.org, jcliang@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-27 7:46 GMT+02:00  <alanx.chiang@intel.com>:
> From: Alan Chiang <alanx.chiang@intel.com>
>
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, the at24 driver
> should be added the compatible field for specfic chips.
>
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
>
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>
> ---
> since v1:
> -- Remove the address-width field in the example.
> since v2:
> -- Remove redundant space.
>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..aededdb 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>
> +  - address-width: number of address bits (one of 8, 16).
> +
>  Example:
>
>  eeprom@52 {
> --
> 2.7.4
>

Rob,

we only have two possibilities here and the default is 8 bits.

What do you think about introducing a boolean property here called:
'address-width-16' instead of an integer?

Best regards,
Bartosz Golaszewski
