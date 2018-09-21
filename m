Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EEBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8731821532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="O8X7yMAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8731821532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbeIUUnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:43:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35906 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbeIUUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:43:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id w17-v6so13295306otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rj5JixjWhunjYfdqKNjucr4ipsqOXNSyjU9PcdnsW9E=;
        b=O8X7yMAs3qsAnWLbKka1nEKdzxMclubqzL6Ey6lxJRafhJYsHARSWSq5rytRcJ7Zr0
         ht+1G5wp3cabYdC9FLRG1O8AfFTpYOEO5ztrf18vfouZixCM3JFQSnImejCjk+eDlQjP
         M9x1tggRlaDQHMrLa8uoKjwpaYOyeNiEIqyFnT3s+v269ternBikFu2HzxMeI0PpML6t
         ZlgSNUsSFtzjLgAht5VGRT6/tFFO7Gai0BTygRPJI/6lvBCBUZScnu74a3ML9L2PCFYo
         v6X5LB0YCi0Jx7T1+YsR+oIl+2115UDhvvX2R2ypU6qE+M8FkE/1hov8uQ2WM9zf7rep
         hUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rj5JixjWhunjYfdqKNjucr4ipsqOXNSyjU9PcdnsW9E=;
        b=oTpKwn0RKRW19RA/bGMtX8VhibO2Q4R0aqTeuFwxDawAusUV9uCZRVOIhHEjb/vy40
         Hqs1gW+dqdUc4EqzCvDQZlwZJknjzAs8wVDvR3Tfjlq6b4K7UzCkpASC00mnU/MOI5Qo
         6D0IrR1rbEbWzY85qy4sL1thiL06Etq236+KMxF3KP8+lP3di0AKsBjOsCqfYiVZOiPq
         B8SaLZRCtaWtPP/j8j0DV9tR4Tcr0YMVYi77mA0SFdSWsMe94MDSZyP1HVl9qOHJfMPL
         M+I40mbgQDx5wQAzXusfSrOKpV6G7TnMaqB7PQd+yccrEMgKpVLfD3M9eQ3zebRwhJnq
         aw+A==
X-Gm-Message-State: APzg51BoOZN2nHcNA4kkd7nJA5rgjOGrKle1nN6UxLulEG4ik91ho6mk
        dtfjSEckjDx5rqcP0rKElmbxSLIegoBSxSkQ9HRw9g==
X-Google-Smtp-Source: ANB0VdbamKabrpQrDJgumqLPHgaet/bwlQZdgon1AD6/eZlpclMcM/yydfonZysEnyKB9q93PPY52TPluuTh/7iDw+w=
X-Received: by 2002:a9d:33a7:: with SMTP id u39-v6mr27113480otc.215.1537541659309;
 Fri, 21 Sep 2018 07:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141815.18737-1-rodrigo@tjader.xyz> <20180921142811.h5jraemk565alh3i@flea>
In-Reply-To: <20180921142811.h5jraemk565alh3i@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Fri, 21 Sep 2018 11:54:07 -0300
Message-ID: <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:28 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Expanding a bit more that commit log would be helpful. What is the
> eMMC connected to that board? Do all versions have it? Which modes are
> supposed to be supported, and which one have been tested?

The terseness of the commit message was already pointed out to me on
#linux-sunxi. I was waiting for more comments before sending a v2.

But you do touch on something I also realized: there are actually
three versions of the A64-OLinuXino. In fact only one of them has the
WiFi board, which is already enabled in the current device tree.
Wouldn't it be better to split it into three separate device trees? I
have made a patch that does that[1], if you think that is a good
approach I can submit that as a patch and then later submit a patch on
top of that to enable the eMMC only on the two boards that have it.

I only have the A64-OLinuXino model that has both eMMC and WiFi. I
have tested all three of the split device trees on it and they worked
as expected.

[1] https://github.com/RodrigoTjader/linux/commit/9f7cb025afbcb4b40d24c038fd976c7090d87d24
