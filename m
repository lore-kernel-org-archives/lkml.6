Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4276C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB620839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEE+gyzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDB620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHaFF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:05:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeHaFF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:05:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so4645971pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0Vdedy1dC1bL5IGQck9HiQoh+zpBMFTPcvE9Lm7b+k=;
        b=FEE+gyzlNCuM6C5orMk+txez1N9GnuV0E9gMvb0fls3p9iBQjlDBVHm4GwJRoHMgMi
         5l4yz9nk1HFlCNYCJksJljjVlOleycO7tNf693g9DxOMYMFHGz3DiA/xpdGOx573i52Z
         kQAEeeb28iRO79PITh9nWq5Qcn9xFGIAOXJK1c9YloGbc9Rh1kZdPd0HrK2uGJpxXjwF
         rQrhs4k2KjG/CKRty3yesYl82ZZVarbyUQl9DhQp5e/UCeEOPx9i3ns/mO0oFooaR+fA
         pU5kwBV60HLgREXPvI6PGpP3bXrH385bpnPBsIfle0x5aKyniEiK+vGNY/sx/z5yaf8D
         B93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0Vdedy1dC1bL5IGQck9HiQoh+zpBMFTPcvE9Lm7b+k=;
        b=JwZQpPXBVbT6eaYFsuWvoqNKF/fxw8nZ1XFeeOi+OW0nxOTXT60qvmkhkvyQ8QfK8+
         1RR/DZYvzKMqX32hx4hQdlJOzTV5JiCoajnm3/pGZkDdSqV1ukv0uUlM5NIrz9Qx1uVd
         x8gRiZopTjTyy3jPqUGThkBxVViDTKQIj6oPwbdIjRLfbxa3tu3jmPwxIAch9QtpYwV2
         r2cPwcNhfLUFU4qvKebGhQrEs16RSXowxpePv9OEhJnvDjP4cAKWmVv/EFRJIBEUb1fH
         P81TKlcR7SR8MpmSDH17DY+DHzQ6LW37VFTRmQkqQGocYsytLKD+ayb952D+KS5W2NWP
         AXXg==
X-Gm-Message-State: APzg51B8lmDj9JYpsSsFE1OxLZPypKPWmTRMo4z9/FRjir9HAbLleXz/
        DNQeCNT6/FcRPAngL5ZR03s=
X-Google-Smtp-Source: ANB0Vdbeo+rkC4q+ACCl83cD6y/VOly81SfZw2jcrNOtGD5Ycr/ETx7bZ7elL/t+xzxcTG4Bj11Qrg==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr12308313pgu.259.1535677264752;
        Thu, 30 Aug 2018 18:01:04 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id b73-v6sm15948475pfj.93.2018.08.30.18.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:01:04 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:00:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831110054.475a3534@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
        <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 09:39:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Aug 30, 2018 at 9:15 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > It's also had a lot more testing, but has held up nicely so far on arm64.
> > I haven't figured out how to merge this yet, but I'll probably end up pulling
> > the core changes out onto a separate branch.  
> 
> This looks fine, and I'm actually ok getting the core changes through
> the arm64 branch, since this has been discussed across architectures,
> and I think "whoever does the work gets to drive the car".

Well it would help if powerpc say wanted to start using them without a
merge cycle lag. Not a huge issue because powerpc already does
reasonably well here and there's other work that can be done.

I will try to review the core changes carefully next week.

Thanks,
Nick
