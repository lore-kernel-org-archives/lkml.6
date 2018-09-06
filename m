Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA5CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="ntdFo3o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA3A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeIFVMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:12:43 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38191 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeIFVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:12:43 -0400
Received: by mail-yb1-f196.google.com with SMTP id e18-v6so4364081ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yi2igLuJhmIhzzM3bfj6xZSZt3cVTIi8gAYJ45AYoLg=;
        b=ntdFo3o60LRdVLiLO8lkSK2GrXRwh23swy4ujNUlmcJhtrBxnrvLh5FA3ZfJ171G+u
         mgtRa8idcsnSNtsRiZEJ8o1MunRJAO3jS6A6N+c4v+T3e8/rzeb3sWYtQqBBYFNSY/Jg
         WhEg+vg87xIfCnrQxQ/djWvrL4Vb0oV8c+P9jfOwqSXP0DISTi410wmyx/1Iv0bSRxe3
         GpBEcFSjt8yb3y6O+o5I8FkAHADP0d1DV3KdzSNJD+wBo+z8g13zEGOx6Xm3NjkeCdBO
         mM2P6S3e5/ubJG79fyzubaI4+FQK3b1V86344BPqrP90R8Op3ZJouJkDgfE0FFHMAvbn
         7EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yi2igLuJhmIhzzM3bfj6xZSZt3cVTIi8gAYJ45AYoLg=;
        b=DDujHIsjM9310L1lNNvXLuRwYlZqju2JeqNWGsx/skqEWmS2xfxEHwHcL7nc3ZO5Xn
         kO+lLn6JPpj9CL6/o+ZSbtz+jXiIyLkLcAG8Z9zcva9cDh03vPzn7FEmj+Z8baDYOJkE
         ++w40uZTllz4x/98n26qqxD2uyhCDG9zlT4pp9G6VCu0LwnZa7Va6lHljRa7dDktFfK1
         yDQtWcl0sn1u2JrOjSDpf6+74qlPYw0FvBOrxJc0wFREjxV5PZ3TdlmEoVGWRyys233r
         7ZwUo/N8ki36S7ZzCEp+V9s4NmGNWKQvqxDlA9SWWAoga/goaw18iv7u+Vb5p1ktuaAp
         SoKg==
X-Gm-Message-State: APzg51AxD+zYmIfEGRXi8clIlb5z4nsaoB3QEVxCqvv823/2/YHYFu5d
        zFf1cn9sDKAR8QWsdFtxJ/duHt3u93SaU9v/qN7PrA==
X-Google-Smtp-Source: ANB0Vdb7BF+Fe4ZEhxDrk9A2D7VG/N93xpM/msLjTqgEslRAfOcUWoJTMJeCeuqnKAJoJHUT0+bHDyfPsVjLhmX8m6A=
X-Received: by 2002:a25:6c86:: with SMTP id h128-v6mr1995827ybc.354.1536251784502;
 Thu, 06 Sep 2018 09:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:e106:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 09:36:23 -0700 (PDT)
In-Reply-To: <20180905123101.GA26739@lunn.ch>
References: <20180905001535.19168-1-mdf@kernel.org> <fa4fca9c-5950-8ec1-5746-91e51085cecf@gmail.com>
 <CAAtXAHdZxgvb7=DG0B2irB4wJ+taJaOYbxhGjNtjWvaAQP8_nA@mail.gmail.com> <20180905123101.GA26739@lunn.ch>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Thu, 6 Sep 2018 09:36:23 -0700
Message-ID: <CAAtXAHcXwxG3_iK9TcgTP7iES_RAZW322HJCbbbC1_xmMq1Z+A@mail.gmail.com>
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williams <alex.williams@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Sep 5, 2018 at 5:31 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Let me check, it seems there is a register that indicates whether the MAC can
>> do either 1G or 10G. I might be able to use that for some of the above, but
>> there is not really much in terms of writable registers there.
>
> Can the MAC do 10 or 100? At the moment, you don't have anything
> stopping the PHY anto-neg'ing 10Half. If the MAC does not fully
> implement standard Ethernet, you need to tell the PHY driver about
> this. That is what the validate call is about. phylink and phylib
> knows what the PHY supports. It passes that list to the validate
> call. You need to then remove all the modes the MAC does not support.

Makes sense, thanks for clarifying. I'll do some more research on this.
>
>> It's like a DMA engine with a bit of MDIO on the side. Let me see if
>> I can make it look less weird with that. If not I'll go with a
>> comment explaining that there isn't much to do for the MLO_AN_PHY
>> case and the MLO_FIXED cases?
>
> You again need to configure the MAC to the selected speed, duplex,
> etc. If the link is down, you want to disable the MAC. You need this
> for both MLO_AN_PHY and MLO_FIXED, because both specify speeds,
> duplex, etc.

I'll look into it.

Moritz
