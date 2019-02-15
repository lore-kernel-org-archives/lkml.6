Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A74C21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htge0fQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfBOTZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:25:21 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46760 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:25:21 -0500
Received: by mail-pl1-f180.google.com with SMTP id o6so5401925pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfUp5ku+6fj+x3YogObjg6zT9GmAYNVP+Wb6MscecPs=;
        b=htge0fQvi0b5t+blxFUTtZFfds1La4YTBZiOgDJ022C7DXydsfTMqlfKY678831nHU
         HmLsxozYBIc7/baB7MwArQX5oyAwk+oMPxIzcymu+9z7RbbFsNMREqc8XBimdwvMp/TO
         s5MDJe0E0tp0JXUhTpHoXLPu++lzByoAOh89ENMO/xmDDIf1VskqXEPPAAY4O5jGdM5s
         EwLZ2ADhUZ0rlW3mKrIXNiFfNfOQejVRx6ecVCVLhqt51X3Qb0S/tdMIEuM7F8xn/vfO
         pT8p7CdKeG1hhQl6QHs/DPE8OJ9nbkFBT6riUV+Y754bdGT2SAsxmq/wTNulnv6Ub4qy
         G4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfUp5ku+6fj+x3YogObjg6zT9GmAYNVP+Wb6MscecPs=;
        b=Jf3HOiemK03wsDJLptJZb3v/BSFJ0LFZhC167rkBxq7Cv1q0YZJu4IoIH5nD5buM/d
         h5LhEO9Eebd7Jvo/G4cxefc6zjy6BrjXfbKbBreU/TEq+UU88SVCVwERwmg2ubvb1T5A
         ZSpxjkNijF+/mhXxYjvOUTGj3jhk6rAhPlmUqteIiFkX7fmYWOQiuzk3sw2FwspwkjCf
         jOu9CRPP2F1bIKY9opfCM8PzWQwFSniSt4kR007nHXCncXP/iGxYA0PE0DJ68Lk6Uo5n
         jVZpD3u8ZK7M5KkAlzn5UndbdZAF1M6+B3CnCkVt2myjRhA2pm5e6CowBzz9HHdWK5kq
         qrAA==
X-Gm-Message-State: AHQUAub4PfmPHiUCEfRHuZGwbWW3skPoy0nB6ORDRVEGYSX0toaL4gFG
        FX8fZA11ieNr2+1CJqpLt82mHkllu/tIOTqxxFFh5A==
X-Google-Smtp-Source: AHgI3IZqvDGiZ2Lliz1c6KZlqDD8STWYenxZsYpENamTZnfj9SJwKLUso7VtTb0omZveMvUGtyrqZVMHEDXSMWOcjQ0=
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr11676032pls.320.1550258719940;
 Fri, 15 Feb 2019 11:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Feb 2019 11:25:08 -0800
Message-ID: <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandeep Patil <sspatil@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Provided that we stop sending Clang enablement patches to -stable:

What does that mean?  We're trying to provide clang support back to
4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
-- 
Thanks,
~Nick Desaulniers
