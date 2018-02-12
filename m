Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-911174-1518426393-2-1859388373709614827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518426392; b=pJpqUhcRCa7DmJkkhFJs7y1INlNkOVk+2pZnYSW28d8WEIt
    0xY5xEAZyr6bK70PLwI36RCriEG5oTPYuYlNBvRhiXwElxG/02TSWX98myeyrbIj
    4a+76mqf2Nk/sJl2eD8ERjGQaQwETZEoZpTaOgScgC7wP5tq8cbEQ2/Nkt9KkXO3
    diQGgoe7V/XVmFFxYjeJwscUGF9A+36LrB0kJWn6bOxrvZ3x/mXHhYZuQlXmt27m
    IL8wShytu8eU/5iILqi6SD4U53wYZPcH51fDLdkj4PonjcumfHn1KSqjsmFm2dBi
    sC2w9JD/CzItxJ6cqpHH239nXxCsHo4RYLkxhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518426392; bh=F798XQ24ROZqGTEW9soVOdRz9xhGr3ZSFqJT8aHeFXc=; b=u
    dtRGv72ZaQ39ayZEv46kOzKkyS44e4Gld/n50ChSyvjQWbsNMVhHx49X6yCOvB2r
    lkSlQqci6yiNXB+S5LDrXPvq6hnOSlf1XHuMRXJjLm44f4iemxbtTgbL6K9iCaKS
    8E/V7eLzEtMwAEqeQJVknytpq0ZskNaFDQYwgOcg72GrRzfpfJX+eiw2MCk+pOJ2
    p7RKRx92aea3tCeaUS8e3eFf8LDNmZDAHH9kZXEGJI3mf9YD6rKJ9er90zy91nKZ
    Epg5BTbnyySGU5bUuu6zIXffZRh7q2caKFPHXBZyl+JvTN+P3DuNH7ikjfAbl0RW
    r8BnSeoRLFgdhB3BhMN9Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeBLJG3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 04:06:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:38918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeBLJG2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 04:06:28 -0500
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>
Date: Mon, 12 Feb 2018 10:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/02/18 09:49, Juergen Gross wrote:
> On 07/02/18 23:22, Simon Gaiser wrote:
>> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
>> concurrent xenstore accesses") made a subtle change to the semantic of
>> xenbus_dev_request_and_reply() and xenbus_transaction_end().
>>
>> Before on an error response to XS_TRANSACTION_END
>> xenbus_dev_request_and_reply() would not decrement the active
>> transaction counter. But xenbus_transaction_end() has always counted the
>> transaction as finished regardless of the response.
> 
> Which is correct now. Xenstore will free all transaction related
> data regardless of the response. A once failed transaction can't
> be repaired, it has to be repeated completely.
> 
> The real problem is decrementing the counter when XS_TRANSACTION_END
> for a non-existing transaction is being sent.
> 
>> The new behavior is that xenbus_dev_request_and_reply() and
>> xenbus_transaction_end() will always count the transaction as finished
>> regardless the response code (handled in xs_request_exit()).
> 
> ENOENT should not decrement the transaction counter, while all
> other responses to XS_TRANSACTION_END should still do so.

Sorry, I stand corrected: the ENOENT case should never happen, as this
case is tested in xenbus_write_transaction(). It doesn't hurt to test
for ENOENT, though.

What should be handled is EINVAL: this would happen if a user specified
a string different from "T" and "F".


Juergen
