Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC66C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A907C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xkSsnEPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A907C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGSKtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:49:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39412 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbeGSKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:49:16 -0400
Received: by mail-io0-f193.google.com with SMTP id o22-v6so5527447ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VOl055BhduSo5J7YsFJvGwNoM//6uQ8iqB4uxoQZeUM=;
        b=xkSsnEPMx95IK37nOT43QlC7KFDN+7/9wfsUWGmoBCNLvut+NAf8QYD2uOxmzGf89g
         uJg8dGFhyz1uFlamw+oP2ZnI8iCqSox+718SPJt9nN8UqVQIS8yv0bXyHTc9/cp9k09S
         FRxTcN+lgBNo8atGs/5v+Xyp4CWOqpl4ODo0La+3panMBosLXfsEhVam+rYWiVGt6MIp
         fTwyI4T3Gx1fR7H8leh8Q/j/QqflSyI1F5gTPoHeysW3lrWg5W0ivCSEhUDYt2sEfdS2
         qDfbKHr4rOg//+x06blU+e4dcyY8lblViwEXLebOQoWwvPLU52b9Vm8a1qRGw5pdiN6U
         Ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VOl055BhduSo5J7YsFJvGwNoM//6uQ8iqB4uxoQZeUM=;
        b=Z5Myr8au0Qy+JwBzQO2c6TugV71wuuN5pK2v8ZgnHe9YoVXfOFSybxlGc46e40WjE/
         M1WpbeD7xqUFWtCkPGCU2UOIH5cGruFQFIiKsu7LZI24YTaFMOic/VozShUzrwyDQPM0
         pDSSyRXCOcZSbyekSQD/JePrX8a+5q1ufh0mPXUDVYgKpQ87v/rxU5CiKypgI2u9d8Xl
         QAo012MAw1bwggGPJMjnpMG+9IDQnOui3WmZmQ3Ija0Q36ddbCApQ+g1ZjyikMh3xj6+
         wdY2o5YESmI4bhodpyi9PQhIgN1ev2MmsZeOuwip8RqqU2HeV8VQUJhn9iLfdYO7AE+g
         jSEA==
X-Gm-Message-State: AOUpUlGoi47oSPp/K5+W1Nb3Y5hAHvIBUVisVC/BY37NUj9NUZiUVLDL
        8Dzz+hEs/1nvYjdq76eD7SfQwdAxxlAE0MynSvuzJw==
X-Google-Smtp-Source: AAOMgpfFPZdZbW/yP/0a3fM6bU8ua4hKfHHk7gJlOfMrs3RGc2u4uZE0COmtCmj1YdKgt8zOMNX+Fr3ttWe6rAfzn6Q=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr7733109ioj.258.1531994812574;
 Thu, 19 Jul 2018 03:06:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 03:06:51
 -0700 (PDT)
In-Reply-To: <20180719090929.arbysqo2bk3esoar@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl> <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda> <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
 <20180719090929.arbysqo2bk3esoar@mwanda>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 12:06:51 +0200
Message-ID: <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 11:09 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
>
> Maybe it would be simpler as three separate functions:
>
> int of_eth_get_mac_address() <- rename existing function to this
> int nvmem_eth_get_mac_address() <- patch 2
> int mtd_eth_nvmem_get_mac_address() patch 3
>
>         int ret;
>
>         ret = of_eth_get_mac_address(dev, mac_addr);
>         if (!ret)
>                 return 0;
>         ret = nvmem_eth_get_mac_address(dev, mac_addr);
>         if (ret == -EPROBEDEFER)
>                 return ret;
>         if (!ret)
>                 return 0;
>         ret = mtd_eth_nvmem_get_mac_address(dev, mac_addr);
>         if (!ret)
>                 return 0;
>
>         return -ENODEV;
>
> regards,
> dan carpenter

It looks simpler as long as you don't add all the new routines
resulting from this approach. I've just tried to quickly implement
this solution and it resulted in much bigger and duplicated code
(checking the validity of mac_addr, copying it etc.). I would prefer
the current approach and would like to read someone else's opinion on
that.

Thanks,
Bart
>
