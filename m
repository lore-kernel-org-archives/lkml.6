Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28733C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AEC2584C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScSXIVCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AEC2584C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeFZQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeFZQpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:45:07 -0400
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com [209.85.223.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BE826C03;
        Tue, 26 Jun 2018 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530031507;
        bh=jj1x94cUnVXL6neY2k3LHiA3Afq7+NPR1mrHXnDWxZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScSXIVCCsOoRhtzTeNWTXoJp+ePI5KvLx7XVXlmeVNwZ9DCGhnj8gz5RbELZVN9+U
         9CzGiwE3+j2ACSearUEAgshYNvwebT1mv5vVrwe5JmgLdoRqFobykabOc/sgriWnB0
         fOQvqd1jcXkknNu5mXhy0sCIBP32sVTSLrv7mwa0=
Received: by mail-io0-f182.google.com with SMTP id l19-v6so16585109ioj.5;
        Tue, 26 Jun 2018 09:45:07 -0700 (PDT)
X-Gm-Message-State: APt69E1GgdOfLbvKqn1bt33rq3WGsUtkGmivHKZOqmgniTnbGYN4zjvr
        mSdMhF8OgaOwjvagCgpn5c1vX9EZdSY/8GsCkw==
X-Google-Smtp-Source: AAOMgpdUhOSMuk+PH+tDgmtJ8WeZJlBqO2PBeEOZbE/qfpy3YKz1Ef8lreN1w9zwTR92gh+2WrsgwyTqFOhVM0f2slM=
X-Received: by 2002:a6b:c696:: with SMTP id w144-v6mr1890709iof.79.1530031506432;
 Tue, 26 Jun 2018 09:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com> <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
In-Reply-To: <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jun 2018 10:44:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEK5gevV6N6qiqX2xya+S+pWfwbWsmhD3rjKoJyy-shA@mail.gmail.com>
Message-ID: <CAL_JsqLEK5gevV6N6qiqX2xya+S+pWfwbWsmhD3rjKoJyy-shA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: at24: Add address-width property
To:     Alan Chiang <alanx.chiang@intel.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:22 AM <alanx.chiang@intel.com> wrote:
>
> From: "alanx.chiang" <alanx.chiang@intel.com>

Please fix your author name and send bindings to the DT list if you
want them reviewed.

>
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, should add the compatible
> field for specfic chips in the driver.
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
>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..9467482 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>
> +  - address-width : number of address bits (one of 8, 16).
> +
>  Example:
>
>  eeprom@52 {
> --
> 2.7.4
>
