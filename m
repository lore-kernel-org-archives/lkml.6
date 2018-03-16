Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521235597-2-656216085260489229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521235596; b=S9YqTuuj8SXsTDKCSpwOTM8e2jEmKGLoSF2BUTmGWLyf/Ua
    k8ZyHYsnowIaYAQcn2zeXVvTZXVNITfWhDvno9wGD4hVfrnJ/kAF5CkqltEznoqC
    0jW37Tfr6jEabLutYZACzzpPt1L1p/hoAt7pbPt+mNF63YW0tpGdGRGxepyoElGT
    CB+hYR0Csp6ERI31EmtdTFcZ4E8NtHRwUQITAIEOZI4nRrLSp5KSTudy4rHXRIdp
    iB3GmaEO3A8NIXgLwsOUAgl4Hiwvj6iAdUH1wzJ/dyCvj5Hg6L+dE0hGSisKxml5
    WXhBnsVtrrYg+rNZnuS6vrA4dVBiP4qeNgN6lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521235596; bh=Zi4rvwE
    +YaqJFj3coV7UmuXeXwffjq1Z7lr1YvVqWHs=; b=YOah6xACMGPJSTBswi5YVVv
    a5NIR3wQHVByLcAW1cu+q62OLPxWiN5QLvKNm9yaF3yfSFJBibCJU7NKqLP2vSfg
    eryiTgqlw3ID7EHxyIqdoJBOoxJR2c4fOgd3zIv/RzEz+UxcImqthFv8e2Pv3mDs
    NzBOXGxtB2bbmdU7GnfpVzWDtvIqiu/pHaW7k3UtVS28MvotaBRsqnNPWDuaDedk
    V2uN+m54KquElC5n55R5I4m04AfUaoGf/8SCwBm69hYj51qLihcIvzAL0uiFKH4S
    z8kjefAYBf5OS3bkaRiKL5INMWbDh/QjnL+J+NFhVh6FitDPILU84PQm3YrXrpw=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeCPV0e (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:26:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750806AbeCPV0d (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 17:26:33 -0400
Date: Fri, 16 Mar 2018 17:26:30 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is
 destroyed v2
Message-ID: <20180316212630.GC4861@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-4-jglisse@redhat.com>
 <20180316141221.f2b622630de3f1da51a5c105@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316141221.f2b622630de3f1da51a5c105@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:12:21PM -0700, Andrew Morton wrote:
> On Fri, 16 Mar 2018 15:14:08 -0400 jglisse@redhat.com wrote:
> 
> > The hmm_mirror_register() function registers a callback for when
> > the CPU pagetable is modified. Normally, the device driver will
> > call hmm_mirror_unregister() when the process using the device is
> > finished. However, if the process exits uncleanly, the struct_mm
> > can be destroyed with no warning to the device driver.
> 
> Again, what are the user-visible effects of the bug?  Such info is
> needed when others review our request for a -stable backport.  And the
> many people who review -stable patches for integration into their own
> kernel trees will want to understand the benefit of the patch to their
> users.

I have not had any issues in any of my own testing but nouveau driver
is not as advance as the NVidia closed driver in respect to HMM inte-
gration yet.

If any issues they will happen between exit_mm() and exit_files() in
do_exit() (kernel/exit.c) exit_mm() tear down the mm struct but without
this callback the device driver might still be handling page fault and
thus might potentialy tries to handle them against a dead mm_struct.

So i am not sure what are the symptoms. To be fair there is no public
driver using that part of HMM beside nouveau rfc patches. So at this
point the impact on anybody is non existent. If anyone want to back-
port nouveau HMM support once it make it upstream it will probably
have to backport more things along the way. This is why i am not that
aggressive on ccing stable so far.

Cheers,
Jérôme
