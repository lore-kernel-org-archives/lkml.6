Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2746918-1524756705-5-4459829931483829780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524756705; b=bRXRdbSb6YfBa603RyFer9sSsybmFJ5tTdwwr6fXZHZ4D3UmP+
    9cRuNzWwkVqfa/0JAwzihov9g4MJlMDUReMkCe/8z3NMCHB4CmEdtnVOIRF75c+9
    AYg5AIjGR7swtC4akGuBTG/Q1m3elIZuWMGONmvU5ggkfmWohxFZlbgqpHmsfaR3
    yCjus8YrHhbeoDzU1opH7vf4xGe/wvIPoa1m2tUbvjd9xKOT9NVlGe+w/u3Z/X2+
    i30PMItUVyj5Oh5veX6RuNuPZ+0mLJk0J4K8Uuu0NeF0nco1TBWXp/e2yq+iuImO
    b/ELcB0cod7O934KYeuIH8BUnXbnL2mLYbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524756705; bh=rzliMRGuF4oaqF6sQC5TbOmiHVnR5r
    VYiKoBkfoNDvI=; b=SjXcPz3l2byzoikNNjCMvf61cR3rfcMzTof90/iHWt3Q4P
    fviGaJCdJmMVeTl3DSkq48cyd00D6zzRJxbeW3LyW0Z3239yvhNvkFo3HwwNGQAT
    7i8rNGekNeY2lPWnAx7nOs8p18SNkV1xe4lEVWzX5zBXt3tgVMCAXJ5jmESbcFni
    on9PCdGw0/UR/VZU6imzSI3JF5XxlRmJNHtGqc/KInjoeKvyBlD7s72zkin2gLqh
    +U7AQ2QybLpxtCnUGG3INjXND2nB/g77YSA7CNG5vtJ2+Pt/tEJQDP0Q9KNBIY6F
    9gZ2y0Ac0G0rCrD5eFiW4aE11s/xM7dV8suCxGAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNL4eg5Lq8RJJMDt0hF6uz2cc+ls7Q+3Wpmay7MOgbczFfvT2aUfT2t7nx3t5wQ/Va+7RHcPauBCFYSO65ieY9QmYdN7l9S3Az6n3IKDEXJSKD9i/WnM
    ycfDhftPowO2BdkWLa0n4HvO4/ONhEaYS3WtktKpVZj7IFJo/gkWpkowz471MvScpjbeBXJ7sgLeJWuKSEMxmN7RYF6rOTS5FmZEC/hu7obnZWqydNpyxBde
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=mr87v4auvEVpSelZpWYA:9 a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10
    a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756414AbeDZPbm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 11:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50349 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756589AbeDZPbl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 11:31:41 -0400
Date: Thu, 26 Apr 2018 17:31:37 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Michal Hocko <mhocko@suse.com>, Borislav Petkov <bp@suse.de>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Message-ID: <20180426153137.ztgwzmjnjwg3qvs4@suse.de>
References: <1524755647-18695-1-git-send-email-joro@8bytes.org>
 <20180426152712.GA17729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426152712.GA17729@kroah.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 05:27:12PM +0200, Greg KH wrote:
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

That is fine, as this is an upstream-first submission. When this commit
gets accepted it can also be applied to stable, given the original
commit was applied there too (didn't check that).

I just cc'ed stable because it was cc'ed on the original patch.


Thanks,

	Joerg
