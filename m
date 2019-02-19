Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D143C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4883421479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i31TQv42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfBSUoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:44:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41716 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:44:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so11316893wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zuctJZe43Bj7eQw9GFG1honXF0uFsp2TN6kLJwJyV9c=;
        b=i31TQv427o1KztWmys6C4XOq8+lQl2LHfqJs9nSdtfOkbdGhtg11StTcW2FzWhDtX1
         nuHNdeizyFXTPWbBpeAo5ikT0jpQDscK+owEpV7dglV5CfXlMZmQuqGtZk7XXrTv6OmK
         qQLrWd3CPSuFbDisU+I+JzbP02PfX4B9N+0HkSzhneyWjItADzqoe9nzwfB6n0pgtCIs
         Rw80/DhWFv+PDxBfVh+2jOvIF8GV1UdvO3h+PBXwubemaBXe6KovgK8gTPsdHewwzg4s
         bsW0p0iP8RlgDRO0+unr34HqD5qPx58okMkL6o4y4Nz9SYT/ZRiBVuxd/MXWYWVbTYNy
         9GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zuctJZe43Bj7eQw9GFG1honXF0uFsp2TN6kLJwJyV9c=;
        b=XzrHFpGyL2K2kXnUVrcct4P9nXAVUh+O0v4bZYx5DtzHA5Uazu8JtlYK2UJQfj4cBz
         28M3sxRmGQz5Gb5mNpYtSGQxSoSdn5RnE85rEcVezThTKOfsuaJ4CC9i8GD+Pt3mBoSx
         2nbZcyxZv6ypZMcwpqSRvWxUmVE1jWhB/Q4VzS1DBUQYIBhiLTvkRq/Rg1GFW1GtaZ3c
         TVKqvCB3owCQNPgDQ7Mq9mb8m2rJS0atP0TDp3/CYor8MoQd/5HwEkxVwvjuQnr6ikpV
         YYn0QEU2ccdTJ7Sk2sFSR9qDsnldGDrNQneNeMotXYj7yt6qp1SzldR552kNByhnYNOv
         4DKg==
X-Gm-Message-State: AHQUAuZBewMdsT1VW1QBieLYhNLIhgMrCfQEqLhggwVtMfzTtanrG1sY
        RO8x8ou+QRsf4ZdK3abEPHI=
X-Google-Smtp-Source: AHgI3IZ3l4faKuFELL/NN1dEeIBNu3ezW95Pv2g4x+rX5OhTyk/I9SOZs6TZAaUX2s02EvlKR7RGBw==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr22115073wro.249.1550609056343;
        Tue, 19 Feb 2019 12:44:16 -0800 (PST)
Received: from felia ([2001:16b8:2d99:800:2146:580e:1091:7c])
        by smtp.gmail.com with ESMTPSA id c14sm22192643wrn.12.2019.02.19.12.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:44:15 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 19 Feb 2019 21:44:13 +0100 (CET)
X-X-Sender: lukas@felia
To:     Len Brown <lenb@kernel.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        Jiang Liu <jiang.liu@linux.intel.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update simple firmware interface (SFI)
 section entry
In-Reply-To: <CAJvTdKnui1i4pswtNWPKG8RBHBiSgv3H9Xo4bW_Fdn1MtSwE3Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902192140480.20286@felia>
References: <20190119200719.5686-1-lukas.bulwahn@gmail.com> <CAJvTdKnui1i4pswtNWPKG8RBHBiSgv3H9Xo4bW_Fdn1MtSwE3Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2019, Len Brown wrote:

> Acked-by: Len Brown <len.brown@intel.com>
> 
> Indeed, Lukas, I believe that all of the systems that will ship with
> SFI have shipped.
> It is probably time to delete this code from the kernel.
>

Len, your answer suggests that we should actually set the status to 
Obsolete and probably plan to delete it in the kernel soonish.

If you can confirm that, I will provide a PATCH v2.

Lukas
