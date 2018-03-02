Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1739853-1520000389-2-7210158651949961275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520000388; b=GUuNwNKlb/OpOGaC+Jtbl1XT73DjegJHNrEBP6CgkotrWIl
    EncliHGMODHnjXh5ju5t9yiEQZHB05xkq/Ns+zgg+TLfLhnm5xy7wGSNIwHqlWoB
    GBJDuu6P2mMWMfOymb4+x+67Ascw92FvUS5NY/bzVpKlmYdnPpKO2EmyI4TyROOk
    GyK5neDav++QOaVeqpbj81OHQT0ZCbkoU9ac2BtxTcXShsiX4LggCF0uF6ybW+JO
    yVBZKtV+HO4DQ13jmieSLbcqSNP49w01lU+XmXRbs7VzeyZ2ccBhD07AsEYWtzYH
    QtA3VYfGNsbm/oQAbpxNWQMFw+/Hx4DKF/q91Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520000388; bh=Yb86OE+vyVdicgyRvhSC7gtJOp+pZ6sfO1FPl8reLHQ=; b=j
    Z0h5psKipb3/zb6IRkYgUjLtxiAUier7XUwevSkY5qwC7Re8ZU01y8mEqFkpX3tQ
    a6zcD2HrLdU+KoYFjpgDzggbKYq09VGUCj2l1wbiF9apqsihNC15zllg0rjSZWs3
    W6rWEOGxF2NZLqZ6NKf9D+A8IUfnobAYlups5IH1mbrXWZhCkRWTf8PBe+YyUCQs
    UOjxtxOlZvr4T7Ph51Bx6aY6zuGu4btEaaQJh/UElcooiXTvaOxgv22eCg7HDUL8
    RI4yRixjdxxq8LeNd4l8WVZaZReWV8M8tulo80Pj5MWLH85wj66l7iBVr6e3phV2
    FoWtERPuTcEazsk1cz0gg==
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
        id S1428589AbeCBOTp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 09:19:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1428567AbeCBOTo (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 09:19:44 -0500
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
 <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>
 <1d10edc6-8ad6-bc58-432c-d1867f0ab57a@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <2263ddf3-54f6-d81e-7674-d0ae0802aa65@suse.com>
Date: Fri, 2 Mar 2018 15:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1d10edc6-8ad6-bc58-432c-d1867f0ab57a@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20/02/18 05:56, Simon Gaiser wrote:
> Juergen Gross:
>> On 07/02/18 23:22, Simon Gaiser wrote:
>>> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
>>> concurrent xenstore accesses") made a subtle change to the semantic of
>>> xenbus_dev_request_and_reply() and xenbus_transaction_end().
>>>
>>> Before on an error response to XS_TRANSACTION_END
>>> xenbus_dev_request_and_reply() would not decrement the active
>>> transaction counter. But xenbus_transaction_end() has always counted the
>>> transaction as finished regardless of the response.
>>
>> Which is correct now. Xenstore will free all transaction related
>> data regardless of the response. A once failed transaction can't
>> be repaired, it has to be repeated completely.
> 
> So if xenstore frees the transaction why should we keep it in the list
> with pending transaction in xenbus_dev_frontend? That's exactly what
> this patch fixes by always removing it from the list, not only on a
> successful response (See below for the EINVAL case).

Aah, sorry, I seem to have misread my own coding. :-(

Yes, you are right. Sorry for not seeing it before.

> 
> [...]
>>> But xenbus_dev_frontend tries to end a transaction on closing of the
>>> device if the XS_TRANSACTION_END failed before. Trying to close the
>>> transaction twice corrupts the reference count. So fix this by also
>>> considering a transaction closed if we have sent XS_TRANSACTION_END once
>>> regardless of the return code.
>>
>> A transaction in the list of transactions should not considered to be
>> finished. Either it is not on the list or it is still pending.
> 
> With "considering a transaction closed" I mean "take the code path which
> removes the transaction from the list with pending transactions".
> 
> From the follow-up mail:
>>>> The new behavior is that xenbus_dev_request_and_reply() and
>>>> xenbus_transaction_end() will always count the transaction as finished
>>>> regardless the response code (handled in xs_request_exit()).
>>>
>>> ENOENT should not decrement the transaction counter, while all
>>> other responses to XS_TRANSACTION_END should still do so.
>>
>> Sorry, I stand corrected: the ENOENT case should never happen, as this
>> case is tested in xenbus_write_transaction(). It doesn't hurt to test
>> for ENOENT, though.
>>
>> What should be handled is EINVAL: this would happen if a user specified
>> a string different from "T" and "F".
> 
> Ok, I will handle those cases in xs_request_exit(). Although I don't
> like that this depends on the internals of xenstore (At least to me it's
> not obvious why it should only return ENOENT or EINVAL in this case).
> 
> In the xenbus_write_transaction() case checking the string before
> sending the transaction (like the transaction itself is verified) would
> avoid this problem.

Right. I'd prefer this solution.

Remains the only problem you tried to tackle with your second patch: a
kernel driver going crazy and ending transactions it never started (or
ending them multiple times). The EINVAL case can't happen here, but
ENOENT can. Either ENOENT has to be handled in xs_request_exit() or you
need to keep track of the transactions like in the user interface and
refuse ending an unknown transaction. Or you trust the kernel users.
Trying to fix the usage counter seems to be the wrong approach IMO.


Juergen
