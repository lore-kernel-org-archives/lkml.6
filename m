Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B34214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxrvIh7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeLZQEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:04:05 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:43264 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeLZQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:04:05 -0500
Received: by mail-io1-f53.google.com with SMTP id a2so773080ios.10;
        Wed, 26 Dec 2018 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=FxrvIh7xRx4cYwi0lsJnXn46a5o9wEUU/ksmyiR/4wesVpVBSeSka7Y2f8v+8ACu2P
         5ywNU+yLF++IXpPDjffWUgBHh75DCRzDYDQ9ILy2M3qxKEHpyAnDaybe3SIocZhRb56P
         XtmYN8r1UYdNhDsb1CKZSJrDhGv8no8RAvegaqb7hzk3RG1IFj5K+PDyuOvB07PzsIz5
         YFMHhCIkE75YbJ7V5l1kJnEGzTrQKpuuKDn9B43QWvaOWfR0h1VUX2ospmerY3vOiuF/
         VIvJ8S6IjPlpSAiimM68dBUbyZLtuPwwYLr4R0gqRE/0IQ+3lbrOfwG004mHxnL7dMPD
         m43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=hw/FHW8Uu3nGwvkoYo7GhLk/dUdTGNoH6Sn4X9vSquZWQcv/cavCzoYAqpdoF+HWpE
         DE33PEmtwR0KJI9eCG7zHyZmQFfzwHMzO5iOESUSGpzskzRwndTgdLNWw7gA3UulHNhH
         4SeJxj0+j3/OrW0ekf3N0KU2K1BPKKkWoMxd2I2SESUps84wFhqMBu4Yx/LVj7vMzk1y
         5vCBCma2otEPkRGHHP88f7bxp6hzz4TIbw26sGg1HJziMQQ2towLZz1UPuhZv+SeAZ93
         JLgG2WjJc4GPvQ5nH07vIkH9opKIIaJ60XWMfJpYFlIijglnb4vvoMI6S3NGYMjXkj4f
         ZZ3Q==
X-Gm-Message-State: AJcUukfLgShT2mmQSua8MwI0iUhhIW5mqfsGoHBHC3uRjxbOAQm1A4pQ
        AU0wD7CQQPOaz/O3Po7YGNPep2hIfrhZPA315lQ=
X-Google-Smtp-Source: ALg8bN5EVCx5Qxmm9iysSYGiRvfBiJIT0dU4nYsSg9Vk0niJoVLtdPLlDF5EYC+HGBG2ZF/d3d6I8yFsc3gZlGjbu48=
X-Received: by 2002:a6b:c005:: with SMTP id q5mr12987342iof.225.1545840244301;
 Wed, 26 Dec 2018 08:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20181123145058.27115-1-tiny.windzz@gmail.com>
In-Reply-To: <20181123145058.27115-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 27 Dec 2018 00:03:52 +0800
Message-ID: <CAEExFWsmyq5G8vNy9rVa6rdx2Fq5xxA+U4LsjcbcgPd4BN4TPw@mail.gmail.com>
Subject: Re: [PATCH] thermal: tegra: soctherm: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
To:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        jonathanh@nvidia.com, Kees Cook <keescook@chromium.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>, ezequiel@collabora.com,
        srplinux2008@gmail.com
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
