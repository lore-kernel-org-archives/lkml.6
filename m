Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460752-1519406578-2-8463977803115595256
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519406577; b=QfPvxN4MaIojElhFDw3ft/RY5Pmj9WUtu2ub8ybWrjuyWNU
    mLHjb6e0Z3zgY8/OS0wSYFmnKwhgDOVQ3D8jfhpIIN82e7A1P6ZlUSxp/l3/vbzk
    N68J/c3YbnQNvhsJXm7KAHSZQ6ewo0+L1lSB5KKiax6okkDQ2ia2DNVXAADm7aqz
    RoL1dt9xDwn+ZOhLqrK/+BY6z5yxowcs43jpaMSDgvUR0TEuL0rCepAfOzQYvnFS
    dzcelRiKWp7Hr1Bs4XutjxZEZDW5XJVFA8RA7l8xHij68fiClcfYyyuXMO1BiUIy
    Gv/hDEMWL2dCErFzmkdJDXj3FHS+oddKpWWvpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519406577; bh=L9oVXZtrekz1WwkweOqrW7fKNE
    vGH49/gjYLUINdaCY=; b=JtMPSdeBsXmp357yrELz3mmDFMVTNi+FKJjZjHYpO+
    qsbdhTHGCdxP4g9EeFctco9HqTJZnyfmUIiePsIVpe089mkcGWCRLFnpFkP6sHrC
    wxK2RG76ewIJg9+q5GhmH8on/kp8JZOfpyxwAMlK8ExQjZcVPslwZr/lMq+7Y7ck
    p+ibBuXu8BU3w0gX1sB+r0sUSDxDD7pifsXffx/0ou+Co5FQbDdIkTlJ/AZ2u9v+
    1IML+vyMbvBcW5TIdfF1BblfexVBzdT0mY833gw7q+EImoTuL5Y4j7fC2rSYNGhn
    ao8+/CMquYhesUxCydWiphyMR8kdKEX/Hzei4g0mbSEA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Bw/D2lvL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Bw/D2lvL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBWRWk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 12:22:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBWRWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 12:22:39 -0500
Date: Fri, 23 Feb 2018 12:22:20 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: use native MSR ops for SPEC_CTRL
Message-ID: <20180223172220.GK8252@char.us.oracle.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
 <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
 <20180222170717.GP31483@char.us.oracle.com>
 <d66a2358-cfac-f441-3b59-e44674b6a792@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66a2358-cfac-f441-3b59-e44674b6a792@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 10:37:49AM +0100, Paolo Bonzini wrote:
> On 22/02/2018 18:07, Konrad Rzeszutek Wilk wrote:
> >> Having a paravirt indirect call in the IBRS restore path is not a
> >> good idea, since we are trying to protect from speculative execution
> >> of bogus indirect branch targets.  It is also slower, so use
> >> native_wrmsrl on the vmentry path too.
> > But it gets replaced during patching. As in once the machine boots
> > the assembler changes from:
> > 
> > 	callq 	*0xfffflbah
> > 
> > to
> > 	wrmsr
> > 
> > ? I don't think you need this patch.
> 
> Why not be explicit?  According to the spec, PRED_CMD and SPEC_CTRL

Explicit is fine.

But I would recommend you change the commit message to say so, and
perhaps remove 'It is also slower' - as that is incorrect.

> should be passed down to the guest without interception so it's safe to
> do this.  On the other hand, especially with nested virtualization, I
> don't think you can absolutely guarantee that the paravirt call will be
> patched to rdmsr/wrmsr.

<scratches his head> If it is detected to be Xen PV, then yes
it will be a call to a function. But that won't help as Xen PV runs in
ring 3, so it has a whole bunch of other issues.

If it detects it as KVM or Xen HVM guest it will patch it with the default
- which is normal MSRs. Ditto for HyperV.

But <shrugs> no biggie - explicit is fine, just nagging on the commit
message could use a bit of expansion.

> Paolo
> 
