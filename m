Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493875-1519408564-2-15118037628881708784
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
    t=1519408563; b=StNyje7CvO8bZsZ3kErOr1jEdonZCb/oES9NBNJzA0U2EQI
    reoJmeIJE1LjegU9CURjGn9dItLhw7RydZkOC5OVe/n0iyc8TH2m6nf4BCdhFPtR
    8h3OGwf70+UhAhMBNIFhPa/VybkZPLHPECiPWqAoy4lGS18mezoAPw7m+2CpXtGb
    a7M0HzBNkiLJi8PRqqxeDHDPHakxVfaIk1S1WIlDc3V4EXUM6ugRVcq6/2+brNHP
    3nhpaU5TPvO1J5BMzWyIyzh1iOZ3Bdf+UXIiX9gLPtTPc2IPX8XKwJ1xvIO+ZSAI
    YCtZuOzYuXVFXmeQgOkZZt3KJuFQJmIX0MyKN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519408563; bh=wbz7c00OjrHCPWRaf2gkkn6g8v
    quIXDxl0dOcCFiOxs=; b=RtKBmDVzrtj1pALKQkHyesQ5tA+ACV37lsvTSc5JYJ
    EFPImZdPzgd7g7+IwHwFUcE1luGhXJlaBEbBq1AmKi96DCtsa2t9Mg8s+Ji20zSn
    AKtLnKZHj/Kea8I+nivr9ttMek4ehdO4RpI6UGG374efwgSMqwEcvdr8B3i+Dzo5
    e6xuIofTP1TRIIH63B8SXDcuPziqxynkdi7jJ6QhEaorfOSle4kSBUNWdE3+JIBZ
    p2xfsQbUWMf3X42LpUSBvoRRCaKgM4uzTgZQIHJOw26NVrqXejZLkZOPL1nCb3xn
    rsbJMJX4p6NGMTEzXZMzr0T/sbj34XpwvBhH24nCPs+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TBSgKwZh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TBSgKwZh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeBWR4A (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 12:56:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55956 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWRz7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 12:55:59 -0500
Date: Fri, 23 Feb 2018 12:55:43 -0500
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
Message-ID: <20180223175543.GN8252@char.us.oracle.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
 <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
 <20180222170717.GP31483@char.us.oracle.com>
 <d66a2358-cfac-f441-3b59-e44674b6a792@redhat.com>
 <20180223172220.GK8252@char.us.oracle.com>
 <7534bcd3-e21b-240c-9ed2-62026ba10301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7534bcd3-e21b-240c-9ed2-62026ba10301@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230219
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 06:35:30PM +0100, Paolo Bonzini wrote:
> On 23/02/2018 18:22, Konrad Rzeszutek Wilk wrote:
> > On Fri, Feb 23, 2018 at 10:37:49AM +0100, Paolo Bonzini wrote:
> >> On 22/02/2018 18:07, Konrad Rzeszutek Wilk wrote:
> >>>> Having a paravirt indirect call in the IBRS restore path is not a
> >>>> good idea, since we are trying to protect from speculative execution
> >>>> of bogus indirect branch targets.  It is also slower, so use
> >>>> native_wrmsrl on the vmentry path too.
> >>> But it gets replaced during patching. As in once the machine boots
> >>> the assembler changes from:
> >>>
> >>> 	callq 	*0xfffflbah
> >>>
> >>> to
> >>> 	wrmsr
> >>>
> >>> ? I don't think you need this patch.
> >>
> >> Why not be explicit?  According to the spec, PRED_CMD and SPEC_CTRL
> > 
> > Explicit is fine.
> > 
> > But I would recommend you change the commit message to say so, and
> > perhaps remove 'It is also slower' - as that is incorrect.
> 
> Actually it is faster---that's why I made the change in the first place,
> though later I noticed
> 
> > If it is detected to be Xen PV, then yes
> > it will be a call to a function. But that won't help as Xen PV runs in
> > ring 3, so it has a whole bunch of other issues.
> 
> Ok, I wasn't sure about PVH (which runs in ring 0 afair).

Right. PVH is HVM without any emulated devices or BIOSes or such.

In the context of the paravirt ops, Xen PVH == Xen HVM.

Xen PV (and lguests) are the only ones that patch the the
	callq	*0xffffblah

to
	callq	0xffff800

While everyone else does the wrmsr.
> 
> Paolo
