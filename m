Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE58C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37FE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RnSsn1bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeIMJsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:48:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42481 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:48:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so2068997pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=niy+KibFEahFMgCSjrRF6+0YqR0YiLtJ9rAcxkJ0Vgk=;
        b=RnSsn1bzJzvgkMI/CGeTl/NrXMdnLPO35klIAb7Po6mDfe60+sGI1Ts6yD5s3/SNRZ
         vSCxRecrZnA6E4ZzrwVPNnPRi04bIk65CiQPULqeDOq4sNp7rinZpWicGOj1uJcSHU9y
         RhspqkRzHLtO+qA6rXBL2F9/ksT7cjrdPFW2N7rMMRqLCr84NQsevOdD+IQEi6WCCDAB
         8l+qQC4tI2uRce//lDvI7hjphH6rxmpWuKbq152EPrXx9XmmFl/cOzgFT6HTJVqQziCz
         iLvaBUZiluKdY2z612a1agcpci+bzcr/SRBdAA2P8pW2b0caSMs6IX/ZRhoABZnLrN6S
         8jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=niy+KibFEahFMgCSjrRF6+0YqR0YiLtJ9rAcxkJ0Vgk=;
        b=VQ26oSRxsPqOyvSIGNJ0ZZD6mbjjk7ehXTPwN+AnIuYEzbtu1bxKdKhdUq4O8EAWh1
         k5bp3owhMAFGukpHp8QTBnb56QAoGVoR4hr+HezPkB6EoYJPNYMDVaMcYC6VogaP+UCL
         Mr+ZcqLGRyEi1qR5dNpjaQFtv51YJ+r+TsALuzZW3FE9LF3ixSoG+AY7YtZWrvlPiinV
         En2H55YRiBICkTZUrsaDez2v6YyoSPDN1VyzmM16TyuOB6WxJQY0BPM13gflvrnuIJHt
         6WDM7KkLKFdpuP14tsaNA7QIgHoCtht//Q5LwIUrQb5hO0uHPB6jKTleJDOhqQyn7N6Y
         TdHg==
X-Gm-Message-State: APzg51DLyAphgKWcYKf8EzIDNHOeq5o0k38c8kkOKi3LAMtceEHIVSXB
        1GsYdLYgAr1mhq6jKOB+To2ZfA==
X-Google-Smtp-Source: ANB0VdbnMRV5H9OAe7naPOYrgjeIHrLhgoqPsvZnWvQPzBg+q2VTUaE/+S9lU16nKB9sD/wf0Txrmg==
X-Received: by 2002:a62:12c7:: with SMTP id 68-v6mr5528627pfs.216.1536813638397;
        Wed, 12 Sep 2018 21:40:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 6-v6sm3799008pgf.38.2018.09.12.21.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:40:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
Organization: BayLibre
References: <20180823114954.30704-1-mjourdan@baylibre.com>
        <20180823114954.30704-4-mjourdan@baylibre.com>
Date:   Wed, 12 Sep 2018 21:40:35 -0700
In-Reply-To: <20180823114954.30704-4-mjourdan@baylibre.com> (Maxime Jourdan's
        message of "Thu, 23 Aug 2018 13:49:54 +0200")
Message-ID: <7hworqvwl8.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> DMC is a small memory region with various registers,
> including the ones needed for the canvas module.
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Applied to v4.20/dt64 with s/ARM64/arm64/ as requested.

Thanks,

Kevin
