Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1760902-1527582098-2-11804803751209025196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527582098; b=P1g0+RRTFDv8O7Df0MfAl0bx28M3pZsT9kvKri6nMOfft5GJaD
    R7zvTWKicMZZEWczMYy3Zl9U3iBFaV/pcIT+zoyhyKETVdmp4iUS2oFaS7eFpQsl
    trLdggqL+aKMJXsqdIWpCOGc3wNHXVKqcOk/1S7CHjuPSZNGkT2ULMfp98OvJKdb
    xb/GHEKBA/kVQC6vJPMZs+uqrPhII5TGByIrUayKNCeRQXIKxv0ScsBkk8PqkkQz
    +gZo0iS2MIZRsaCivm0RoW+12zNRpFThdZihHj61N464mIEepj/eTgs06cOmgx7+
    YVXs3RtqE9FwIpNJ8MkiWbdIkhHsD9ALEg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527582098; bh=Ebwkh5by50d00zeycbPBBGAYC3mxpT
    U6o6gvs7tuUsA=; b=UFeYksqHHCVnz8wkMNbGOGEsmCt16hx2VH1PJ6/DroMXAF
    uBgFlvs8KgiU2V0693uOwiaNas5nVVnQuOYOJAKgSaE+8Kv0KQnv0B2GtZsk9MQo
    4MAO+yfJzCFQohamQn6Jk/zY+Og0IXF0lY4rJHJVb7PHJr0ORJfrETJWMH88kymb
    tSu4GHTgKUWTeVN++KvNXb9I2JHstx9Ne6ouEWmvURooBnHfao2M+PliC1BMvXDY
    ex3dF2QGzyPaHwA2QtIYqGqpB+tvmE4vjdmoGbNqOC0guj/vfdO9MwGCngfwtb1Q
    gtcdd1yYBrUilobcfBdvG5lePIFsoTmPGzjIorig==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFc0L2+TNkKy8R5dzmIVjgVdR81mHMK0iDg5Z38dP6+TWZlFjMdWrnrwXgJHocjJYxdkHOpHijLiY8EXSC15Bj470x/4bMSwQGq9GiBnVWi3CtH4X7Hk
    ufTM5Yzrs7/PhpqP/hV6YaW0ipDTZ/gMRNRsobrhDVd+PdJln1I/vjZVcLF+jEX5lpyUUgSIItlhc6Rp4JiI/O1JUaEZBw7sHGe74cey/BR3AmZE0dEc8e9S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=vWbxazblGus6aMOT588A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeE2IVe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 04:21:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932081AbeE2IVc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 04:21:32 -0400
Date: Tue, 29 May 2018 10:21:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180529082130.GO27180@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
 <20180527124721.GA4522@rapoport-lnx>
 <20180528092138.GI1517@dhcp22.suse.cz>
 <d2f6c4c1-856a-d233-8610-67a868b856f9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f6c4c1-856a-d233-8610-67a868b856f9@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 28-05-18 09:10:43, Randy Dunlap wrote:
> On 05/28/2018 02:21 AM, Michal Hocko wrote:
[...]
> > +reclaim context or when a transaction context nesting would be possible
> > +via reclaim. The corresponding restore function when the critical
> 
> "The corresponding restore ... ends."  << That is not a complete sentence.
> It's missing something.

Dave has pointed that out.
"The restore function should be called when the critical section ends."

> > +section ends. All that ideally along with an explanation what is
> > +the reclaim context for easier maintenance.
> > +
> > +Please note that the proper pairing of save/restore function allows
> > +nesting so it is safe to call ``memalloc_noio_save`` respectively
> > +``memalloc_noio_restore`` from an existing NOIO or NOFS scope.
> 
> Please note that the proper pairing of save/restore functions allows
> nesting so it is safe to call ``memalloc_noio_save`` or
> ``memalloc_noio_restore`` respectively from an existing NOIO or NOFS scope.

Fixed. Thanks
-- 
Michal Hocko
SUSE Labs
