Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26EF20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O52WqGH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26EF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeKIW6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:58:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeKIW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:57:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so1883614wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 05:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fdGqnpf5TLAguiVn5EkKAzmHIs+U+mbcmm6CnNjc6DM=;
        b=O52WqGH00j7AVFo3rnMqQ2bYTZ8TAY/NETiBJ9adYIa1ZsmqlwJPzye403xod85qr2
         JxEAQPQ96SLbpub0pkUK7mYrbXvZVzwYOmZBWE7A1p+ksmeC87xuF7k9JFZhasdyEenz
         Laj/ru0La4is7W1tOJtX8ysdQVuRgz1xZvCHlw9TJMfpLd5SWBcOj5yuaKOS7V6ejo1N
         Ac6RZ6j4MFAIPQwA6/KGZVicqcIjxrXJRuG95O7gWjyxPlMcES9GtoIWjdbduN4U3FXR
         jxywa5Lo03psvQYZ3adXcUTP16IETP5jjpF9c+BF6rtAi1vXPJqiJHFel1ZHcQ8mrLyu
         4zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fdGqnpf5TLAguiVn5EkKAzmHIs+U+mbcmm6CnNjc6DM=;
        b=C1fks8cvpTL398FloFRam6V8m9F+mHfAQrmlrTjwyIEGsGRqmMhv/nBOnqi5Fk+h+u
         7vMOnMRczDta/nXPExvL3LB/rqZlnYeJzy0U5CnMjjdRfClwgGZdm6fAWxpo0tSbz3/h
         PUgJ9iDgLe0J1m0gDSSSUsaoxBlGhziH2wyrUI+NA3mvinQUZSolRLmNnRp546beewsj
         lti5E64tLfh9El593ZemrWAwhU+ZFNvKHkYXjDFJ5ktopWuEjiI1QL1GkheO2fSShYKl
         oGxxFu6PGIJ4SC2PwLtB8daIozDB5BhP/OHoIzd5p1xzOQXwl16HzLE4viT4paRI5W0Y
         EJGA==
X-Gm-Message-State: AGRZ1gJGwTYgMxcq1w4JnT+9auSG4V7I2qApZrsFY89yw4uHSOtnVCpV
        rU28JlU/OfLOrX+oT5/8NoL4yQ==
X-Google-Smtp-Source: AJdET5e2QFTWCMbr5K6XH5qnNhuoAh44pxv05FA/HfwB1S/LLL+PPGpuvbX60NgoN+D1CUReJUqZTw==
X-Received: by 2002:adf:9cc2:: with SMTP id h2-v6mr1883394wre.322.1541769443825;
        Fri, 09 Nov 2018 05:17:23 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id g1-v6sm1900261wmg.2.2018.11.09.05.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 05:17:22 -0800 (PST)
Message-ID: <d923e31b63a5d4c4d67a274b8ef9555cd25f8bff.camel@baylibre.com>
Subject: Re: [PATCH v3 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
From:   jbrunet@baylibre.com
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Fri, 09 Nov 2018 14:17:20 +0100
In-Reply-To: <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
         <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
         <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 23:43 +0400, Christian Hewitt wrote:
> +/* This will enable the bluetooth module */
> +&gpio {
> +       bt-en {
> +               gpio-hog;
> +               gpios = <GPIOX_17 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "bt-en";
> +       };
> +};

Instead of this, is it possible to use the driver provided by
drivers/bluetooth/hci_qca.c ?

