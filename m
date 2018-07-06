Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A33921A0E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRoNozLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A33921A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGFO5n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:57:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37754 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeGFO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:57:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so14790882wmh.2;
        Fri, 06 Jul 2018 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=goMMqDZRisJhBPUTsZVw+OHH1rS3arLmpFClK2SP7Wk=;
        b=uRoNozLHQv7DSQOhWXypHSE6KFV6UWvfI2rSggaRCzOUc9IYNZ1Vk2hKXs0CNTqQUJ
         p71EXNBfaHePNkzitlNtqG3Roq75df4lYFSfHoM2zCGKHpFQEPlL2yA34SQ7V9ANs/qg
         qLB2AkdPYKjT8d+Uz40bUJYG1E1EtRdQeJqrvRQtpkUPdF6Ypr+jkPXQLYPdccVkbort
         zCts5bSJX0CDpEPNC02JTyWr6xXrToD1Daia2EIks1M55vCkStLLxJBIL/hY6/DTP78x
         XLYlp0glMdUd0Umrxo1aszHNHGmJPnDnw2oMbO3aY1ePTh/ONW/TAjJ80/p3LwhT5Cqn
         Un/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=goMMqDZRisJhBPUTsZVw+OHH1rS3arLmpFClK2SP7Wk=;
        b=kxzXp6I5br2cIg1R/2ESwNCosRopjKGLWUbt60spKHmPE5L8Hvu6VpQoVS3Wli4ZxP
         2qCSZa5mKE8XtCj39YFl3fx9dD75ojPVgXqoNgfVWxcuyij7WlyX6K5CZ4XblL74OkIP
         qY7wxqwot1ZGpiJgxCNftsjtDy6qncsyDGvwWVvwSTqbmP/tMJM2DCngXGHMA6hgGL/x
         WG9XfDcsAw8kB1nrjvwj7ivjJo3ToyohRKJsuyxbwbhmX5sqfWZwk3Rgl1WHQ71GXo/S
         Tc9N3XzO9CBglXSU0plGQczV3x8nVAn2AEJ9fxt1rVqOLnwFZAtSfb1jkt4UezkEqCVf
         gg8w==
X-Gm-Message-State: APt69E0ryGdHdaxEYZfRKacksp4NmdIHUTN23S5Hm0RB94/2hrlKfOEJ
        t9xjmu1ZWVWGyFWY36kyt9Q=
X-Google-Smtp-Source: AAOMgpdfWzOeptBLZsTsxWiG/OcFVAKkjoy4CpPgLjbcgl9HI50pw0CEK2ReQKTTEu36vdrTv6gmpw==
X-Received: by 2002:a1c:b590:: with SMTP id e138-v6mr7052870wmf.154.1530889058859;
        Fri, 06 Jul 2018 07:57:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w204-v6sm9113773wmw.17.2018.07.06.07.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:57:37 -0700 (PDT)
Date:   Fri, 6 Jul 2018 16:57:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180706145735.GA7100@gmail.com>
References: <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
 <20180625131932.sge43esxdb5ejoxg@treble>
 <20180626064930.GB25879@gmail.com>
 <20180626123154.unjji5glpokedwal@treble>
 <20180705075815.GA20903@gmail.com>
 <20180706140643.u2vau63nncg23hmi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706140643.u2vau63nncg23hmi@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Great, I'd be perfectly fine with such an approach.
> > 
> > Also, if we have that then we could re-apply Alexey's patch and switch to INT3 
> > (only on 64-bit kernels) without any trouble, because objtool should detect any 
> > execution flow bugs before the INT3 could trigger, right?
> > 
> > I.e. any INT3 fault would show a combination of *both* an objtool bug and a 
> > probable code flow bug - which I suspect would warrant crashing the box ...
> 
> Sounds good to me.  I can take Alexey's patch and submit a 64-bit
> version of it, along with the relevant objtool changes (though it may
> still be a few weeks before I get the chance).

Sounds good to me, thanks!

	Ingo
