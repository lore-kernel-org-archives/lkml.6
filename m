Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA2CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BFD2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uVpXmbuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BFD2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeHCLc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:32:59 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:41005 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeHCLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:32:59 -0400
Received: by mail-ua0-f178.google.com with SMTP id h1-v6so3644530uao.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xQ3EJxZ0YrC/87WlehZDDZrf3uwfW4LOYC4xJN/CyuA=;
        b=uVpXmbuAFhhPGnzV60CcNe+ck+FTV4MQWZl6IFk1upa62IR/EXFl03lgdf6A+AeWPw
         PcHx2fvbvxaMYqLM5IX15kt9zvpOj1gSDuvEbemr33myMwMXrR64AzkWhfg53d/Gba+v
         UwafNKzIiEUIVJuRlMseiuAH7Yl1d1CWM2XGkhJLGB2Duv8XSQ+qRaNCLWJY0AXsxh0e
         mqmO03kqE+0xgaivZumjFft+lIoKdd52EsndIJKY61qXW0pwwjxQZbVcLJX2UJJr6knp
         Qtzx9K1BdpIdUX6FVQkz8Ob8ZPVjZ7Ewp94wdraQ+Y1j7BhWhDw7d5WZRioTQOgfqicq
         RfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xQ3EJxZ0YrC/87WlehZDDZrf3uwfW4LOYC4xJN/CyuA=;
        b=Z5VedopipjBSoeaJICinQ1KjsEyfZYNHRxYNPROjW8yOc1qJIlOmGGPQu3QkJpREte
         TOb1Cx/gtqThqsDTTzGhcddNxaeypbIWxLVU9ZoKrr2mZx5fG0gEVf1Kcy7AhrtTnk2p
         FismAmAHCOwqHMyF+V5td/YrWHCR2p40HjPKNcA2Z2vOsz+pc84HIjn5d/+En8+aLWki
         q9p5qe2dKCGxWD0YdH9pq7Sq3siVhzOYJVH1zHZNKd7oUVc6g3e6hNAxRS+Y0reNnIAK
         +i6EmlCp/FAsz0AXfnecR30cur9Lb7dxQdQfKwTTXxFPVoW1CVLzL1SuqmMPWDIgalSG
         r9yQ==
X-Gm-Message-State: AOUpUlF6xwOnywCzTKIHh0wIr6ftfCfqKfg+iFm4uqwrTN0IBPWrWX7g
        oxIuK/WpsSKgkZ5yH6SWtkPRs3Bz3Sv8bniUOH4=
X-Google-Smtp-Source: AAOMgpeQ5qqp+bEYElt1zY+4PA4kNMQWycj3zFifetLlmrBjS8CH/q50ncRgL5cNzokctYmHCbPRA+5g8clDaUOI8FQ=
X-Received: by 2002:ab0:4ad7:: with SMTP id t23-v6mr2312643uae.35.1533289049898;
 Fri, 03 Aug 2018 02:37:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6044:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 02:37:29 -0700 (PDT)
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
From:   Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Date:   Fri, 3 Aug 2018 10:37:29 +0100
Message-ID: <CAJA7tRahXGuPK=ktS5h86MZuV_o5cA3x1JbbyuwVspAHLKdP9g@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

< snip>

> I guess the semantics of a framebuffer are not strictly defined, but
> the current reality is that it is expected to have memory semantics
> (by Linux/glibc)
>
> Matt is saying fundamental properties of the underlying interconnects
> (AMBA) make that impossible on ARM, but I'd like to understand better
> if that is universally the case, and whether such a system is still
> PCIe compliant.

I don't know that side of the architecture enough to make any
definitive statements.

>
> The discussion about whether memcpy() should rely on unaligned
> accesses, and whether you should use it on device memory is orthogonal
> to that, and not the heart of the matter IMO

Then maybe take libc-alpha off if it isn't relevant.

regards
Ramana
