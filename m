Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-753451-1525472301-2-13024472209175826302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525472301; b=hpPAYn5YVvTSFYBX4D3BbAqFCm3a+0ObXWoVioHlxzJBRPAbB8
    CtzlGXo+6QOdB7v5c2L4fPWZeH2+GqEp/1Ip5HaE11ZcPE6wabxPThjiq3hxf8X/
    HyOsXc/UVtxMDVmd5hDWowf48hueFkq6iX8mMX54Nz64KeHZsKaAdfU9IcT2Jv4K
    xuMUsjfYHQVI0O4mfLoJAd0PAQoI9xJrLhExyL+nlYWhKYLHtjW+z/d4fmpuGI8g
    jV341sT/Mt2Znb8odYAq1lSu8IH7vu4Vm4Q/CMDZEAy2J8LcaZJsXkJgUGUSO2lP
    6gaJCdCe3ou8otnQQnTDq3LWlADGtQs823eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525472301; bh=ZFZE2y+oAhWPpjr3d1+lyACPYFnghD
    80yYd9UYROdDM=; b=gtWrRjWDsnfFTeRpleSF6foIeef6WAaa86xU+3AZsBgMTI
    IcWwf7ghD5rnd6PAmJRtqS2Ljv/VLeFcECGMTigo1FhE5uoEgGu0RH9NlFAD6Q3/
    8EQ4Z/nUVL+r6qUIxwXu6pWYFxtm+Ioc/C5n32HV7szF/9t4dRjWUKocwufU4hXY
    UVl7mBEp+rFDws/ALFtnAift7W1suL1W25Z1YojVD8z8BF5BEFVJmdZiMtwgxRFt
    VojGUCYZ3L8vVGEXgEEpprjwr747CLpgDH3yqXWsiXUeo8Q7eoghwRr6FiX28osI
    mOBzoPrRN+IGI4KJtdkOpPUpuPnl6ryEXTIj/6cg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sMrp4Wx6 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sMrp4Wx6 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLvdYNeL5pPfgAlDBR0fgBFlrtOBnL83Ed/WY6/aM1l43q/AsR0jak7rCwexj7ubk8j3d2Yvkh7LygWc5iNHhI+fqX13MSWsUBJ79FmcflmgAaHRAM7J
    LBPaoMTkHE6OQv6buTi69VBi/62Y45L2eoFt5fLcUqpfrBQZ7jgN1LAopf8SWM2x38B4NnMZLovBB254WYZbZOkIUE/p348tLoAbQ+3sCaO/yybZisfwEmaK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=eXG-Qi8uW-7bfI1ljDsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEDWST (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 18:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbeEDWST (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 18:18:19 -0400
Date: Fri, 4 May 2018 15:18:08 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility
 bit mask
Message-ID: <20180504221808.GB24813@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.637526548@linuxfoundation.org>
 <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 09:37:20AM +0200, Jiri Slaby wrote:
> On 04/27/2018, 03:58 PM, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > 
> > [ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]
> > 
> > To be able to switch off specific CPU alternatives with kernel parameters
> > make a copy of the facility bit mask provided by STFLE and use the copy
> > for the decision to apply an alternative.
> ...
> > --- a/arch/s390/include/asm/facility.h
> > +++ b/arch/s390/include/asm/facility.h
> > @@ -13,6 +13,24 @@
> >  
> >  #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */
> 
> I wonder if the below (plus __test_facility) is correct in 4.4, given
> MAX_FACILITY_BIT is defined as such and not as sizeof(stfle_fac_list *
> 8) as in upstream?

I'm going to defer to Marin here, as he did the backport...
Martin?

thanks,

greg k-h
