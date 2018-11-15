Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D7A2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeKPB7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:59:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41351 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeKPB7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:59:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id 14so7954237eds.8;
        Thu, 15 Nov 2018 07:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLOKVJLUBhL+nGcn2/liKi6x89A2lWkX+GN2uKqDKcM=;
        b=K2XZNcovgaKsDk7ph4uGGhnP12uvhLFqg0ejM1usg2DPZZWrigg+592ejovyh14W91
         ruEsGdAbdMbOCH2zLYdVRhKGvolwOkWl8GUmMcXr0NBD/8YMbuYAIwQGiMRy7v5sV8Db
         DHCgmkP/lNYGDNSTckOpSh6Im1HeJh/Bg5g1r6/60A9d+HzUdFMnlktSQPsGJfGRe0VI
         eyBbvfphaFlyZfop2iQ4XvHQ0Xgza3Zo/wq6kIP2jCRWBZIHYYTO19+LFzWnAdgC591T
         lDaKTJz+KYPAxIJvqwR8JUwCEl+I8Q5Db0/kxtj4yZF8T4V2kAPN5WJJ1C1mEwI3C1In
         +ALA==
X-Gm-Message-State: AGRZ1gJUXy+JFFDbFpxwWEe7S7C2wU/UQ/8K0XFZC89xyBkGq7A4jer8
        ggdK4/2LKN/CLDEspKyY62HdyyoQQUs=
X-Google-Smtp-Source: AJdET5fHvmt8HAJ+t19NuMW62WA15dD2JxUlQPfinLft/nTFtMhRT53Kb94ieP+U9/5/p6Lw3xC6OA==
X-Received: by 2002:a50:983a:: with SMTP id g55mr6301603edb.143.1542297053116;
        Thu, 15 Nov 2018 07:50:53 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id i14-v6sm3665506ejy.40.2018.11.15.07.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:50:52 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id t15-v6so18522748wmt.0;
        Thu, 15 Nov 2018 07:50:52 -0800 (PST)
X-Received: by 2002:a1c:860b:: with SMTP id i11mr920228wmd.5.1542297051009;
 Thu, 15 Nov 2018 07:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-3-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:50:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65HcoxzPJJJqXWffj+xpL9-D_fuVRh+kn83kM4rX636uQ@mail.gmail.com>
Message-ID: <CAGb2v65HcoxzPJJJqXWffj+xpL9-D_fuVRh+kn83kM4rX636uQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] ARM: dts: sun8i-h3: Remove heading 0 in video-codec
 unit address
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This cosmetic change removes the heading 0 in the video-codec unit
> address, as it's done for other nodes.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Other than the subject format we can fix when applying,

Acked-by: Chen-Yu Tsai <wens@csie.org>
