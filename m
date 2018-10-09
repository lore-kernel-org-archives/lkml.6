Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5C8214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqc/dF8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5C8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJISLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:11:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41719 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJISK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:10:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so646868pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uHAiEZ/VNBNmc1syn3PfOTCnnrtxC24MfWBCzSHuzQ=;
        b=Yqc/dF8NcmERqeVmdsbeTK53lG8eqEft/t7CGli3vMBFT80LpTeIjSSH7ZJZXl+3Y5
         x8UDOVZ6uoowb1ftEB+nSp+xZVmYBpfsCgIQzGCGEcwQqOaBqjX3eu443Ujt38d6SJPO
         O33Yl6URbal49N3EnoYWWKXxcVT2D1wZH9h/vhJgfgaEEljHcLup/vD2bYK2X+H3NHwy
         opSQY8HLvt1r1jCuTPY597nTPizin3NfkLCgS6BcBkpLcJkVrVBaQPCY3MniAz0dbCKC
         r7EUPRoOGFKBWxW3f6wxcPPTy1ygDC/nG/7O9z8FKzAOaAq4i9YkYm5ZaNGpu8FGMzKS
         7TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uHAiEZ/VNBNmc1syn3PfOTCnnrtxC24MfWBCzSHuzQ=;
        b=ub8KEftJUiWOre2Qrqt8nWosJoshLtOyvVGuAzG67tuv9brOVBgRgPY27ptaZc9IoD
         GegKC5NXhzxJhL0tx/bNJDhJJWkgqF2MGEdVFBGDTSkktVelOnC5BvnsflnonnhAS2HF
         WnKGLyrfaYVh7PRltLogiX4eCYDC614xn3Aj6vkS2VXdZuWeIKWCLfF0mtp7EUCQHhpo
         mCDVx9CP+xE2dm9NZLIZSqGPfvM8sbnqdrKZUUld1M8p215E+/TiGLQ3Kc3RFX3Omru8
         I6n9I3kV0Q0lnxTLMy4zL3Ju2c4Kh6GDysR7Sglbjh34p6K0w7oaqzxn/PltpN6P5i4Q
         kdNg==
X-Gm-Message-State: ABuFfogM9I/ptEPIaFiSMbj2JUc7/DCFhqEUvn95JBGsPgFGWTLUZPI3
        t/xuBNRjqiCHanRZEwbSOKw=
X-Google-Smtp-Source: ACcGV60vbKRdtkJQplU2pabYcx3WyEoUqCTqFr6oCmA0DNjzl5hgQtngoCz4vwBFbRI6WwOK1HIXaQ==
X-Received: by 2002:a63:6746:: with SMTP id b67-v6mr25328762pgc.310.1539082477834;
        Tue, 09 Oct 2018 03:54:37 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au. [60.240.121.136])
        by smtp.gmail.com with ESMTPSA id l83-v6sm51243749pfi.172.2018.10.09.03.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:54:37 -0700 (PDT)
Date:   Tue, 9 Oct 2018 20:54:30 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181009205430.351134eb@roar.ozlabs.ibm.com>
In-Reply-To: <df8575fba80d19e6e58c16266350e9980c432ae1.camel@kernel.crashing.org>
References: <cover.1538954166.git.christophe.leroy@c-s.fr>
        <df8575fba80d19e6e58c16266350e9980c432ae1.camel@kernel.crashing.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Oct 2018 20:59:56 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-10-08 at 09:16 +0000, Christophe Leroy wrote:
> > The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> > moves the thread_info into task_struct.  
> 
> We need to make sure we don't have code that assumes that we don't take
> faults on TI access.
> 
> On ppc64, the stack SLB entries are bolted, which means the TI is too.
> 
> We might have code that assumes that we don't get SLB faults when
> accessing TI. If not, we're fine but that needs a close look.

Oh, we do. I think the entry side might be okay, but on exit we have
at least one (in syscall and interrupt exit both):

        /*
         * Disable interrupts so current_thread_info()->flags can't change,
         * and so that we don't get interrupted after loading SRR0/1.
         */
#ifdef CONFIG_PPC_BOOK3E
        wrteei  0
#else
        /*
         * For performance reasons we clear RI the same time that we
         * clear EE. We only need to clear RI just before we restore r13
         * below, but batching it with EE saves us one expensive mtmsrd call.
         * We have to be careful to restore RI if we branch anywhere from
         * here (eg syscall_exit_work).
         */
        li      r11,0
        mtmsrd  r11,1
#endif /* CONFIG_PPC_BOOK3E */

        ld      r9,TI_FLAGS(r12)

So taking an SLB there will cause an unrecoverable.

I think we can probably get rid of that optimization for now. I've found
for non-trivial syscalls it's often a loss if FP was used. I have a
couple of different options I'm working on to get rid of the mtmsrd
entirely we can go with instead (but I don't think those have to come
before Christophe's patch).

Thanks,
Nick
