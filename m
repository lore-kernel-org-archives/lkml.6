Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523521283-2-6557006365527845611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523521283; b=cZ2kMGNuKzxizwqXoPmr6vMU6321y6W5N6TI3H9j5YN3s6S4dk
    aMGvyNbK4bbHZFqW8lsNNi+b1bQDKwpEISKM2F4Dl4JbV6Y6QmvHm1p0hY0NxFkO
    mUkatJpAef3qVeI1K9OjC3XMzf6syE8rkDOcuKG6u20qRb1dIOZsVQdjeTM0nf9R
    VM5N3ODFcFoakwRJ5gKQtRDiFVU+VSFmlMviOh1Y3Ed1/lxqHg4zWji8LJ0Ai8wM
    f+GXsfs4rURU1wXz7GpORX82hUH1dhLaFixAYTm01LsADU9xmdzH9e1oARbRs44/
    BCaGwlHjhXu/dLErIqBzoxJtiqQ51NESxLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523521283; bh=4QpNL4+bJonhyeCSuXk7yiaMqAPd8i
    B9Sd76OPTjZ+8=; b=coUzwuEGrNaXD81qZGD2e0jsVtD2+HFNqZ30MRlGAsdMQy
    +e646GNnG03yytH7JwG6QjRzlw+7tR+dylnmplw5eQ9BxhJ3crRzCMtQdoEtGb1Y
    Em/BZ6GpTx8ROod/bQEv5el+z0UYO4lErbgqNmrJHw0RlSw96viZknqC6vKwcSjS
    cEZ33PO04Uj0TwE/ZeWFrXlPzb14vtivKEPtSXeJDClnHwLJOXOSw3Seu1cLgj8B
    vfhGPx0fAD7xkmoDLCblGxQTZsYn21SoZUej8nEaWgvNy9fYjMCUT216+ZCGnqJY
    4cgGHEKlsbNznCfmTd4c/ML7l8y1VVINbaOyxxAA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOlPZMrGtkel2SytpgnEpCeSXPIjvOROr9wXeKwC263X3DINcixWJtg2U2MVNTRg7rPTkaGXOH1VLmWQgaht8BHhKtGgoVyoZRX5AIK3122A89L7C0GV
    7GW08Lo1teF4OkAGYK2eQbWVGhelhn6gpJy1bFlO2P+LMNzxT0vepE1QjUiAiHGkqu2KQ8vlUgtm8qAsmfNNualc1g3SScKiAKulXm/fCiaA5EMKGkyZEv/c
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Ikd4Dj_1AAAA:8 a=OaXELHo4e7-4auQuI2MA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeDLIVU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:21:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58863 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeDLIVU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Apr 2018 04:21:20 -0400
Date: Thu, 12 Apr 2018 10:21:18 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
Message-ID: <20180412082118.GT23400@dhcp22.suse.cz>
References: <20180411120452.1736-1-mhocko@kernel.org>
 <97504dda-4252-a150-e7b5-43fe587aa055@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97504dda-4252-a150-e7b5-43fe587aa055@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 12-04-18 10:04:06, Michael Kerrisk wrote:
> Hello Michal,
> 
> On 04/11/2018 02:04 PM, mhocko@kernel.org wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
> > atomicaly probe for a given address range.
> > 
> > [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks! I've applied your patch, and done a little tweaking. The results
> have already been pushed.

Thanks!
-- 
Michal Hocko
SUSE Labs
