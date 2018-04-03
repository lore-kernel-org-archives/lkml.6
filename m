Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2009892-1522777141-2-3843257834233854955
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522777140; b=KwW0gKAcsaB2kJjyt5DLMw7JZKqNorWQ80ktfP9C91jJzBEcUC
    SlE1lpD1kLt/IInlsqR0176zn6W+RbfseIHE4JeDfBW9M4M9FuQ9U6tjYjxFTnb2
    PdQsFHHgT9pPxpokDcMprvrrAwJsM5980Z4mhCHMHls6aFIwqQ08G5OrZDV2sOm6
    UnBiFquwR2KxDG0hg0C0NMU7q26TVml9B8eJUsDf5w/7A2gOuq1mPFsN/TRZ2sX4
    mxVNNExXyCJu/OBgLP27w1+kDVStOhn6iVYrmJk7YYtZwzxLkfvV4dLYYMvXXEmK
    pSRSzYYC6Ac8v0tIrPlXHcBBzXOSyqLoVyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522777140; bh=CiiFNccGpKJ
    7bEze0oOgtwG9v7f2vIthNHtJIaVNxuE=; b=VuPVkOT/FyUYYxjd8vWZCVxau4+
    xfzs0Vcn7cLT6qBik+Jw8ZPJcwUTYzJsw+NDu/Z0+AUJbiS6E4aYIIWemhQsKPRK
    BelviC9gpnrGMpBb3fYY3tc/j1RcGDYM334Cs0b8yyt7lG9VywvMu06cTaYloIzN
    hYNTQx3Q0mFqHhFXv5pij4P7BM+rNHhw36qTU8ZlzL52UD9tDIfjD30pd9JBUUuv
    1gIWwKyq3E2yVvFD2Z/ARQ1oI9YQshJJpW34yhINGSXS6+YWUVKBJJMKrCBAy40i
    Z0KUoHCQ1zRJ8+shZcI4WHFMfmpEzzTmQZp32iUjtYsi3qbO0V5feq1IFJg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHNTIF/r2FXhou5XUh/7FkYyXR1p3GsmFHMCsclH7CtD4MzifyJxpc1kmUIC+tVH3RCKNaWP7ULfCXSbqjGeBn1PA5pBJSR/YWhSfNDOlpZC9BvF/63
    C8l7tAmpcZ8zZ+dGKwE3jhQna8FlRnSjK91xSK8RAbd9q0qsMsapJ1nOIhCs1Zj6o5FDG5fdXiOw42Q7of+dWRjjXTaYHWGGtOAIhZoBUqswwmsRhdZ36snk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=FEnLU22qlXov9jLC15cA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeDCRi5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 13:38:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeDCRi5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 13:38:57 -0400
Date: Tue, 3 Apr 2018 19:38:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 22/97] scsi: virtio_scsi: Always try to read VPD pages
Message-ID: <20180403173855.GA32709@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094158.812011199@linuxfoundation.org>
 <1522767248.2654.105.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522767248.2654.105.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 03:54:08PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: David Gibson <david@gibson.dropbear.id.au>
> > 
> > 
> > [ Upstream commit 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0 ]
> [...]
> 
> This is an incomplete fix as it only touches the single-queue host
> template.  The other part is:
> 
> commit a680f1d463aeaeb00d22af257a56e111967c2f18
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Wed Jul 5 10:30:56 2017 +0200
> 
>     scsi: virtio_scsi: always read VPD pages for multiqueue too

Thanks, now queued up.

greg k-h
