Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeBSK6x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:58:53 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34332 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeBSK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:58:52 -0500
X-Google-Smtp-Source: AH8x227trOlTSD56LeudusWEEkFUC7vEYcR137ebRSWd70jnCLa5wf5ihUCc1Aoik/1yF7ZG8x9CJpKqrkq64FdbvpM=
MIME-Version: 1.0
In-Reply-To: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Feb 2018 11:58:50 +0100
X-Google-Sender-Auth: a2v0UbngJKw3T9b1PCSv3WT30Hc
Message-ID: <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 7:39 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> Silence Sparse warnings), compilation of arm64 architecture is broken
> with the following error messages:
>
>   AR      arch/arm64/kernel/built-in.o
>   arch/arm64/kernel/head.S: Assembler messages:
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>   unrecognized character is `L'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
>
> This patch fixes the same by using the UL() macro correctly for
> assigning the MPIDR_HWID_BITMASK macro value.
>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Saw the same thing in the kernelci report for linux-next.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that when referencing a commit, it's best to abbreviate the commit
ID to the first 12 characters like "e1a50de37860". You can also a line like

Fixes: e1a50de37860 ("arm64: cputype: Silence Sparse warnings")

which is the standard format to describe such regressions.

       Arnd
