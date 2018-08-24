Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606DF21477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="FOcIIFKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606DF21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeHXS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:29:34 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37392 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeHXS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:29:34 -0400
Received: by mail-ed1-f46.google.com with SMTP id b10-v6so6021490eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OooKl+RZsjpCEQayk7Caf/YPdw/AgbEll1T9D+eWddU=;
        b=FOcIIFKTc1Tg2m8kianP2DaMCJgU9mNUutt2YDvSYjBgIVBOGcsXqzOmdOVtebgqKm
         Muo7mh/XPxySTGTO8QEkKyWPiIhWYcemAy5uuMGuFoparucOIIr7W4CM42k6dge2K+C2
         DfuM9GS2HKvW6owuiohpqYLCnwjHhSMrHfua5yuWYTdZl04R8tX4jQoxKZyO0iWjKBte
         DO6RxTx8XG1zuYkWYzqEr0RV0y55axG8cI0oo35er8t9XQJSRq8+/6mRR7+EjsS8Wz59
         yrC4ZcTnEhgN7wTrlJ8ME5i03X70YNqLN33pw9/DGO0RKPGKrBEmQ4Rg9TLjlDzZwZB2
         nl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OooKl+RZsjpCEQayk7Caf/YPdw/AgbEll1T9D+eWddU=;
        b=mfpUcLWkcGq6tU5D2fsrlWxuOchSabN5BkMZwsk+FNjJX+CA3I+LRsV5VveGh5TZ0X
         EQ5q/0YTzJSNngwBbqHWx1rySE8o20vNJMYybeJduCbw9O8UE86K/PFM0IBf8dJBk+Nj
         xYU1I9rpE0GRJxeog9aR5hUOSEH0qZdsmr1HFFU8b24DaRkl/ARPl069FIs9Dh3o3r27
         YdKfCiwT3BS3/M/KxXCeT7ceaT/0Gjam1hYNuteQh7Lv8xXobYndZbreblE0S0H/A199
         2FIdUz+8y7YvMAielNbrlQC8US1JTDySToaUixcFIqPSxpNaws/pB8MN1AM0FBObdcYc
         xsEw==
X-Gm-Message-State: APzg51ASnvHXqYr/8QPhLnfxUF4oTNtsN7pMQlq5UAyrylHDchLa/IFF
        Rn7cUR2ruHaL1JlfP2mw5KXoJA==
X-Google-Smtp-Source: ANB0VdYGGvUOzCZYRVsj1TcpC/+93R/Zfey9pu/r5cccN7KiY73keQgJMKiVcmUdNnMqJx4Ar+dRjg==
X-Received: by 2002:a50:dd88:: with SMTP id w8-v6mr3225039edk.204.1535122473192;
        Fri, 24 Aug 2018 07:54:33 -0700 (PDT)
Received: from localhost ([94.13.61.204])
        by smtp.gmail.com with ESMTPSA id e15-v6sm2993060edb.60.2018.08.24.07.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 07:54:32 -0700 (PDT)
Date:   Fri, 24 Aug 2018 15:54:31 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Roland Dreier <roland@purestorage.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ben.hutchings@codethink.co.uk, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        ard.biesheuvel@linaro.org, bp@alien8.de, brgerst@gmail.com,
        davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180824145431.GC4253@codeblueprint.co.uk>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <20180823061253.GA8803@kroah.com>
 <CAL1RGDUxkWm+tSdLmptSZZ55mdWCR6i1GevMUx_K-a2BX74xdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDUxkWm+tSdLmptSZZ55mdWCR6i1GevMUx_K-a2BX74xdQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug, at 09:37:28AM, Roland Dreier wrote:
> > > This is bad enough that 4.4.148 and all newer 4.4.y crash early in
> > > boot on some EFI systems that I have.
> >
> > Ugh, not good.
> >
> > > For now I am re-applying the "ensure cpa->pfn only contains page frame
> > > numbers" patch, ported on top of 4.4.151.
> >
> > I can try to add it back and see what blows up, want me to attempt that?
> 
> Not sure what to say... the current state is obviously broken.  If you
> look at what 02ff2769edbc is doing, it's clear that we're now shifting
> cpa->pfn by PAGE_SHIFT where we weren't before, so we're putting bogus
> values in the page table.  And this is enough that my server system
> booting with EFI crashes early in boot efi_enter_virtual_mode() with
> the symptom that NX is improperly set on some pages (booting with
> "noexec=off" fixes things, although obviously I don't want to run that
> way).  FWIW I can confirm that reverting the single patch 02ff2769edbc
> fixes things, as does the cpa->pfn fix I mentioned above.
> 
> It's hard for me to make a call on applying "ensure cpa->pfn only
> contains page frame numbers" without knowing the problems it caused
> before.  The patch looks fine to me and I definitely need it, but
> maybe it exposes some other bug elsewhere?  Maybe Ben or Matt remember
> more above why this was reverted in 4.4.106?  Otherwise I'd say yeah,
> we should re-apply it, since I don't think we want to revert
> 02ff2769edbc.

For the record, I wasn't even aware it had been reverted.
