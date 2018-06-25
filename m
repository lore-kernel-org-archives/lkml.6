Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8315125D2C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvQwZ83L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8315125D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeFYPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeFYPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:47:54 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5B325D36
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529941674;
        bh=mZQlHtf3O2oz/4I+6WpoGLz+zIgLVXHPZAQTO4YRAGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VvQwZ83L+L1LxpnQhuqAa3mAooQfe0hzT1+VTgbTCGp4nR/5TOkjtPNeZF7M4567Y
         Rw01AcSw27DQQVn7oxDRljjIuaspmi3r2pzbSOcfv6gev34doBwqVyTTg8dlGSx4gG
         t+5xGWzCocjrMbOJUBkmV62Yc/PSRLFfi9tDds6s=
Received: by mail-wm0-f49.google.com with SMTP id p11-v6so10541434wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:47:53 -0700 (PDT)
X-Gm-Message-State: APt69E3NYfwnptPwsG8ikYxo6BQ4cIR3+5qrbkrfXOjTH4dlp+ddtAic
        HqSQ5w5Vc6sA6R20Rk2x1lB3XoUaFBQtTkW+JEUE2w==
X-Google-Smtp-Source: AAOMgpcpPRPyKdyAyaJVGhQ9FCsda635ePDRdynA/m2dhzNHaGuzURs1dyZH9hrAcRpDX3XZZIji+ACUjImN66G3He8=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr1369476wmi.46.1529941672382;
 Mon, 25 Jun 2018 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com>
In-Reply-To: <CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 08:47:40 -0700
X-Gmail-Original-Message-ID: <CALCETrWZ=sipwoVic16LM08+-FKV5knO7Cv3pSM_5w=KLCqTKw@mail.gmail.com>
Message-ID: <CALCETrWZ=sipwoVic16LM08+-FKV5knO7Cv3pSM_5w=KLCqTKw@mail.gmail.com>
Subject: Re: qemu-system-x86_64: mov_ss_trap_64 PANIC: double fault,
 error_code: 0x0
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, rafael.tinoco@linaro.org,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 10:41 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Kselftest test case mov_ss_trap_64 is causing kernel panic on
> qemu-system-x86_64 and PASS on real x86_64 hardware.
>
> Test code snippet,
> main() {
> <>
>       printf("[RUN]\tMOV SS; CS CS INT3\n");
>       asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
> <>
> }
>

This smells like CVE-2018-1087.  Can you confirm that your *host*
kernel is patched?

CVE-2018-1087 is extremely severe, and if your host kernel is not
patched, I think you need to apply some serious pressure on your
vendor to get with the program.

--Andy
