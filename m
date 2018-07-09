Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7620878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tM9FI7oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B7620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeGIVxR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:53:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43647 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeGIVxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:53:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so14572979pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Rb197f63audEDhgGHXOfZ9T6KTJ3ow7ZlhCcehNTPXQ=;
        b=tM9FI7oozHfpyxMpDNLKSJ2uFTjxIx/oGffK6/ottFgGBOzUm7mbYEKdok6Y8fSuDN
         xr1fanL5PehL8oaWHDdv2LR1bUYe2ULh0kThr1k8BTGwrFSljow9tVQYAVJErrjX5ZLa
         WZf+IssmLXYhigZZ1eGuEt2dNTHoOGbwah5FzR2m1SFuytNKuoUMca3WS3wxqt30z+Z0
         58cDSd2XVPBTmFQeDduWDXsVSKQdeN/d8CtIvJ5Yo+TzBFkICXZ/SSdJXiK41NUogI6a
         q/E4yFvak8Dkt5A/oES+PTks6pKJWHn4vaJ9arvQMNCnflEAN50LSGscTTzabBitcggR
         jwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rb197f63audEDhgGHXOfZ9T6KTJ3ow7ZlhCcehNTPXQ=;
        b=fGEmsAe39/1bV5AjsYfOWNHVhbOq1MD1X79M+OyRtMkwHER1xFErprEQXtoTf20tyW
         s0iRDUuzmGrFagLTSvr5w0aUgpNrTrlT3IdbAGKBatUP8eFW5jgHGsv36YRkHeBanJl5
         mPrfVF8c2dCO3KD1aSGpUFpD8x15te9Z3Re3G0sSf4/BCLZeGtR7PiPxq6wrJ9ENYrMF
         kqLne9Wz+4KZPXU5mpsknwDU1LK8pN8S7GL4WX4oqzJXLratPkDRo/JZZ655qfZO6F5R
         jUdSjCt1kuWunVK0TGVUt6XZhlVNnde1HILy5du2wezGCe6pSjTOtuV3ZJimBFFQiA7k
         l5uA==
X-Gm-Message-State: APt69E3tmtSYFDS08UKZ7rrz1gwZJwC3U/B1/6jvNweD+iVjeuAt20ld
        veUXJXjCv3MFF8GM08C7RGdI4g==
X-Google-Smtp-Source: AAOMgpf8IIv+BRZwNOmCri9N1Izl0KdPOUnFnNqLYb01E9RDDqq61s/4IaLvUB1JquT4e9WPFfIp6A==
X-Received: by 2002:a62:dc8f:: with SMTP id c15-v6mr23032212pfl.155.1531173194669;
        Mon, 09 Jul 2018 14:53:14 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id v30-v6sm40624463pgn.80.2018.07.09.14.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:53:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM64: dts: meson-axg: add the audio clock controller
Organization: BayLibre
References: <20180706144305.30116-1-jbrunet@baylibre.com>
Date:   Mon, 09 Jul 2018 14:53:13 -0700
In-Reply-To: <20180706144305.30116-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 6 Jul 2018 16:43:05 +0200")
Message-ID: <7h7em4nkja.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the audio clock controller which is part of the audio bus
> This controller takes 8 input plls, and the usual clock gate, from the
> main clock controller. It provides the clocs for the all the devices of
> the audio subsystem, such as tdms, spdif, pdm, etc.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Resend to fix typo reported by Martin in the commit description.
> (Thx Martin !)
>
> Kevin,
>
> Please note that this change depends on the axg audio clock bindings [0].
>
> It explains the problem reported by kbuild robot
> It will be part of our PR to clock in this cycle.
>
> As usual, I've prepared a topic branch with the DT changes for you.
> Please, let me know when you need a tag on it.

Unless you're expecting some more dependencies for the v4.19 cycle,
please tag it now, then I will queue it up.

Kevin
