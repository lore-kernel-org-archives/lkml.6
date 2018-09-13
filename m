Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAA720833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cEcNo75S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAA720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeIMJDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:03:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38076 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeIMJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:03:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so2033775pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=kXWOv4Xq+/hfO7YmSuAXgnoKcryoHakzkr5K2VOn79E=;
        b=cEcNo75S7aqxhJCFjM7pIsnSXDmvFt3vm4FsNi4pO9+x4t9NgMFZ0a/hBTzxk6LtEy
         XV83WJ96tsegp6CEE7OSUA1pF1rwWYcJRWXmryD+erOdHM+6ACSyP2p5e+om2pSPt7wY
         ufilQZ2K6IkPrMrxNzEDg8u17vEP7RkEL6W2Lm/n3EbyNruPBtXvXlQpELs2N3XZh7lj
         1YWLLaxX4aAq5e5AbzA4oBykVYUAebV4SWcN3XWBvnE12hhxCnD/nK0nbdQ7aOY+p/IS
         vldapiXNPxi40c9f+wsWxoNf7HAifxAjPC29d7PCXALX4t7/EFtgUgmG2/Taw0o0XXzd
         VZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kXWOv4Xq+/hfO7YmSuAXgnoKcryoHakzkr5K2VOn79E=;
        b=ho8Hm1/pds0omYg41fY+PK+KhBenqvG5TBcM78a5yWwJFrSbqW7v7dMzDS2XD/gzU3
         wJ72lOY4Uw2w1nxtwPQiqK+vDeS95cepeQVu5g/FfQM6K83eZcOryjlgTBZ6MSa5YPgF
         fFFMTcUaZ4JKkC9oW8HCioEEqk9tE0wUkV8jWoXw1+bUSYDNj/OeCEV3TOPtlxPc5f2s
         i8b22AlCzcIzk4F0M8BPM3t1gG2mYp80r0foj7oufuyH+4qGPUGMZTOdsWOE/Y605yH0
         F7D/+M0BlNyesy/j3CaxI2adODgSX30dKl90Nrp6zWiyO9WKPKWXP1HKi8h7tS/JzCH1
         NtZw==
X-Gm-Message-State: APzg51DVd0oslAU81Da9kHMa6UnCb8qYEMsu2xx21H4olbmipz9E0Rkw
        sZFgaS6UH0QPhEBJRvlrTl0ueA==
X-Google-Smtp-Source: ANB0VdZBNOqbKrTfHU0UdmqNYVA4I7u3S7Y+mPlESLaVTQrKmonsrKxZXO8c1+AjcEavc9Amls23zQ==
X-Received: by 2002:a62:4dc1:: with SMTP id a184-v6mr5371367pfb.5.1536810926218;
        Wed, 12 Sep 2018 20:55:26 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id p19-v6sm4125701pgk.28.2018.09.12.20.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:55:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: meson_sm: Add serial number sysfs entry
Organization: BayLibre
References: <1532613556-5398-1-git-send-email-narmstrong@baylibre.com>
Date:   Wed, 12 Sep 2018 20:55:24 -0700
In-Reply-To: <1532613556-5398-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Thu, 26 Jul 2018 15:59:16 +0200")
Message-ID: <7hlg86xd8z.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an unique
> SoC ID starting from the GX Family and all new families.
>
> The serial number is simply exposed as a sysfs entry under the firmware
> sysfs directory.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/drivers,

Thanks,

Kevin
