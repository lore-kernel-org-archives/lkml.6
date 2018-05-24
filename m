Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2246768-1527181342-2-1310670338648725821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527181341; b=mx8Xg1Unf8w4kgHP3NvTXdau56K1VdaTgpySKAkz8VyLvtdpSN
    KQHlBunk3f2K4m4UDLuPrI6ehoH9/VAkUYKiL/tF/1y+vBqr9kOB6T5G0Gabqq58
    sy2PFyQRa+Z4pHXf5CSgFunAZiDrcKSykqxISBJ6QqLhemypRQWRE0GFBur2yap7
    Bilekt2thlwq/5mv3DLaLqfsiPuHjsjJtaVm68ZVoH1aU2v0rjGapifN3pZHVtRk
    CLdBgBv8tKe3uY5Y5/oDZKGEQE7Y8Cz8wrrNwmh7ejW0Tp7+FhCUD1lpsbAP5dhm
    W6hvRWmoWsmAvFhE94HvWnrPBZqWfkBuyECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527181341; bh=uiLNLv5OVF4cA6F6Da4DhoDJr8GgMZ
    5UyA8EV1CKgyk=; b=hGR0HIgTwK6ArQxu5TK2an0DqYcpkSSKrNd/Nr+umyhmZD
    ofTSxTlYHw+CzfPpPCYi2oA3kdYYetSa1Fb3u09DjRHVfj9FBTuqZhJLAN5MntzG
    xLfrQ5tiortbVsboUf6bopW9MYT07VV6+NhqUnDrJu6fXesRjbH0TX1Jrh3/XN2Q
    ThYlMDqsxjuFTeYG/1+j40OFW7rP5Wn93tTpedKpe53m30hCKcel+8ARuBNw/2jW
    HNG/DYuuGk12bJUEcYKxogrRShj7VRtbyv5v55k+AZagqNgOHoYgX09lFHcCnmrd
    gg62wYbsoTkodFRO6PdRdPW/P5TtNz4LAusQjbkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVDByd9dulvmHci46wIUUiIA1Dk9U9Z16IapV/+yaP+R2ba5b4+CAqn5n1Ar4ZdMVpZ23+xK6IQ/jCUobg4Nooh4RPdsWBiYjOJQCfS+VM6n75spgBY
    XptWu9LyypjnA+i8LgvmPp6B3wzh7/SuDtORLKZ/IRN4/aZ27kNbez5u/tEe2ktk9OSOdNwsih1kNzCVcuaiDuRdMgGSWbQFI6z83o8CxCqT2JEPQAhxJcH+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=Rs3ityNLD-GEJ0YvhQYA:9 a=CjuIK1q_8ugA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031112AbeEXRCR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:02:17 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43200 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030542AbeEXRCR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:02:17 -0400
Date: Thu, 24 May 2018 10:02:08 -0700
From: Paul Burton <paul.burton@mips.com>
To: "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <20180524170208.735ptogcn2uo4izl@pburton-laptop>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527181329-321459-8161-12345-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender
        Domain Matches Recipient Domain
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Maciej,

On Wed, May 16, 2018 at 04:39:58PM +0100, Maciej W. Rozycki wrote:
> Use 64-bit accesses for 64-bit floating-point general registers with 
> PTRACE_PEEKUSR, removing the truncation of their upper halves in the 
> FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context 
> access"), which inadvertently switched them to using 32-bit accesses.

Good catch:

  Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
  Paul

> The PTRACE_POKEUSR side is fine as it's never been broken and continues 
> using 64-bit accesses.
> 
> Cc: <stable@vger.kernel.org> # 3.19+
> Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Hi,
> 
>  Here's another one, spotted in the course of GDB PR gdb/22286 regression 
> testing with the n64 ABI.  Please apply.
> 
>   Maciej
> ---
>  arch/mips/kernel/ptrace.c   |    2 +-
>  arch/mips/kernel/ptrace32.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> linux-mips-ptrace-peekusr-fp64.diff
> Index: linux/arch/mips/kernel/ptrace.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/ptrace.c	2018-05-15 17:44:25.000000000 +0100
> +++ linux/arch/mips/kernel/ptrace.c	2018-05-16 11:22:00.714605000 +0100
> @@ -1070,7 +1070,7 @@ long arch_ptrace(struct task_struct *chi
>  				break;
>  			}
>  #endif
> -			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
> +			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
>  			break;
>  		case PC:
>  			tmp = regs->cp0_epc;
> Index: linux/arch/mips/kernel/ptrace32.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/ptrace32.c	2018-05-15 17:45:16.000000000 +0100
> +++ linux/arch/mips/kernel/ptrace32.c	2018-05-16 11:22:16.313698000 +0100
> @@ -109,7 +109,7 @@ long compat_arch_ptrace(struct task_stru
>  						addr & 1);
>  				break;
>  			}
> -			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
> +			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
>  			break;
>  		case PC:
>  			tmp = regs->cp0_epc;
> 
