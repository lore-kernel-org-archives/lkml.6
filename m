Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D07C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587F82087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIPclmrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587F82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJKUyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:54:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39749 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:54:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id q5-v6so5386779qki.6;
        Thu, 11 Oct 2018 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dt83Pi/rVp6FIYbx+x9QPrk46RYuvrNeS182Lvihmfg=;
        b=XIPclmrh77SgnXr7PDQj3Yqaa0JKPYmyom/nlVXr+TmeRrH1eCp1qAzfgGGJ3JOT+S
         R/+M2I6pFQCn0b7+rjxf/wC379jGutCW4cd1O4iheeSc/c8yxNiKgwk67f0/OyceMoAU
         TdcvanEziJX/Lh5uVj6mzWvgKRetBj719DrE+yrwTa8rRIuF5Y2aYCG/Jkkn+14U3g1X
         46tb9gWq3PevERpQn81+xxpb/X51FDkvHcFXBU0U2cJbgvTT3O2t4QiwjWFy5BH3BEmF
         kJx3VCJihHHCJG2vrhx1btrLX47g7Zrv82Er0yy+snbW28htOVuw2vIgDk7VQcrPsEjo
         HN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dt83Pi/rVp6FIYbx+x9QPrk46RYuvrNeS182Lvihmfg=;
        b=obIyERE0Oyhyl9q9WbiotDpLTRerdLk2Odn17jde8QtMfUJyUiP8ss1jvE1kJEhhha
         zwZgmFRXkhJ06AAHL8lBSmW8RihwX0SlgVm+j2eOXuYeqofcjDjadBE/I/7OPItjBgFn
         V7G/Rh5X/P845L/vXOwCIob1/QOba8Eu4tjtK0qo7Q0GUc8DqTnKEYLjawi5woaXqLw1
         9NDr5yK9vMUtKu1SuT2EVDyYeU3KVOy93/rkIbUK5YYB4pG5E3r0cmpt4c5cpneeFarL
         OGsjpESmMsbCWmU66Szj2ePBlj9XXRo2hVNQPWW+Le8/ZhzdALNOmewuakk/Iqbtf956
         JX3w==
X-Gm-Message-State: ABuFfogOjcwTudj3q35BnWM9WCoa1l4HHi+xdauO63idkpuh6H/t0qPW
        PuFSmDeLGNZeD7uJ1c2sfu8r43LRv5A/sTmhHZY=
X-Google-Smtp-Source: ACcGV60izudQJLd8foCdAqelf04o+1YyN7TXyO8KZLTzzovYhCn6jaxaf4HXlAZ5zSLO8MQxZhNe+JnehGw5lHzxO7s=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr1436721qki.330.1539264459922;
 Thu, 11 Oct 2018 06:27:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 06:27:39
 -0700 (PDT)
In-Reply-To: <20181010182558.7034-5-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org> <20181010182558.7034-5-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 15:27:39 +0200
X-Google-Sender-Auth: j6mG98nvDoegZYO7WPe3hLO4EOI
Message-ID: <CAK8P3a3Zm0TA2LUenrmDusPpCMa2c1B3-TY3VSjYzaM26_=t5g@mail.gmail.com>
Subject: Re: [PATCH / PULL 4/4] arm64: exynos: Enable generic power domain support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Generic power domains are needed to enable support for Exynos power
> domains.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to next/soc, thanks!

      Arnd
