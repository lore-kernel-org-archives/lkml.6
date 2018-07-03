Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B023EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B023EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeGCIEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:04:55 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41358 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeGCIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:04:53 -0400
Received: by mail-vk0-f66.google.com with SMTP id j11-v6so568270vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JT1N4FVDy1rBx+B/8AVTUsgnx5b0GMIrxIVZc4SKPYk=;
        b=CrVLpWTCiBeSdyo2wZ9Vn1pE2jBk2Na81SLbA9NC5tZKUYp8XUv7KFDe4N9zwQkvRU
         FQxqA6iz1yF0MrDJJfPi5YBOct3fvsTW+bp/Z0iPuy8km60FBxX1EU4Bpvzv1XXaH0tR
         o2ITmScHbD8NXgLhTV0hrsgGHQFC06AAbCSlCJXMnGQPwj9mWAn4IDP00qJJghucSWK2
         yRF/ScJ2nQ2KOZwDLHJbEDaFlA8Xgkjcg+R4mDwEEXir7VriViazfDTONfaHOrgZti+T
         JHyIfzotbx8sYCrnGYcWDsJrVKfYcsEnokgfD6iDRDvNCE4hR7b0Oj6F5K8cYODqbN1x
         fuvw==
X-Gm-Message-State: APt69E286tQJJjO+wdAio3ZHpRnSYswqvOkNXT+KXCUSJzlRCHt6nNtn
        rGynKf6AFYS954YB9gEshFCGp++y5IqBcmvpwwU=
X-Google-Smtp-Source: AAOMgpe3XZPSjRdbCxf9DRmkCD+MQ4pwYNpnWYWJEdLBVP9yHHUEF/QzvMhvzNSLNZIgVHY46fXvECZKqDeEEn1ey6E=
X-Received: by 2002:a1f:3701:: with SMTP id e1-v6mr4239322vka.50.1530605092077;
 Tue, 03 Jul 2018 01:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <1530101255-13988-1-git-send-email-crecklin@redhat.com>
 <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com>
 <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com> <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
In-Reply-To: <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jul 2018 10:04:40 +0200
Message-ID: <CAMuHMdU89jEp4Oi6RK887P-LxCFNVPMnOpvvC6BEDHWDjNATAw@mail.gmail.com>
Subject: Re: [PATCH v3] add param that allows bootline control of hardened usercopy
To:     Kees Cook <keescook@chromium.org>
Cc:     crecklin@redhat.com, Laura Abbott <labbott@redhat.com>,
        pabeni@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        kernel-hardening@lists.openwall.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Jul 2, 2018 at 8:44 PM Kees Cook <keescook@chromium.org> wrote:
> On Sat, Jun 30, 2018 at 1:43 PM, Christoph von Recklinghausen
> <crecklin@redhat.com> wrote:
> > The last issue I'm chasing is build failures on ARCH=m68k. The error is
> > atomic_read and friends needed by the jump label code not being found.
> > The config has CONFIG_BROKEN_ON_SMP=y, so the jump label calls I added
> > will only be made #ifndef CONFIG_BROKEN_ON_SMP. Do you think that's
> > worth a mention in the blurb that's added to
> > Documentation/admin-guide/kernel-parameters.txt?
>
> Uhm, that's weird -- I think the configs on m68k need fixing then? I
> don't want to have to sprinkle that ifdef in generic code.

config BROKEN_ON_SMP
        bool
        depends on BROKEN || !SMP
        default y

So BROKEN_ON_SMP=y if SMP=n, i.e. not an issue?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
