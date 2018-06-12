Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7A13C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E9420660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9420660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933987AbeFLTKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:10:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38515 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933011AbeFLTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:10:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so26040pgf.5;
        Tue, 12 Jun 2018 12:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZIJ2337ZfatyGsHj6AhkWTZqCqYht1IwCqe6Cos2gI=;
        b=J6cWylG31aioD2AYdfBqtncnG6lpvIDcspBPLpTiGcHWzratt8pTDs4iA/dKF+cWW9
         5huY8Jdc2CCdgFJdnOAc3//IQE8chKm2bKPq2ICFpQLKvPloj2JZwBGTs0TE6iVnYvAN
         1SZM8A4xVvCXCryzhiQ6CagL+BXOYMxOZudSQtkMMtXf2ag8xPW2l8K1h7PvS1NQG1Lv
         3xAnrbnYOQa6+BDffqmNHHi9j0KDrWoP/atJ0Kzh97rfjyRoKWBhncBeBJ2UvmFdz1fN
         km2sgWdFJOSQ9tQ9grMbUZXgbKGOYqYtyEaYDTsnZezRu4Ab3OqutIUGzhTYQdqpJobE
         DzJw==
X-Gm-Message-State: APt69E2sVNIx1ag1jZcjJmr8sukRB13Rms2LcPE9hhT8P8S2T/zd+2OL
        wCCBnxj/mdj9xBgC4jsLKQ==
X-Google-Smtp-Source: ADUXVKKYX7ykxPn5v7U42/R7Oz+TbAztZmTUeCkg5JqmJlUs89zvbuMs+34qOuykh/y6cj+5UFJLIQ==
X-Received: by 2002:a63:8ec8:: with SMTP id k191-v6mr1370198pge.435.1528830613132;
        Tue, 12 Jun 2018 12:10:13 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i71-v6sm849406pgd.22.2018.06.12.12.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:10:12 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:10:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 10/11] dt-bindings: misc: add bindings for
 cros_ec_throttler
Message-ID: <20180612191011.GA26266@rob-hp-laptop>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-11-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607181214.30338-11-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:12:13AM -0700, Matthias Kaehlcke wrote:
> The cros_ec_throttler monitors events from the Chrome OS Embedded
> Controller to throttle the system if needed, using the mechanisms
> provided by the throttler core.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to series
> 
>  Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> new file mode 100644
> index 000000000000..7316dcc0ef75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> @@ -0,0 +1,4 @@
> +* cros_ec_throttler driver

Bindings are for h/w, not drivers.

I continue to fail to see why this needs to be in DT. There are other 
ways to instantiate drivers.

> +
> +Required properties:
> +- compatible: "google,cros-ec-throttler"
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
