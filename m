Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1190338-1522751263-2-13277117037636312592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522751262; b=BYG5OmLWlESrlCyfGHbtJfqDflXe9q42bL8cmrtoE3UibUpuUp
    8ZjysWa2i/19SUan+a6xnlhtgZuAVKFnS/xeRf8wC4oyLMqJjgMvnZGJAaHLT6BL
    cOpv/dbQaPNfmoa+Hx5j/XAWiJUAXKncQfOCXMw6Sdz5ZWDnsTDDeRJBgPlFBNxF
    uo4SAxChC7sFNLQGhOHk/hsIwVAd4MjZt1iCiI5X34feGTtfGuLrgHdfLSMk9QiM
    sOl3z0EtO9mru57KsKOYQA+vFnVs98WOrzdZLCk2pGYWzn10/jktqcaBi+enTpY2
    wdljoUIzKHzsnDuyydvP1HTWFADCe3B2YSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522751262; bh=Oo2d62jVdXt
    toR7zqNdtUrVWKKAolpYBdwK0PGYxvqY=; b=XWgllCxPo/J2fOfrPDX4ITBRcKA
    btijGukcbmScaDqmI/oRdexH3xy3NDHsqlL+3qBZ1d/yP7AKdT6dpUOxGBv5C6d2
    wczHfs+0aUMttePKh7Hhahpj4e7nhzUE+easq4iF67rL1rqw35GDQNi/+O75sstM
    AZDI/PoMk7K2XrppPiogBokOm2sNsfTdDqELv4ghnjCqyaSRGEZK30aBHsDc1Bt8
    BfrzB4ncud+7RPXYD/KjQHFEQfnSS/xpdcPTtVgN4XVeBTWwoAGgTg6DoajtfMBa
    fVrzP4K7U1YJji7vBa8EXIntmlZLbovL0M8CDJlzImUhpJHrtJ6YJ6W50HA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVZJdKnzb7M5QHqNChoKuF6K/ap5iZnupGXAqfSf0zU9x7fPrPIDFgumoGrswEeFqas4uUui4+4I59kMLv/Bgf4sDR9G7g1LVdcGtc3RrRUi0RJcFqT
    XzTktObFid0PtvhhGlpWcMrJqrz+I6ZMTdg5jitcHJ7+YoTLOd+qzFVIZseO/nFxo+hiSuBpXYS5hioir26yYvtT/U6Qh/t6XWcAesqJ1BOSkGH8s1yfY3JY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8 a=CVGTnWRxnZ6q_qCLuKwA:9 a=wPNLvfGTeEIA:10
    a=3ZumFrijQQ-2J9H5h8ct:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbeDCK13 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 06:27:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbeDCK11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 06:27:27 -0400
Date: Tue, 3 Apr 2018 12:27:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 076/134] kprobes/x86: Set kprobes pages read-only
Message-ID: <20180403102726.GB17259@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171900.247219741@linuxfoundation.org>
 <1522599630.2654.59.camel@codethink.co.uk>
 <20180402154557.361168f8f4139bbd2689dc99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402154557.361168f8f4139bbd2689dc99@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 03:45:57PM +0900, Masami Hiramatsu wrote:
> On Sun, 01 Apr 2018 17:20:30 +0100
> Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> 
> > On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > 
> > > [ Upstream commit d0381c81c2f782fa2131178d11e0cfb23d50d631 ]
> > 
> > This caused a regression in mainline, fixed by:
> > 
> > commit c93f5cf571e7795f97d49ef51b766cf25e328545
> > Author: Masami Hiramatsu <mhiramat@kernel.org>
> > Date:   Thu May 25 19:38:17 2017 +0900
> > 
> >     kprobes/x86: Fix to set RWX bits correctly before releasing trampoline
> 
> Thanks Ben,
> Greg, could you please pick above patch too?

Now picked up, thanks.

greg k-h
