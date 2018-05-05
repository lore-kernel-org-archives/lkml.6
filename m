Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440419-1525565258-2-14989332463173319927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525565258; b=S0/fq58eH8nWBrjqSzhji4jDXd7yZyLCpvhugL80IlDaAQYaNn
    LLM4VoyWVmMBI5z0tp6vgT3ApJ1D0TM412wiPema+b+hVOV6btLnnBvaffBax6eQ
    0+TtWIFwGgZqEykG/2sFcXT7sePnNl3TOUwKA8aLypRLt5B0AcwoGDHcgYLAzA3/
    LX2+Hc0V44GTZr6NaR4LY62uiphjJ+Bmcp50vIyX+XG+Z5NoyjvDipWMk+kSXLXD
    Ee+y5qmVeVv0SA6g48NAGtT/MqC4iWStdOO+Zp8cQsvBXh0J9YJGX99VIBfVVlBt
    sl+f3Ez0TCaz2qUL2Q2wo2lUmc1U+8I6fbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525565258; bh=6lQrUSgmeulcgiPzp59Zf25PO5gWFA
    rJOJiemybUqIo=; b=IDEVfras2hmfuvgG4cy0FRWm52McWefvCFS7r9gJHQauRO
    CBrWIzjrqmH6rt8tglNRveo3c4GbxqQ9Y1HNkscMipYYKQGxcn6Z9REs6G8zqv/W
    2wB+9b+kPzlFR8RAl5ECvCDNLjxl5gEANAtC2HaF98RMQ/4yYtFS7lDUFaOPs2G2
    EpLlD2OYnPyF+NgWU5I9dNI5E0FyNAvCFQ5feXDui3SQabhTmjhdnY0aLS7xO+pU
    vIaSeY/hVzTyxXCv1dlNXdwzwGVT+h59DVm/NESPXWjoIyYu9q5Voa+mmKxIYsmg
    v/FYlA3vEQlw0rcvqIKlxebjJA20YB81+6oK4VMA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLPPjvVdcb2BdVv1dZbxZyK2SE+iFKjc6j5CWZob3l99O9iLWNWEw8vA2HuxC0Kgv0emH+MMW+OnWouX6HWYhHJImw6TjRL8lglhBLB0hOS13cj+LX9k
    qAeHJWlACcMIoL84sgjqGzh9vzS4AtXe1QMZgS3SWmB8q/3N5zVlNtuAGGKC4V4+BM/qMD/t37ckJ/Ylgt+dvB7v1dVoA9Y1OK4buM34mT1Vw6aqUj/rv7dx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=BN_EupdU00CviCaM-nMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEFAHe (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 20:07:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:20708 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEFAHd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 May 2018 20:07:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="43452204"
Date: Sun, 6 May 2018 07:57:26 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org,
        x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
Message-ID: <20180505235725.hglh6u77spw55qa5@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-5-git-send-email-changbin.du@intel.com>
 <20180502101707.206984e9@gandalf.local.home>
 <20180502134558.1f388e097dcde6f589635404@linux-foundation.org>
 <20180502211956.6c9e8d7b@vmware.local.home>
 <20180503134546.5p3z4g5na7ew4fun@intel.com>
 <20180503102823.5b54cd56@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503102823.5b54cd56@gandalf.local.home>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 10:28:23AM -0400, Steven Rostedt wrote:
> On Thu, 3 May 2018 21:45:46 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > > With that gcc comment, I still think CONFIG_OPTIMIZE_DEBUG is more
> > > inline with what it is and understandable than
> > > CONFIG_DEBUG_EXPERIENCE. The "OPTIMIZE" is the key word there.
> > > 
> > > -- Steve  
> > What about CONFIG_CC_OPTIMIZE_FOR_DEBUGGING? We alreay have
> > CONFIG_CC_OPTIMIZE_FOR_SIZE and CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE.
> 
> Yes I like that much better.
> 
> > 
> > And do we need to move it to existing configuration menu "General setup->
> > Compiler optimization level"? But I also want it appear in "kernel hacking"
> > since this is a debug option.
> 
> I understand why you would want it by debugging, but I think it does
> make more sense to be included with the above two other options, as
> they are all mutually exclusive.
> 
> This brings up the topic of creating config paradigms. That is, a way
> of saying "I want a debug kernel" and select one option that selects
> everything you would expect. Or perhaps we should have a:
> 
>  make debug_config
> 
Agree, I accomplish this by running script scripts/kconfig/merge_config.sh.

> that does it.
> 
> But that's a different topic. For now, I would just included it in
> init/Kconfig, and not worry about it not showing up in kernel hacking.
> 
> 
> -- Steve

-- 
Thanks,
Changbin Du
