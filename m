Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D6C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFE02070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0JOPhN4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfAGOQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:16:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39873 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfAGOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:16:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so1019214edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KHzLH8hmDewoquII+Xcdqdc5pt2HOJhBok89GWmD+hQ=;
        b=0JOPhN4+g5F+nVzR/5MInS9O0lMTJBQRUnZdWpVN2wzstB8V7ABszzmOd1wbEzHgcv
         JZ+1s01+HFjAGfqRNViZNKBFUmS2bDGlL81LHT9PmyueJ/413CXTvCaep5h7q5P4oz+Y
         mUL669aUk5GdMr1bS59ljZMv4eqeoYLImbIsRfyGHPf+1uLIkdkh3hvqYPqOZRHI2WxT
         QebmN5Bdon9z5ZPy5RYZg/KW9EzaLjMB4sJbyMNy83wlsszaulPFDtAxrAIjIJAv/V8O
         TyRrK/1ZIrgJoqubY1VeRLzoHBsflOwbOIvTlZEQjik95DEw997GwhcnAFy+K+2zosWu
         DORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KHzLH8hmDewoquII+Xcdqdc5pt2HOJhBok89GWmD+hQ=;
        b=qwYSX9POfzS2n4ZXx3AuwBm2oSaErrYaEM4bFRhAxDiX0RpxhVIw+DDF3yS2oX7dNq
         YjvjF5kh4xj7TT6gFMv3k1rOYCLtZzvvDtNvygnpa62HsvC03XXDciNIGSww+kIEx5AZ
         3ZBdVRCHjnSBMVaGXxYa/rQBSfGngHqRgjZQHzwGe3Qi9MnYGlSVh2PNRB5THtQmInU0
         l0IrzqYDOBQL6FO8KpnMBXhX3xN1LSjOtRWzKnyRxtFm9Dye/LSm/W2BGyxa96bXPvdX
         7VEnrdXUFhlHYnyrXxEOMacT9IGVPdgrlVhq0OoNXQPQBCgbbRkH6gn6fFIX3fn3Tml+
         7rnA==
X-Gm-Message-State: AA+aEWb0haQErJMRRVMp2Q55hnIHpq7ZoHrTlW1eoJMLRKD6SOzwOagr
        d4U7eX8HnD/Ev/bbNE6Q6u30eA==
X-Google-Smtp-Source: AFSGD/UERWKmac/kAK3jdGJF6xAjInJb7wa1GXLHbmaLXMadS6Pnx45uEOdHxlf7w6E8JJGpY9956g==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr56932634edq.30.1546870585492;
        Mon, 07 Jan 2019 06:16:25 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d7-v6sm18454653ejx.68.2019.01.07.06.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:16:24 -0800 (PST)
Subject: Re: [PATCH v2 0/5] clk: meson: axg: add 32k clock generation
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181221160239.26265-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bb5fef84-3bcd-d273-e8f8-0664e0828785@baylibre.com>
Date:   Mon, 7 Jan 2019 15:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2018 17:02, Jerome Brunet wrote:
> The goal of this patchset is to add the internal generation of the
> 32768Hz clock within the axg AO clock controller.
> 
> This was initially added has the CEC clock on gxbb. To properly
> integrate it on the axg, a simpler 'dual divider' driver is added.
> Then gxbb AO clock controller is reworked to use it. Finally the 32k
> clock tree is added to the AXG.
> 
> This patchset *no longer* requires depends on this CCF change [0].
> There is a work around in place until a solution gets merged in
> the framework.
> 
> Changes since v1: [1]
>  * Add work around for [0] in gxbb-aoclk
> 
> [0]: https://lkml.kernel.org/r/20181204163257.32085-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20181204165310.20806-1-jbrunet@baylibre.com
> 
> Jerome Brunet (5):
>   dt-bindings: clk: meson: add ao slow clock path ids
>   clk: meson: clean-up clock registration
>   clk: meson: add dual divider clock driver
>   clk: meson: gxbb-ao: replace cec-32k with the dual divider
>   clk: meson: axg-ao: add 32k generation subtree
> 
>  drivers/clk/meson/Makefile              |   4 +-
>  drivers/clk/meson/axg-aoclk.c           | 175 +++++++++++++++--
>  drivers/clk/meson/axg-aoclk.h           |  13 +-
>  drivers/clk/meson/clk-dualdiv.c         | 130 ++++++++++++
>  drivers/clk/meson/clkc.h                |  19 ++
>  drivers/clk/meson/gxbb-aoclk-32k.c      | 193 ------------------
>  drivers/clk/meson/gxbb-aoclk.c          | 251 +++++++++++++++++++-----
>  drivers/clk/meson/gxbb-aoclk.h          |  20 +-
>  drivers/clk/meson/meson-aoclk.c         |  15 +-
>  include/dt-bindings/clock/axg-aoclkc.h  |   7 +-
>  include/dt-bindings/clock/gxbb-aoclkc.h |   7 +
>  11 files changed, 540 insertions(+), 294 deletions(-)
>  create mode 100644 drivers/clk/meson/clk-dualdiv.c
>  delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

And applied to next/drivers for Linux 5.1

Neil
