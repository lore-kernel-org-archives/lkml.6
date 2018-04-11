Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2499229-1523453120-3-4519607583215729277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523453119; b=sT+N160vdmrvyPd9/g/weV9OImu8cRZ1CPpkkbcoTG/V1D37Bx
    3I21MEIA5YWXsGTdulGbkLXl5pLcKAj5qJszfp7zmVfksu1ouxqhJ6i+fAJjPzWi
    Ts/K1lBWNTTYnbpeBkpmXLVNH/jXyFIcy9hxNXP2pBdz6UDKPHRBP2yYLyrqtj4O
    d1yVxUEYy1FyrJ+7h1DzFViaB1OrR2xUNEhe1Vx77khl6v6mbhtUQdcDAEM2Tr1O
    M3Dydy/DgVhhr0ZRL7QPAGC8vlK4/mv7OrQ0l1aXgyjs3ep39hwDBcN4pj+XquTe
    UgDyL4WBkScVIJsjQzmnegCtajPBioxEyO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523453119; bh=88ame+RGL33z/cI2wMZwlcrnWm+N3J
    FCWTLscM+pz4E=; b=giYa751JWMBwVnJYx9KWO+gsyMDf+kqqWhMQa4ZgMTXqNO
    Fe/mrPwbiy/sP8kWzoNlwWuWZazq74MjrGlP7bOk3HFKGE8/vp6J4fvt3Gt/EBop
    899s1vqozKtuw3/i/s4MjYY9zN+fLDtOq5ZB9YERGWM2m54INVsuE4owcap/cKJ9
    mlH+ypsTQCQRzpkNw/4OpMry1Evfho++0aHG4+1RxxXfms3dUyzxcgU28M3dAmtz
    9xrNIMCORYiWfLL6mFj7yzzsm3AEYi3D4KpkbXYfgJDc948h6C/fWDMAVLKQTSjv
    SwOU6Z8LMVsncVRfc4fO5tAhvlpquNGcFNR4bihg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDvbBBUD1ZcKtYlSwEttMf9VDeiQ8O5zIDYNW5hIzZt0pJ9vftIUQq64gR56FvepipXRuQmNJk0IsXC2cQPS1w3FYZToWEVHF7aqlzCW5Fx/ntzFYg0t
    CU3qIkd6/M23xPuyvQlmEQE/vprtNBAsBea9EtQZBIrGJEsOkFAWwOvRTtkorqIC8F799acyxy3UCEPYs3A+O+PbY8baNSUgvmjXkpi6ODgtEdAJY6ZCOzZ7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=gu6fZOg2AAAA:8 a=V-ww0aKWpDGzI2Sdbb8A:9 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeDKNZR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 09:25:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753194AbeDKNZQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 11 Apr 2018 09:25:16 -0400
Date: Wed, 11 Apr 2018 16:25:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
Message-ID: <20180411162435-mutt-send-email-mst@kernel.org>
References: <20180410212902.121524696@linuxfoundation.org>
 <20180410212917.818627954@linuxfoundation.org>
 <20180411023210-mutt-send-email-mst@kernel.org>
 <20180410.205553.264864966341341110.davem@davemloft.net>
 <20180411080413.GC2137@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411080413.GC2137@kroah.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:04:13AM +0200, Greg KH wrote:
> On Tue, Apr 10, 2018 at 08:55:53PM -0400, David Miller wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Date: Wed, 11 Apr 2018 02:33:16 +0300
> > 
> > > That's a bug, davem just queued a patch to fix this upstream.
> > 
> > It did not get queued up.
> > 
> > The patch series didn't apply so I asked the submitter to
> > respin and resubmit:
> > 
> > 	https://marc.info/?l=linux-netdev&m=152337186209819&w=2
> 
> So should I drop this until a fix comes in?  Or keep it for now?
> I have no objection to staying "bug compatible" with Linus's tree :)
> 
> thanks,
> 
> greg k-h

Fix was just posted.

-- 
MST
