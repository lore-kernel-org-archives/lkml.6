Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FB0206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A6GzpSgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FB0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeK2LXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:23:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeK2LXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:23:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so82590pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IetqlkRlwQX9wKmz0tyh6rhafOaqs3BGAufReuO5NyE=;
        b=A6GzpSgRf4S4P9Z0xTmupwFRSMpns2zYEEZI6TeMdDdh8TN65zI55e59veeHbsBB9P
         vGFNUQbJJ+SbJF5A+UmzW+W85awZJ/hdJOa+sgVfTIL6CAQAUDwO79TLu0jPJpK48hbp
         EoioyD7zS6EJa4dfkhPiSePxKWyeJk65tWML/gCnvwyD5GDT2/OqXxiiCRHoX6SPk0hi
         TpTKqiM71sHbiOtm86l+lTxuLmbrT3BUiQHkLAgjToXKhVXY+5WFtrMerp9B9zGd19L2
         xIgzadC1OUDFeR1tHctUEhLHEtARf4maOcZlTcHs+wQjKpNMoMNZl92Uy43lSZzkQFDN
         6K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IetqlkRlwQX9wKmz0tyh6rhafOaqs3BGAufReuO5NyE=;
        b=YBkl4Srsrdu5iupJi48MMYM8HSSOifcU4PiQ9n9dJjv0EF/oJY0DdhrNES0ZP5pXMo
         9rMWkFhnN/i3YwOPPhBuHmND6CIdmczofUw8mjIi043XQDgJ3w8fBQvt7qRYBznsa5KX
         W7uTu8ynxYXmo8tLWg72uXgPocNK2aMa6NixYbtOobL/UkZks4wrmeVw8SJgVKYBtxc2
         NOcBvLq8S9Av61HqwWOZAIlY3O6dVoWIBPEuDNd6pqn5Hb3U3L5FDaczzHTuHE+4Rg7H
         K2riwInGYIeX44Rpts4ogScZTULfeHTrTRJDRNiJazsxyNwpp9what8BtUxopFnLw81G
         WoXQ==
X-Gm-Message-State: AA+aEWY/zi9OCygEDAM5npvMls2aOQMiHK/YqxHv9n0F3eLJg+HiAFNQ
        iA06KTXdYaT88m0ys+UOSyUfdQ==
X-Google-Smtp-Source: AFSGD/VZ903W1s507lfDleLFFyuGltqcXgEoOiiAcVbi+tkn6s2ZWb42M0FLLrS9zonddNZwH7iLjw==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr17445431pfk.191.1543450824960;
        Wed, 28 Nov 2018 16:20:24 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id i189-v6sm157144pfc.16.2018.11.28.16.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:20:23 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/2] arm64: dts: meson: add Libretech aml-s805x-ac support
In-Reply-To: <20181116151539.18501-1-jbrunet@baylibre.com>
References: <20181116151539.18501-1-jbrunet@baylibre.com>
Date:   Wed, 28 Nov 2018 16:20:22 -0800
Message-ID: <7hlg5cd9a1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds support for the libretech aml-s805x-ac, aka 'La Frite'
>
> Changes since v1: [0]
>  * Update gpio line names to align on Neil's recent series [1]
>  * (really) fix typo in comment

Queued for v4.21 (branch: v4.21/dt64),

Thanks!

Kevin
