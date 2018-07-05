Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF32C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3BA2419E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcmOHiAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3BA2419E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGEH0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:26:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36353 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeGEH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:26:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so6110391lfh.3;
        Thu, 05 Jul 2018 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3MOGd6ab9BL0ijUs3QxDdd0XJ2oPXenP8N6TCXwDHn8=;
        b=lcmOHiApHCu9lMQQSdRDsLmiazFU7PIAGiMCOzDBlgsVgE/iI13avPnM9AJImXw2Iz
         yenlY5nDbSser/npAdARyqvX5e5v3a7DEE6sVJ4UrJDF61RixDH1qR4+Jnw0gXEMAyNq
         b95V84LOGHFw8N1SJU9u0WGgkG8xt5gS9e0+lfCWfhrIHjw4bkQsmVjIL1NsdyhlrRh2
         OBzMGY1NgFsTVW8HwQ9TwqCCmgNXXP/RfQnLjNCPN1DbT7Q4g8DXEG6m7ImUUxEtJXLC
         67dcbCb+5Pq3dFp+MK+h5oYXAaZqUcCX4dlJ5fp+c5m4JtcuYMeZxxyDi+Qh9mz2w7GT
         tFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3MOGd6ab9BL0ijUs3QxDdd0XJ2oPXenP8N6TCXwDHn8=;
        b=nfkBqwZ1rD1K7dVtL4DHzRl0itZF/rES2sbFM0fDKuSWFxyaxysL7Aom+pp2g0kUHP
         FQ2/gVjzdRBqgp7g2bhzMmK5rDpw4r3MI8zOW85WCFIENIdkprPMfTvmBLUjHafV/6pM
         ynYE2ZifIkyjGBFjh+nizlHFmG54gJ6b1mNMTT0MN90+UOVO2HrtcYUOgUS5PtihcIlA
         CUH11uLTayBXLRIB2fYoOtLXHwccCKur7RsfVifme+RqU4m7TlyCdzdpFUshSBouBloG
         L6NzKyHAsSHbokPQ/QFBnGxDk32i8Bqj1xOxaWg+n66JnQtkWdyOCb+2lFoLU0/YHYHS
         qBzw==
X-Gm-Message-State: APt69E0+6beETvk8nicLLeFMzTrqS5qPwOHyH+0lcl3NzYnqWWapHNaq
        HW8JRh6KD1cT+nTsLAas4A==
X-Google-Smtp-Source: AAOMgpc2UuxfSEZbwaivz5u0Js2t7jzlGkN8RftURZQdsxtd0RH237WMUM+e38nLxtrOXd4q5aOkzg==
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr3384641lfg.14.1530775603943;
        Thu, 05 Jul 2018 00:26:43 -0700 (PDT)
Received: from [192.168.0.4] (89-64-27-18.dynamic.chello.pl. [89.64.27.18])
        by smtp.gmail.com with ESMTPSA id o4-v6sm414035ljc.67.2018.07.05.00.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 00:26:42 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Thu, 5 Jul 2018 09:26:35 +0200 (CEST)
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH v2 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
In-Reply-To: <20180703125224.GC14626@piout.net>
Message-ID: <alpine.DEB.2.20.1807050924430.31418@carbonite>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com> <20180627131609.13681-2-bugalski.piotr@gmail.com> <20180703125224.GC14626@piout.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexandre,

Thank you for you comment.

On Tue, 3 Jul 2018, Alexandre Belloni wrote:

> Hi,
>
> On 27/06/2018 15:16:04+0200, Piotr Bugalski wrote:
>> Just minor typo fix. Fixed in preparation of new driver.
>>
>> Signed-off: Piotr Bugalski <pbu@cryptera.com>
>
> This SoB line must match the author. It doesn't matter which one you
> change. note that you can still submit your patch from an address
> different from your work address if necessary (git format-patch will
> insert the proper From line).
>

I didn't notice this issue, I'll fix it in next release.

> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

Best Regards,
Piotr
