Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C35E206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sdGv5xbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C35E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIFNFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:05:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54235 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeIFNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:05:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id b19-v6so10523681wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nOU+papWqmVgs6DGv7jy4F1UdKWyVf4oo1QxnYbtrOs=;
        b=sdGv5xbPIpYOtR9P7xfyZU3HmjCF5hIxuLkxQjwx88QCvY61ORYxU7PHI/AjVU/AhX
         WFD5U4CgLvHgshOtt5IhL1+ebkFueqIr1gwkiQD8olqvv69WLQ0GV/0C7kvHHWjhPoPV
         rzCINcJ4buIq78cVWTDj3RTw0ngw9/R7tQK4QnejAM1mg8HAIdboEUrbCGkeIoJ2W844
         2kVt0DrabEBR7zi+H+mxWOR0vq8m23dEnUsQGUJenniyU0j4Wg7CYb5WDw1AxtOOreM/
         2dnrW/EHMdwfxzIFwAdAt6syfNCrIjTbnTbWIpGsuy8D9asoXlFlhM3bEr05Ezzgx8me
         HLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nOU+papWqmVgs6DGv7jy4F1UdKWyVf4oo1QxnYbtrOs=;
        b=a0HfnBKu+pOSNRLZ8r5/Jw4/eRB8YLJarRhVtm6FjT09AmrpneNARtWl6JuJQru3EW
         1SxFO0ebTjzu7dmkMAEuifSEz9VyMx8n8Ic/Nz+gYaV2PB22No4q93QMX2aR/DvhXYaJ
         3nGPk+X7fozYblmmayBvOk5eRKkUO+WMuGFKQlNm/caXMpm1y5zMBiOw1wlmJj8hpVnY
         PnGSzuPzxXtCgUzv2UQBjxwaB4WYRCgxf8L3K3ychABde1tfpr3AU2Ca2MbA9TsDPevr
         41Pipsi+rOmK3hcDK0QFTDNwRxkPY3GJoYObWpKVHtBYdbkw5kNIRuofp/SvW/tRFAJD
         M1Wg==
X-Gm-Message-State: APzg51Aygp6f1tWcUmpcKA+QVPi9xtvgxDRJa2qUZJlj5oM0q9XrbMwD
        w0X2Ff9XQ3X5KVpyWmIcGL9u5noRr5u4yxnHeXoDPQ==
X-Google-Smtp-Source: ANB0VdYPn+3mY9VtGXQ5CXXPZ2dnse/+yJcUPYjbQUeCsLgTfbokCuyq5Dr2zBvh3RPyz0oxfT8jxQXHIiNftFzdDn8=
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr1460342wmp.58.1536222686349;
 Thu, 06 Sep 2018 01:31:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:686:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 01:31:25 -0700 (PDT)
In-Reply-To: <20180823114954.30704-3-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com> <20180823114954.30704-3-mjourdan@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Thu, 6 Sep 2018 10:31:25 +0200
Message-ID: <CAMO6naxHjK7cZAEpGPfPz5c8ZjGC5aPz8+yTAxoFpCc_gP24FA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: amlogic: add meson-canvas driver
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Please create an immutable tag for this patch, as this is a hard
dependency for the video decoder patches. This will make it easier for
Mauro.

Thanks,
Maxime
