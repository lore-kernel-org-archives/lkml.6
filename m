Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968A620841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC/Vw/Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968A620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeJKVdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:33:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46309 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeJKVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:33:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so9904857qtk.13;
        Thu, 11 Oct 2018 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gbuFfQfhIeJeuxXP12cspPT8w0L/JAhgWCZGi2jARvw=;
        b=mC/Vw/JkAmQKisIzu85Ije+ern2K07uvNymAnmQ0OocB65ANVsPDPSHtPFwlfOI2ii
         7b/Asj4UMljHN3AujoDS6F6lfIAaBl3+OQOeDyhdBJ4pMLcUodQhYSxG7sMh+5MJOjDD
         c8tGQ05SHL0XtMNL4UeQiJKitbdfyAv75JsybsT4WtlnN+BIJnrSxlqzNL/uh1OrUYXB
         rhe6nsjoBpAz8Jvy90ziFT78pdFEWZ9gpZgQhwjuJYcuhFB/xzxlLfhSrs84OPRVr09F
         P6AVDMEckbAv72YhdkTWmyTNhKH4CzXm3ijceVlWMlLB6N60kQVLNtU3Iyjxj/z686r5
         mODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gbuFfQfhIeJeuxXP12cspPT8w0L/JAhgWCZGi2jARvw=;
        b=Wvi9QSlfd94nAwxLdJ7YQx7VG8bLq0CLgtiZmNgKneVmxq9vLx4zYMlm45soOrNFui
         9jaf5X4dmTFj6JQMG7IevZPQT8o8XVDjQQiLnSIWgpuKEkJw3b/jMyOwEFZjJ2R+5OdS
         BphUXkHhVfCXfJAo3DTcO01FivsgZN0fVn/ZBnhQmhEE2CWHOmhWWNCmk4fzas9gFbNv
         uKCTffgaBXm0vXCJ42FPcbmG5gezoJZcG0BP5dIy08HHX3TyB3IBvf92b5dMazW6vUi3
         AVpg83Cy+U3vM58NnOLjjNlFpF0Xe8Nx3mSpFKZ4z5huTM+4Euvw5InZuLK4GtmOUZwK
         GV8w==
X-Gm-Message-State: ABuFfojJmTPOGprBhfazZ/dAwEfdGM8UAzx6TrOBIwR/ZZmJASzP73k2
        +x/DSIm0qPF8x7z3DAlyf9i3FdkkghEiVsRlYegAwQ==
X-Google-Smtp-Source: ACcGV61QTo6XsUJOkC39Da+cgL2EyD6RRfZSQANP4VHVuXDCk2YCP5AYDBMD8k9uESqJykhVUXuYin2/veQJjhDYFNE=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr1731248qvl.161.1539266762445;
 Thu, 11 Oct 2018 07:06:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 07:06:01
 -0700 (PDT)
In-Reply-To: <20181010182558.7034-3-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org> <20181010182558.7034-3-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 16:06:01 +0200
X-Google-Sender-Auth: z3ndNZME5IEvbJfpyouBnXc_vIA
Message-ID: <CAK8P3a02M-1sPeRY+gfouVJptxSGWuB714C3YwgXuT4O=NMauQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] arm64: dts: exynos: Stuff for v4.20
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
> tags/samsung-dt64-4.20
>
> for you to fetch changes up to 2352ae1306974528d11fb9c7dbf2cf91e0dd2c31:
>
>   arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2
> (2018-09-24 19:30:54 +0200)
>
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v4.20
>
> 1. Use graph between USB-PHY and MUIC.
> 2. Cleanup of SD card detect pin level.

Pulled into next/dt, thanks!

     Arnd
