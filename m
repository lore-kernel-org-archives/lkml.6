Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3248017-1526012055-2-1870850728755894325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526012055; b=j9VRk4EuY/ZyF6LofVHLMg5GT8rw4cw0+AU5x9LHd/TDL8VkX8
    BgNfMU938dvhoyTwLXTYOLWXZIq0ZNeyP1Gy6gQIv7Z/QpYLlWm2M0katTm6Lq+g
    bpJ10ygMEV84tGGUIHBo8yN12uWin7CvNmJihw+wTS7hbuZjqL4aW2Dq0jqbDRiZ
    i9yYiXgLdbbB7fTWLP+S2tziCcyKJqsZUf6aO1FL6KFK6NniqDAC5glqe3592/Gb
    5w8c90MAeS1oPL1Q2ZDm+xhSAhQVBEzM4WEdcf4lsfKOzk1sr9iSxtE3dwBpBuDq
    I1xgH0PZBYOkgZwkBfDUyZVlWuljpx5mti1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526012055;
    bh=1xPLamVGUEgeQHjHUapxwPhu9xCB4iZfi3CeMDL1Xcg=; b=Nryk93TrbQ5n
    iB9gFMKrS0dPXjVfS1mh4XXNhzxkzY6OVdjuHqwBM4FHr5AvB3HVi8vDNa16JeQp
    fel3C2Nm5rSzDKiEq9OcZhiVurh1kNXkQlKdXxHbjERm2H8QUNc7c+C4aw/b8S/j
    sdcU+Ejrn9O0P/6bR5oP9vRvjGNDaJvQHX71wlWjEBfTH+wi3zp1SpJzSkWIzQq8
    NijO8XPZGTStEagUO+ZR1oTCQo8ocrBYBynx4gp4+lkbUn6+fEmul0VZCQUEnjzT
    +6pHt07FnLKuHOkacwfv+T53XPJaXQeR9FI93TzAv2lRgdUlNjpoWRUFs7muIpHQ
    yZzwKUzNqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKii8OaFWyhLhNzIxbOxO5gB4XAi6x8+zl9vM+9ekLff787YRy5qf+CxKXwY+KRf6Gc7KUpDvHRQHgT/6zk2Si6b0uwpLKZh6RKMlBymR59dbYA8QHH1
    yDZwnDLp0bqoDFG2SNK5XPsPe72c5ljNFJxDyQkGlZ9/bLXW+j3FarSC2lmp+79dYNhWQuYNNrkIxpskQ3SxUTvDDIywbUVIOxMsuKTVWRvEPJndHCQJVQK4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=XVgS6tsLxPKvYAlxa0gA:9
    a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeEKEOL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 00:14:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40907 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeEKEOK (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 00:14:10 -0400
Subject: Re: [PATCH] tracing/x86/xen: Remove zero data size trace events
 trace_xen_mmu_flush_tlb{_all}
To: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingjie Jiang <jingjie.jiang@oracle.com>,
        Mukesh Rathor <mukesh.rathor@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        stable@vger.kernel.org
References: <20180509144605.5a220327@gandalf.local.home>
From: Juergen Gross <jgross@suse.com>
Message-ID: <54c0a807-87e3-866f-aaa8-de383d567d50@suse.com>
Date: Fri, 11 May 2018 06:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509144605.5a220327@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/05/18 20:46, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Doing an audit of trace events, I discovered two trace events in the xen
> subsystem that use a hack to create zero data size trace events. This is not
> what trace events are for. Trace events add memory footprint overhead, and
> if all you need to do is see if a function is hit or not, simply make that
> function noinline and use function tracer filtering.
> 
> Worse yet, the hack used was:
> 
>  __array(char, x, 0)
> 
> Which creates a static string of zero in length. There's assumptions about
> such constructs in ftrace that this is a dynamic string that is nul
> terminated. This is not the case with these tracepoints and can cause
> problems in various parts of ftrace.
> 
> Nuke the trace events!
> 
> Cc: stable@vger.kernel.org
> Fixes: 95a7d76897c1e ("xen/mmu: Use Xen specific TLB flush instead of the generic one.")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Any reason not sending this patch to the Xen maintainers?

I can take it through the Xen tree. :-)

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
