Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3271C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3C820685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3kh1jT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAIViG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:38:06 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37950 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfAIViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:38:05 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so5713854vsa.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0E13t76P4f46qIpKbwm1PIalSHlmYXrVb7lzustlt0=;
        b=J3kh1jT3fAen0lKqM3wDDfKvWGqpI2JTCxz8e4J4POwrcpR21YViNdV8S92L4iW6Q0
         m0HDDuvtW5vauozn2bRTr0RoZVs65NY2qEkdJdmCdDQyp6W9RTeKT4quLt1dZvRMnvLr
         TkFLMEdCeIbxVcJCoZB1LdGzZ0P5urJW+dzAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0E13t76P4f46qIpKbwm1PIalSHlmYXrVb7lzustlt0=;
        b=dAkm9Y1kNkJjJkaZAQlWDHF6oJrWW2w/732VOJ6xKtBLcap7ay1qsudYROoqR+1hXn
         fBFyK6eqZwaBPDPdBanqha/zviyYVmYlAVYUp6+sz3mu/ixC4Jr5DRZPGt+fqH8Yf6Z+
         0JLgXxGbN+uF0SIYSYn4fo3uoP/B6vELkSvDq5iPRr2PgXfaJ3bApmVQAIixa/nESOdx
         0NDU5GplXcPEsnyHU7ES3UkPdq4tLETPxWgAH46WBGelOUMeSv6gnTVwG6wZfXd/p5IS
         Z6te4YiR6FcX6AMHYpugWkXKUrFxhzVo9WQXiiXPOyBPZpClSsR5KaPkd8wxGK3aS7zv
         cjTw==
X-Gm-Message-State: AJcUukdkeWgNqromKlReBE/RaJpjY2A/Bjobmyl5S8NaDeSsn5GpPMuu
        TA4BabDAASp2UTxlBUVvWwzSKKSRInM=
X-Google-Smtp-Source: ALg8bN70iphE9Ol76CrGhXNal92Q6eGegPAkoyOmiMFqKOej+aJoyJ9bpbAPTNMz2UZc5AB8zQS1wQ==
X-Received: by 2002:a67:f31a:: with SMTP id p26mr3253876vsf.113.1547069883957;
        Wed, 09 Jan 2019 13:38:03 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id r8sm22275136uan.0.2019.01.09.13.38.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:38:02 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id v70so2011078vkv.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:38:02 -0800 (PST)
X-Received: by 2002:a1f:298e:: with SMTP id p136mr2931774vkp.40.1547069881716;
 Wed, 09 Jan 2019 13:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com> <20181209103740.GB30658@n2100.armlinux.org.uk>
 <47a91e5a-0e97-334c-2f36-a0bd966a0050@intel.com> <235f0830-a293-5b00-4510-7d7d4c829d26@intel.com>
In-Reply-To: <235f0830-a293-5b00-4510-7d7d4c829d26@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 9 Jan 2019 13:37:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLYG=UBrJXmrtoZVCka-w4_k_op8c7M1cQXmZs702fZ5Q@mail.gmail.com>
Message-ID: <CAGXu5jLYG=UBrJXmrtoZVCka-w4_k_op8c7M1cQXmZs702fZ5Q@mail.gmail.com>
Subject: Re: [kbuild-all] [PATCH v3] ARM: smp: add support for per-task stack canaries
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        kbuild test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>, kbuild-all@01.org,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 10:30 PM Rong Chen <rong.a.chen@intel.com> wrote:
> I tested the commit on another machine and the warnings are exist.
> I found " -Wno-vla" was lost after the commit, so I think it's a real pro=
blem.
>
> -Werror=3Ddesignated-init -fplugin-arg-arm_ssp_per_task_plugin-tso=3D1 -f=
plugin-arg-arm_ssp_per_task_plugin-offset=3D24 -fsanitize=3Dshift -fsanitiz=
e=3Dinteger-divide-by-zero -fsanitize=3Dunreachable -fsanitize=3Dvla-bound =
-fsanitize=3Dsigned-integer-overflow -fsanitize=3Dbounds -fsanitize=3Dobjec=
t-size -fsanitize=3Dbool -fsanitize=3Denum -fsanitize=3Dalignment -Wno-mayb=
e-uninitialized -fsanitize-coverage=3Dtrace-pc -DMODULE -DKBUILD_BASENAME=
=3D'"test_ubsan"' -DKBUILD_MODNAME=3D'"test_ubsan"' -c -o lib/.tmp_test_ubs=
an.o lib/test_ubsan.c
>
> -Werror=3Ddesignated-init -Wno-vla -fsanitize=3Dshift -fsanitize=3Dintege=
r-divide-by-zero -fsanitize=3Dunreachable -fsanitize=3Dvla-bound -fsanitize=
=3Dsigned-integer-overflow -fsanitize=3Dbounds -fsanitize=3Dobject-size -fs=
anitize=3Dbool -fsanitize=3Denum -fsanitize=3Dalignment -Wno-maybe-uninitia=
lized -fsanitize-coverage=3Dtrace-pc -DMODULE -DKBUILD_BASENAME=3D'"test_ub=
san"' -DKBUILD_MODNAME=3D'"test_ubsan"' -c -o lib/.tmp_test_ubsan.o lib/tes=
t_ubsan.c

Hm, so the -Wno-vla is getting clobbered.

in lib/Makefile, I see "+=3D", so I wouldn't expect a clobber:
CFLAGS_test_kasan.o +=3D $(call cc-disable-warning, vla)
...
CFLAGS_test_ubsan.o +=3D $(call cc-disable-warning, vla)

and scripts/Makefile.gcc-plugins is using +=3D against KBUILD_CFLAGS:
KBUILD_CFLAGS +=3D $(GCC_PLUGINS_CFLAGS)

I'm not sure where the per-target CFLAGS are built, but it seems like
something has gone wrong there?

--=20
Kees Cook
