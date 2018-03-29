Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-984330-1522333833-2-4067106293552520827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522333833; b=TlrXMoFNShTiEkTC+bCfLU0uXBW66qZ8XfD8tsqdI8BI5NeZTa
    IxPFvekCD4FGtRloSGWfcxDWy4dovi/rheiZI9AXOLC7iQ+Hw2/pkz6LQvTguRP9
    XiKUWMy+iMy1K1LzovQnX5HbzL3Rxh/dzE5TtoGG4sUwgwqUmIKgolZ+61ejG0Ig
    hlM/44sCk8ACRqN26piWA8QjHnYcamEqvkTQDnRkk2RiAcBJ0Rk76drjVktcyHIu
    LkUPN/ROBUPqErVRrwmV71YXbn+EYAE8ybEeKOaT9S4fofH94hm7GeVMhpW/jWg6
    fgPfF2AJnYlS0mNEOujyHytgd2m1NAIreufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522333833;
    bh=rdIzooebDAOFDrF8MlvprKW7uVRJwG5f3RLc2wIFLj0=; b=bNWpcbuV5TIC
    IawMca18/C8XjPbju2MzgaB1VFZDqqaARqEuG7Y6FR/iBATt3yZxgt8l3Vn1gung
    b3PyT9BnDTpQDCaAtQLKT8ANj5XW3nlP0BL1Ktu0N3b8gkCsdFHyJDTlavANCeU6
    XtyZycmZ0aFpdVf1ky1LJwqiDWVUmR28aXM4Mt06B4gu5VS+gBlu+tSzv1kIPQDK
    FzHZkbx52lXD+ZiRzYDD9gYFtkKior9TlOB/Be39Trv98+p2+nyhCeQ1GkhaH4za
    W9oxDVFHPzNAZMuvmLogdGSDJ7W1VCi+oMlxdfOSQZKsPeEcH1+4WteXjBvJ0HPC
    bX4qiXQRdw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA66NI1nACsEjJ9rXxNfdd/4aaQ/McEmXnxelrAwa5Vfy3I7iWuEU+4BU0NTLgn3GpyL3hr/u7VNwFVJcTDdL6mZ0dKrrxZtNVsNs6mHY9Skj8rzc/LX
    W2F+6rjXTDt/fxcJdZzjZN/R6moJfzXfK2BmJ/nvSJIeZ7SNhD+wFGqq3/8M8JNHuUnXTIEzY/s/xlmXnl4/uffoPrRWFzSMHXoFhl6L029SQ2EsyyVn2gel
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=hD80L64hAAAA:8 a=6qkhlW7tE5uzx7neum4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeC2Oab convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 29 Mar 2018 10:30:31 -0400
Received: from osg.samsung.com ([64.30.133.232]:52483 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC2Oaa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 29 Mar 2018 10:30:30 -0400
Date: Thu, 29 Mar 2018 11:30:24 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Inki Dae <inki.dae@samsung.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
Message-ID: <20180329113024.6cc18340@vento.lan>
In-Reply-To: <5ABC23A0.20907@samsung.com>
References: <CGME20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093@epcas4p2.samsung.com>
        <cover.1522260310.git.mchehab@s-opensource.com>
        <5ABC23A0.20907@samsung.com>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Thu, 29 Mar 2018 08:22:08 +0900
Inki Dae <inki.dae@samsung.com> escreveu:

> Hi Mauro,
> 
> 2018년 03월 29일 03:12에 Mauro Carvalho Chehab 이(가) 쓴 글:
> > Hi Greg,
> > 
> > Those are the backports meant to solve CVE-2017-13166 on Kernel 3.18.
> > 
> > It contains two v4l2-ctrls fixes that are required to avoid crashes
> > at the test application.
> > 
> > I wrote two patches myself for Kernel 3.18 in order to solve some
> > issues specific for Kernel 3.18 with aren't needed upstream.
> > one is actually a one-line change backport. The other one makes
> > sure that both 32-bits and 64-bits version of some ioctl calls
> > will return the same value for a reserved field.
> > 
> > I noticed an extra bug while testing it, but the bug also hits upstream,
> > and should be backported all the way down all stable/LTS versions.
> > So, I'll send it the usual way, after merging upsream.  
> 
> Really thanks for doing this. :) There would be many users who use Linux-3.18 for their products yet.

Anytime!

Please let me know if you find any issues with those backports.

Regards,
Mauro
