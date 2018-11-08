Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8637ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693DB204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP+5Id/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693DB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeKIEWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeKIEWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:22:52 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A0020857
        for <linux-kernel@vger.kernel.org>; Thu,  8 Nov 2018 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541702764;
        bh=pioQnMAPS1lpghmgomUHcHmT7Y1jAg5LnSVhR/vOdjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hP+5Id/1tIkFH9uBgoyS3OslVYe4LmYHK0yAUKkqDwhvD0AmK3OLl9/4UFeXJ+0j9
         pdO2FOjzvHdMWv7QJ0g9G4cumre+vpj4XNyJZwDSmwljrVSZ4myJcO3OjLFXhCbsuC
         bZKJHixw4P3vquseVxPyq5uTr+WiTAfuASMAxkCs=
Received: by mail-wr1-f51.google.com with SMTP id z16-v6so22382825wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:46:04 -0800 (PST)
X-Gm-Message-State: AGRZ1gKZEt9fp7BJuAHR7/mbdZW6UwWrIRkUw5kotXIOcRpre+I4KAJE
        oK1VVmPzhkmu9k+BNDMq9RmO5TL73fr/+F/hPLAjaA==
X-Google-Smtp-Source: AJdET5d5V39pv9xAzh9vqkbAfkJMB+NXdzltb2tJbpZApcHalNG6KJYudy1XTaCKdQir5sbXSGlSB3nFG+eqiIjP+e0=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr5409613wrb.283.1541702762746;
 Thu, 08 Nov 2018 10:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20181107194858.9380-1-bigeasy@linutronix.de> <20181107194858.9380-5-bigeasy@linutronix.de>
In-Reply-To: <20181107194858.9380-5-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 8 Nov 2018 10:45:50 -0800
X-Gmail-Original-Message-ID: <CALCETrW5Ct9oLceGtOWhOz0MW-ieZmHNvqFtR5WV56NMHpzEvA@mail.gmail.com>
Message-ID: <CALCETrW5Ct9oLceGtOWhOz0MW-ieZmHNvqFtR5WV56NMHpzEvA@mail.gmail.com>
Subject: Re: [PATCH 04/23] x86/entry/32: Remove asm/math_emu.h include
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The math_emu.h header files contains the definition of struct
> math_emu_info. It is not used in this file.
>
> Remove asm/math_emu.h include.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
