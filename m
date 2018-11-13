Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A3216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31A3216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeKNFrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:47:18 -0500
Received: from genki.is ([104.200.25.21]:43362 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbeKNFrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:47:18 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id f2047756;
        Tue, 13 Nov 2018 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=ZGlLmtrNq
        iv+mIMS3aCEedOipcM=; b=HFx/O/L0iSlG3k/+XxGOOZe6bSsJBCi5du8uK9WVQ
        ZT8Q89ak6o63DK2K5jDWPYkC9N5dW0Z4GVbxkoCyBVblfRdfpUOcRoVi4P3MvyQ5
        oLXgTT+fUECpTNZwF1fAisoVbAFK32XyqOr0h1k2VtNPOjCny3te+5dW0H45clvK
        RM6MK5Pe/kBrHu+Sj88mDZbY7A28/gKwgUojik/LayuFOHvUEC+3/N9pnyMB2CUs
        xdUBwaN6HglnnCHeuarAeWb0+yCJ+AvkOn6f7onKW1ncQHGVXpO2Hxmn5oDC17jn
        3tjR4BDU7WCu3TDBN0E5PilSqUoQWNoMz53qMpjD2RThw==
Received: by genki.is (OpenSMTPD) with ESMTPSA id bfb722ad (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 13 Nov 2018 19:47:40 +0000 (UTC)
Date:   Tue, 13 Nov 2018 11:47:38 -0800
Message-ID: <20181113.194738.514344626@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH v2] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>,
        alexander.kapshuk@gmail.com
Cc:     schwab@linux-m68k.org, yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20181113190335.GA50985@google.com>
References: <20181110.085826.230851261@genki.is>
        <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
        <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
        <20181111.174140.002789201@genki.is>
        <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
        <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
        <20181113000938.GA16783@google.com>
        <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
        <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
        <20181113190335.GA50985@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all,

On Tue, 13 Nov 2018 11:03:36 -0800, Brian Norris <briannorris@chromium.org> wrote:
> [ ... ]
>
> Cc: Genki Sky <sky@genki.is>
> Cc: Christian Kujau <lists@nerdbynature.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Genki Sky <sky@genki.is>
