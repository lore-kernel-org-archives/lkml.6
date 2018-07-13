Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD49ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD852087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ODRI/j+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD852087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbeGMTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:07:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53770 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:07:14 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so12850099itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2471f1Q2g1g0D/jsijS9XCdkxJVRSw6d1Uh4YKUBNY=;
        b=ODRI/j+dy3umxtmNBBXimPBIspI6kHkKYTBeHJecrAY/3ico7pf7yY0uDflLYkEEKM
         EqBLoukfTLlQRUPj+pZMkN9hs0B5uYzaYrdgflka8X2SU6hIwNdjiVJPJpUMQVqONW56
         Vl2Nq4QosVhUego5xacACJ+v49BM9FuJ3DnhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2471f1Q2g1g0D/jsijS9XCdkxJVRSw6d1Uh4YKUBNY=;
        b=lk+1FzxF0sJDx9P/Af9GnArY4Jv9NNObw0/IaFPhiPtpoFTmCXZ+sU4n7uGiEzgSK4
         CH7k656SfiFYIx7ZxiBy+miwsCyPhTPk9NVyzV8XAgkBcl0nMf/D1y3NWK2kxBfv+tir
         BYL3UcSS1rF7Kk4X59wwWwUmHvsChGLKR6JAY/lRUbWgu88SzrPgewK5t4NPfAI+Pg++
         PTW2IO168X8HCEboQJIL8IVJ8c046ePXMvQvztCUIP5NJGEe7e7U4GBFb1lNNE8wZU4A
         SfZmCmrE4C3+WWMWeZYlh6y+gK8zmEPZyHFT6dflmocix93G86ffTUcwn3yzyvrzUt2v
         3i6Q==
X-Gm-Message-State: AOUpUlE2kMSokuutPwNHPT2bq1gPbf4Z9ggGyf8mSbtA/Ha2JqgcuntE
        ip8zVt2yNPJ8V0l4dUrYiKOUeFuPqxCxNrIIVY8vxw==
X-Google-Smtp-Source: AAOMgpfpk2mFIiaGTZ/dW/VQ1HtrDKzoxG8BxsESQhmtvEuXmJ2NUJigQdcEMYx+BeHwCqDiBcZUowA8bR3VLXbdvuE=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr6619163jaf.70.1531507883310;
 Fri, 13 Jul 2018 11:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180713131344.GH32020@arm.com>
In-Reply-To: <20180713131344.GH32020@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Jul 2018 11:51:12 -0700
Message-ID: <CA+55aFwR2S4a=Ytb=Rk46GBBCTX=ejVyYZ6YKO63j2MrW7+Vaw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for 4.18-rc5
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 6:13 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Catalin's out enjoying the sunshine, so I'm sending the fixes for a couple
> of weeks (although there hopefully won't be any more!).

Never fear, I'm sure there won't be more than a couple of weeks of
sunshine in the UK this summer.

That's what you were trying to say, right?

            Linus
