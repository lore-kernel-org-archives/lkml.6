Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-829916-1521666712-2-8887091796309415488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521666712; b=Wb4h2zmTErghVX2nuh9dy7p5ef/fvZdZoj+Vq8lVChZWBy3
    B+/RM8kUSwm5aYYnM4j/0TCMfmYfSfCQdT7yGUfy4LsyA32ESlEn+Aas7xEaKRE5
    2xJByi4sxAWcbZThZodWePekQXDC70sY/Jdfmjo9PB7rorFaJKJhJjIPCp9O++3v
    Zo+woNujprW1mAXG47Hef9OoJt6dW/9hd+SzokDr+yAiMA2u23Y08lgEM0uIZ2rv
    DV/b16Axw8cTYvGYwW9kziaZYJ5YJwJB+GgBg9KJYmkc4njTzp7PooiCjPQ+N4tX
    VEa9vy056sx/A1063wQWQbrw9+x+/q1feMXNNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521666712; bh=cichXeIOP6AIi7buphbai/x8EGoqP3rGSGYAPLgY8TE=; b=O
    qBnSlUPpNN3qPjeqYFRJEQznwUv+sK3QFJiP1hTYrX4/HFEWCFi1xhwPItGhLRTU
    0gwOE9iXwfAvzcbFEAm6j9iSa3V4+Dk4bbwW5639M2sC2z5KpePCEiAiiN8b2UZb
    fuLzh8rLJSQN0ekWNnrkom4hINW3c/fLfi5oRrJgpVnnZMgU49v1uU/ydN9WL+Cw
    +Sllhdw+oETNvVHFO1s4YdiISh0AJSYBRWHTkOo/5ruu0kuqnFk4INWSADpzhmuO
    5sdV+sJTeI7vj8njUi9b4dRxde0WNQ3GnQz+FdLQjH67Qr9w2oGr8zZoPtqkc3Eh
    qSDE0zc6EN56clKD0NPhw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=P5hH3VxF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=P5hH3VxF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeCUVLi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 17:11:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52004 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUVLf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 17:11:35 -0400
Subject: Re: [PATCH v2 1/3] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
References: <20180315024322.27429-1-simon@invisiblethingslab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <a0a062fa-3245-359a-2d1b-0542a1b274d8@oracle.com>
Date: Wed, 21 Mar 2018 17:13:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315024322.27429-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/14/2018 10:43 PM, Simon Gaiser wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
> concurrent xenstore accesses") made a subtle change to the semantic of
> xenbus_dev_request_and_reply() and xenbus_transaction_end().
>
> Before on an error response to XS_TRANSACTION_END
> xenbus_dev_request_and_reply() would not decrement the active
> transaction counter. But xenbus_transaction_end() has always counted the
> transaction as finished regardless of the response.
>
> The new behavior is that xenbus_dev_request_and_reply() and
> xenbus_transaction_end() will always count the transaction as finished
> regardless the response code (handled in xs_request_exit()).
>
> But xenbus_dev_frontend tries to end a transaction on closing of the
> device if the XS_TRANSACTION_END failed before. Trying to close the
> transaction twice corrupts the reference count. So fix this by also
> considering a transaction closed if we have sent XS_TRANSACTION_END once
> regardless of the return code.
>
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>

Applied the series to for-linus-4.17

-boris
