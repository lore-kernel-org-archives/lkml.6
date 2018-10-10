Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76731214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wX9pYOIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76731214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJJRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeJJRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:31:25 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DFF214FF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539166198;
        bh=xEQ8madIB8bR2DEAjgslyqEK1pQE4mMeQoTcGL52gHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wX9pYOIj//ctLMT1HMNTYWmBTSusXxyqKVkhwC71cqXgIKIzawG22357eq8On9kK+
         XGmuI5eQ1waBOBSvqTCsv2U3IC+eiheC9PYxyJCck1lIu+lC9p37uag4i08G8ZLpre
         +B7uugLQ7e211AjrBw2/P2IpmZxzhczlj0D+5+fQ=
Received: by mail-wr1-f52.google.com with SMTP id y16so5043139wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 03:09:57 -0700 (PDT)
X-Gm-Message-State: ABuFfogQWyE3A5bsIztQhC+alkwqjoI0x36uORqcNoqT0mhftQoKIxmK
        JGDy9pEgNLNBouI85iFg0S5JAgqyi4NqWcQ00O8=
X-Google-Smtp-Source: ACcGV61hB69GwL4KmzaBmfplkrn8ExjmQCOAGttvGtzNqxghYE9OcI+RebRw06MGrA3LThiKB6WWtdrHYPbhsFB8ipI=
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr18702524wrq.189.1539166196159;
 Wed, 10 Oct 2018 03:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
 <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
 <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com> <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
In-Reply-To: <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Oct 2018 12:09:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfRcNQb2yd0oaLStDDcQZBV+MXnhWesSBvOCyT7mCd+FA@mail.gmail.com>
Message-ID: <CAJKOXPfRcNQb2yd0oaLStDDcQZBV+MXnhWesSBvOCyT7mCd+FA@mail.gmail.com>
Subject: Re: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
To:     l.luba@partner.samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 at 11:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> Is it still valid that the Exynos has locking issues?

The prepare lock of clocks was not solved entirely. We just
implemented a set of workarounds.

> Or is it enabled 'just-in-case'?

Yes, all debugging features are implemented just in case to spot any
issue as early as possible.

> On arm64 the config misses that setting.
> Should be enabled there as well?

Because it is a shared defconfig among all platforms and apparently no
one wanted to convincing others to enable it.

> You have introduced this entry a year ago, probably during bug
> investigation.

Actually not, I enabled it much later after issues where discovered.

> The issue is in lockdep, the setting which enables it in Exynos
> is prove_locking. For now, just get rid of the second.
> My tests showed lockdep impact and not other minor debug features
> enabled.

You did not reply directly to my comment - you disabled all debug for
locking. It seems you are unaware of this so I question your test
results. If you run tests on this patch, then basically you compared
existing config with a config stripped out of debugging around locks.
I understand that this is not what you wanted...

Best regards,
Krzysztof
