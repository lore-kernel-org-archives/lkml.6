Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2377225-1525764071-2-4320780084215438339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525764071; b=FOb357CsPw7kVCFyjwgS7Mgu6ITgRXqYNIaPg6f/0thfNqb/mG
    lP7x+FKdB0lxtRxuy+0mw1RN0dLVYny8NszaiTcbsnTyjWyctSV+E/fYrqQ6fzRJ
    fObqIIUxHpd9F+rGHpvOa/+T6k1jut+Qpggos6DF+bcyC7i9SDm4eotLb9Edhl0u
    aAyoptmUmVLC6DxFYxFtfgO7FfB80i/byaPKsHnoY7vn2fK6ZDFj6oYHkAQqLrmt
    8dK5pzFtH1HLNardywNSzR6FBDc5ZoLf4HcBVO038nQ8qnttLQhRWz+vMPmdAN6i
    QXw8S4/R/0OENMLcUIY8blooj6PSVSi+P6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525764071; bh=+A4MDD4fM5dOeIxaOUsHnkGQZGokxP
    x0WNeAGF0/Ois=; b=nhI3xHnqQfOs9VrdfCEWs+dTrgrvQPiSvSQmsraPcerA2z
    75mv2+W6NtaIJDftGW71ytNHaDox00Yo0v0nzRzR3SRXOq1xozr/j+vjXWl5pcvr
    t4gP+pq5onYE+Swogw6DitQRHd4Ej8bCKKMRrqz5UrDr5vPD3tUzhvkZirgyel1k
    nfor2ZGvpDPlqPmjojeSdRts1vuzJIPKDKEgOciOMgizN8CYgWCTIXIVMoMNvffd
    s3DJ83kccg8IRgbyEHaFKsbGlzH9HqeVizb4jNL5/V8pLk5EUOtxYQnqwjVhO2Qw
    hOwhxQLDO2ooCOEvKiBV20YagXZ9pBjOj7DavH+g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=qVwfCwxV x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=qVwfCwxV x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA0Edy+fA8utPVMYyKjOoEkA+akS7JjkG8ODy7etnFSk/ovMJcXw3AsuvhL2jE2zTWb+SVlc/tZ2XFVX3JXR7tWaNcvrjG2lF1AUblDOF2rVsvv+nYTu
    e/CXFxRUpzK30BXlPmqOEhkzX5Fs2WULCXm4UUUfiXNLtKURO/An/ClfBAdipHh2a8ySvYaC1tvlbO/tLvaBiNNbWwMzrvCa0UjR975mBGvajv5R/S8sh9tB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=ieh0TtmqImcluCFY4O0A:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeEHHVJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754139AbeEHHVI (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 03:21:08 -0400
Date: Tue, 8 May 2018 09:20:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility
 bit mask
Message-ID: <20180508072055.GD17166@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.637526548@linuxfoundation.org>
 <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
 <20180504221808.GB24813@kroah.com>
 <20180507080707.2a41ae28@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507080707.2a41ae28@mschwideX1>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 08:07:07AM +0200, Martin Schwidefsky wrote:
> On Fri, 4 May 2018 15:18:08 -0700
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, May 04, 2018 at 09:37:20AM +0200, Jiri Slaby wrote:
> > > On 04/27/2018, 03:58 PM, Greg Kroah-Hartman wrote:  
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > 
> > > > 
> > > > [ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]
> > > > 
> > > > To be able to switch off specific CPU alternatives with kernel parameters
> > > > make a copy of the facility bit mask provided by STFLE and use the copy
> > > > for the decision to apply an alternative.  
> > > ...  
> > > > --- a/arch/s390/include/asm/facility.h
> > > > +++ b/arch/s390/include/asm/facility.h
> > > > @@ -13,6 +13,24 @@
> > > >  
> > > >  #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */  
> > > 
> > > I wonder if the below (plus __test_facility) is correct in 4.4, given
> > > MAX_FACILITY_BIT is defined as such and not as sizeof(stfle_fac_list *
> > > 8) as in upstream?  
> > 
> > I'm going to defer to Marin here, as he did the backport...
> > Martin?
> 
> Good catch. With MAX_FACILITY_BIT == 2048 and the patch applied the result
> for a test_facility/__test_facility call with a facility number >= 1024
> would give an incorrect result. Fortunately there are no such calls in
> the current 4.4 kernel source. And there are no facilities defined with
> bit numbers this large, so even out-of-tree code would not do this if
> it is sane.
> 
> To correct this the MAX_FACILITY_BIT define needs to be reduced to 1024
> which would require the patch pointed out be Heiko:
> 
> commit 6f5165e864d240d15675cc2fb5a369d57e1f60d0
> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date:   Mon Mar 20 14:29:50 2017 +0100
> 
>     s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT
> 
> I would say yes, it *does* make sense to include this patch even if it
> does not fix anything.

Ok, I've now queued this up for 4.4.y and 4.9.y, thanks!

greg k-h
