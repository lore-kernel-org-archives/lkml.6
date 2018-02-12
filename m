Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932590AbeBLXCC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:02:02 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36556 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbeBLXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:01:58 -0500
X-Google-Smtp-Source: AH8x225D5ScNfFoaHCcS16VMJyKnhgvNhlFukBCsoVkntRhOTIor7PYOhV3Km9vwMXYojyflFlmLSKrfOWth6TnQLGs=
MIME-Version: 1.0
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 13 Feb 2018 10:01:57 +1100
Message-ID: <CAKTCnzmtDNJHThzuZa1+ydrriQG-dVovHA7uLSVvfLFG2MaidQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 9:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
>
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
>         implicit declaration of function 'crash_ipi_callback'
>
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
>
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Thanks for working on this.

You've added two functions, I understand the crash_send_ipi() bits
that I broke. Looks like crash_ipi_callback broken without KEXEC_CORE?

I am going to test these patches, for now

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
