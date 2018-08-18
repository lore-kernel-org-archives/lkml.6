Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B4C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EC3208EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MkvoxoMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EC3208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeHRDhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:37:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37319 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeHRDhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:37:03 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so8299743ioh.4;
        Fri, 17 Aug 2018 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO7gCSoxHA9g7kbmN+RPyVbzoE/IoibubnsyAFdeAug=;
        b=MkvoxoMmf2teAvRBlSXI3LpT/d2CsXwPioT/K3nguj0g9PFQ9NkO2ALfEZWGXeMpID
         hP7bQm9Rdk9VevVpzqPVCD41QBQOh5eR6bP2Ta2O2RN/DNustL/txk+CNC6SkeO376UP
         s1kIC+P9BPFKgdSw5rK4MDho5FogxY9JF/i90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO7gCSoxHA9g7kbmN+RPyVbzoE/IoibubnsyAFdeAug=;
        b=huxRvr93iejoZk0QgiO43+y385z42K9/MCkpvu4p0cjok59fJgA+TFhPUy0/UwTC90
         uadkE1AmShj9z8HzV/ghzXb+RJzdtidr4t0K9ffhOn54O5QtsltIkm0e0Jsy7gCcthws
         P1jGBRjMlWT5eI6VWIukwPYsW1+vWL/rQbMC55QRT6W33fhJ/UEOVhTOGaqHWnjFxGxl
         W+M7Le5YrrlnLuEdUiIMC8lTpJ8zaUChycSxfU0V5tWAomHC4TBbBK/hu1YA+M3XYUNh
         dgsVBOvD7EGek5Hp3Qh9WtIjnPvXVBtnoB/Pw8paYO1oE0yGYCXF+HyGhnclHuc63p0T
         2GpQ==
X-Gm-Message-State: AOUpUlEBAFQC1mBxs9I4udtpTBfPrX6drUyIBSmmkFn6PEqMJoF2mhbs
        ZFCIicc1lHW9WUP5WWrKX40GncWkn/DyQ3Srp9IoGw==
X-Google-Smtp-Source: AA+uWPw7tWHxFFt1IJd0bzEYxhQF1xaNSIpuK121aOH2BmOoPnai90hLOLPzp1m21AUsuohuEczSKrTfQwuU7UaG3CM=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr27351248iom.238.1534552288109;
 Fri, 17 Aug 2018 17:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180813012347.GA32555@nautica> <20180817023307.GA32726@nautica>
 <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
 <20180817213648.GA31406@nautica> <CA+55aFx58-vbKca_KGdhOA3cJ_M7HP=wOsJ483os=CCobi2zOA@mail.gmail.com>
 <20180817154155.ebe6ffee995a37ade029db2f@linux-foundation.org> <CA+55aFxzuLnK7E3hz_YZSNjjJ7TeMTmPrpn4rhHGjgrY2DgTtQ@mail.gmail.com>
In-Reply-To: <CA+55aFxzuLnK7E3hz_YZSNjjJ7TeMTmPrpn4rhHGjgrY2DgTtQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 17:31:17 -0700
Message-ID: <CA+55aFx2N85vSkLc4Xk7TqWsv-tYKeBfPSDqWW2Rzgb_s=CO0w@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 4.19
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 4:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Aug 17, 2018 at 3:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Please do.  I'll actually be sending you the MAINTAINERS update in
> > about 55 seconds.
>
> Heh. Ok, that resolves my biggest issue with the pull request.

.. and with that patch-bomb from Andrew out of the way, I've now
merged the 9p pull request. It's going through my basic build tests
before I push it out, but expect that in minutes.

                   Linus
