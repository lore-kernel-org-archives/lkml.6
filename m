Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2932816-1523468951-2-17306016926584296023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523468950; b=lo5v5OBdWxBxZMHRPkqHrL0rfJMgheRd/nwEy5tSLxhARIYYHY
    frpxuh601ul0GjfsNpfk09Iye2SWymZ5UvoeLbHWEiDhc2muKh+Rojd8x3PO3vTh
    OQipi9pZrpGWmGaVWRzFd0KDcNe/qTyRO40K6X5Q6bX1kQoCfZUjh/6AffwjvqZl
    T8tnZWtDziuPpFFnPxb8n+G5TfbXsZfj6B3FeBJ19zvQwgXQERA4+6kWTKLZvRGL
    iY0y/M+0K63Ovml10fbIEJ3i7Err611qaD1GDfLMkFLqUKLNRmQqtDwi72qFnvtm
    OJAp7v58UNIV12NEHyDgXK294NBfOGtzGjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1523468950; bh=0MHH/belJX9JoIyHgIGJqDgVFeIuiZ
    WWymnikh1XTX8=; b=i+2PDBKH8yx1jPYuHekSKzig//SJRW8ISdVGntMV19NoA6
    ke9Tfz5pdkMmmOSCsqxnMbsd6Vd68c2RE3rPftsx4mZRu27imE0CDR++4jR44XLM
    5GYTjL/xjfpcmjMCP9rzlFFp5rCbJjL8ARajztFqpJTgygAbrUx9DX1z9c6PK1XJ
    EsF/J/2TLZNKPvW7ZYyGguQTiIScMKqA7Rko/Us+OMDYuCs9Au02ujaUXKgB6lGs
    +CgXldMOMr4gLg8DM43r3w3y2/+CrcEXlyi8R2BQP8mx07VGex2iiQ28uaTUWuSH
    IDeog/iKMsUPwFDLRGyGo3Wx3LAsS7rAtPul0+ow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBh21tujCPIDG7sngA8P+/nvUczLRPZV1gC1vvHNICXJSCp14UM/byuIjvUNEMd97/BB8zpUQGCBdhBptPEqcULBi0P9YWit19DdYhi4qC+xwwisGPHx
    N8pP/sS+1VLNQfTzYahoamsMXIL6CrQIGtWXovxj117RF7oX+CeNJ7OojdjUjNy97rBNfG3S0Taw2hAclLCpDQlNy5rmAwRtpRT/1uDU0EACwOwzJ1D2n2fC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=SWCsgaQcD5guoddKN4oA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDKRtJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:49:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbeDKRtI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 13:49:08 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org>
References: <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running kernel image
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7366.1523468945.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 18:49:05 +0100
Message-ID: <7367.1523468945@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Randy Dunlap <rdunlap@infradead.org> wrote:

> > +	  drivers from functioning because allowing manual configuration of
> > +	  hardware parameters is forbidden, lest a device be used to access the
> > +	  kernel by DMA.  This mostly applies to ISA devices.
> 
> 	Is DMA from non-ISA devices OK, or did I miss seeing that patch?

The issue is where you can directly command a device to do DMA, possibly by
using the wrong driver.  Ask Alan Cox.

David
