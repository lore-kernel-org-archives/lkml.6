Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DDC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2D82804C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeIykoxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2D82804C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754989AbeF2V0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:26:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43704 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeF2V0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:26:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id h2-v6so5100771ljb.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GLaNskfRiS2MxK9/phAVpzl/k5gQMSLMuH1z3R4CeRo=;
        b=FeIykoxUCGsGtvQT5sFAntSyxc66MQaTzSgtB13veQuisSlj3dxZpQy4b7Mnw6O0Nd
         3b82ZnUfueDefO/fExUYWiCMve7qAnm8w6F+GIs0nf6JPWDx+bttICl/MhxUjit5jFqE
         VggrahHog0QUem4eGBHux5n0VWGxZv6y239l7I9IVSNBJyPW+FH4a9Y3MrMGQMZGRfkc
         27AURdlP64qDKtCuEYcE15Ta46uPAWh9XMz1HS2s0KVzWUNl/kFZlJpqJRGkbnkRv2c1
         m1o+aSLKaQhIOsyrGruxkcKvHdglJgnjKm/zlRvTP7AGWtb30wWCOzo1axp9cOeCwJS2
         WZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GLaNskfRiS2MxK9/phAVpzl/k5gQMSLMuH1z3R4CeRo=;
        b=K5ZS0Y4Vj10PbzdaDWBVTe37PxfRtZPk4z0wTCe2bBS+hzVtxznKUYmQyAoBPF1+Nn
         gjtTJDzXm6tEYubI933/RzXntR7yi0jyFI0qDA044x8f29w/q2iY0nlXWXXHtNWRC/Sy
         jU26ItL/5PPyEegLZlYgLZzj5faBNbCCKCqV9trw77gCSvkcxuICKij7ue8ZiNdiR88A
         PHt5RpF4iveaw1SaRL3kaU4lf3/RPo/sxUxg5uy2IyFLqZiECoatXi74/UbEXMnGitOT
         o+SimHXiqXS5wKtGzzpk8q+AoBlAwi+rJJ/5M3ntai8OZ5sSUjlOZWjjdpgor4PF033/
         B7qw==
X-Gm-Message-State: APt69E3aoDoUiZNWPWAIs5aBpVG2EpUbjpe51THRR07o3x/zrT83hDvW
        ktyrRqGPQY6j8W8kmTEpqyC3Ux5p7O0Zwi+HSgg=
X-Google-Smtp-Source: ADUXVKJ0/aWcDYsz3NL5uDOj2fgrhmWgaRc79Xhy6vaeP7mGmPxSK4OKQOQRA8gkKzYKb6DNfY3ik8CuRYAJ4Gdym90=
X-Received: by 2002:a2e:9a95:: with SMTP id p21-v6mr11018933lji.60.1530307588902;
 Fri, 29 Jun 2018 14:26:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:26:27
 -0700 (PDT)
In-Reply-To: <20180629184536.GA37337@beast>
References: <20180629184536.GA37337@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 23:26:27 +0200
X-Google-Sender-Auth: OiXo8xYTwoN2LGNNH0NLOy8-oE4
Message-ID: <CAK8P3a1+MCxfPdQVXnm2jyQc6tGtV+wpV=_2+tPRBirTvPXTyw@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-cci: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:45 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the VLA in favor of a maximum size and adds a sanity check
> at registration time. The sizes are all explicitly enumerated already,
> so this just collects them into macros.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Looks good to me,

     Arnd
