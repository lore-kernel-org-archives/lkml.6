Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2873C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C28C20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uBYWNRNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C28C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJNDOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 23:14:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34345 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJNDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 23:14:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so20221324wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IB0dDp12Jf0ZeNJvQ0OICfXMiDXerl76Z99vxAuNG9A=;
        b=uBYWNRNkHCWLtPoK9/uZ+UylZsLKL5D+tG1rUIwdM8hp/6QbLCHJa3iyfq+wb9wGRO
         iDCrInMooCfWkB1S8lXak//59rGflC+qeMlwoai1SCJ4IrjlEcX7AWU1If8ueJh7mFdb
         DRsvbWtC0aM/UgVbmp3iICuVSoih0YZtSXv7x268OzznD+W2mGRNcdLNH4Qk4KIigllR
         IBm8iAXfxcqnD0mR+sQnhB9Qs5VDjW+zGT3Ht9Z+xEx6Su6hEcoh009CDYZi33zuczTt
         50ovhMLBcNmM0vLXDAhr+Z6RN84GlMhYq1NxdJ48vyI4lhPtCLOyczZDlkKit+WNSO2d
         hlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IB0dDp12Jf0ZeNJvQ0OICfXMiDXerl76Z99vxAuNG9A=;
        b=UX+fPgEGO7/TnjtkngtVfl2RwLs6xJygta2o0h9PsK14OsvjTfVtjjtmtX+qe04hoz
         4ybA2wBWWyGLct7pxIX++dFshqE0KsAYQ705IFmWRSbxQ0Z8oHTDL65qAt/E3TqDRTco
         UewVKtYLWd5FUIJzIi33GfAebFZV+vL1Pr3ZzreWQ8uHryB9J1RBxIXoG0Q42/vtqmVH
         b/rYWrOhN2prGLVuA24+0i6aLTJa0owmtk4TBuEoRLnX2Y9ylKfgkJk47sArCphE1uR2
         uR5ePzGNvSzS/GyIJv4DI9DXwVFbVRGG092sTjp5g82mG2Tarwu0G5AzZRM1stkpsTul
         a88Q==
X-Gm-Message-State: ABuFfoiYC9zhgY1ui0Ksp/XmtSLTn0aWmjjxSwM6UZwS4vqURH9BImX3
        HPbAQNbL7XcejbLVCQIiznVdlwm5g+tVVgMaD7NkWw==
X-Google-Smtp-Source: ACcGV61ulHaUaGgXMLFCkeOKbViTrIIKrwfSR83PifPtlorZhlo/4VIHrA06ghfe/bqGgooHbdDdm41sJyALGFttN0o=
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr9345378wmn.102.1539459393753;
 Sat, 13 Oct 2018 12:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 13 Oct 2018 12:36:21 -0700
Message-ID: <CALCETrVuabkb5ZQOSgQQTEq8CrS602NBpAkE2=4n982r1f5reQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     ynorov@caviumnetworks.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>, klimov.linux@gmail.com,
        schwab@suse.de, Andrew Pinski <pinskia@gmail.com>,
        bamv2005@gmail.com, Chris Metcalf <cmetcalf@mellanox.com>,
        christoph.muellner@theobroma-systems.com,
        Dave Martin <Dave.Martin@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        "Joseph S. Myers" <joseph@codesourcery.com>,
        linyongting@huawei.com, manuel.montezelo@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan Lynch <Nathan_Lynch@mentor.com>,
        philipp.tomsich@theobroma-systems.com,
        Prasun.Kapoor@caviumnetworks.com, ramana.gcc@googlemail.com,
        sellcey@caviumnetworks.com, szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 1:19 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
>
> This series enables AARCH64 with ILP32 mode.
>
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.

A few thoughts:

1. I've never been able to shake the feeling that x32 should not need
kernel support at all.  As far as I can tell, the kernel support is an
enormous amount of code and complexity to deal with exactly two
issues.  First, ILP32 only has 32-bit pointers, so there needs to be a
way to tell the kernel to only use the lower 4 GB of user address
space.  That part is easy.  Second, ILP32 user code is highly unlikely
to end up with the same struct layout as ILP64 code.  The latter seems
like it should be solved entirely in userspace by adding a way to
annotate a structure as being a kernel ABI structure and getting the
toolchain to lay it out as if it were ILP64 even though the target is
ILP32.

2. I think you should make a conscious decision as to whether the
ILP32-ness of a syscall is a property of the task or of the syscall.
On x86, x32-ness is a property of the syscall, but historically it
also got rather entangled with the state of the task, and the result
was a mess.  It looks like you're making it be a property of the task,
which is fine, but you're making it impossible for very clever ILP32
libraries to include little ILP64 stubs that do fancy things with full
64-bit syscalls.

3. Make very certain that you aren't exploitable by malicious
processes that set the high bits in ILP32 syscall args.  x86 compat
has issues like that in the past.
