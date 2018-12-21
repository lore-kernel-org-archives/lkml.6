Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A4921927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LizlE4Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbeLUWku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:40:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbeLUWkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:40:49 -0500
Received: from zn.tnic (p200300EC2BD18000C4134EF852AC8500.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:c413:4ef8:52ac:8500])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F8981EC0980;
        Fri, 21 Dec 2018 23:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545432048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9Vz1KYjBItIW/Ziqh3Kyc07UroFLljmcsA76X85FOi0=;
        b=LizlE4Ljfld2Hw3ApLxgEAwOVEYGFdEt5BUSCuycuBdvdd2nYHsCeOKm/WYZinfobE/7Ff
        ZgCLopkGct23Mjv/AWILbApI0ZPMn5xGc736TBAxirRRxQ7gb1CjVlrQum6bmnusKt/9et
        lKsNNVfqRR3v/Ld6noW3AkQNIMilGLI=
Date:   Fri, 21 Dec 2018 23:40:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] Last straggler for 4.20-rc8 or final
Message-ID: <20181221224040.GA25147@zn.tnic>
References: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ mingo.

On Fri, Dec 21, 2018 at 02:09:02PM +0100, Paolo Bonzini wrote:
> Linus,
> 
> The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:
> 
>   Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> for you to fetch changes up to 3cf85f9f6bd7b172122865432b4c6f0ec844e22a:
> 
>   KVM: x86: nSVM: fix switch to guest mmu (2018-12-19 22:19:22 +0100)
> 
> A simple patch for a pretty bad bug.  I haven't yet sent my 4.21 pull
> request because currently I'm waiting for a patch to be removed from
> tip (MPX removal breaks KVM live migration and was committed without
> Cc or Ack from me) and until that happens I cannot finalize my
> conflict resolution instructions.

Lemme make sure I understand it correctly: you'd like us to not send

https://git.kernel.org/tip/eb012ef3b4e331ae479dd7cd9378041d9b7f851c

up now and delay it for 4.22, right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
