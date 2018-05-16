Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1005318-1526512918-2-9211949266417771612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526512917; b=bxMUQPCH26nAn842PyuNWJ85uUJMWgTKzXiCRb99wsby9XpRKi
    pl4lw0mJf/9fHU8zls8P3BWPzLHvgJh6cBWIHc/YZfv3okCF94ArrigQgSv85sTa
    BxhiM14/O2z9YBUAq4k+zpRtgt7so6NqEzGv7yhPSsCwWBCVjT30ExB57/o8nNul
    +qejVUy/3XD1A5m7NYnt4HVgI9A4oTcdorT24VPxnsbegMAaCuCI2iXiVRRV0Uns
    ARuwdNIu2Wbegjm+bKvCb5mE7TDhfy7zVv7wrL+3c85HkFM6FwGvlhRvtg47Cygw
    L3/0zl847vjaRBdSMG55d222yq/rrT88q0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526512917; bh=gqX30/IUQlx5i/U/v2U/clhnrYEU+F
    MFoLwNGgbBjmw=; b=EwnAYEq1H1VxslTBfQdYkI/B9bNKO2T+mCt2TXwiaVAKvH
    +fk+QJ3JI9JjeYyihmSAKVjoCDNL1yuxNz+zMSiXA/XeWix9jYQ5B0irBJ1Fa2Zn
    deDKnrD+k3cPF4Ceu9kEt9GK30TG7tG/z5d+jCZvjmtwM8mlY5e0mUe6/mjPpe/R
    9PsP941XTCL3bu7o+vgMebjyl/c7uMhfZj1qxBSYdhKHuO6oMEtKV20IwbINYDqB
    MmZKX7gOWNCH7us5NiVgsepQrwGsl9TwOFf7j8Re5CWefYaMR0FDllR77y6FZk3r
    JgqY1AM0rG/WJdCBfCjCmGxwffjqx+0elJXhojsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOUaqvBPweMWB5AUzIX07Yw+4Egkgmz/wXqH+fe50b0mZ0SMjPo+5RH9nivvfZ+gg5d6GKOIwJZi1en2Dcs761g1YTd+dy8uV5sxT2EVpDGZ6OMB9bpL
    /7/PwByoATLRoRivm9K5o92atHwQRfkqYzInPjnu6OKvo6QozRgn/lcCzimRmfKceBEf9WUJ68Hq0eyzUbcyf+OEuOTVSo/xTUiBUmK8qT9ISYx1UGpqclHf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Dfd11gtApTG0vw2jIIoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEPXVn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:21:43 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54220 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeEPXVm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 19:21:42 -0400
Date: Wed, 16 May 2018 19:21:16 -0400
From: Rich Felker <dalias@libc.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note
 reservations
Message-ID: <20180516232116.GB1392@brightrain.aerifal.cx>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
 <20180516152913.GY1392@brightrain.aerifal.cx>
 <20180516154957.GT7753@e103592.cambridge.arm.com>
 <3e291fda-b27b-7002-9374-23196f18a38f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e291fda-b27b-7002-9374-23196f18a38f@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 04:09:29PM -0700, H. Peter Anvin wrote:
> On 05/16/18 08:49, Dave Martin wrote:
> > 
> > Since <linux/auxvec.h> only contains #defines, it may be enough for arch
> > <asm/auxvec.h> headers to include <linux/auxvec.h>.
> > 
> 
> <asm/auxvec.h> doesn't seem to have any reason to exist at all. If
> anyone includes it now, they are Doing It Wrong[TM] since
> <linux/auxvec.h> includes <asm/auxvec.h>.

Sounds good. BTW there probably does need to be a check for
kernel-internal use of #ifdef AT_* etc. I saw some instances in
arch/um and a few other weird places. They might not matter but there
might be code that's indirectly enabled only for certain archs via the
AT_* macros.

Rich
