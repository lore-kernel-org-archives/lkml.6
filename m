Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B584FC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96121523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSU+dS+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeIVRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 13:42:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33063 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeIVRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 13:42:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so3898893pge.0;
        Sat, 22 Sep 2018 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Je37oF4Yc5XjncxCG0Hnr4l1wEitjIGXgk3l7mYtZeA=;
        b=JSU+dS+Lzqa3WKL7DtKp7laClhkjeDQZF5RMSrHoqd4BxZqXBJ+QCmibm5eRGqtTFL
         kgeyZVs2I0mekzfUEoDJd9QNgzPCZmu/GSqYWer9GRRpynrdr2ayVBpzHnLlkjgZnEyb
         PGpxS9/X9zU7SOE1O4b8MX8OuMntZ51ULotisxZVzflaSmKWfB/JkbenmGPlt22PGOAH
         hadVdL/a+Lr8qtm26eCS0CPUKLQP64iP0Qo07nGUVCSMZ4kQXcBBbFZCIjEQxyAHtmIo
         Efr/f/Bq7vCJikNNGoUrZNYgU+gUtkovBPPwhQqN4/tuzjA9bgH9QGgkneorapPfYN7h
         DUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Je37oF4Yc5XjncxCG0Hnr4l1wEitjIGXgk3l7mYtZeA=;
        b=RHL5mBixT+iwKWKKo8tMKenlobYPBRC+AmTVhU/B17dkEqRzazLajOaz2bujesFh5S
         Po5VJwWgUi0JbklPN5wertSjxkEU4wQPWZ/Tdd2fDLpwT6+DduInnv+cFTjlgad3WGlV
         cgXVjQzK5PWZD0N/FnLpKnws4zsSqYaqBnn0d+Hd3Co6GfchHklY09CxaFeYCpsJGjXm
         y+Pb7SntPHjMmqRjdfeOXP4WnRjTNjSk+4jkzBKq3BfW1od13xTl/fja9OceSu9WpLML
         /9LzLAY7nLK7hYuqO26n+CWh6vdudosjbjMm3rCz/ZwjhcO2f/CPsnzsptzcnNEkBc2w
         qKwA==
X-Gm-Message-State: APzg51DNzBRY5FCIS2DnLe9iBI20SskK/xOY0zKGEdeqtmkZ07KFKlcw
        wy513yfNq6qcAoFnG6tvkZs=
X-Google-Smtp-Source: ANB0Vda9uD9SM2YwgG6WQY0zSyOWKC+Z/B0QOYQBRtnYXBN222cWBp9vrHWGq0mMqKa4WsnTOJBALw==
X-Received: by 2002:a62:4f94:: with SMTP id f20-v6mr2281267pfj.60.1537616936890;
        Sat, 22 Sep 2018 04:48:56 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id h85-v6sm47176368pfk.71.2018.09.22.04.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 04:48:56 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:18:49 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180922114849.GA3890@himanshu-Vostro-3559>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
 <201809211544.zop1vk8B%fengguang.wu@intel.com>
 <20180922113616.2d849fb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922113616.2d849fb0@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 11:36:16AM +0100, Jonathan Cameron wrote:
> On Fri, 21 Sep 2018 15:26:03 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Eugen,
> This one is leaving me stumped...
> 
> Anyone care to point out what I'm missing that is wrong here?
> 
> Also Eugen, please don't cc stable on a patch directly.  It is fine to send
> a backport request once a patch has hit mainline, but before that it's just
> adding noise to a list as they won't take it directly anyway.

Song is correct on this one.

So, just replace the declaration to:

	struct iio_chan_spec const *chan;

and then warning goes away...

Another thing, its better not to reply the automated bot and instead to
the author by changing "From" address. :)

That is what I do often when replying to that thread.

https://lore.kernel.org/lkml/20180921182616.GA2077@himanshu-Vostro-3559/

And it nests properly in the given thread avoiding any noise to kbuild
bot.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
