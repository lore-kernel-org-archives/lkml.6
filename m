Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7521B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohX8/5cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfBKT1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:27:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39789 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfBKT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:27:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id f132so23210pfa.6;
        Mon, 11 Feb 2019 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+oM0/xXLOkqWUNTZclNstle1SN4HebVede/xP56WAdc=;
        b=ohX8/5cRhRlFAEE+pStLv5HD83z/gPPjShpexmPKbkoB+4M+/8bvC+G12H1oNlpZ4X
         Xr5D1wcj9+8Wmc2PtwVleNcbPFyVVHe89XLTO1BOtdyivFyrTTkX3DR3H5h6E22yTOgb
         ElX9TKuHZYNDKqOvh8bAwXU+fMAy71Gtqml5Hix/FlfaI4HBLytzliJCCy1LV5oBYts4
         GqKpuRQd/1xGtE1LdEe51/WW9xgqMad5ur5z9i6SkkwtdoSgnZ8fhJv4keIPyJHg62bt
         6Z2/yQgYt7iGgy8NUaS/c8ZAVR+T3R+iTCfjv3rWEefhFf47LKGoyB3uA3KlxFENE5g9
         Vikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+oM0/xXLOkqWUNTZclNstle1SN4HebVede/xP56WAdc=;
        b=jGvzs1FzHJDgdSgxoKGuhUZqjsnkKQar8hW8g35gN78g/saMuFh3LCY2I05byQ/Wy1
         akGVRc1tzieFg3DkQ1YZ8GGUHNKD/XABojCOe4jrZYLoEqylf2kf6P0g+GL8O3UP1isR
         VSosDkS5GlMMGz7oOdkMb8RbYnkPnSLcs2XKVRO/VN0L03LpXGzeeWduNLkmnQHPg8RF
         z0rozu/y+dunm7xz907M9NVkBd3MKa4585cTBu+AUKUuh1AAnyZBfcI64ZwvopYYVuWa
         DADC6Fk98rnA0hY0RF45vHAfNTxHL5NFiY7iENRn1Wdvgib6Wx+rSy1Zo4/dSpOZarHS
         ZNqw==
X-Gm-Message-State: AHQUAuZmTyXWD7hHB5J66cIVg5bTExtMb7P25b8ymLP6C3p4KmOELaps
        8TZLQTJGviLMKmnduV33T0w=
X-Google-Smtp-Source: AHgI3IaY1AiMYebkmcDfbYYok1NODcbe/RnHFWN6Al9Fn2I2kEnfJveqTXvy5uGklYvEz/WRKUL66w==
X-Received: by 2002:a63:4658:: with SMTP id v24mr34547801pgk.114.1549913226955;
        Mon, 11 Feb 2019 11:27:06 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a187sm9887508pfb.61.2019.02.11.11.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:27:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules
 loading
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190211191059.GR19618@zn.tnic>
Date:   Mon, 11 Feb 2019 11:27:03 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic>
 <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic>
 <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
 <20190211191059.GR19618@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 11:10 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Mon, Feb 11, 2019 at 11:09:25AM -0800, Nadav Amit wrote:
>> It is just that I find the use of static_cpu_has()/boot_cpu_has() to =
be very
>> inconsistent. I doubt that show_cpuinfo_misc(), =
copy_fpstate_to_sigframe(),
>> or i915_memcpy_init_early() that use static_cpu_has() are any hotter =
than
>> text_poke_early().
>=20
> Would some beefing of the comment over it help?

Is there any comment over static_cpu_has()? ;-)

Anyhow, obviously a comment would be useful.

