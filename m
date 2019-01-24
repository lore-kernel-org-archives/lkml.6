Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C4EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A74218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVzVkHkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfAXPZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:25:04 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42140 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAXPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:25:04 -0500
Received: by mail-lj1-f180.google.com with SMTP id l15-v6so5585261lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRySIxPAIBkQqoVv3M6PC9TVja3BRjgEUylxL0WPeMQ=;
        b=RVzVkHkzHefd60hlG0V3bOVpdWxmDYo4S/mfVnh67WhEtKG/wy6p9hxQ0dSG9ZVfKd
         kz17G7c1X3FXqQFrAFZ1FJ4S5Wny5iMZQzyzjhH8D+MqSZrOPKlOqKK+t5H1fD4i/MoV
         IpD23zsE15ZpNAwAuPYT0vmknjYfOKd1K82fzv6a8GegWcPeKCPOSg1u2FPxiMxum9rB
         EnXjXuugidm16LxPi+4A/kDGGc4WJqnNNqqW0J+/ZjIg6D2o6hXnf4itnr6hDTkRmvbL
         yMJqC5twdiYeIxGWwmMB12J1fOXKSDtYpwjKSolE4o+4qAoQheSkhfTtGOh8HWq9qpEi
         QJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRySIxPAIBkQqoVv3M6PC9TVja3BRjgEUylxL0WPeMQ=;
        b=i2K3eO6qF7X4ySnM8/r7cMvx+gBgRwLN1v/arsF6SMhJEUYlwi5tx8yxIgs7EoE/gk
         YBDSb/S8NG7AiJfm6zsfzGkw5KXL+Zw+qVEaVo9fwljDtPDHj+NDfbi2eSUDyNB+eKND
         tzLULnasPD2TGaYp/JbpbZC+ihpIjYCnkNhCR4p4RCL/OwGAZG5xVP3PXCZLLdBvpgaR
         7KCSnSRy+XcEvxKabm0ShtylDxgK/rVAHNK2wQsSvs0nKWgD2F4pqMfPs86eNHhcGttj
         pUY1G3IetLJiDLxz2wboXnb8wdMbZtCMNrmq8D++CJTBorf1fkym5qUUapDSVu3CMm4a
         Pa5w==
X-Gm-Message-State: AJcUukd9JMBE2TSct7HI3cjFGfiT5BgFe4+eNcyCPvVmkZe6HeYYHhCS
        nPtMucm0SZkgXcahl/U1fbX9v8CXT8jfwrRJZH8=
X-Google-Smtp-Source: ALg8bN51PtPCO2hl22/hL4jHlSvpf9/c7XU78d8eTWsF9f2kblsPdVc/gsDeZqHs9FQGodoIVjeUeQy/C+D0QBV5vlQ=
X-Received: by 2002:a2e:9147:: with SMTP id q7-v6mr4430760ljg.69.1548343501764;
 Thu, 24 Jan 2019 07:25:01 -0800 (PST)
MIME-Version: 1.0
References: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com>
In-Reply-To: <90cb9f5e-c0b5-dfa5-c6bd-4808dc47c799@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 24 Jan 2019 16:24:50 +0100
Message-ID: <CANiq72nA3bTYCd_8Msn6NPFJYz85F3qsb0_c75XqDKTujPwpYA@mail.gmail.com>
Subject: Re: New warnings with gcc9
To:     Laura Abbott <labbott@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Jan 23, 2019 at 4:27 PM Laura Abbott <labbott@redhat.com> wrote:
>
> This looks like we just need to make the attributes match
>
> BUILDSTDERR: lib/crc32.c:209:5: warning: 'crc32_le_base' specifies less restrictive attribute than its target 'crc32_le': 'pure' [-Wmissing-attributes]
> BUILDSTDERR:   209 | u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> BUILDSTDERR:       |     ^~~~~~~~~~~~~
> BUILDSTDERR: lib/crc32.c:195:19: note: 'crc32_le_base' target declared here
> BUILDSTDERR:   195 | u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
> BUILDSTDERR:       |                   ^~~~~~~~
> BUILDSTDERR: lib/crc32.c:210:5: warning: '__crc32c_le_base' specifies less restrictive attribute than its target '__crc32c_le': 'pure' [-Wmissing-attributes]
> BUILDSTDERR:   210 | u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
> BUILDSTDERR:       |     ^~~~~~~~~~~~~~~~
> BUILDSTDERR: lib/crc32.c:200:19: note: '__crc32c_le_base' target declared here
> BUILDSTDERR:   200 | u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
> BUILDSTDERR:       |

I am sending a patch for these as well, since they are also coming
from -Wmissing-attributes like the others.

Cheers,
Miguel
