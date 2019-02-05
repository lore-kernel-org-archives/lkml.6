Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0FC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96DF217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfBEPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:08:29 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44548 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfBEPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:08:28 -0500
Received: by mail-ed1-f46.google.com with SMTP id y56so3085291edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8Z0apMRHXXh+nTlUahkqxKK3MNso4+Qj3edMSnGaDQ=;
        b=OyZrUiC0ajKl33sNXZDMHjOKXQVmvFu2/11sXDrorxzW7kKnVZuVHjEKwlvu7Oy07i
         X6Fp6IqJ+XEM+daToFDYM87vvDHMxnsJ7nsSm9mwnxhe0KrcRIAzH5tjh/5YUNbrUBcM
         wBPgJHNKYd0MKypw7KAIJlFxv6uRoi5bUpc4tlWRlZcvatA9V0t2+xB3/gNnmpryffjw
         vbx0JNjNODByWAm/V6Kie5HFjRwPxdaL1IXLw8JeHE8LutyOQUlVritAYQp5fp7e9W5U
         H6VZY79T5F5T2UOSVsKlnbzwKbtmIMFgI1wq/3FyOTvUTXKapqFYoyiE4r8d+r/QPqhl
         E9oA==
X-Gm-Message-State: AHQUAuYqS62fLjT2MxohxaQAYw8nd8c2Aj2mzQ+oivbfoOvlmPRIV6AY
        NayGqyHuwnd1i8uuD28MZ4xeCCVH0NQ=
X-Google-Smtp-Source: AHgI3IZULbvfHjnmu8Dh+91h9Hi6DGDU1S8TAJM6CbUyqYTAJhTrSun4G4SMLyXm/vgWAOIwz6l07w==
X-Received: by 2002:a50:a982:: with SMTP id n2mr4286187edc.236.1549379305545;
        Tue, 05 Feb 2019 07:08:25 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id r20sm2106705eja.73.2019.02.05.07.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:08:24 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id t200so4079869wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:08:24 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr4073442wme.111.1549379304052;
 Tue, 05 Feb 2019 07:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20190203000622.30856-1-chrisadr@gentoo.org>
In-Reply-To: <20190203000622.30856-1-chrisadr@gentoo.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 5 Feb 2019 23:08:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v64eH=UyR5rvFnuLwVJHsDeX-RJudgqw4GhrgD5LuncH9g@mail.gmail.com>
Message-ID: <CAGb2v64eH=UyR5rvFnuLwVJHsDeX-RJudgqw4GhrgD5LuncH9g@mail.gmail.com>
Subject: Re: [PATCH-next] drm/sun4i: Use PTR_ERR_OR_ZERO in sun8i_phy_clk_create()
To:     Christopher Diaz Riveros <chrisadr@gentoo.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 8:07 AM Christopher Diaz Riveros
<chrisadr@gentoo.org> wrote:
>
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Maxime's reply to the patch "drm/sun4i: hdmi: Use PTR_ERR_OR_ZERO
in sun4i_tmds_create()" [1] probably applies to this one as well:

"""
While this is technically correct (and I appreciate that this is also
a matter of taste), I find the former syntax to be clearer and easier
to extend if needed.
"""

ChenYu

[1] https://patchwork.kernel.org/patch/10671757/
