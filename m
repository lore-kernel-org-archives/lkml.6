Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0727C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654D220878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GrC39jdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654D220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJBKiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:38:07 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34111 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbeJBKiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:38:07 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 273a6970
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=YY8B1ElpJxpWxeq8S+g5TxWU6E0=; b=GrC39j
        dtXSZN2skegveZKyqvRmNEUTJF9mUB4khT9WZo/U/SLuFpN/rsSFveAL2lox/Aq8
        mE18+nGgh9D/DhJ8H7SQAvq7oa2OKbEOdLGneNGMQO1qSFCHHN8MUwj7vbiiH0Bs
        MFocb/EC2TeFFpfCKit7Z0lhgXZ8eybXYkMf5A0QqL9deazmTTJusvPSRiPc3SF6
        rrOvJuHDtvIAqrO5YEsaF7hFnHUN/l8m3jLJoizNU9i+/r8PzzeVhjc56mFV0Q+W
        dKJL+7A35gHUbv7pi7340Bqp1UrcqLUxs1bpT9t9QX/iD2GTKQ6gUUUq8C0Y0Heq
        Rq0+EnghTTR05KPA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 469e6c2a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 03:56:58 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id w81-v6so419054oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:56:59 -0700 (PDT)
X-Gm-Message-State: ABuFfohvTKUW3UZQganBF+oQ0lGJpbGt55x/xtKqpuAYsfMxbC2cYRwp
        sh0iP+5UbxyMUF8vGxclc5fcio9mdBk+/qnKonw=
X-Google-Smtp-Source: ACcGV60QpNcTEHL+3rl4U4TKQ6TfmDwOsAnNxLGdpfiU2t6IKask2XUPwYU5k3B0uDOHJfW/4uByKLqXLeMExh8ajWs=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr6104876oig.225.1538452618574;
 Mon, 01 Oct 2018 20:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <20181001175622.GT30658@n2100.armlinux.org.uk>
 <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:56:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocfHx2BxCqor-hg0ida6mS7x9M3RU2rZdoaxk=s9bHTQ@mail.gmail.com>
Message-ID: <CAHmME9ocfHx2BxCqor-hg0ida6mS7x9M3RU2rZdoaxk=s9bHTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Oct 2, 2018 at 5:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> So Arnd's suggestion to switch to armv3-m would actually be feasible
> then? The code in question does not use ldrh only umull, and so it
> should build with armv3m as well. And we will even generate some
> better code for RiscPC if we apply it to both the cflags and the
> asflags.

It turns out armv3m isn't a solution for the crypto code, since it
does other armv4-isms. So we'll need to find another solution for
that; I'm partial to my initial Kconfig one just doing "depends
!CPU_32V3".

With regards to RiscPC though, given that armv3 codegen might be
better, it sounds like it's a good idea to set -march=armv3m anyway
for the platform, irrespective of fixing the problem at hand here.

Regards,
Jason
