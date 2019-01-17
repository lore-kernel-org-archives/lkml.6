Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D7920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W4SndBG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfAQUjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:39:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53161 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfAQUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:39:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so2476171wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AMH7YbOdg2Vw/ywsYuiaFgHHvXIsGR4Fj5IfkQierxM=;
        b=W4SndBG36Hb0fR9tjjWQPIe/j/UhrXHGn0+LSZSErxLFROJzswgyx6OsbL9b99tDKP
         ruj2EFs6LQSa3O5pGXEFwSpOdf5zms5vzbYLmmVoV0Y9QTtJjk5k6Ju7cldKWHB+yYeY
         0oy1Mz00lqi8OVD8wulaUB1djWGFiEDfEtJa8/WVXpjZZC/e1CYOauiu4Cu79Kn8l2H6
         2LhHlrS0/Y4q/8PI+RMqCBchwkzbPxhJ9FFmsqCvDX1jeNEActsArTs7OdQipFbHuTaP
         dNiZvsCHNnKXFx1WyYx4jyZOvyoFxOUhrHAStTsJiQL0OYBJcLkM7C77fpkwY0OpxUwh
         V84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AMH7YbOdg2Vw/ywsYuiaFgHHvXIsGR4Fj5IfkQierxM=;
        b=XEwjjCWLKfx7yacmdwuzcO7op3Dfu+T1vjZgPjR6Jye5gRK4jeirqOw2FZIT3I49MO
         6NcxUj2l+XWEmgpoep9lVlP5Vc5aYB/8Wxx+4JhlECTjcOSytIsFpGOuz45rjSxmxAYL
         u3wdw9pn3xqFrIFpXjQumlVeQLlTqY8jt2Lokqyb4l7CfL/hX9OCNKKqASMhT7k60HG/
         rXv2BMrJg9LM0yh6INCkq9Ynsk4+9g9nvm2dOydrGXXrNiwjpg3GrZY557KAHY8WN0x3
         CRGvPj5vwZ8BSadgacR9PXXLoyzI1uJ1i103QfmVHkPCWFpL9I9s/w8tpyab3kFeN1Ob
         msPQ==
X-Gm-Message-State: AJcUukeIAfB/8CVESgvhMTEsEUiH+hgcRm94yKo4rj3vKP/Wv3SSys+4
        SX8lVj8ceVstkvOAefbWaTyGAA==
X-Google-Smtp-Source: ALg8bN5TDA84nVo71jpNZCJl0sbhmoIwt/2aGlFca2bVairQHl0kPNsV4oyyGXACEMO8trS72TpQ2w==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr13016697wme.122.1547757546511;
        Thu, 17 Jan 2019 12:39:06 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k128sm52082162wmd.37.2019.01.17.12.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:39:05 -0800 (PST)
Message-ID: <ba1f56258e7873041a0f75996e376170563c9e6e.camel@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 21:39:04 +0100
In-Reply-To: <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com>
References: <20190116165236.8330-1-jbrunet@baylibre.com>
         <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
         <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
         <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 21:27 +0100, Martin Blumenstingl wrote:
> OK, but we had incorrect documentation in the past. did you check this
> with someone from Amlogic?
> 
> I'm curious because there seem to be two different approaches here:
> 1) hiubus name and offsets are being fixed within this patch
> 2) aobus is being dropped here and re-introduced with a different name later
> on
> 

because hiu exist and aobus does not, for which both the name and size was
wrong

> approach 1) can also be used for the "rti" region (at least in my
> opinion, the patch doesn't explain why it can't be done):

THe patch remove aobus (instead of fixing name and size) because, of the
multiple region documented covered by this 'made region', I did not anticipate
which one will be required and I did not want to add them all.

Better to add them as needed, which is want I done for pinctrl as you pointed
out

> rename "aobus" to "rti" and change the size to either 0x1000 or 0xb000
> (both values can be found in mesong12a.dtsi from
> buildroot_openlinux_kernel_4.9_fbdev_20180706)

RTI is added here:
https://lkml.kernel.org/r/20190117103151.3349-1-jbrunet@baylibre.com

I don't really understand the problem ? result is the same

