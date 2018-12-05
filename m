Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58022C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB092082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB092082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeLEMoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:44:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33039 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:44:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so17413790oib.0;
        Wed, 05 Dec 2018 04:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Pr/+bszTfj6S60aVpT69HD6fFT0XdG8D+p/Mm3BjqA=;
        b=BGqjZIXUCPD5Y/30lpeCjZT7oaU6bj8YFv4GqzSrgkjDDARi3GongLpa44fYjbS5oQ
         e873BXPVsFXokz5YynrTUZM/naZB2rpSAq0Y18EPaxyB45vmUaGM5DhBu2RNmj0BDBkM
         GO7+k8S3hVqUZFzij6wblBgn4EQPBPZ0Yoq0Tslrqi3xyl9bXVmMJVC02d28RDL30JdC
         r2E1Hv9sAA4F5l+sDwVmNi1Dfn0+sEBZ+vHNDbwpXNBD5y5nyet5er0y0/GnFTkhzLJ2
         rUfHPYZj9814qBflbeY/VOiDK2ZB0gH0CJHDb4N3bgix7ADLFPiAH4LdP3YrgP4pOOYd
         xZZA==
X-Gm-Message-State: AA+aEWbYX5W9DImjCP12CJfXox9tmXFOe3hem1CmtW1EGqWiIVbEOLIQ
        J9TdAefdNJOSmoiwGZwFLf6aG+OXvlLpm69wIus=
X-Google-Smtp-Source: AFSGD/U/xkzUP2+b8gYW8CjWZj1+FCiZv8ZS4zIyqLLLqZVZKsyyqzRk2xmpnj6Lgwa07Xa8JcZ97nAXLYRYIrrU78A=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr15334971oia.95.1544013862136;
 Wed, 05 Dec 2018 04:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20181205101131.28996-1-bp@alien8.de>
In-Reply-To: <20181205101131.28996-1-bp@alien8.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Dec 2018 13:44:10 +0100
Message-ID: <CAJZ5v0h3X7KF4bkq3xc0FSncYVQwn8JTfw7UotdnU0Y3EE9YuA@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.banman@hpe.com, dimitri.sivanich@hpe.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        mhiramat@kernel.org, mike.travis@hpe.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:11 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... with the goal of eventually enabling -Wmissing-prototypes by
> default. At least on x86.
>
> Make functions static where possible, otherwise add prototypes or make
> them visible through includes.
>
> asm/trace/ changes courtesy of Steven Rostedt <rostedt@goodmis.org>.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI and cpufreq bits.
