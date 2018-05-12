Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1377525-1526124707-2-10448320781037690260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526124707; b=C6P3Qnah2MVDHg2BwbRhrxgySOZKj5ND5PNXLbks5u6oR7fCup
    /K1M92SQLlhINL4OA/xLq9YjjlFoM377gg1WNYoyX4lMzcUI3lDvykSRYzazf9iI
    Jsdx22JAGalzz1WjkeHTRdgDt9ONu52uIVuq+zDgIY7Tw/2D8kblEvYNdIQvxjfA
    +JVP5KAGIrV2oLxK/9Ug/+iBAo3LIAYmKujtvApUDy/gVFNVArl3mf8Nq2Z2AwJw
    BJmzhi5mnp8HXd8uxuBSO+JXPh4AUmIvX3XlWWzVCm/9UYDLB2WNVt/JIZ+M9RMl
    EaINiwJ/WytzLYTSaRjZ4eKHB1rvUqPfVr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526124707;
    bh=dKs1tgRec18TKyeooOjzJWfMliEIcuJXSNSaX+UiubY=; b=k62g9HDmEyu1
    niE1+BL1E1NbXLzvD0PykCYE2e57karqj6QmUo0XyHi2+j7v5kBVrQ407hLR9OMJ
    pCsre5Hfl2DjOLUk6+DF7P5ZdfEatVZz+FI6cf8qs30LMK5QJArdVWXm38ty2oAX
    XzVZh/rGYxTC2u/bGW8N+9pVoJaHFLOSDubBqPNjcuRB8aVhw40wf2KBcFJ8sjCe
    TA7IFClTeU+mbDuQBG3AbpUTWKT5uQF/O2jhMdHkd6leww1XdB11oT+Yr1L0b59S
    NLcQlsTRAfFaw4Yg8E5+o/mhHE5KjtqKrGiICJZx+IEyGAN5LbNy5SDqUwdMq6Ue
    DK8Y7wE1cg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=F4tjdtAU x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=F4tjdtAU x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGlltFA74L82361dFg+rbxH9wELcN+zzCL5yKWjkDfrwVCnu68dtsrIntWadQPcKxBpDrq6e08G3GIN4bzhIQFeugsG0iDBQShujfjGJdE4hBkxmJgAc
    nImXZguCk6Yeb7sdn2bGTBKp+HLYHSAN6GPx+xrXmbZAiAlQUZaGCmXm5QcOpxIJaiP1hr2Rj0Tz72v01JlTYEQDqzYNabHDr/MgvEeXEe7qhTqE1pjt5ADs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=PHq6YzTAAAAA:8 a=VwQbUJbxAAAA:8 a=PMT70qdeAAAA:8 a=YhlAls6PJlfj8XbK10IA:9
    a=hPMAS4WPngrL-wA4:21 a=k9ngxYcO8rZc-aUO:21 a=CjuIK1q_8ugA:10
    a=ZKzU8r6zoKMcqsNulkmm:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeELLbm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 07:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeELLbm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 12 May 2018 07:31:42 -0400
Date: Sat, 12 May 2018 20:31:37 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Long <dave.long@linaro.org>, stable@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-Id: <20180512203137.4c00f301c4359de1f6253154@kernel.org>
In-Reply-To: <20180508112503.GD16141@n2100.armlinux.org.uk>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
        <20180508112503.GD16141@n2100.armlinux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Russell,

On Tue, 8 May 2018 12:25:03 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > This is the 3rd version of bugfix series for kprobes on arm.
> > This series fixes 4 different issues which I found.
> > 
> >  - Fix to use smp_processor_id() after disabling preemption.
> >  - Prohibit probing on optimized_callback() for avoiding
> >    recursive probe.
> >  - Prohibit kprobes on do_undefinstr() by same reason.
> >  - Prohibit kprobes on get_user() by same reason.
> > 
> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
> > which are not merged yet, and added "Cc: stable@vger.kernel.org",
> > since there are obvious bugs.
> 
> Please submit them to the patch system, thanks.

Could you tell me what you mean the patch system?

Thank you,

> 
> > 
> > Thanks,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >       arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
> >       arm: kprobes: Prohibit probing on optimized_callback
> >       arm: kprobes: Prohibit kprobes on do_undefinstr
> >       arm: kprobes: Prohibit kprobes on get_user functions
> > 
> > 
> >  arch/arm/include/asm/assembler.h  |   10 ++++++++++
> >  arch/arm/kernel/traps.c           |    5 ++++-
> >  arch/arm/lib/getuser.S            |   10 ++++++++++
> >  arch/arm/probes/kprobes/opt-arm.c |    4 +++-
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up


-- 
Masami Hiramatsu <mhiramat@kernel.org>
