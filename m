Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CBC20873
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zzZyMT4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CBC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeIIGGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 02:06:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45758 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIGGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 02:06:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so14761944lff.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RuU0i/zDt6aoNjAAm8eAaoCEwdpvnEe7Hyh7uB9IY2s=;
        b=zzZyMT4iFemsdOAGGcYZnMWR8N/3wreoBCdvChbMHNfOigcg1fzGTY622ylmE/op9Q
         pF6IXdZLQIkOmf8OC+GPOJiOu1QH2wX98vKhmkRBzu8TX+SIvV6fOcLqB3iunBFF9p0f
         PSp4Y9Q8jNeaD4zj8UwXNt2jjFQLQm+iU3Jq+pKb7bejyitl1fZYFDOwTSyE2FTTLI0C
         Fs9UytoN3FffxXMlk9UmAtplWhKBKsSp4jYEJyf1LNy3Ynr3bWKNM88fFW6AWvk/MnUY
         5up3TCeW3Ip1gekIzINp1v8yEbbtoFNGWQh7RWgVs8qin+MdchhVhXQqMcLDI6OTOinC
         jm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RuU0i/zDt6aoNjAAm8eAaoCEwdpvnEe7Hyh7uB9IY2s=;
        b=SWlCMSggzkVfFqkQi8DP2SJa9gSjunlFiRshS8GaWcDq57JwwSV5XRrkULr1HiYrXw
         CiD/gK/XaVSHh4fA1qbEgDhCZ4lQNXPlp7k+HvN283F9fax2Jr32AJjeb5UhIQq6kXfs
         OQDZBLD2HNNdZnpIxRhC6XfkGtb+oRRiOWMNIKlUYBbMGdYB2+ngcnNe30CNTWT3cASJ
         QP8oFLd6HO8RhX6BhH2vnuHF0/085tqDFn/czLgKETrltUy1tXmwIF2WhUoARRFxqDHn
         QyOKE43NkH4LhoAmYwDjhTIT3C9Uz5g4pbo4e6uwi8kV7Wlx5GbnGxlDB2PyhKZ0T1fQ
         A/Xg==
X-Gm-Message-State: APzg51CwTtvLywp3APwY82UWD2vk4HjOJjqnwT5gMsJ/ILiHWOgGy90+
        GbRBJ0rTBDU9do5aOe8s0BvQm7K9XcYEIrbfotigoA==
X-Google-Smtp-Source: ANB0Vdb0EMrDrGuIFN38XA70gSDrRYplGiLKE+0RCzyvuZDEx/2eM/T+32vd8U27TuT9Tl9FBRA4wR3Lm7xHNc4DAXg=
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr8519165lff.33.1536455934587;
 Sat, 08 Sep 2018 18:18:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:6413:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 18:18:53 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <1533318808-10781-4-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com> <1533318808-10781-4-git-send-email-jollys@xilinx.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 8 Sep 2018 18:18:53 -0700
Message-ID: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt@codeblueprint.co.uk, Sudeep Holla <sudeep.holla@arm.com>,
        hkallweit1@gmail.com, Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, rajanv@xilinx.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
>
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>

This patch worries me somewhat. It's a transparent pass-through ioctl
driver. Is there a spec available for what the implemented IOCTLs are?

Should some of them be proper drivers instead of an opaque
pass-through like this? Could some of them have stability impact on
the platform such that there are security concerns and the list of
arguments should somehow be sanitized?

What's the intended usecase anyway? Just a debug tool during
development, or something that you expect heavy use of by some
userspace middleware?


-Olof
