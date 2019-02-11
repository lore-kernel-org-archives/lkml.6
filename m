Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A36BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756D21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892325;
	bh=sgaSP8PRy3heCOIqssQZCa19lNFLWlTXTcO81SWa7eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WfwhXWYJEmMqt9kmWFL/wnxtUiY7VdQncjsQuObLRg+r++6fvdVewTzWjbil8BqNj
	 R/CsIJnkzDPXN0gxY1/3Q5DjidacgAMm9gh3ajNyYEzux4MdvgwcjJ1tGcrwtgfDJf
	 oLKkZLCe5qfl0bj/LXr9TCQ3HJhh8B2sdmI4pe/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfBKNin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:38:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfBKNin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:38:43 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E317C2229E;
        Mon, 11 Feb 2019 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892322;
        bh=sgaSP8PRy3heCOIqssQZCa19lNFLWlTXTcO81SWa7eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X/FQ2LK2GEizx6o8QKqOy/hi5vmoEnjk28UGaHWmrVnfjU1AhiZmTjtPSFYtik+yG
         T8kUgzq7ulpc/jCZIJxuJdsLvePB3HqIZuea7CrIJy0ATFVxb1A2YsLtTNuv4MSuPE
         v1RRXjJOD0XWfnYm737aujZ3Lfa/mzE2IdiAOOdQ=
Received: by mail-lj1-f179.google.com with SMTP id l7-v6so2206679ljg.9;
        Mon, 11 Feb 2019 05:38:41 -0800 (PST)
X-Gm-Message-State: AHQUAuZ4R2kVKlTme+YiB0UwhO4ishdz8Y2WFKR53j4+tKe6h2cNBNXP
        L8tFf2xjrRAEBhTGifojMPtLT4fDqKYsG0jiCM0=
X-Google-Smtp-Source: AHgI3Iar4XqSKyP9ql2nM8BPbdauVRxCngTA2LbOvC5S9UFbhNVNp5K4WZiRUYHIHreKKXQeUiqJlN51apOg2MQaANU=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr23386870lji.113.1549892320127;
 Mon, 11 Feb 2019 05:38:40 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170102epcas1p445f2a5d8e70bc3a6e42424034c2eb34a@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-6-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-6-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:38:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPewC4XW_+_qQt92+EZqm4OMs_L-mkEOt+t8iiWYcCfWzw@mail.gmail.com>
Message-ID: <CAJKOXPewC4XW_+_qQt92+EZqm4OMs_L-mkEOt+t8iiWYcCfWzw@mail.gmail.com>
Subject: Re: [PATCH 05/22] ASoC: samsung: i2s: Convert to single component
 with multiple DAIs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch includes minimal changes as a prerequisite for adding support
> for the Exynos secondary I2S interface as second DAI of the I2S component.
> Doing it that way allows to avoid problems as indicated in commmit
> 6b01e0365b1689 ("ASoC: samsung: i2s: disable secondary DAI until it gets fixed")
>
> The samsung_i2s_get_pri_dai() helper added in this patch is temporary and
> will be removed in one of subsequent patches.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 192 ++++++++++++++++++++++++----------------
>  1 file changed, 115 insertions(+), 77 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
