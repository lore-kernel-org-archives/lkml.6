Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D22C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA56208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2ktATHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA56208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHUPUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:20:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54538 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeHUPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:20:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so2652156wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/uzisgm4VaO5+87MaaLuCja+daGuU9gaxmTfS6V8PoM=;
        b=Z2ktATHUAU3WtrEtoTyQpRtRolKNJ4Ti1dTgNsO2gVRmC5PILVHrX19gRuN2HF9dFp
         G1tUid4M9SmMS5aPiKcz+yd6mO6SmvnRJWPdMJ7pU2pjwWHCa0Ct/gyR5q5zFetAXqFn
         KLK62TyLrFq+h5Y+x+BfUPzYjxaB0l4ksqLWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/uzisgm4VaO5+87MaaLuCja+daGuU9gaxmTfS6V8PoM=;
        b=a22VRIhZKnEdeAghakSdsgLurMT9lymbYySmdAuH4GAxndLE0jr0++mokY7oYykz7t
         qpkg2/b0l76pLhU0CMYTLs3jC1EU91go5GprOAtKcTc8B6m0JAIoq1vqyPfaAvsTQ8f4
         qu6ykurwaBWiHc0MvAPWF/63rJ/cKwOFKTPCUR8hKEXn0JLbaHf+JPTVQaZVamLKUMKo
         ab+oRWP3hf74mH/Hq3Cyt5OA2hKk1a5MmbdaOUCE9768RsmZQtO41zf8aLPjRSpmOFKA
         Z8s4HF414VKujnrvRgul5ngk2mq/Xv2+R1E7RjgGLFThTLD3qVN1ZXvHiEW1GQj5kgyI
         vF0w==
X-Gm-Message-State: AOUpUlHz+PYbmb36NQdNw6Lx4QrqjDzYXPLs2imeHXcUdPCC2iOTxKsl
        XAdAifZSjdcu13yFNQfZNtBL4A==
X-Google-Smtp-Source: AA+uWPxbpYJKszl17lqsb2oBSGmliaORK8u/ZAFJ/bohdNbIsRehH1sxJIpy1bujnz1X4vVvczxgDg==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr27435377wmy.81.1534852807272;
        Tue, 21 Aug 2018 05:00:07 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 139-v6sm4040277wmp.4.2018.08.21.05.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:00:06 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Alban <albeu@free.fr>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821133916.3a1c51b1@eos>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
Date:   Tue, 21 Aug 2018 13:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180821133916.3a1c51b1@eos>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/18 12:39, Alban wrote:
> However we still have the a potential address space clash between the
> nvmem cells and the main device binding.
Can you elaborate?

--srini
