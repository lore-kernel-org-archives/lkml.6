Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1833056-1526353987-2-2403016061469189050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526353986; b=bvGzYhYQCg1TIClvwAnjNSmWbNutVsClj4wYxChPfGyC0r/1aJ
    F4SMXdiLxgrI3rfq+p/sjmfO8matLQnIITNIZ3j7kR8ljaQDUC4syg0JBDM46fsw
    9qinvOS2lkD3O12g5aMVVeYAAWKREybhfUQaaGqXrkTt+HojQOoeRTn2iAMGPLFB
    mrKWCzgGZiDPoo0SheDwQMjQgRRS8SVKvT3Sspw2cHupKDEOdZyOONoWZkhu9y8e
    fHxQin1HAEsmC2vT+YAgHiw5J25iZQr6upE6LjQux05KZg2VFixiHEKriLj0s4Ej
    Vc+OLQDik3Sl/WKauwpTslOvGLCeOaz6tmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1526353986; bh=8lIudwyadTQtfGsVm+NMkBcl3k4ZE1YLIw2IbuEYm1
    w=; b=BbeHRwIhjcJ3RgcJJgI77UNkEqwK9rIN9oUv3GOKJQp/OBE+F1CuGUGw3S
    XNZBx8Bs/RYvZC4aXczhV3pYuQm115j6NwdHmBcNabStZExWF0wrwpJGjp9y0Lfw
    hM6JwPJYPEkVHR8wRnKtD2j7GV5B3k9v9MVZ6DzrjjOO+XDyuGUIlApwBzIKvtOg
    o8jwlvHYMEKJcRUWn8nzPLgdcCUtqQ+3rWudjZG6ufeIxO+blRN9hlmKjAdkaVDz
    WT/A6druulwG9graywESsUbXPvYzI51H6ZRAuUhRou5LUcLvzHiaQdFfn6z4TNb9
    WZXe9XFEdUgC4a6Hf/Lib0z55GKg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFWmRH7+bt3sBaW03KjmWGKuxFqMC89dYW6vxG1DHaJfLPBtxszvTcCgmMs6wfEBW5aj7aFk1eFQUvHKaet3faImhYEgGALgTxVh6EqqeOkKQQoI2kY
    2ZVcdPQrXnk/Ust0AHVBNP2SCqnp68SoqbH8zbxTtLk4mQduYcWCIoZn4WISpHeGHnTmO5xNwvvkHFN4ft12wkTCBOGSFEwELDx7Dfj3y0ctdXWwVtezxnFr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=FRwMG6dQGmbBtAXrKUwA:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeEODND (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 23:13:03 -0400
Received: from ozlabs.org ([203.11.71.1]:39399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeEODND (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 23:13:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH REPOST 4/5] powerpc: Use update_thread_flag()
In-Reply-To: <1526051104-15995-5-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com> <1526051104-15995-5-git-send-email-Dave.Martin@arm.com>
Date: Tue, 15 May 2018 13:13:00 +1000
Message-ID: <87d0xxpq6b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dave Martin <Dave.Martin@arm.com> writes:

> This patch uses the new update_thread_flag() helper to simplify a
> couple of if () set; else clear; constructs.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/elf.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 548d9a4..136c9b1 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -88,14 +88,8 @@ typedef elf_vrregset_t elf_fpxregset_t;
>  #ifdef __powerpc64__
>  # define SET_PERSONALITY(ex)					\
>  do {								\
> -	if (((ex).e_flags & 0x3) == 2)				\
> -		set_thread_flag(TIF_ELF2ABI);			\
> -	else							\
> -		clear_thread_flag(TIF_ELF2ABI);			\
> -	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
> -		set_thread_flag(TIF_32BIT);			\
> -	else							\
> -		clear_thread_flag(TIF_32BIT);			\
> +	update_thread_flag(TIF_ELF2ABI, ((ex).e_flags & 0x3) == 2);	\
> +	update_thread_flag(TIF_32BIT, (ex).e_ident[EI_CLASS] == ELFCLASS32); \
>  	if (personality(current->personality) != PER_LINUX32)	\
>  		set_personality(PER_LINUX |			\
>  			(current->personality & (~PER_MASK)));	\

Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
