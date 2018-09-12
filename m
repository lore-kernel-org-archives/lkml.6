Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406372146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfgaEX7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406372146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIMCMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:12:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41161 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMCMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:12:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so3459827wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yY5WhE0yfjK2CVyfIBMYRMbGL/D+C6JLq0tj0MgvnpQ=;
        b=GfgaEX7l/v7itvMjl6Jo6nkBe659JJkT2zlQM4PthtTY8Wf/7ounlHLpI6+zo+XkJU
         nKx3uk+FkaTvvZBELqeT2q5PWsTK9KF6k9a4XfZRT7hQW6b+KVl/ZXzBq1llpCL/rutp
         yBKdhdw20QSziGRE9HNDgE5Gmg5JmI+NgOKTENO0trvBp2VCWxQC8wA4H3YiMgMqVDy3
         q9GbEqWUhmeLXHMtk+ZBxA9c4R04lV3sAjPf2AcXeKA35Zej63WIsJQwvN1onQ8eSK2r
         F8xXx9mbrMgWOOYdgdq9cvWTINkau6T894OMG2g9ZE5wQ99P0V3Nn6VfKiM5AyJSQ4rt
         KQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yY5WhE0yfjK2CVyfIBMYRMbGL/D+C6JLq0tj0MgvnpQ=;
        b=LfJSyf+9QWmaGszOLBfYAVFCSf3/SlPVa/z37IVglnYS9Ud7uw/eHQd445fBfUOjEp
         2pSI+mFLZsDbldEQGBOfuM83dqHnsSNSE+/NtUgTuB6xu6g41jFl0g03P+UDN5jqDwt2
         4HdjOBgCEh4vA+ETRrJ6+wnm4SUOQf6CvT/6XhTFpcFuhFjVsKABFNKxhSv+EpCCPh5T
         0wbq+KT6MimtM7VbLnMxyp54PCKqV48Qi8p8vsMvnQ06lPHm3s2E61cG6LZPVoiTMuGp
         U6je6Ol21vQmo/If1tnGromQxJSXnt8uOG7kQQ3LkYsK7rlyoq6WYfSBXfLn0wuBsmaG
         LzzA==
X-Gm-Message-State: APzg51C4dDE9GFHwuLAxQuUM4lelfUYN7NSq+kzvpWQoZEdbhtCnpON/
        KKwcL+Lj7b49thjp0Ngy5j0=
X-Google-Smtp-Source: ANB0Vdbx18slIOR1432hwqz55xrM/5iYGctxkEdjhCIGeDZM6vI1DQ5/8rNG83wtbVcWIjN4CYJvxA==
X-Received: by 2002:a5d:5248:: with SMTP id p8-v6mr3036857wrv.198.1536786394456;
        Wed, 12 Sep 2018 14:06:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n14-v6sm1372117wmc.14.2018.09.12.14.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 14:06:33 -0700 (PDT)
Date:   Wed, 12 Sep 2018 23:06:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/2] Use named address spaces for percpu data
Message-ID: <20180912210630.GA2958@gmail.com>
References: <20180912144442.29271-1-willy@infradead.org>
 <988cf77c-e0cc-25fb-dcd6-945e6f2ba65e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <988cf77c-e0cc-25fb-dcd6-945e6f2ba65e@twiddle.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Richard Henderson <rth@twiddle.net> wrote:

> On 09/12/2018 07:44 AM, Matthew Wilcox wrote:
> > rth wrote a patch back in 2016 that uses gcc's address space machinery
> > to improve code generation for percpu accesses.  Ingo asked for some
> > minor changes to be made, but Richard didn't respond.  While looking at
> > something related, I came across them, and asked Richard's permission
> > to resurrect and resend the patch, with the changes Ingo asked for at
> > the time.
> > 
> > The important information about why we want these patch is in 1/2.
> > 
> > Richard Henderson (2):
> >   x86: Use named address spaces in asm/percpu.h
> >   x86: Enable named address spaces for percpu data
> > 
> >  arch/x86/include/asm/percpu.h | 147 ++++++++++++++++++++--------------
> >  1 file changed, 88 insertions(+), 59 deletions(-)
> 
> Thanks for resurrecting this, Willy.  I'd totally forgotten about it.
> The adjustments you made look fine.

Not all GCC versions seem to like this series:

 In file included from arch/x86/mm/tlb.c:12:0:
 arch/x86/mm/tlb.c: In function ‘switch_mm_irqs_off’:
 ./arch/x86/include/asm/mmu_context.h:210:28: internal compiler error: Segmentation fault
  #define switch_mm_irqs_off switch_mm_irqs_off
 arch/x86/mm/tlb.c:183:6: note: in expansion of macro ‘switch_mm_irqs_off’
  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 Please submit a full bug report,
 with preprocessed source if appropriate.
 See <file:///usr/share/doc/gcc-7/README.Bugs> for instructions.

gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3) 

Thanks,

	Ingo
