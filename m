Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9424C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C02186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph1yj7zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfB0RaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:30:01 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46814 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0R35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:29:57 -0500
Received: by mail-yw1-f68.google.com with SMTP id n12so8718328ywn.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSSmuG4mKdZqfAxPKCJsdtWMhnsZAqHY97PjvphoIqI=;
        b=ph1yj7zWvRmQCYCm4VsH/94vAD9eny0ts8vH/3dkLnUO2LcPhYR3R9a1mDOEu5MlH7
         6GCEDYQDvs9N4oaU49m5RXkJksem6SdA6MZA9zRr1YyYs5wgnW2bS9TCoqpVjQ9CanbJ
         c/ns0vyML3r89aD+pRHb5rFY4DSU/ZIr6TiZ5N2nEyC5hg1A0Y3hW5+G2PxlHM/hh5yp
         mEze0/MOPGnG8xjfyZW73ZWDN3WTwb3HmpfRg5jE8G75K5GhvH9IfQ6OCu+WsuaKInP3
         V2Rdbs0NpfPrkiTZ22zln0qu+dPzqNo2P2qZRLw6Y12uiYgcEBZ6RXokCqHjgmL6aQKM
         B+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSSmuG4mKdZqfAxPKCJsdtWMhnsZAqHY97PjvphoIqI=;
        b=Qy44tcjoqbALb+Fjaa1W+DiVBk3J/28VKtnK+MqCYuXdhA+dgZEqzZzKGT1Eq70H6I
         ddW7Lt0vwuIlkKORXqz5L/9FLnWAAd4MzsKHf5dQ8QTwLwS6ThlGF+mYS7/eku1cPgC5
         tbA6CYSTI9yU3U9gYLdlaZbwiqF7z1+AScLhiiOJ3EKJ7OVYx053+r7Rtnv5/6Xtf0D/
         Drnfj4ubQnOfychGIhF7WlE4cE86T0+I78AeMoGpAJTY8bOWD+d7MjeMOwdATrCPrPlV
         7sh5bzZGprXq+/00CcJzVTTjGBKjIC9egcoI/ugCWM5HQA4DWHFGLaHCnccJBtGkid9h
         JHgQ==
X-Gm-Message-State: AHQUAubeX4Q0Mxx2L7leC/AUGhFhp95uWwf5aJOqLSArImLljsE4Ba/+
        Ahz8paMqSB6TU9SJ+5EW64ALCOHNGZ3LpZfjtGE=
X-Google-Smtp-Source: AHgI3IajeGjzc7JjBBbd/HnJnbRx3bFug1NbTzdtCFYI5K+mLSoTjKT583kzUbbV0c0iVxLFQ5xbozrcXnPTOGQt+cU=
X-Received: by 2002:a25:8703:: with SMTP id a3mr3045476ybl.445.1551288596863;
 Wed, 27 Feb 2019 09:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20190227170608.27963-1-steven.price@arm.com> <20190227170608.27963-24-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-24-steven.price@arm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 27 Feb 2019 09:29:45 -0800
Message-ID: <CAMo8Bf+W3o+ZfTztNyCJVs1CDshB_=3hhCne6MY6v=PD=GqLUg@mail.gmail.com>
Subject: Re: [PATCH v3 23/34] xtensa: mm: Add p?d_large() definitions
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:07 AM Steven Price <steven.price@arm.com> wrote:
>
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
>
> For xtensa, we don't support large pages, so add a stub returning 0.
>
> CC: Chris Zankel <chris@zankel.net>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: linux-xtensa@linux-xtensa.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/xtensa/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
