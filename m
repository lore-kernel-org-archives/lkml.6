Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA09C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0862081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHLcEFH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0862081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbeLBKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:07:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37665 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLBKHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 05:07:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so4967836plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1T/bK/E+LATm54MQ4sbPWt8svmG8fqGcobSpZxNTso=;
        b=kHLcEFH1bKAkhggwdDW593qEjJqpftOEbtEtiG5RHVemPNLOHqVGyZb2USR6peEtQT
         xNO37Etjw3LUpr0IwfMfyEZE4gNcCclwjePKb9YUNkelWI0EgzTBTCaCVc/REltIbcxq
         RCtwSXlBBOaQDMMhKBPmQ1St+YST26hcK2EBCmHlwf2PVJDba9ZivXLUuCTLQOYfcbuf
         FHtBUkaX1KfiX0p3UwSqq8SBhyf2Rn6qtw2s1fLWOpR6ExgKuTaB0oS/0nzeGbNI1qY7
         OBGV2K9ru1ckz32l4KUWZIFAljWbO7cQSnc13sBn1O+zPnJHtrxzW/nxfC3+7bn+mpcA
         HVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1T/bK/E+LATm54MQ4sbPWt8svmG8fqGcobSpZxNTso=;
        b=Z//yiRf7PCpA0cfWXaNh7X6D+zGP/zzvphqfSTJrTsbcCxMLCat0Epy9P7EXk7Nods
         1sotioBKtO9Tma5QLAqJZCWsfvBuOKeyBYeoLp+5229XiMZgyLi9wzLT6d2e7hPQycV1
         uf0ioEKT5qIX4vQPlEhhBGfKhelh2EWj6N1Fl1dxzH/LZ/SpcCrI6TYhY3NKMbsf2nAM
         LgaDQR2DxQIWGTEIjIBdcmQ5H5UlV5n2peRezeMhAYJaKVdgfP9BGyewJl5BSXPxv0LD
         FrzmB67Tw5j5nB0FUJxBOl8aeqXw4w1Ne4vdgIrcSp8rDYbAtOC5JE4WVj7j79rtWrsQ
         mZPg==
X-Gm-Message-State: AA+aEWbqcQLIfztk3sBo9mOQoNb5wzEIzL7LjfI6S9nIIpKzbuRr6M5M
        JpLzdZL/R/FERQvplvK49QZ2VA==
X-Google-Smtp-Source: AFSGD/XswavVGCwxqBXW9IqFcYWcryVE7aywfCvvlVuMFde4LOws9+ui+ZfbMMQmz1y5Mn7vPGuSyA==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr12206688plb.17.1543745251146;
        Sun, 02 Dec 2018 02:07:31 -0800 (PST)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id b10sm19705642pfj.183.2018.12.02.02.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 02:07:30 -0800 (PST)
Date:   Sun, 2 Dec 2018 02:07:29 -0800
From:   Sandeep Patil <sspatil@google.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Paul Lawrence <paullawrence@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
Message-ID: <20181202100729.GT239052@google.com>
References: <20181023212358.60292-1-paullawrence@google.com>
 <20181023221819.GB17552@agk-dp.fab.redhat.com>
 <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com>
 <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
 <4a934593-1bd1-be5f-35c0-945c42762627@google.com>
 <alpine.LRH.2.02.1810261558460.28906@file01.intranet.prod.int.rdu2.redhat.com>
 <fba91b2e-4b2e-8daf-ff64-a12c9139cada@google.com>
 <alpine.LRH.2.02.1811151809380.25860@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1811151809380.25860@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikulas,

On Thu, Nov 15, 2018 at 06:15:34PM -0500, Mikulas Patocka wrote:
> 
> 
> On Mon, 29 Oct 2018, Paul Lawrence wrote:
> 
> > 
> > > The snapshot target could be hacked so that it remembers space trimmed
> > > with REQ_OP_DISCARD and won't reallocate these blocks.
> > > 
> > > But I suspect that running discard over the whole device would degrade
> > > performance more than copying some unneeded data.
> > > 
> > > How much data do you intend to backup with this solution?
> > > 
> > > 
> > We are space-constrained - we will have to free up space for the backup before
> > we apply the update, so we have to predict the size and keeping usage as low
> > as possible is thus very important.
> > 
> > Also, we've discussed the resizing requirement of the dm-snap solution and
> > that part is not attractive at all - it seems it would be impossible to
> > guarantee that the resizing happens in a timely fashion during the (very busy)
> > update cycle.
> > 
> > Thanks everyone for the insights, especially into how dm-snap works, which I
> > hadn't fully appreciated. At the moment, and for the above reasons, we intend
> > to continue with the dm-bow solution, but do want to keep this discussion
> > open. If anyone is going to be at Linux Plumbers, I'll be presenting this work
> > and would love to chat about it more.
> 
> dm-snapshot took 9 years to fix the last data corruption bug (2004-2013 - 
> the commit e9c6a182649f4259db704ae15a91ac820e63b0ca).
> 
> And with the new target duplicating the snapshot functionality, it may be 
> the same.
> 

Thanks for that. We are as much sensitive to not duplicating functionality
and of course reliability of the implementation.

So we did spend considerable amount of time trying to make dm-snapshot work
for us (including the approach suggested here now). However, the additional
space needed to make dm-snapshot work in this situation is unfortunate and
won't work for Android. Especially given that we will be taking that space
away from the user all in one go too.

Anyway, I wanted to ask if there is any way we can make dm-snapshot work the
way dm-bow does? With patches is fine, we can work on that :).

I think Paul is planning to send a v2 with more description and the block
size fix that caused problems for others trying it out.

FWIW, dm-bow itself suffers from a mutex for each write that stalls for
longer when the write is to a block being modified (as opposed to a free
block being written to). We are hoping to iterate over that problem once the
general idea is acceptable to everyone.

Thanks for your help.

- ssp


> Mikulas
