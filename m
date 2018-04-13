Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3024051-1523602807-2-1631848050364873841
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
    1523602806; b=R5dBK1qL7yBQmVFKXAAClzDBjiI8b78uacZh0VgyJPX2e9Fb6Q
    0TH/aXZEU1pA8ihLJ25KIdMb2NUBIHN3DzpMTUHn7NVVGBByY32yUTEyKUp5Zjgu
    O76Igv+LrISBDci4QsYWC9WS+aqL3hWELMQDeMkvfGSDqk+H++c2y+5iu5q7SSAI
    J/h22WNfqsl9VHgji2G42KMJPq3gG0CPaDOFytpOhb89X3+/cPAck2lBETl/s3ng
    PfsMq3RbFyzarZL3cTSDNDuy2Z3hXXl2wgtbbOhxI6Jd5beJDaeh8hY0mVDbayUV
    5najKTRHmQRhx0SXaoEuH89+l+h4GN6Ppd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523602806; bh=NoSNBcvi2DTDhK7gKub4BI7ncTZiEF
    J5KSvdbHIRWd0=; b=fU2eCuT/7k07VeWa+vg8N1ES3bvo9NBnoGxQqnTn//6y2i
    momb3x3ni/GS7lFfdCigLbFuIIJ5OLayscXCpsfhPmhJ4tgUpZo+1wvYRhJX3AV/
    OjGAdstIU/EUi7LsB/5yXO8PYM/SIFQ5BWPII1jTf6MG5bkC7Tyb6X7I2B5CAEPH
    0HCoTM9U12BrB+2o+l4OvCLtAqkgIpNOYt/529E5kSaysv7FH1QRkxKL+Oy0f6yA
    1fHoM0pDvsyZNJ1pGpbDt1ZvRQCZtCb0SU3CdtqjwO7mNDADvv+gB4wee+DJxVLh
    buUQssOEmn0RVVnlJueq6iKa0DxOzGqNT3lgoThA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfAUSYjsFEawlKLQSzvy+h/7/pS/zD7WoYpwrLf/4Nk2tOlnAMtWwWHIyOq1sru0f7L7yeW162+ZTT2do/XiBVWoYfdpdOTeKwAfG/rClmDSLDwnZV4bV
    BUFjduRZQbG3VXI0HRJnUGyx9PDu/MkPp/CvUjApvoE1aWBV2M5NimF4ruw8zmFe5IgqEWhFROt2060ZRKzI6coFMFmQ8rRBGqa/zutblFLibaPaXq940XYm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=3m0qUpd4KoLUhiiKViMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeDMG7u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 02:59:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42243 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeDMG7t (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Apr 2018 02:59:49 -0400
Date: Fri, 13 Apr 2018 08:59:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180413065944.GE17484@dhcp22.suse.cz>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412145702.GB30714@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 12-04-18 15:57:03, Roman Gushchin wrote:
> On Thu, Apr 12, 2018 at 08:52:52AM +0200, Vlastimil Babka wrote:
[...]
> > We would be just making the reported values more precise wrt reality.
> 
> It depends on if we believe that only slab memory can be reclaimable
> or not. If yes, this is true, otherwise not.
> 
> My guess is that some drivers (e.g. networking) might have buffers,
> which are reclaimable under mempressure, and are allocated using
> the page allocator. But I have to look closer...

Well, we have many direct page allocator users which are not accounted
in vmstat. Some of those use their specific accounting (e.g. network
buffers, some fs metadata a many others). In the ideal world MM layer
would know about those but...

Anyway, this particular case is quite clear, no? We _use_ kmalloc so
this is slab allocator. We just misaccount it.

-- 
Michal Hocko
SUSE Labs
