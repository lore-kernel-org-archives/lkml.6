Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524809323-2-7194672975665252872
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
    1524809322; b=B2JMoD+wISUs2aMvHtMkoy5zczGHBWZzKwwv8nIUEPyJz5rMil
    QC33H/lN49dkPWcM++eaJciaqnpRDnne6t7OxKotg7GqFzu9QIphIEK0CL3/DVKC
    jIgiycThR4l0se74yi27YkPbzj5k+R2H6QpWaRb835YU5wN90tJzQV04mqj+xF2t
    ojEul4fMBlFjz/9ZZNOECzDDJCZpnlV0VUbxq8I13aA03zAVw/XCl8725CUYfX6B
    o0bsXU9A3fiflZP+c53JNnuYMreBmnfqoHPT03LVqouVfdM8zJb+G0h81RuZ9jWU
    irT6vhmh03Mi26Bpnn+MPqBg/Hnph6aiAHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524809322;
    bh=k9SwgealiHg+utdkMgjMTAh6S7MieNfTGPC4EENTHfw=; b=JMHKuea/krs/
    yhIQ19Ez7KcXCBptplhmdhemRfH47aajgeWS3D5ZZbo/ubEbCYNMp6T9bCOor5o6
    vcMLL+gce0pxTjy6XFDUlSagftB9FHWduC6Jp6ViSs8VCgQRF5QnK2GbkZMasaYa
    9wjfDlogyozOH7bbFZ9Hlz+k0o2MC4egmcJR8dtrtd/rmnZirCzJZw9Wsdrx9MJQ
    db3C5SpMgRDGu7Kf1QpXppDkNqU8FO4ZSk9aaeGVUzCzqGXN1z/zMpGEy858lgPU
    J726vdaKlF4CWR6Qwg7/dwtfBaETxhCPAZXa8dZnf/zlgYyxD+QmfzrmQghMFQKv
    v90vxRZDPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfF8+8PYENweMKVJ8f2IpusoIt363xYje/30Dgx+MGh+YdDlDyFzveoEc3b//52fOjjWiH9PDKf+5YIqvsAlb3i8amz4KPm+nOa6ICzcoMcOeRCgU3hAB
    7/o63eLTMceMzrxdzcKEf6rrkcZ4DqtoN/bkYjyn8iRNrOrULp5Xn0YtlhAm4rYU6OO5uYr3rh4oxHM4eXLqPXSl5L1IcCHNG70rx5MntAgFQe7Szxg1jZDc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=pV56haHnpCiGjKuy9gcA:9
    a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeD0GIk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeD0GIj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:08:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FD221853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 27 Apr 2018 15:08:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Message-Id: <20180427150833.a9d21cb6ea96ca7eaf31cdf8@kernel.org>
In-Reply-To: <20180426211434.140fa33d@vmware.local.home>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <20180426084022.GA6777@kroah.com>
        <20180426211434.140fa33d@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 21:14:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Apr 2018 10:40:22 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Is it because he didn't add the Cc: stable@vger.kernel.org tag?

I think this series actually conflict with Thomas's patch which is already
merged.

I'll update the series on the latest linus tree and resend it.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
