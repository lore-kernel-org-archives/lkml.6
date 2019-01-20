Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A873CC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B62084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCXt7pJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfATDaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 22:30:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45822 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfATDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 22:30:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so14718826ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHil3/B07qvaV0f5nv6g4tsoqrxMXGl73zytgQtPgCo=;
        b=DCXt7pJwVih8kI26AuyFgLiSi/4yiVQuHfnye2isrvOXqPoo7p/qsNyOum325NWefB
         wD0UEPSh1hMAVqxnG/+xtRfsdAWFVNEJlxiMbdqgNAjWNHyzoXstcrDJPbq2trpNworn
         /b7yxpynwdtuU0gE6MGUhaYcUDbfwshOX8efs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHil3/B07qvaV0f5nv6g4tsoqrxMXGl73zytgQtPgCo=;
        b=YTDC3f29vgO7xXSwz1QoJvxeBQcWg/AGivzu8d5uTj5gkGcjBcuV0OV6lJqF342cUK
         Kvm5O79GIfdXDHkXStC9gvqemaFIL8SnRSt2cgn8bASRnzOayT7g8WtxDaHwxdmZxlAn
         xzhaaYt21JBLH9sIAi6KTZHonbQZMke1x3+43/eIVX4SUfOHSwiC8sD2RCGaA3osprjS
         cYEuKWy7efuRpBijK7g0TxzuFWHUzdHJg8cFWUe4o4lnSL+qCpn1QRYzTmngq97LwTlS
         WENtj3RnZ8sIL/9OM0Wal1bvECiggKEL3UpAQE7Jlja3odbsFR6iRF5ukTpcdUSm4AtH
         Uy0A==
X-Gm-Message-State: AJcUukcqPt1XRB170ZKVyUkDyBsa/4eSDc869k3aZu6tvV4hgUzMMUX5
        KVHhjVnv4DziGvXAsyOvMvnoGS9Ev0nX7Q==
X-Google-Smtp-Source: ALg8bN7OfohHCCgkdlHvPw1qL1iTwTuLNwpc/LBuaYtbkODwaIulTKfbdMyKIiMwxhZl1uiRSgjhfg==
X-Received: by 2002:a2e:8786:: with SMTP id n6-v6mr16259496lji.100.1547955015175;
        Sat, 19 Jan 2019 19:30:15 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v17-v6sm1475433ljg.32.2019.01.19.19.30.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 19:30:14 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v1-v6so14801201ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 19:30:14 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr16278165ljx.6.1547955013741;
 Sat, 19 Jan 2019 19:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20190120000420.GM26876@brain-police>
In-Reply-To: <20190120000420.GM26876@brain-police>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Jan 2019 15:29:57 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg=yY2DdU+G73O-r==G6tRYmh_d-uM7_N5mBRubzELXGQ@mail.gmail.com>
Message-ID: <CAHk-=wg=yY2DdU+G73O-r==G6tRYmh_d-uM7_N5mBRubzELXGQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: fixes for -rc3
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 12:04 PM Will Deacon <will.deacon@arm.com> wrote:
>
> The kernel.org servers wouldn't talk to me from NZ (the keys appeared to
> have changed), so I ended up pushing via the UK which seems to have worked.
> Please shout if anything looks weird.

Everything looks fine.

Thanks,

              Linus
