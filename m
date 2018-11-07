Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068D20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeKHBVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:21:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41382 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeKHBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:21:49 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8EEBA72CA56;
        Wed,  7 Nov 2018 18:50:52 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 804057CC774; Wed,  7 Nov 2018 18:50:52 +0300 (MSK)
Date:   Wed, 7 Nov 2018 18:50:52 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107155052.GA27736@altlinux.org>
Mail-Followup-To: Andy Lutomirski <luto@amacapital.net>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io
References: <20181107042751.3b519062@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107042751.3b519062@akathisia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:27:51AM +0100, Elvira Khabirova wrote:
[...]
> The structure was chosen according to [2], except for two changes.
> First: instead of an arch field with a value of AUDIT_ARCH_*, a boolean
> is_compat value is returned, because a) not all arches have an AUDIT_ARCH_*
> defined for them,

To be more specific, here is the list of arch subtrees in v4.20-rc1 that
invoke tracehook_report_syscall_entry() but do not provide syscall_get_arch():

arch/arc
arch/c6x
arch/h8300
arch/hexagon
arch/m68k
arch/nds32
arch/nios2
arch/riscv
arch/um
arch/xtensa

Among these trees only m68k has its AUDIT_ARCH_M68K constant defined.


-- 
ldv
