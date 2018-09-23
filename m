Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F82ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97001214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHlcU1hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97001214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeIWPUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:20:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIWPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:20:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id q1-v6so2345969plr.4;
        Sun, 23 Sep 2018 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTp/UI3ZNNsXvQvkOEXt+YcwGy265tVijee0umcwmNc=;
        b=tHlcU1hzz0nUH4e2K2epN6LmLDt1pt0pT/9g7QctX+iVhiBdCPVFO3/ocOnwawf0gU
         YKqw9uQUi2PbLbu+jUs7ftQqubQJjNjn1ways3RVk1bzycHnsxfd1OAo4uK3nkgU0GHQ
         4zxrzBHnNNCcvGnGrb326hOBXepBVpCg2VOZKrMlUcdiuuNZmyux97jCHVEF6fvAdVel
         jRibKXTnudUxSYTVYZnX/pObq7H7v6ahzINGJipTLbVA4p8pgMEu5vrQveOEcKJjvJcA
         VxbtxcLujyPoVFyyAoixRgEB43S9mhLSukQoFT731ccpyNYrBM7lLQNSXdpVmi+/Zp0e
         5mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTp/UI3ZNNsXvQvkOEXt+YcwGy265tVijee0umcwmNc=;
        b=NTOGIcfgSycTrgbh5lmzaACN5OH6EEEBRin7ESXvUsVvGI6ZWDrvZ/uCo7i6zg6UCi
         pw0/N6MlRRpaDJKA9VY2No08bYSYD1YViGl6f9oMa7K4q0dacRYZ/rKXM1Uqg0mgqSK9
         LlKnHxQQkvHfyJ10KhgR52AWR8SRBt3WCaJCdKoIGf4rSaDvQWHj2RzvOcA2SBrX6A4Y
         G8RKa6aksIDNCsEM28FF5ERCs/2YnBeyIG3QY8zlQtl+u++zUHJyl7tqFSu2bwNxVVhp
         4bEtF6af7C6NAJrPVkMPFMGYl9H2xPr56l9hTtzQNzNpx6sCQXGUb4pUD7phPyMuQFkm
         vztQ==
X-Gm-Message-State: ABuFfohgPdkFEFnxonYlwNfbpLGSLzb+Br8tfgG1Cpm8RtRNBeB8mJJn
        fVjMiIovg0O03oxejIj63Pw=
X-Google-Smtp-Source: ACcGV61LoABF/yvN5DHHTzAyhS/lGNTbzelaPhjqyGxhAZlqeEc9gClc8eQ7TapjwXxKbexiQ5e9uQ==
X-Received: by 2002:a17:902:a507:: with SMTP id s7-v6mr5667059plq.303.1537694602832;
        Sun, 23 Sep 2018 02:23:22 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
        by smtp.gmail.com with ESMTPSA id 143-v6sm48835281pfy.156.2018.09.23.02.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 02:23:21 -0700 (PDT)
Date:   Sun, 23 Sep 2018 19:23:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20180923192315.13cb4114@roar.ozlabs.ibm.com>
In-Reply-To: <1537519325.19048.0.camel@intel.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-4-npiggin@gmail.com>
        <20180905142951.GA15680@roeck-us.net>
        <20180918035337.0727dad0@roar.ozlabs.ibm.com>
        <1537519325.19048.0.camel@intel.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 16:42:05 +0800
Ley Foon Tan <ley.foon.tan@intel.com> wrote:

> On Tue, 2018-09-18 at 03:53 +1000, Nicholas Piggin wrote:
> > On Wed, 5 Sep 2018 07:29:51 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> > > 
> > > Hi,
> > > 
> > > On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:  
> > > > 
> > > > Similarly to the previous patch, this tries to optimise
> > > > dirty/accessed
> > > > bits in ptes to avoid access costs of hardware setting them.
> > > >   
> > > This patch results in silent nios2 boot failures, silent meaning
> > > that
> > > the boot stalls.  
> > Okay I just got back to looking at this. The reason for the hang is
> > I think a bug in the nios2 TLB code, but maybe other archs have
> > similar
> > issues.
> > 
> > In case of a missing / !present Linux pte, nios2 installs a TLB entry
> > with no permissions via its fast TLB exception handler (software TLB
> > fill). Then it relies on that causing a TLB permission exception in a
> > slower handler that calls handle_mm_fault to set the Linux pte and
> > flushes the old TLB. Then the fast exception handler will find the
> > new
> > Linux pte.
> > 
> > With this patch, nios2 has a case where handle_mm_fault does not
> > flush
> > the old TLB, which results in the TLB permission exception
> > continually
> > being retried.
> > 
> > What happens now is that fault paths like do_read_fault will install
> > a
> > Linux pte with the young bit clear and return. That will cause nios2
> > to
> > fault again but this time go down the bottom of handle_pte_fault and
> > to
> > the access flags update with the young bit set. The young bit is seen
> > to
> > be different, so that causes ptep_set_access_flags to do a TLB flush
> > and
> > that finally allows the fast TLB handler to fire and pick up the new
> > Linux pte.
> > 
> > With this patch, the young bit is set in the first handle_mm_fault,
> > so
> > the second handle_mm_fault no longer sees the ptes are different and
> > does not flush the TLB. The spurious fault handler also does not
> > flush
> > them unless FAULT_FLAG_WRITE is set.
> > 
> > What nios2 should do is invalidate the TLB in update_mmu_cache. What
> > it
> > *really* should do is install the new TLB entry, I have some patches
> > to
> > make that work in qemu I can submit. But I would like to try getting
> > these dirty/accessed bit optimisation in 4.20, so I will send a
> > simple
> > path to just do the TLB invalidate that could go in Andrew's git
> > tree.
> > 
> > Is that agreeable with the nios2 maintainers?
> > 
> > Thanks,
> > Nick
> >   
> Hi
> 
> Do you have patches to test?

I've been working on some, it has taken longer than I expected, I'll
hopefully have something to send out by tomorrow.

Thanks,
Nick
