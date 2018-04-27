Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869114-1524810516-2-571059851603024539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810516; b=LzkYTwhKicCZ9DYlBxEmyS3g3ojjugkIfwiTKkbzpQKX5NAm0w
    vHoQezLBzB9fFg22uw/HvcW1CE/0lnnEdUr+P2mGAFrbibCifICDo61rSPOyNmim
    I9p9RpbEj7VN5YMx0A+/o6VKk8EtIGpkAqqpVZK4xoOyu7Ew+ZqKS0uSVKu1UeaX
    a2ahVEJk4FsAbe9eK6jChU8DWnIqPoLCzhDH8Z2A/iSjWZnNi6+iEG69kW7uiDJD
    HNiee8YQwV+EZ1Co8b8DskHjATCk9VgwZ1ggZOuj0GR05U9LCIdwAbDvYU/6WV/r
    U8WNfnyVPO9N5MRPej8XeXJzo7XpKYYYqgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524810516; bh=bgonCAUSKIFnfzNduXEngx0LQS6Dil
    KQS2ZgWJU0bA4=; b=MO0EyC3EC5kItkLsTbDHatG8YajWqfmK0Z1j2y5vwfHJEd
    bb4NaeaGGX7dnnCT4oDflza914g4Fwef7KEWflja4+aUEZt+XiwY1JQIP+y69x10
    w50/2lEgFSm2nwFjNkgYiEqz8gJIlT6/PTupU8MDTjWAcU4AZACfM/QEWfV2dM+F
    XYePFmaoC2VOSM6TZ7IlDeTCyoYDS5+s2x5n4lOT9S/kjKR4NqVWQ50+CD5cOGQG
    gSoCSzKSyAftVqgaRnsAiN+8XzFFgfWQAiTaJ7Cad7cAhO3dybiooMgod+tDFuUN
    Ljh6JF9k/iJcK25vf7+C3PS/zEQUZuLAkn42lJHw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KT5+tpZW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aTPOffap;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KT5+tpZW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aTPOffap;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKpSV07kFs9hjlZKD2/PSM1xZsLP3rnL7eH0jn1OUt/YaoMEj3T7TUusZhAoTGWznebPG0imqWSXrymsC9MdifimrupJvLpBSeqANfprdPm5B2AeEy4
    LD4E5JJVf7j4VwFoQlpUq3iFeHjGvFgLrmaiwVDPCV506+CEj5JV8BnApnLyHfWLyOtXJra6soB96FUQBFkvO5rMeJAPUpwEmnSBzkP1Vvig3VHa5a7eD/59
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=MvuuwTCpAAAA:8 a=z_2eJEbwLPwyjiWl9h0A:9 a=CjuIK1q_8ugA:10
    a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeD0G2d (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:28:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53425 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeD0G2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 02:28:32 -0400
X-Google-Smtp-Source: AB8JxZqNxLtA3IK8t1v62L/okAlNVWyG+6Th9bYsNpLkaxqC/FHAljnq5pb9gtD9O2V7jdLCEDj61g==
Date: Fri, 27 Apr 2018 08:28:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "Hocko, Michal" <MHocko@suse.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Message-ID: <20180427062827.js6kwkwye4ewkuz4@gmail.com>
References: <1524755647-18695-1-git-send-email-joro@8bytes.org>
 <1524760125.2693.468.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760125.2693.468.camel@hpe.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Kani, Toshi <toshi.kani@hpe.com> wrote:

> On Thu, 2018-04-26 at 17:14 +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > This reverts commit 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89.
> > 
> > This commit is broken for x86, as it unmaps the PTE and PMD
> > pages and immediatly frees them without doing a TLB flush.
> > 
> > Further this lacks synchronization with other page-tables in
> > the system when the PMD pages are not shared between
> > mm_structs.
> > 
> > On x86-32 with PAE and PTI patches on-top this patch
> > triggers the BUG_ON in vmalloc_sync_one() because the kernel
> > and the process page-table were not synchronized.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> I do not agree with the comments and this revert.  Let's discuss further
> on the original thread.

The original patch is totally broken (it's based on a misunderstanding), so unless 
you have a fix the revert is justified.

Thanks,

	Ingo
