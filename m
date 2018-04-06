Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1786810-1523032617-2-17243994768718018236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523032616; b=j+O2bX42SN6e2O0dYJty1hyFyOt7e6kklxxu33N4rzYNJBeHQ0
    dQJhUy3MJUK7+u60C5PHYh/YTKLJErDN3TVyb+dZhB2tSF3IbwZ8YkSkiOAmZigd
    3EpqR2ADe4C53uKtV+YgA+T5VBcSJJV0NBvSpqef8XNNG6VSZ6FPegC8Jbot6IVc
    0kHXZnNhCb04DDrcvL0I7L7m8FVRaZBGcQIl3cwbyj75cKedfxkMRmBg/Gg4BQ7y
    H7/0X2oSZdxhuOWnUCzVXua2xTrIypYsg4/WmHtEHhDvluFEc11P5zufEWRjqWg9
    fn4j1V8iQtaj4Er+uIvqIQS3NTIgnIejQxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523032616;
    bh=bjWtS/OcPHO+efR70+q40axrYqoHgu3AFSfCOXwSWVw=; b=mVifXm07UV/c
    JKBG/kkdqw1K4njR29D02Q+A5lplJ7e8FwF1bE1TiOAD70WGcFmFO8Jmz0BR7iHI
    QWesgdJA4gBwG7Jn62k+oHFghFAGRA1I62AxrmAhHpCsI6iFpuUUB4C/fErfGbqc
    4Jptw+WXbOVxRc1f2cvpymNJnIl17hV50GCsuaFqnPnBQsB5cEjPS3WEevF5kkh2
    iSfo+Os6gf5Esnwvccyd02/te5qJO/YXrRApnh7W2nJQ4R2PJ0mA/62zGxLSx8Xr
    /bOROeC/H7zBaxP/kUusST5wD+PWMMd7ShpfwUbK0H0/zrI1s96ilVAolDeXnC0J
    zKxYnLPhfw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=awxrd.com header.i=@awxrd.com header.b=uN3SR7wd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVby3+Uh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=awxrd.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=awxrd.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=awxrd.com header.i=@awxrd.com header.b=uN3SR7wd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVby3+Uh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=awxrd.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=awxrd.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0OCs+I91mOdkFBWKvaWKKG4thFw9br+9pP1Mb8WCiRgxyIc4MZuqFH/KGhNAvbiSPWc6glzOE+9z7TSIxqOxjmWpoyhu83UyVXnWqfHIhxJ5wo0Cfm
    UDpMJEKFzZlx7eP6P9wj++Lon643RtRLdd8wRw/E2TVipUnAMWM21LLSeEMgg1gShV3ZYP6S1Zaww6+ywcPmDL3d214IyYIocB+V5GptQ2+x/vzzRfHqbQZv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=vDLGeLTdAAAA:8 a=VwQbUJbxAAAA:8 a=wlf5s8t7N3Svnv-oRn0A:9
    a=04j88B_gmrxUBNkS:21 a=mfMwHkcbVxNfm7XL:21 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22 a=1GWREyU_VPGQROUScI6K:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFQgy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 12:36:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49317 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751871AbeDFQgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 12:36:53 -0400
X-ME-Sender: <xms:JaLHWuO3IrlfL2jpfhCH2DITsKkpm3U4DhzUfz-TaB-ZePlZFTXO2g>
Date: Fri, 6 Apr 2018 12:36:50 -0400
From: David Rivshin <drivshin@awxrd.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
Message-ID: <20180406123650.7fe32612.drivshin@awxrd.com>
In-Reply-To: <eae3e959-60cb-a8cc-be97-f782d0c96f08@linaro.org>
References: <20180405200916.27964-1-drivshin@awxrd.com>
        <20180406132511.uzl6viazwaey4bem@holly.lan>
        <eae3e959-60cb-a8cc-be97-f782d0c96f08@linaro.org>
Organization: Allworx
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 6 Apr 2018 14:49:22 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On 06/04/18 14:25, Daniel Thompson wrote:
> > On Thu, Apr 05, 2018 at 04:09:16PM -0400, David Rivshin wrote:  
> >> From: David Rivshin <DRivshin@allworx.com>
> >>
> >> NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
> >> on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
> >> of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
> >> it takes to serialize those registers. Since FP registers require 3
> >> 'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.
> >>
> >> This causes GDB 8.0 give the following error on connect:
> >> "Truncated register 19 in remote 'g' packet"
> >>
> >> This also causes the register serialization/deserialization logic to
> >> overflow gdb_regs[], overwriting whatever follows.
> >>
> >> Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
> >> Cc: <stable@vger.kernel.org> # 2.6.37+
> >> Signed-off-by: David Rivshin <drivshin@allworx.com>  
> > 
> > I pointed some trivial autotests at both gdb-7.12 and gdb-8.0. Results
> > look good to me!
> > 
> > Tested-by: Daniel Thompson <daniel.thompson@linaro.org>  
> 
> BTW I noticed that myself and Jason in the only "real people" in
> To: . Most arch specific patches end up making their way upstream via 
> the arch maintainer rather than via the kgdb tree so personally I would 
> choose to the arch maintainers in the To: field as well.
> 
> I certainly think you will have to follow up via Russell King's patch 
> tracker once you think its had enough time on the ML for review.

Thanks for testing and the pointer, I wasn't sure what tree this would 
go through.

Russell, if you have no objections I'll let this soak on the ML for a 
bit longer, and then submit it to your patch tracker with collected tags.


> 
> 
> Daniel.
> 
> 
> >   
> >> ---
> >>   arch/arm/include/asm/kgdb.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> >> index 3b73fdcf3627a..8de1100d10674 100644
> >> --- a/arch/arm/include/asm/kgdb.h
> >> +++ b/arch/arm/include/asm/kgdb.h
> >> @@ -77,7 +77,7 @@ extern int kgdb_fault_expected;
> >>   
> >>   #define KGDB_MAX_NO_CPUS	1
> >>   #define BUFMAX			400
> >> -#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
> >> +#define NUMREGBYTES		(GDB_MAX_REGS << 2)
> >>   #define NUMCRITREGBYTES		(32 << 2)
> >>   
> >>   #define _R0			0
> >>
> >> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
> >> -- 
> >> 2.14.3
> >>  
> 
