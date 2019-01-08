Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338EBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8969214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwEAsR1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfAHUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:52:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41889 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfAHUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:52:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so2442384plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aKsnrpS9LfIKVDJmKQ/CzyPXAJq7+uyByfdWwDdMbNs=;
        b=nwEAsR1yyq6BTBh8k2XHHsB3pmyrTaBhb6x8PK3Zn7lfZF+fetEfACCXxsUKw/Wtut
         +l9kSw3niiERFEObum6UMQNuGf2r0Vtmec9DhHF+2qWXoZNWPGQeYfGG/Ln6vtgqOvOU
         GSJXw2ru/8UsHA/HxVRrRYE0Q58NpWPGO7jJE8yaE1LmpQo1Zjv7HNkE6MWYSnSIu2jW
         ZrpkGLwuShZwkkrnUFiH7A5NpejfGHVAtKiOlubpTMdz5E9G11ypi1017I6mC5het/U9
         MIHUH1Z70oJFYqBbMe//Ik4+SyfZo1zcMGrQF+aXS+JyAYZ2gZZc2SpCiIpYMGjngubb
         N89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aKsnrpS9LfIKVDJmKQ/CzyPXAJq7+uyByfdWwDdMbNs=;
        b=fQ73pi91V9A98+7heGI0IKAX0jhxLZdzilKjVCJ7YxhpaB4vY3roIhIyPEblIlTvyU
         TW9sXsWuS1pzyM4LjmXB8nZD56jBc0g8TpCB2jQO1JDF/tO5zzfLOEj8P89hKjKHvPmM
         hBQ4SSIzkTXFP4iK4aec2PFlSMeAnrkew+IwhH0eGMX1DBbneR0Ec76V5hBT80Rlwg96
         3t3dLeV23HUkTt6d5AgDpwNujfcn3prZ9usl01yLuNcLsAjya4tTYVkNiC5ym7Z97XYk
         YEoVVB60DFwXSNUHQ7d22GrKz4cc/5v2/iKxQ2a30KQeAKdVId265rRuTF1U/Hn/Q5Pt
         IS7g==
X-Gm-Message-State: AJcUukcvkdlySojKEF6DjpQhHIJwpKoCHH9oncdb/5O8ViMJzhbrU9Tq
        XME25n8IByPZgmBbwMlIv8VdZLae0v5uzwQ9bGXmBA==
X-Google-Smtp-Source: ALg8bN57UrBNBFZexuMrCTGnsg5CO495YXiS4IEQQuCD3bgLZ+uDsiKegtPaSiozcKo4PNZySv0SHvwmxT5zkJof5t4=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr3274954plb.238.1546980741482;
 Tue, 08 Jan 2019 12:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20181219183509.GB31643@zn.tnic> <20181219190145.252035-1-ndesaulniers@google.com>
In-Reply-To: <20181219190145.252035-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jan 2019 12:52:10 -0800
Message-ID: <CAKwvOdn5Syd_pvAmcDy6n6c9=HrpRxEU2fWBa7Rf2QexPZP90g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build: Mark per-cpu symbols as absolute
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rafael Avila de Espindola <rafael@espindo.la>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Bill Wendling <morbo@google.com>,
        Dmitry Golovin <dima@golovin.in>, hpa@zytor.com,
        Michael Matz <matz@suse.de>, Tri Vo <trong@android.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:02 AM <ndesaulniers@google.com> wrote:
>
> From: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
>
> The kernel has many variables that it wants to have per CPU. It is
> similar to how each thread wants a copy of a thread local variable.
>
> To access such variable, the code has to find the offset of that
> variable in the per cpu block and add it to the address of the current
> brock for that cpu.
>
> Section 3.10.8 of ld.bfd's documentation states:
> ```
> For expressions involving numbers, relative addresses and absolute
> addresses, ld follows these rules to evaluate terms:
>
> Other binary operations, that is, between two relative addresses
> not in the same section, or between a relative address and an
> absolute address, first convert any non-absolute term to an
> absolute address before applying the operator."
> ```
>
> Note that ld.lld does not implement this behavior. Instead, we can
> explicitly mark non-absolute terms ABSOLUTE via linker script. This is
> no functional change for ld.bfd which coverts the term to ABSOLUTE
> anyways as specified above.
>
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Tested-by: Dmitry Golovin <dima@golovin.in>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Michael Matz <matz@suse.de>
> Signed-off-by: Tri Vo <trong@android.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> [nd: commit message updated as per Boris' and Michael's sugguestions]

Happy new year.  Bumping for review.

> ---
> Changes from v1 -> v2: commit message updated
>
>  arch/x86/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 0d618ee634ac..ee3b5c7d662e 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -401,7 +401,7 @@ SECTIONS
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
>   */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D x + __per_cpu_load
> +#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(irq_stack_union);
>
> --
> 2.20.1.415.g653613c723-goog
>


--=20
Thanks,
~Nick Desaulniers
