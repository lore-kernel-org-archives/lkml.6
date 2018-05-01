Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2838156-1525161245-2-8196256618441746950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_EXCESS_BASE64 0.979,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525161244; b=eVB69eG76QZF+QLG1db18bS36ocHYjXZbTWvjpnYPtSOGVOYIM
    kCAZPkFdrE6LFZb4pbOG9inJzv76jJHHfIOHSDYZf86/m64fvEvCpR0RW+h7AV3o
    1PuY6/95olYqijVT2mAi5i2sxaYmhJ0yb+CjgLEb/ILt7gSgjFvGffF4h7LH54Ch
    xuZUFPezyEyA+yf0qoyRT5AADkoWVe5VAzuxNGdWJlaUyP9DBTWrLZ1qpdUw/2/4
    pSOZsLHXr5VcPZxwGXX/GtpNA7wGpHkpBwAahpa4MS0InxPdK/tCnfD5mhaUELV2
    Yzvfw62zZFJ8QNACG0bxMBIyko2aoPG7J08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525161244; bh=fN2L8eiG+zx
    8FLTD67z+6iCTtzDYJSh/WhuZAsWCLqo=; b=BBxWu40QtbkWl3Oh80s5ReQukil
    vykOrUK/azPOeRYi8TjgjAc7/E319G1G/AHqzKOqDUFuH245gEIeZHPMDRPE+8X1
    ANiHyFoZqpHFEgPsKBIj1hDtqenSRh/MD/zJ89havR5oAOycIrBBEij4giPquGfC
    zTFmc+y548Xy7eaYvYiN69Tgr3sX/6OzSLPkpwi+Aoxg4Slj3cPd6uD7Z1Zw4xvM
    P3BcNIMMjmvXhQxonI8m2QnupKtJGzGtAdly3boRaXwKSNYtqD7+3gIU58oPZYOm
    CY6EKCQUAup/7+c1pRCFOLr8ACF9Pu35zCEubesc3uIiD7AAgD6Jfi0KHkw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDvboYCdWbSn392X4YLfZIbrXzrF/S87+z6xeWZ0UQ/hT/ffHtnjpksBEdKOYRbDXrDEdBu4EsnU3RrwtZF4CMxuNtBYqKfodGOF3rYoAxv79gYctJYS
    KivTlkqn+zFlnZzOhcXzVeH14rC74ls742kM3pQME+TB/0YE1JoLxoy1c0bDgcVgyhcfVy5vX8OzIgeFqbmcoMerbH1n0Yo+q6uiEnjagp0VKsKQkwtm4Ar0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=WeUwhyFcFz-3ZzPF4DUA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbeEAHyB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 03:54:01 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:11361 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAHyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 03:54:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520899200";
   d="scan'208";a="72417676"
Date: Tue, 1 May 2018 08:53:52 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <jgross@suse.com>, <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit
 constant
Message-ID: <20180501075352.ffx5dqaedo657nub@MacBook-Pro-de-Roger.local>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
 <20180430165704.bkce56nzx3giodbd@MacBook-Pro-de-Roger.local>
 <310676e9-d527-421b-a367-a6a8ada5255d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <310676e9-d527-421b-a367-a6a8ada5255d@oracle.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:07:43PM -0400, Boris Ostrovsky wrote:
> On 04/30/2018 12:57 PM, Roger Pau Monné wrote:
> > On Mon, Apr 30, 2018 at 12:23:36PM -0400, Boris Ostrovsky wrote:
> >> Latest binutils release (2.29.1) will no longer allow proper computation
> >> of GDT entries on 32-bits, with warning:
> >>
> >> arch/x86/xen/xen-pvh.S: Assembler messages:
> >> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> >> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
> >> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> >> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> >> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
> >> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> >>
> >> Use explicit value of the entry instead of using GDT_ENTRY() macro.
> >>
> >> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  arch/x86/xen/xen-pvh.S | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
> >> index e1a5fbe..934f7d4 100644
> >> --- a/arch/x86/xen/xen-pvh.S
> >> +++ b/arch/x86/xen/xen-pvh.S
> >> @@ -145,11 +145,11 @@ gdt_start:
> >>  	.quad 0x0000000000000000            /* NULL descriptor */
> >>  	.quad 0x0000000000000000            /* reserved */
> >>  #ifdef CONFIG_X86_64
> >> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
> >> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
> >>  #else
> >> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
> >> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
> > Maybe it would be cleaner to use something like:
> 
> I actually considered all of these and ended up with a raw number
> because it seems to be a convention in kernel (and Xen too, apparently) 
> to use raw values in .S files.
> 
> Kernel is using now GDT_ENTRY_INIT() which is a C macro. There is one
> other location where GDT_INIT() is used (arch/x86/boot/pm.c) and,
> incidentally, it also generates this warning IIRC.
> 
> I really don't want to move definition to C code just to use a macro ---
> I don't think C code needs to be exposed to this GDT.
> 
> 
> >
> > .word 0xffff /* limit */
> > .word 0      /* base */
> > .byte 0      /* base */
> > .byte 0x9a   /* access */
> > #ifdef CONFIG_X86_64
> > .byte 0xaf   /* flags plus limit */
> > #else
> > .byte 0xcf   /* flags plus limit */
> > #endif
> > .byte 0      /* base */
> 
> 
> I, in fact, started with something like this. But if you repeat this 4
> times you will probably see why I decided against it ;-)

Heh, right. Maybe a .macro to generate those? Or this is all too much
for just a couple of GDT entries anyway...

For long mode however you could use simpler values, AFAICT the code
segment in long mode could be simplified to:

0x00209a0000000000

Because the base/limit have no effect.

In any case I'm not specially inclined either way, and maybe using
similar values for 32 and 64bit modes makes this easier to understand
(and decode if needed).

Roger.
