Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2533879-1525975517-2-16349547168406363400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525975515; b=Eq8EfpPvuuZTzyyRcyMgw06Bhfgx0mTH3NSsNJxJ2CjrBgKAyQ
    e/mPKCyymd9hJ0++aCHeba3ZNYRCfGXZ7w3qSRfEXyaQhe1CQXuyoOanFXtX28D0
    uNeajQ9fXWd62Fm5/9bK5I59eFWleK1AkdBWrZyeuW9gys71OiJx+F6/shDmuuJg
    QqaGh/hH296R24/IIPPATFJjmhnSsIpZjaEws4VuL/wPS1m6pX05sk4GoWWcnKPm
    k5LNho4P8OdO/RQk9xcamVKS4t8/GlgNfJ259myT4dcjWARVdj1cNBNFJmcxQjJf
    5RxwgKak/aWkasIN/Eci3XNRXJkn/tUdsCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525975515; bh=vGAJEybvd7IJvuKC87hFrvQRcayQ/S
    HnQJM4oxlCpNw=; b=Mae6SuHE7eooqZKmZZJ25OTL6IbsHTNm8VkZunwDQvX0iF
    joYryo8UFaMXZilnACN6BzYq10X2hN9punQLGwnkyAVbMcSfGL2xf3HvvxkLEd0W
    pl7Pqnfhm3KtKp6+4bqDuLCPjpryAhumNFzVJ+u8r9iauSuC6hkI4GGvBMhlWVSB
    28kXk9W68q3CF42PgNN/vvIf2o3ZWhMiCRqyQEFK2u09DjED8xAgDm3c9rBiXhQD
    xoQ5+E2czu/vD8htwSJGf1VrYMw5jyJ+lGu0gn/otGuMHlX+RyCVV2dpdh0Z6uDH
    CQxSUavYR2nLjh6TEHozBehWZ1GltIb7LsbEcoSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGHELFF/k+K5RmIGUpZ4LEc+f2XHmxfv4H2pTJUI5RoX1B6L0ld9ILPYETSlesFHQNuY5MjTFXddhaT0gQ5BylUDFRUvzrMwfBIZSf89cC1z4k5I/2zN
    KOeeujAD+Z/yJvsW2/PeKa+9ELlS2dn5J7vzE8ygfJFTL184MFfNbFOwWSI7mgi4IfoJFQF/1g3xnLaLoK3FXq2BJF4eQ21l1HOjLfgWD4R8tEh8eybY/SBr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=dLsIQAb4t8nMwJCmKaQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966532AbeEJSFM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 14:05:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52936 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJSFM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 14:05:12 -0400
Date: Thu, 10 May 2018 19:05:07 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: io_pgetevents & aio fsync V4
Message-ID: <20180510180507.GO30522@ZenIV.linux.org.uk>
References: <20180502211448.18276-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 11:14:41PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this patch adds workqueue based fsync offload.  Version of this
> patch have been floating around for a couple years, but we now
> have a user with seastar used by ScyllaDB (who sponsored this
> work) that really wants this in addition to the aio poll support.
> More details are in the patch itself.
> 
> Because the iocb types have been defined sine day one (and probably
> were supported by RHEL3) libaio already supports these calls as-is.
> 
> This also pulls in the aio cleanups and io_pgetevents support previously
> submitted and review as part of the aio poll series.  The aio poll
> series will be resubmitted on top of this series
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/vfs.git aio-fsync.4

I can live with that.  Merged.
