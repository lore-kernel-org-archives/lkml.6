Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2486C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAE42086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAE42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbeKPCB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:01:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38568 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbeKPCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:01:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so17128010edi.5;
        Thu, 15 Nov 2018 07:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kelFFckd1xIAuSP72j37DURaRioIXquCJ6W4bnoWbg=;
        b=U+y6AoXc+MPcF5L5Msdy1XCEVghGSM5suuUOLoJglYV38cHUajz1CT8gJr9/890h3u
         sRXBNA9HwUFxhmaEKNPDqXCgoaPQsHBzJEB20b+mVoTcudRr1rf/0iBX7d0YPGar6K/4
         hCxOy6bibgN+Tws8D/GvZeSkVSIEbpzsPPkiPHe9H89eoIadLcgs6j+st9F4IYLpGmYR
         kFUwoEyhQbs/Kck3o5kavH9m1R+b3iu/3jYPrZuZ9WTvkQyx+EqummLhjBru9hK9SELQ
         Qet3H0KfRpb4SoPNfap2/tSnIVZQIHtq/uT35DKRIo+fsaksp/fnXmabshA2HA+w9Vb2
         DCfg==
X-Gm-Message-State: AGRZ1gKw8SjPq46zCmBQIPx2Tjt5gXR+wuDa0Rsf2SlukBWzItEFw63n
        sX3Ee5/88qp7RCODM0+g74o/Sn4Devo=
X-Google-Smtp-Source: AJdET5fwCY+cs8IJUDLCshKwedtEM0xhxeB7guwwWvhfxBVWJfgAJi1Qv5qZHqWUkOUWuZIp30Y+cA==
X-Received: by 2002:a50:998c:: with SMTP id m12-v6mr6364504edb.7.1542297211799;
        Thu, 15 Nov 2018 07:53:31 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id x35-v6sm7910585edb.24.2018.11.15.07.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:53:30 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id p2-v6so18372194wmc.2;
        Thu, 15 Nov 2018 07:53:30 -0800 (PST)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr5577531wme.8.1542297210182;
 Thu, 15 Nov 2018 07:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-5-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-5-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:53:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67QgaeAMPrPagHnn9+gw2hsY7z=pA4bgOg=wSbEnG86Dw@mail.gmail.com>
Message-ID: <CAGb2v67QgaeAMPrPagHnn9+gw2hsY7z=pA4bgOg=wSbEnG86Dw@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: sunxi: sram: Enable EMAC clock access for H3 variant
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
> Just like the A64 and H5, the H3 SoC uses the system control block
> to enable the EMAC clock.
>
> Add a variant structure definition for the H3 and use it over the A10
> one. This will allow using the H3-specific binding for the syscon node
> attached to the EMAC instead of the generic syscon binding.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
