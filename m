Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E017C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B8C2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOYw6eok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B8C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeKCVzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:55:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37377 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeKCVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:55:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so4047653lja.4;
        Sat, 03 Nov 2018 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8c3C1zs2gXWrr4C6uv4YYXmaJBdWKRHXWPnPLmiORMM=;
        b=YOYw6eokMhwlcZ9fOa6gwcPc6cNp6sdVaESUvP8nINglYDfjNo9zA40prosurWnRcM
         mwucH3UyAHKrh3AurJ23+AghNe6YQOv7gVcfdNt3xGdIuaJ4aQ28aZ1SX/4cYmx84H7G
         BLzlbeDxeUf03nPDDkhtDZVUq2y5rNg2c4gFgjeRusX1SIpuovg2xeldJ/tczc6k+eoy
         olnLaH2z1DBuJA45MsdoocXm7Rl/VfY0yX1KbRmD2h3zltkyGzBfmvv/HGBHPE4CrSqj
         EFva8d3PMbecuRp00R3IgIrzXvyLCLPTpZBTHBCNQKfHixc0WhgmJAj8RdWtjklhisbp
         7jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8c3C1zs2gXWrr4C6uv4YYXmaJBdWKRHXWPnPLmiORMM=;
        b=a/I2W2xOpqTMtLgXe//6fy5e4nAw5ksyhrHQ2Dzf5nMC/tNX9114L4DQ1wT2OTBECF
         4s3PtRGoVlZz9gAelwNMxB+6nWSAvdZysl46ju+HAypgg1/084LiXDlqr5v+8VE0Pr93
         mlbbdxXknCi4b8dJq6IQBiko3jDnIHINpb71f27+2E5c7xyOcq+D+D/TDyNsJhVTKxUa
         PL4CfyNoaYToqyuOdeIRh1HH8tWcGF/D2rSbwsKUI+GA6WFJ3dy8fvC78id4kaMqiJah
         Fv5WUFe5tEiDkrpCO/b6cnYE1ItuEo3/rYdyATTypSn96ZXTpYHf+63mmtiS2RrPSR0n
         pE5g==
X-Gm-Message-State: AGRZ1gJyWjjgtojIdff3kkeRtbaCpf9cWz8vGfglUOieUd/VERYYCMnV
        EnX4qgj6GkMSJtl5WLp+oq9LE306o5zFcWD3glxmR45t
X-Google-Smtp-Source: AJdET5c5o6gVUjk3zvSgySvKWqP0Rs+dCgqWZith1DpjCLT3b06F0vQUV3vDV6h/AYDXrncQcfbOVJvg1j/Kt5AECf8=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr9900281ljd.94.1541249030899;
 Sat, 03 Nov 2018 05:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181102143018.09feb051@canb.auug.org.au> <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au> <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
 <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org>
In-Reply-To: <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 3 Nov 2018 13:43:40 +0100
Message-ID: <CANiq72kBx4+R4SVFZ_iTfk61=oHMLwvhHdmBDe=cBFP5Lp7bSQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 2 (compiler-gcc.h)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:56 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> on i386 or x86_64, with gcc (SUSE Linux) 4.8.5, I am seeing this problem:
>
> In file included from <command-line>:0:0:
> ../include/linux/compiler-gcc.h:75:45: internal compiler error: in functi=
on_and_variable_visibility, at ipa.c:825
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COU=
NTER__)
>  [...]
> ../drivers/media/usb/dvb-usb/pctv452e.c:1102:1: note: in expansion of mac=
ro =E2=80=98MODULE_LICENSE=E2=80=99
>  MODULE_LICENSE("GPL");
>  ^
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <http://bugs.opensuse.org/> for instructions.
> ../scripts/Makefile.build:293: recipe for target 'drivers/media/usb/dvb-u=
sb/pctv452e.o' failed

Is any plugin enabled? I can't reproduce here on a compiled 4.8.5
using a minimal config with pctv452e.c and a few other things enabled,
although with a full allyesconfig I got another problem:

*** WARNING *** there are active plugins, do not report this as a bug
unless you can reproduce it without enabling any plugins.
Event                            | Plugins
PLUGIN_FINISH_TYPE               | randomize_layout_plugin structleak_plugi=
n
PLUGIN_FINISH_DECL               | randomize_layout_plugin
PLUGIN_ATTRIBUTES                | randomize_layout_plugin
latent_entropy_plugin structleak_plugin
PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
arch/x86/kernel/apic/apic_noop.c: In function 'noop_init_apic_ldr':
arch/x86/kernel/apic/apic_noop.c:32:1: internal compiler error:
Segmentation fault
 static void noop_init_apic_ldr(void) { }
 ^
0x7f18e09006d5 stackleak_cleanup_execute
scripts/gcc-plugins/stackleak_plugin.c:253
Please submit a full bug report,
with preprocessed source if appropriate.
Please include the complete backtrace with any bug report.
See <http://gcc.gnu.org/bugs.html> for instructions.
scripts/Makefile.build:293: recipe for target
'arch/x86/kernel/apic/apic_noop.o' failed
make[3]: *** [arch/x86/kernel/apic/apic_noop.o] Error 1
scripts/Makefile.build:518: recipe for target 'arch/x86/kernel/apic' failed
make[2]: *** [arch/x86/kernel/apic] Error 2
scripts/Makefile.build:518: recipe for target 'arch/x86/kernel' failed
make[1]: *** [arch/x86/kernel] Error 2
Makefile:1071: recipe for target 'arch/x86' failed
make: *** [arch/x86] Error 2

Cheers,
Miguel
