Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3724309-1524805688-2-10784803546310830725
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524805687; b=HIFG3h9MthxKgxaV+CwLUUbZrnqCVwibYTT7y5InJKAPi2QJmp
    D4izO/F3M7KBE6578csKlTLS+nDCjr0ccCvuGwLh5JHaeiiSoyLffXBBVg2jLbJs
    50GQIa/WKr2Pe5FSuzBTfLdt7xFSxPJbOfOAQ6sCnQjZVrbwILYeFxr9AB8wsO6/
    WdwBPD0f9SKWChBXdZ301/4www6IkFa0cQRvV/PCtJK9c15foSvefnSukiBcpwaq
    NqA0/eWuAhu8faFyaTJkSxNaSRdKP+DSgg9pOa6xGO8qm4eOBj5c9efxuxj7dKrd
    97odQWZnHQyMd5iSqLUNXcCEYNtIpdXGwxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524805687;
    bh=M5xGA+f/KHpGV6IuM4VnZ8zc+nhncOsf5kaP+xwXjk8=; b=lgSatAYsO4NS
    ac8bVEzOLXPatfTvH0NCpzE8j8luSyE//UYztqfRuMDuY12dZA9645TeFzvP+Yhu
    RpqfAiHM4Df4CGa9XFOUxtTAGcKIApieNilk9sAjQXAgXcHWEqebCRCDdMinCl2R
    +LzvrtP9LgFepcHN3MB+yx/w/rOE4Tm4wE/tXNbqHKPDDiw/ugEZO4Mmy+dO30CB
    IjStbMH2u/W/4wiW4n8SJDhqeWq1ldCAEiQgMDS34ai0R+VFvsykAh+OkDI9yb0o
    9tjoadUDYjQHUlZau8T0qUMmXSJ1Mqr5ghRpEWVwSMigvqp9yV7MnOSd8BnURb2R
    w70SgosPyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDcdxw+zHEzjKtvLcCgq73VOFllyXNl0YnFCnGz1pBjJnQQp3w+cWraR7Ab8VLXeVrE3fDFxeisjMhHOvpEUbivyzzJB1by5SRJst7KQ3R4KuLiMOc2F
    SbZnlcxnqwtZBQBvpVnuJDW1SOkrYPzHK/Vo70Oh1Jf0kYO4o8wBsV0ILX7EIxB2PUe0NBcCEHp1fQGSbC2Sww76jkAlAGqzhlC3koGcl5uoi5Ffxh0V3ES9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=alyLhzZ2wJ2f5D7GUyMA:9
    a=3IpnG7oYPH8QZCRD:21 a=zuDihmPB_AKjqZvJ:21 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeD0FIE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 01:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeD0FID (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 01:08:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6221838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 27 Apr 2018 14:07:57 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH -tip v2 4/7] kprobes: Replace %p with other pointer
 types
Message-Id: <20180427140757.39c937eea546ccfdafb38332@kernel.org>
In-Reply-To: <20180426224824.3492232e@vmware.local.home>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
        <20180426211351.419d3502@vmware.local.home>
        <20180427113951.8e3192af570c0bae925b2a71@kernel.org>
        <20180426224824.3492232e@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 22:48:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 27 Apr 2018 11:39:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 26 Apr 2018 21:13:51 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 26 Apr 2018 17:10:03 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Replace %p with appropriate pointer types (or just remove it)
> > > >  - Use %pS if possible
> > > >  - Use %px only for the function right before BUG().
> > > >  - Remove unneeded error message.  
> > > 
> > > I'm not sure "right before BUG()" is legitimate for using %px. Why not
> > > still use %pS?  
> > 
> > Since BUG() will dump all registers and stacks which includes
> > raw address information and reboot the system (means reset the
> > kaslr base offset), I thought it may not add additional damage.
> 
> BUG() has been changed to print out %pS and not the address while doing
> the stack dump. It only prints the address if it doesn't find a
> function name. For example:
> 
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc3-test+ #48
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> Call Trace:
>  dump_stack+0x68/0x92
>  lockdep_rcu_suspicious+0xf7/0x100
>  rcu_read_lock+0x5f/0x61
>  __is_insn_slot_addr+0x23/0x5c
>  __kernel_text_address+0x4a/0x80
>  show_trace_log_lvl+0x157/0x296
>  ? module_assert_mutex_or_preempt+0x4f/0x51
>  show_stack+0x3d/0x3f
>  dump_stack+0x68/0x92
>  __warn+0xc2/0xdd
>  ? 0xffffffffa0026077
>  warn_slowpath_null+0x1d/0x1f
>  module_assert_mutex_or_preempt+0x4f/0x51
>  __module_address+0x2a/0xac
>  ? 0xffffffffa0026077
>  __module_text_address+0x12/0x59
>  ? 0xffffffffa0026077
>  is_module_text_address+0xe/0x16
>  __kernel_text_address+0x2b/0x80
>  ? 0xffffffffa0026077
>  unwind_get_return_address+0x50/0x5c
> 

Ah...
OK, I'll fix that.

> 
> > 
> > Anyway, for this patch we can use %pS. For the next [5/7] patch,
> > I'm not sure %pS is good for dumping a stack address...
> 
> Although it now is.

Got it.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
