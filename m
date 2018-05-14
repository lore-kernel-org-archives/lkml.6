Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572352-1526339485-2-4140744198925651292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526339484; b=N6Nhjn7yBc//0GR9ZreZ4ri4FGtrEXBadkVIidmGFIjmEMyhQK
    7vE/8kKKUMxzcvhDSSKhwvYf5Qdiqi9XXnCKRm4bQZwKh2hci6de1EurDTooOwwh
    YRIUZysP8EGFWq2LmH+knn9/KUEl9j+5IHThGhCOt45tjGTVLAsddbov1LX4G45C
    WAvNZhjG7qGrV7PH9HPVc2yWOrJ9l5OVQeDrrGoe6lzblceembDPGEArVLIex72P
    HCcsTALTSqUXkYeMcwASRitRf9GTqRkDgwZfsOlpNKq2ZDi4WelCEyQcSTDwVLMs
    GBUOb6omhH4s2B9inX45Xg8XQVz6h6jRCokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1526339484; bh=wUNStNW1bXSxBmsPlW5/lril2rc+RGvF3EXmavT
    yDW8=; b=B3jkN74kt8Zt6bmrl1V18SlZPFRU+dCYQ7KTS/eKv/159xD4TbeJlAe
    llUYBsdm7Ywjxi10eVVNe6Eoi+cY0EGDxSVK4PJm/Q7P2dbJC3TbuZDR233jDfPO
    gOLst6ZHJYR7XJbzvvM3LRV6BoBpNBCnPBX0W+xjodz3dvOSgoRCUeJoyPFboNOM
    rEzg9pkoXzGurI+tVG19ru9UPBgybjqXaweRREnJ/fJxGw0ukfCWLdbCf3RYBvF1
    9VCql7I9kx9CheB7vgh4YzJ1rHqozpUybXDZt0i2dRXL8aKBxBRMgi5No3YZ1wd4
    2wpNfgWBA2LQG9pBYMvsILPWNopUr3g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDiCWTCs1NHGPJoqGaoLqjjphx6iYhjB8W/+IcXyUNuFOgqY5oN9+J/K92t8JeQVcw3aQmsLAHo7YTx3YxAv+FOxUY6OJs9VvtDqdWIgfVr1xtvF/10R
    mAHiMuGgGQLiZE80gDJTx2ZCrzldHoBiUuSuSz4K1zvCTvO1iA9S7ieLIegschQuVjQDJEUoK3sxhEFltb1lcXQAux+E2bo7LLqa7JISmb+0Jzmke9QEgCM1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8dpCUCyp5n4A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=JmvQfdDft-mIqNVBj0cA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeENXLW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 19:11:22 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:59480 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeENXLV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 19:11:21 -0400
Date: Mon, 14 May 2018 23:56:01 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for
 small_memset
In-Reply-To: <20180416202234.GA23881@saruman>
Message-ID: <alpine.DEB.2.00.1805142329120.10896@tp.orcam.me.uk>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com> <1522315704-31641-2-git-send-email-matt.redfearn@mips.com> <20180416202234.GA23881@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.96]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526339478-637140-14382-841-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192989
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, James Hogan wrote:

> > @@ -260,6 +260,11 @@
> >  	jr		ra
> >  	andi		v1, a2, STORMASK
> 
> This patch looks good, well spotted!
> 
> But whats that v1 write about? Any ideas? Seems to go back to the git
> epoch, and $3 isn't in the clobber lists when __bzero* is called.

 You need to dive deeper, that is beyond the secret commit 66f0a432564b 
("Add resource managment."), to find what's happened before the epoch. ;)

 Anyway, there isn't anything special here, the thing has been here since 
the inception of memset.S with commit 2e0f55e79c49 (no shortlog available 
for that one).  And it is clearly a bug, possibly just a leftover from a 
WIP implementation or whatever.

 And I can see Matt has already fixed that, thanks!

  Maciej
