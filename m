Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C633C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AC320833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhL2c3EO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AC320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeIJTWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:22:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45918 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbeIJTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:22:42 -0400
Received: by mail-io0-f196.google.com with SMTP id e12-v6so760033iok.12;
        Mon, 10 Sep 2018 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SifSyhMuydHQHrtbDlzmaT0ctZMeBqJ7gvlao09c98=;
        b=PhL2c3EOzhBBWNDjMcwoyCJM0P/gbegicSYMz0dyGXP8B0kLd3kcyRfqMaryz1tLVT
         7W7lR61I51ZtWBmENpMNWFdv4t8dcdExFgdQ7t8SFjb4S0BFGgg+cuhmdvWkBccP0akP
         HvxS6wSp1aMZEwXRfItb9F5NFcBnbBnbdXp8tl3vV2vjhfltk/2CGlfDCpu+B8q1R+yp
         j/n1/4Io3a+Pu3mxFP+nlJI7DyUlODgAlO5ZyMaI0hLw/H8xGn96AEMb5y53D+xBejOA
         TkYx/enwEyRO2OKo51jan7W516tL9YaOLoXwA2j6+UNhpCDUkLaK0c7TR7hfVYtilh8e
         PYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SifSyhMuydHQHrtbDlzmaT0ctZMeBqJ7gvlao09c98=;
        b=bbXaPbwMvb5gEaYafajXRfBbB1sQisKMiSO1l1cItqEfTOUp1UjWaYFr2pbufv9t24
         FgD1M8nDpQa/+C4FFeUo43l4rHzSi/vtEzj1Q5zNHc6B4/8hWJyF21ugOMUDO1q5eNDS
         1nrJJBxtnLH+1Q0klzyHwqbAHn4bEk3Ix/nX8hVt/T+wH+3+kXpbCIMxwPK/TPnZx7oP
         FZCoSQmM1LDSdhR7vMydydgKcgAgADJm6Sb+n6TdjQbPHXBs87h5h85JtqD7R/8HEVLW
         8r1Vy0FttxFj2ht0P1IApY1p22JoAUyRFVx0OlrnRl3iODdfnZBokUE6JHSuIfzK1YpE
         Sf8g==
X-Gm-Message-State: APzg51BPENKFuBR1OY+gsFGvCyXGkfwHnd/kLsg+ABCxeK4gAErzrcKP
        aPB99xIXmIf9+PkyqBlOF2LpdVQ4cJsBXDsmETopHhFT
X-Google-Smtp-Source: ANB0VdbNRlQ6sTmTHqKYptyaMaozJ2CRB9tQgAiN+Sl6OhKaP9VjSxAuEIYXseVIiqKqNiBSMC4FYyAKjGgNDFQyiiU=
X-Received: by 2002:a6b:15c2:: with SMTP id 185-v6mr18444764iov.161.1536589699597;
 Mon, 10 Sep 2018 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
In-Reply-To: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 10 Sep 2018 22:28:08 +0800
Message-ID: <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        Michael Ellerman <mpe@ellerman.id.au>, jishi@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 2:09 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On little endian platforms, csum_ipv6_magic() keeps len and proto in
> CPU byte order. This generates a bad results leading to ICMPv6 packets
> from other hosts being dropped by powerpc64le platforms.
>
> In order to fix this, len and proto should be converted to network
> byte order ie bigendian byte order. However checksumming 0x12345678
> and 0x56341278 provide the exact same result so it is enough to
> rotate the sum of len and proto by 1 byte.
>
> PPC32 only support bigendian so the fix is needed for PPC64 only
>
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Reported-by: Xin Long <lucien.xin@gmail.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/lib/checksum_64.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
> index 886ed94b9c13..2a68c43e13f5 100644
> --- a/arch/powerpc/lib/checksum_64.S
> +++ b/arch/powerpc/lib/checksum_64.S
> @@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
>         addc    r0, r8, r9
>         ld      r10, 0(r4)
>         ld      r11, 8(r4)
> +#ifndef CONFIG_CPU_BIG_ENDIAN
> +       rotldi  r5, r5, 8
> +#endif
>         adde    r0, r0, r10
>         add     r5, r5, r7
>         adde    r0, r0, r11
> --
> 2.13.3
>
Tested-by: Xin Long <lucien.xin@gmail.com>
