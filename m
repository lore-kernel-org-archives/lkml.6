Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-911174-1518425373-2-6315617614746577172
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
    t=1518425372; b=F1q8WVU2JAD0hXeP1aj4zI4LPUR5iK0JKR+nrl5DpQ5TQby
    XB9CIH0f0ZDzJu8tXmwSty9m5CS58k13GCYwslNagJGwQTsthlIWCHMRnY7Lragl
    HvhMRJH8q2L9ezJ5j0ioBjdFjT11aHsuEsxQKeINXA8CvVsnsPcRP1MZOGWob/Rn
    M6jZWhQquGzFo2E/ZWHDRICr8kp3Cl7aBZsWQiykLg2LpsIIoDrE8PtxyyUvtLO1
    8ENepsLcSfiRBIp3ecZ3oDHBLoD2HtqVf0SjvMm4IKNEuolj0+d6JPigAcDBHmCU
    QvxO3Hd3sTPZKyN9xTxm87T2kTJgxM6eSmE6A0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518425372; bh=FRagnKnuA5R1oOOE2XtdVWBODvvoHhYYaxnZKqsrwPg=; b=L
    S5fN73ZHEyegM3DLQjzqXembXHwTg0DOnff3VCzKwHJuZKtMK9LrM5/DtRnt6OyT
    NxtahPyVLxAiW/N6c0ZpB8uh939DaKfo/jkwaLvB3DXZL4ok3b/R01PL/znYSuSh
    aZDcVMhlaVOhMFD2cg/gmap/hrBRQTdOLTlvH96jJxXk3lsV2POJBfoOiwv2Gh0x
    n1lE4Kd15e5JHTMq1tDdk7Dr2LNi/52SfD7SejQllEViJ6V+iXU//ApdXnevo8G9
    JzS00FXclAfj09+qbpzzjMKjDo8qx0txlSGEL18dW1mB9VHAm8vVICJd3XEtVc3H
    jiMTBcxCiFBtNYDvI54jg==
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
        id S1750801AbeBLIta (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 03:49:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:35922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932891AbeBLIt3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 03:49:29 -0500
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
Date: Mon, 12 Feb 2018 09:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207222236.7434-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/02/18 23:22, Simon Gaiser wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
> concurrent xenstore accesses") made a subtle change to the semantic of
> xenbus_dev_request_and_reply() and xenbus_transaction_end().
> 
> Before on an error response to XS_TRANSACTION_END
> xenbus_dev_request_and_reply() would not decrement the active
> transaction counter. But xenbus_transaction_end() has always counted the
> transaction as finished regardless of the response.

Which is correct now. Xenstore will free all transaction related
data regardless of the response. A once failed transaction can't
be repaired, it has to be repeated completely.

The real problem is decrementing the counter when XS_TRANSACTION_END
for a non-existing transaction is being sent.

> The new behavior is that xenbus_dev_request_and_reply() and
> xenbus_transaction_end() will always count the transaction as finished
> regardless the response code (handled in xs_request_exit()).

ENOENT should not decrement the transaction counter, while all
other responses to XS_TRANSACTION_END should still do so.

> But xenbus_dev_frontend tries to end a transaction on closing of the
> device if the XS_TRANSACTION_END failed before. Trying to close the
> transaction twice corrupts the reference count. So fix this by also
> considering a transaction closed if we have sent XS_TRANSACTION_END once
> regardless of the return code.

A transaction in the list of transactions should not considered to be
finished. Either it is not on the list or it is still pending.

> 
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>

So: your patch is a band-aid trying to cure the symptoms, but not the
real problem. Please do it properly.

NAK.


Juergen
