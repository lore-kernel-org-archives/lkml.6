Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D548ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58E3214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58E3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJQWDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:03:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38416 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:03:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so26271893otj.5;
        Wed, 17 Oct 2018 07:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlFd3PUCH4bNT9jqiKwa6TB3bFOe0e2yehGLzuVM06U=;
        b=V+EgOmws5X85kQ9Dmhl/2ImwJqakSrHA4EQ+Vn7sz/QVeyoYK0zDJ1yIOa8fuCkWaH
         6G3SHLn81NyMZ7rm879tKlj1eltZehRypcKJP1MxsIzjb1cV/IGB0KJFn1sf1SStD8O3
         XEytu4uDaVtJIz33k6vp2ih83dm1++8TxDkCtZxU5nOtU0He5AFFikilPOL5QyOrfnuA
         ut+2CXSQkiTYQFe6D98JyvoAkyS3VNQeO9himZZiCuUpgHG0DuG4N4f6Ya4SZu7d4h9x
         nzevk28D5aXKhsgXgH8mYQYPid5vHHxjqgPSnYF4JclwwRlxKThBixD8MGxJ8PaLp3YI
         UGmA==
X-Gm-Message-State: ABuFfohibqD9tWUCQzw/dOP7dxm3DnfXom/eD6Cm7SuTXacJMjLggCYf
        rXKMEffnfpRHZ2FfAYrF2+PnajI=
X-Google-Smtp-Source: ACcGV60DV5W8lHgdJEB3EQOcALPrY3H+PfxVdDW0A2CYPtdr2yokaZo5RLMYlt2KxoWjmr/QTk5vdA==
X-Received: by 2002:a9d:6509:: with SMTP id i9mr680259otl.338.1539785265903;
        Wed, 17 Oct 2018 07:07:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b1-v6sm5011531otk.35.2018.10.17.07.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:07:45 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:07:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/2] misc: hx8837: add a HiMax HX8837 display controller
 driver
Message-ID: <20181017140744.GA21328@bogus>
References: <20181008202321.128937-1-lkundrak@v3.sk>
 <20181008202321.128937-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008202321.128937-2-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 22:23:21 +0200, Lubomir Rintel wrote:
> HiMax HX8837 is a display controller used on OLPC platforms. It controlls
> backlight and is able to capture and freeze a frame when the LCD controller
> (and the rest of the plaform) is powered off.
> 
> This driver is based on the same code as drivers/staging/olpc_dcon.
> I modernized it to use managed GPIO, device-tree bindings, sysfs attribtue
> groups, essentially fixing the staging driver's TODO.
> 
> Why I am not removing the staging driver now is because I've hobbled off
> some functionality too (with an intent to bring add it back eventually):
> 
> * I've removed parts that talk directly to the OLPC EC to turn off/on the
>   power. A separate patch will make the EC expose a regulator interface
>   that should be used instead.
> 
> * Some work is likely needed to make XO 1 and XO 1.5 work. Both platforms
>   are DT-based and could use the same bindings, but I haven't checked
>   whether the cs5535 and vx855 GPIO drivers are good enough.
> 
> What is there is the backlight control and the sysfs attributes to control
> the freeze/unfreeze..
> 
> I've also renamed the driver to use the actual chip name instead of the
> original name that I found too generic. This way the staging driver can be
> used on XO 1 and XO 1.5 for the time being, while my XO 1.75 can utilize
> this one.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
> Changes since v1:
> - Use interrupt bindings instead of gpio for the IRQ
> - Update the statement on XO 1/1.5 support in the commit message
> 
>  drivers/misc/Kconfig  |  16 +
>  drivers/misc/Makefile |   1 +
>  drivers/misc/hx8837.c | 741 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 758 insertions(+)
>  create mode 100644 drivers/misc/hx8837.c
> 

Reviewed-by: Rob Herring <robh@kernel.org>
