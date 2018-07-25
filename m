Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p5NcvWf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeGYWck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:32:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50876 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbeGYWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:32:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so4108956wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTfTDA5ZOyUhIzQSKMnXLsYvzI4PLDQiCShlg/fmV/U=;
        b=p5NcvWf2tCNFmBFoKx69JJuBHGKc5p5EvjEdybmKHv+AxQn2GwEeVy2DmW7QjhPin+
         2uzrMJktykoRIr3igWNeqtygq+J773ml1gucnP3DsNxCvirRzG7GcIoDvB2VbL1soX7E
         zTWpB6vrXH/ASgpRBgf8TbOBmNI43pmtCNyOACP/nDzF6nCiSIEwH9i981q+ttw3awpY
         6oVfoOHcSfy3QPQjIfsRq36crx5scDoft8MfjvKOsl+zYv+I2u7L+l6Q3V5ecizeLwDa
         tpSuS/KnZAKqQ+WCugLRQ6Lu0lV9UwW++IfeV+2LY+8gFz2gy/l1D0xhaqxLbUwP5e6l
         1Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTfTDA5ZOyUhIzQSKMnXLsYvzI4PLDQiCShlg/fmV/U=;
        b=Wzh/Eaph6tcGqPQAu2oa8vzfxPT8mfUfjlqHQsXWhfXM+qJJLARFwnVpcqaKHPAFVB
         riXhLhMtwez3XRx1HnVejQBhx4oOuLH2gqsLP0TFd13ZB1owd24EqQTjhv+Y3uvaokrk
         /qfL9LX3aP5VvMfyP8xah+8UsWmnKQEHVXZUZjvMzMXks9VNi2JWlWfHY7g2F/YffFJT
         tYnP3ZIXvmOBuqTIw1751cDxvZJPtqIbA+IyachmGxE9TrRWdnOwFACHau+pPO4UPiaL
         /Km6yqJ4murBBzcy0ScTFbZaiqV8eW8P79MNsbVusePTwJ6WPWn4ABYnx9OIL7ucqUP5
         vYUA==
X-Gm-Message-State: AOUpUlEM3Gimo09w4/VtRUFmnfryLGeg/xN/jhcU5S2XlvGpA/1+snPI
        ac7KP5/WUFagJErfPkSVoo4Eyg==
X-Google-Smtp-Source: AAOMgpcvhmwK37chQlwMM7SXjFe3hKMamA9H8QDjsfSK0fZbMfyMwLr8ZbfoWisfk6VfaCbf5E6LUw==
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr5744581wmh.29.1532553548290;
        Wed, 25 Jul 2018 14:19:08 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10228865wma.33.2018.07.25.14.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 14:19:07 -0700 (PDT)
Message-ID: <705e31bf0d978b7d356b2f077179ab0e3db6f092.camel@baylibre.com>
Subject: Re: [PATCH 00/14] arm64: dts: meson-axg: add audio support
From:   jbrunet@baylibre.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 25 Jul 2018 23:19:05 +0200
In-Reply-To: <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
         <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 21:11 +0200, Martin Blumenstingl wrote:
> nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
> while other patches that are touching the s400 board aren't
> if you have to re-send this series: can you please use the "arm64:
> dts: meson-axg: s400:" prefix for all patches touching the s400 board?

hum, do we really have such rule, or do you think we should add one ?
Kevin, do you have opinion ?

Not that I really mind either way, but prefixes rules are usually there to help
maintainer filter the patches. Will such rule help in any way ?

