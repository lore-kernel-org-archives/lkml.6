Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE21C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D28208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qgsdy+a+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qgsdy+a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D28208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbeFUPRU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:17:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeFUPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:17:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D022D605BD; Thu, 21 Jun 2018 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529594237;
        bh=KrXvSLn0XNU+G48byX8Rk2mvBzAjFGIy54DTqXih5X4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Qgsdy+a+BAYGItP7FmJZ52GyOx329j8hh+DEcx1lif6CFx4H33nGQJj4dRqt3cjP4
         jo7eE0u2irO2vU56RRiiHb8cbjgzarfGzmPM7efkRQF4jwwkTMKALlG9f1dCH6bC8h
         x31PvdbVfApejWxOD+yuUy1lAE2DrUmv/SVXG1d4=
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2486660AFF;
        Thu, 21 Jun 2018 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529594237;
        bh=KrXvSLn0XNU+G48byX8Rk2mvBzAjFGIy54DTqXih5X4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Qgsdy+a+BAYGItP7FmJZ52GyOx329j8hh+DEcx1lif6CFx4H33nGQJj4dRqt3cjP4
         jo7eE0u2irO2vU56RRiiHb8cbjgzarfGzmPM7efkRQF4jwwkTMKALlG9f1dCH6bC8h
         x31PvdbVfApejWxOD+yuUy1lAE2DrUmv/SVXG1d4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2486660AFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Received: by mail-oi0-f48.google.com with SMTP id c6-v6so3288248oiy.0;
        Thu, 21 Jun 2018 08:17:17 -0700 (PDT)
X-Gm-Message-State: APt69E3aJzKS5qV9kgabzwL9d7+A7P/uzxKxCQk3PuetMCmKYrNtUHOt
        06t4y4VIX9nIGyjm3XKxMxFBqARUFB4WGMb6zZI=
X-Google-Smtp-Source: ADUXVKKm+Yz7ZcRHXuOBWJ8jwuoY2i5S7YxRTYyobXkgs9hzdZqgZeCXyVAsx3WG4QqrwObxySnCZSqZTgV/eZnt5Nw=
X-Received: by 2002:aca:605:: with SMTP id 5-v6mr15110192oig.297.1529594236494;
 Thu, 21 Jun 2018 08:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b11:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 08:17:15
 -0700 (PDT)
In-Reply-To: <20180619095430.26358-1-vkoul@kernel.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
From:   Timur Tabi <timur@codeaurora.org>
Date:   Thu, 21 Jun 2018 10:17:15 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
Message-ID: <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hwrng: Add support for qcpm v2 hwrng
To:     Vinod Koul <vinod.koul@linaro.org>
Cc:     linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 4:54 AM, Vinod Koul <vinod.koul@linaro.org> wrote:
> This series adds support for newer version of hwrng as found in
> Qualcomm SoCs. To do that add new v2 compatible string and driver_data
> values for v2.

It's amazing you're sending this now, because I also have a PRNG
patchset that I'm sending out today that adds support for v2 chips on
an ACPI platform.

I'll send my patches as-is, and we'll just have to work to resolve the
merge conflicts.

I will probably need you to test my patches as my last day at Qualcomm
is the 26th.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
