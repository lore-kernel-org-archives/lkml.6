Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2360335-1520018793-2-6904975584803050350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520018792; b=HTMJDNl/jHMnCvsjnmu7O2akdkd58I50/wdEvNjnJkY5zkq
    s69QLnikmwcFccIjdQpvgpUPva1hCPtzGNtm1jd/Yi9OKWshmx2XzzOMey8ntZRf
    kQHrYvjprls4kIopgbUuozfSjQrnSkhZBgzb9p50Kyb00CqVwKyGQJcQ947IIJF4
    wxu3k+lJKRRIGPVhaGSujZkTv4FNPz4Im0ig9354eg8/kDtMIsy/cEzpvl5LfF93
    mI6402rqg7JsuzhrMt9bUDAElIGHcDX8e1FbgGSfEsv3Y3E+WWRotfP4CqwG+ktz
    r0vRIFvX89n4rA/BcL9wOln58xRdISZ0Y44wjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520018792; bh=1r2Xrcy/VBdfIMJ5kk0Z3MsB/e4hTfa/6Ee0xa
    EfCvY=; b=VNp7jXF/9yXmlAAtwTkc2tqXcXNw0csl/FmCzRK6qFkk9QuglI5aQ6
    tzPjGyIMDevGaJr3tH8N0PxFeqVgj1I3mbaBHBbMIAO0erubGhOOuGq6yEQT7fqd
    X65Lh31W1Q36EBa2G7RrPHiZ9zN1SQxb/Hm0kDSL3PnrrUwGF04Zs/SBQlYk33tG
    VS18f5WL6oHPGUL2L6fSmUtamNNnnqljwW2KdkwNt5W+X8fnkhAEr7IECnFMMDin
    z/bgrzM6Swog84u4gtVMuhLAhn1UMQbzumr196JXC3jRcwGnRNp53HPHd7HYTAEi
    7Y5ZgzRHkWsJ784Mb+eRZpxRjAnXuveQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uW1tVCLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pVaYeK4T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uW1tVCLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pVaYeK4T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965732AbeCBT0E (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 14:26:04 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:43439 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933280AbeCBT0A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 14:26:00 -0500
X-Google-Smtp-Source: AG47ELteZOk935K7zLF0jZKIUb4hF5KtPABzUeqv6pdwZ2G5cekp1uHUTHtYfqdU3TGyoCb4smL9KVcR6aMc7v0cEZo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180302182321.GE31400@bombadil.infradead.org>
References: <cover.1519930146.git.rgb@redhat.com> <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca> <CAHC9VhQi2QC8_e1fgYr=bfTACdtpgXZubc6S18r+1+9qf6TJ8w@mail.gmail.com>
 <20180302182321.GE31400@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Mar 2018 14:25:58 -0500
Message-ID: <CAHC9VhSapR0jXyhonKjLVpBfPX-P4KCR7OJTasyiTQuDFYZ1Rw@mail.gmail.com>
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Matthew Wilcox <willy@infradead.org>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
        Eric Paris <eparis@parisplace.org>, trondmy@primarydata.com,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 1:23 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Mar 02, 2018 at 10:48:42AM -0500, Paul Moore wrote:
>> On Thu, Mar 1, 2018 at 8:41 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > On 2018-03-01 14:41, Richard Guy Briggs wrote:
>> FYI, I think you may have a problem with something in your outgoing
>> mail path; I didn't receive the original patchset you are referencing
>> and it doesn't appear in the mail archive either.
>
> I have those patches.  Which mail archive is missing them?

The archive run by the linux-audit mailing list:

* https://www.redhat.com/archives/linux-audit

-- 
paul moore
www.paul-moore.com
