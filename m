Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3971411-1526651891-2-205841843815951414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526651891; b=CkABxWnGe0UM5Pc/hxorZlsaueSZ0birZEagp7ijpovsdDCMjT
    6/aL4McVughiMM2FibKRd9p5W0dXBzHfnckFQGzxVLXYiLPLWq8tfFhnqIdgRdC0
    Y0sfJqbqWD2wwQR+gaFAU2Wzdtd0ntmSvf6mydxLBhpzPTnUw9jyHrM/jtrzqGXO
    DiWe7rshEZ9dqGs06x558wJBiTm1iR2Mr0DSkVwJrkG4M6JlLHCO34seqZwAJImM
    fBM8AT5r7fXsNlch1NxEr9ugRRPdd8X+JX3MBchl1KNiA1b0NVE/ewc9pqRNmuRU
    RqIoWsHMP1SQEnpBMh6g9d53WtljIaSobuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526651891;
    bh=9w8D3XCe/p95256nRI1fpo0RqOD3d2h0sV76wycSGi4=; b=jfAqaDlnJ66i
    VrbOoWWl4Hpl+4WPj/6zk66HRERN0R3esBmDTtyLol6sCtX3aGUQR5KhkzaRZacf
    bBsZyqY/SrWjje7tTOeOzv0ozp6KLJ8NKGkIZT/krd3QJm/7cF4wjA2lyu9obtSP
    nMUXqx3pW1jKJC97lU5muNQ5ZbtAGmCq5m6uzGMxUJPG7YVG9GzhWVhXkl8o90oE
    1usyu6FqiDIHgoUXDRWApcgsV2Wqbh6eO1pXPgxWW3h8PVAGiNKS1dv1R/H9o8kT
    6lZsLuJmyuIkd6e/NqkStM38M4+oHzGYA7sa4X9cpZv+1kV09CDzq8e8vT5BYKT1
    YO2ANi64xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPf0yFsJvJ97R9ifI51o+aT0iZ74i7d+x3F4vFXIEdC3hv5u0BCn5LzB6kjU5YR9LjBYV8jj+hI7KyMW2H1Cgkx3IqwWiQCMkHLGQY56x6BnXnOUHbo6
    Idg1u7W+Ul5kRrPPDKeYgpg851/IiBP2kFAJe5fTRK7EJJ7FO23G1t6XUP2HAF12OWv9DSJmJn65r5cspiZp5wagryHzOuXTbXJXziMuKH8YtucfbWbi/HOf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Ydja_Lxhjf-VtOans9oA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeERN44 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:56:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752605AbeERN4r (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 09:56:47 -0400
Date: Fri, 18 May 2018 09:56:36 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180518095636.56ff322d@ivy-bridge>
In-Reply-To: <20180517215600.dyswlkvqdtgjwr5y@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
        <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
        <20180517170053.7d4afa87@ivy-bridge>
        <20180517215600.dyswlkvqdtgjwr5y@madcap2.tricolour.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018 17:56:00 -0400
Richard Guy Briggs <rgb@redhat.com> wrote:

> > During syscall events, the path info is returned in a a record
> > simply called AUDIT_PATH, cwd info is returned in AUDIT_CWD. So,
> > rather than calling the record that gets attached to everything
> > AUDIT_CONTAINER_INFO, how about simply AUDIT_CONTAINER.  
> 
> Considering the container initiation record is different than the
> record to document the container involved in an otherwise normal
> syscall, we need two names.  I don't have a strong opinion what they
> are.
> 
> I'd prefer AUDIT_CONTAIN and AUDIT_CONTAINER_INFO so that the two
> are different enough to be visually distinct while leaving
> AUDIT_CONTAINERID for the field type in patch 4 ("audit: add
> containerid filtering")

How about AUDIT_CONTAINER for the auxiliary record? The one that starts
the container, I don't have a strong opinion on. Could be
AUDIT_CONTAINER_INIT, AUDIT_CONTAINER_START, AUDIT_CONTAINERID,
AUDIT_CONTAINER_ID, or something else. The API call that sets the ID
for filtering could be AUDIT_CID or AUDIT_CONTID if that helps decide
what the initial event might be. Normally, it should match the field
being filtered.

Best Regards,
-Steve
