Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4167094-1526660160-2-5122257718317349486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526660160; b=gXVxqcVbb+n5VJYObcGFkMiEdewwRomAzlLDlhDZTpjyn8hiWa
    6j9vgpjdmk2ZFO44qKadtw+PZhl+K2kUP90Lcn9tr7ruIrwDcEOCdZ5zWmEWitbA
    TLClRbkyd/byCCXAmf3gFHDqrN1eNMqyRPWLsAkkcQ189bZAONQveMAiR/nW5fi4
    rSHxVpg0Zk5hfEUfkM5OlfQkedVB5NQyMIv1O8njL4J/5Fj1FPdhH/MDUD3PeK6J
    TK+9/dqMUHYyHQnAvEMiGaq5pWnezhDEPNHb5eFXP2TM/xndAzW0tl9i0YIS3AKT
    nAbcJOdASf25aDzLPONUvA0dYLxYh7blsHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526660160; bh=mTd6kJsWxN0UpnXUxP1PVdbyAtd705
    jgZw8JLv5t6W0=; b=LgTnmGS+SvDQetqJJ53Q2Y1a4OM8kGiFnEW62j3wyG+yxq
    lT17f18/vkf7sOIHCey9oRJayqoYkIUfetEeNxKCjIQsZ/FUEgnrXTiiHsEL/Cn8
    ULdia13bZla8HJ6hsDR/DsVBVKFlA01L0TPu9txWd6uE7oTPNDi2rSC2TSuz0iYd
    By5GUVG+sjkYIZsKGovWf5fpIixzxsX1inh+V2BH5nXSGlsrfPnF1ObDmEccWQwY
    vF6+E/YobhX9vgwJO3Gs8iO88FxDt61FMflXuMEA51rkEG1LjqBCduYzrdnX2FHt
    cK2iByCb74+qIF6iFR4BlVEYvlwZOzUpVia9jxoA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=GY7oSo+r
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=GY7oSo+r
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBUsotfnbaEfHVCAlBz8dTi0mnne4qYbyj9VFSCd+r8Jmdje22r4pv6ST+v7bmBwHSFu1mrBse9Huz85CszFPDvwMBp9J4DJMEhCogpxFTsk1RFY+fdZ
    BWVIT3U8KBM+eIShD7ePxHK5IwAPU2lHXbxbuq7FZpgi40h5BB/NmtMOajtAOYtyun89wVmRc9MIErE0CwtlG8Q7UPPbAePwpXm3Wqi9ufwpSE05n8uFSuTD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=m-3w2UqWg4Tghxr6dZ4A:9 a=CjuIK1q_8ugA:10 a=UxLD5KG5Eu0A:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeERQP4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:15:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERQP4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 12:15:56 -0400
Date: Fri, 18 May 2018 09:15:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Potapenko <glider@google.com>
Cc: jthumshirn@suse.de, jejb@linux.vnet.ibm.com, dgilbert@interlog.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-scsi@vger.kernel.org, dvyukov@google.com, hare@suse.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Message-ID: <20180518161552.GA23907@infradead.org>
References: <20180518142318.200260-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518142318.200260-1-glider@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 04:23:18PM +0200, Alexander Potapenko wrote:
> This shall help avoid copying uninitialized memory to the userspace
> when calling ioctl(fd, SG_IO) with an empty command.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
