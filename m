Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840702-2-14484800010367686587
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
    1524840701; b=OG67SgcHzQP5DYnQAhnWGC9akeG7O4EZaqGnYho7cXfUtjk7s7
    +SQOOZhmXFV2MnXNHoL9QHnU+KkZT03EC0aIdyen2BWE3b4MremavfzKogNDn4BY
    8IAHDsnF0da/suYZIn7MCXO2OdwaqIPhMSET3LpT5byCB4k5N/tHu6X7A1CTtfid
    WT2ynwNu7Fg6xOi5bx9mtQgOEAZ1wqy4lNw+92K6GJygf4E/cMJecNcbk/3sZoja
    4zgLGNsDHdZdSMK28Kj64A5KmGP4xtKqpw1sc0j/NWyA+cQWxRWxOvqtSfNiUXbG
    js+Lbjgqja6g1pvjYBEh2p48NqbvD14Em+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524840701;
    bh=ryR3dTkZeiQmK7RuDEjyJYNtaUE0Xc/YELQaqLf1MEk=; b=mMHlCBtG9UQy
    778VTHnLZtZo8w9qWFrda5x5ZwyEY/BX6jO48xXza8FgV11NmbEz4if4EnRsuiQb
    QApAeaUoLfn82PfnlEQfhqR7kaVq1FalH3EmiOCIsz2mN69iPhtsVKXYlN85yeNc
    SKBTu+UvAmQGE9N7VS8aMdnC+HY2x95OJE4zDWUvMNrT1sRNtoCKT4TfJPhJ/Q8A
    EJnOOsnQyenpiHQ+r7k/2gZcQN/VfiVdFAJ9U4asARsMF0HxIEHpyy607+2AddC0
    ii8INCdkCsWczAQ828wYLzmbVl/O0paq+OU3gQ7JgaJT+Sz8V6iGpx5Tc46fIv6G
    zsG6hruiwg==
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
X-CM-Envelope: MS4wfIlCuf1y39HlWTFD1mF5glkCYXf+CU181SBGi8X5Jnef7X2b5+DDCcJWkcIspzcP9LHXtSRwtNoqjBJJ8kKRV0fbmuISPQSndWiBqzYLIbkb53OIENCi
    tffnsrkyB6B1TQ5tjrLD8lAJ168zxXilp9zYVhn52/3es/I0zWGqeF0DJfzAjokctwJUMLbLNypYQJX8kfM+Kggy4PDzdFOukZxpXBsR6KwWiUnj7qmeeYBN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=CL4aYdDgmrSQ3XynRpsA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934536AbeD0Ov3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934495AbeD0OvX (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:51:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174292188D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 27 Apr 2018 23:51:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20180427235117.c0bcfc30ed4cb0c97038e555@kernel.org>
In-Reply-To: <20180427065637.GB4361@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <20180426084022.GA6777@kroah.com>
        <20180426211434.140fa33d@vmware.local.home>
        <20180427065637.GB4361@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 08:56:37 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 26, 2018 at 09:14:34PM -0400, Steven Rostedt wrote:
> > On Thu, 26 Apr 2018 10:40:22 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > <formletter>
> > > 
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read:
> > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > for how to do this properly.
> > > 
> > > </formletter>
> > 
> > Is it because he didn't add the Cc: stable@vger.kernel.org tag?
> 
> Yes.

Ah, I misunderstood that. OK, adding that CC in the body.

Thanks,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
