Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B359FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E46F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLKNpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:45:55 -0500
Received: from ozlabs.org ([203.11.71.1]:39307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKNpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:45:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43Dh6S55N5z9s3q; Wed, 12 Dec 2018 00:45:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a225f1567405558fb5410e9b2b90805819df1c67
X-Patchwork-Hint: ignore
In-Reply-To: <20181207155605.GB28964@altlinux.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v5] powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call
Message-Id: <43Dh6S55N5z9s3q@ozlabs.org>
Date:   Wed, 12 Dec 2018 00:45:52 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 15:56:05 UTC, "Dmitry V. Levin" wrote:
> From: Elvira Khabirova <lineprinter@altlinux.org>
> 
> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h,
> ptrace_report_syscall() is not expected to be used outside that file.
> 
> The patch does not look very nice, but at least it is correct
> and opens the way for PTRACE_GET_SYSCALL_INFO API.
> 
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a225f1567405558fb5410e9b2b9080

cheers
