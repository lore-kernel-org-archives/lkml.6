Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20970C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF6A2086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dto9cLZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF6A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIFMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:55:46 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54880 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbeIFMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:55:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id c14-v6so10475190wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XSH4FEc4I5NTzpCx5BMBUcqlTwHzKNHIXhCvZZwBQtI=;
        b=dto9cLZbr7hmf8uVKhWaXe7bmxZQNpA1U3h1Et8L44tSjocLu6f7E5gItgHEzalp+G
         keBG7xBZizDCZkHpOWVSazDoa4/RkGg+NWwrGLRqrLClKgF0i2zS+7fYcGIdm0UgqYeA
         twCdZCHg7nY58b5UCwdX4y6Xds2aXJWIxAtsrhO+PsY884xiagK/UZxI2yIfgoohuva3
         i6rsLee/4/J9d8aLguFyDsJTyPENobV0Kb9sDtmLD8oiWi+6Doc/HuGKsl+CN75X84f8
         XILVCJC9K1J7zmhQW7vRb+/34DMd2qNtYJ5iRDd6FRPQ9VqWBm53J8G3Jbe9t1GGb24C
         gi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XSH4FEc4I5NTzpCx5BMBUcqlTwHzKNHIXhCvZZwBQtI=;
        b=DagBMqj60/Ez1bdy8ae8jvyQ8vmJBD1Xt38zfzrwYy9CIDmi3LL9YhfrFP49e5emYT
         /dT8aZJQOaSgIQJzUsg1zS6n+5YEgWeaFGO9tKNhrHauzd1DD9P4rUUCsXClW8dP7DiW
         GgTgjghjWZ6BW333nlX5cgRo3GKn0Otd9MYogeSFUcKyg+qQCZ2NV+GDwkk8X24ffC7I
         YM/qLsEQMCskYLpswocuHAraJdpGz+ABnBQFQqwxrkNFnbo9ZZAEdk3hT4E8MqVrCpTL
         s26C3zVJi/RPrDkftkzTDCxVsCFm09f7GTN99xE1wE5yQB6rhxYYYveSIna2RBUuqRa2
         REZA==
X-Gm-Message-State: APzg51C/+TE/Z/mt+mQlzQZm2IjVci1HMEvX3PQtdThqFAfCyD2cbBcn
        9JaeQh8IHgFAyWjgU0/amv6tUbAvrvouw8IbuXh2eQ==
X-Google-Smtp-Source: ANB0VdYT9LXAv3nMlHwGwwD1zHA4vyk20wPCW5340piMhQg0TG/ApyrIRCdBLU45S86lw9SbKMaIOHvw/w8kJ5gDmdY=
X-Received: by 2002:a1c:6386:: with SMTP id x128-v6mr1464669wmb.104.1536222087639;
 Thu, 06 Sep 2018 01:21:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:686:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 01:21:26 -0700 (PDT)
In-Reply-To: <20180823114954.30704-4-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com> <20180823114954.30704-4-mjourdan@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Thu, 6 Sep 2018 10:21:26 +0200
Message-ID: <CAMO6nayiONr5Z5P35jhSY7i52+7Sfn_GLU=syFVV-cS8Bhxeiw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

If you don't mind, please change the title from "ARM64" to "arm64" if
this gets merged.

Thanks!

Maxime
