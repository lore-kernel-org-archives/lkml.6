Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D81C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553CB21545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f5yM5+Z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553CB21545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeHPAzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:55:40 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38612 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeHPAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:55:40 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so2264173iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYUWuY0Omsuyw6K3QcpD76/mcnM2SiezVSHyq0q1umE=;
        b=f5yM5+Z3fsxylN18CE9vNrWJ7nu8yFq6nXDRfMt6yLoCWJBO4IABqpDFGuHiXA0vBG
         yhmYAH/2RtxB/h7KCmPeEr+jM18pxSx6MXSTfSRCjM0BrNaFIOUlxFoyTW3gwuvtw/97
         DTea3B995wJZgx3lOcgCOwVSXlDnAQTId1gN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYUWuY0Omsuyw6K3QcpD76/mcnM2SiezVSHyq0q1umE=;
        b=alfQByzOOhpzGrMl+k1ViUOtl74qvJX6VXXQQi2XvGA96Ql/XAcmRle7XymxaHHA7a
         gVfRO2CnqnJdGwpdig7PAiLGcIEtHLpco1LjVvZ/NZvutt451/IBIH5PgLnfmzrC4dum
         iBStSa2U9yPWnubGBQ0B4Aeq99qCUEdv6pRwaBcgPxNTLZTqjfkEuQ+C6Hplhn0h+TaM
         XBahbwMrXf+/fSolSmb5VqMhOBkB5GOriOTZg7qvqMxz9jD/7gle9mnGXSgLMXoMRTFk
         MrU2Ylw+LvAb99ruUo0/CqFQ76lgqfeGbSfjr1i9cUxizeIoZeMvcVGChCftV1WePMnV
         qf7g==
X-Gm-Message-State: AOUpUlFI+Kgr2RZhC/+tRMGAwMlI1yrP3LX1sdYpKMgbq/tQU5YW398v
        rQPj2ICGTmIp2JOLH2fZUVG0tPAXosynD3y66so=
X-Google-Smtp-Source: AA+uWPz3oI5APFWcMxo5UXWOJa/YbiZ1ZOskiWkT6mMKv532QfSbSbhiULc50+ZElSQpMxaLuJfhESn5GCszneOYBm0=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr10846790ioh.203.1534370497831;
 Wed, 15 Aug 2018 15:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180815194244.29564-3-yannik@sembritzki.me> <201808160443.5h16PxVs%fengguang.wu@intel.com>
 <1bfa03ed-c9f8-d0f2-700c-c93e96d5b99c@sembritzki.me>
In-Reply-To: <1bfa03ed-c9f8-d0f2-700c-c93e96d5b99c@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 15:01:26 -0700
Message-ID: <CA+55aFw1oaRiqAU_61BwqS5QWS2VtZ6o9cAF3YEVx2NfMkmHpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [FIXED] Replace magic for trusting the secondary
 keyring with #define
To:     yannik@sembritzki.me
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 2:19 PM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
>
> +// Allow both builtin trusted keys and secondary trusted keys
> +#ifndef TRUST_SECONDARY_KEYRING
> +#define TRUST_SECONDARY_KEYRING ((struct key *)1UL)
> +#endif
>
> Sorry, I've fixed this now.

Actually, just remove the ifndef/endif entirely. There is no possible
other valid #define this could have, and the header itself is
protected from multi-inclusion the standard way.

                 Linus
