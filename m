Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968249AbeCSRsa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:48:30 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42076 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965345AbeCSRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:48:24 -0400
X-Google-Smtp-Source: AG47ELvdkZg9VnGpbWavl/5I4hGFcihfG3Dax8AbyMeufsgEd2al3NfYhUza968OkYXby787Tmu9jvPwwJO+MLJ7YPM=
MIME-Version: 1.0
In-Reply-To: <1521479041-17030-1-git-send-email-jason.vas.dias@gmail.com>
References: <1521479041-17030-1-git-send-email-jason.vas.dias@gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Mon, 19 Mar 2018 17:48:23 +0000
Message-ID: <CALyZvKyQ3Rneq3+4O+esdjUmZ=ew0y2DnkQqZsSyK-+RZwP4Gg@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc6 (1)] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note there is a bug raised by H.J. Liu :
     Bug 199129: Don't build vDSO with $(RETPOLINE_CFLAGS) -DRETPOLINE
            (https://bugzilla.kernel.org/show_bug.cgi?id=199129)

If you agree it is a bug, then use both patches from post :
    '[PATCH v4.16-rc5 (2)] x86/vdso: VDSO should handle \
     clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
    '
else, use the single patch from $subject, which makes the
calls to the statics in vclock_gettime.c' use
   indirect_branch("keep") / function_return("keep") ,
to avoid generation of thunk relocations which would not
occur unless compiled with
   -mindirect-branch=thunk-extern -mindirect-branch-register
.

Thanks & Regards,
Jason
