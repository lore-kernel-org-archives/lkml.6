Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623479-2-13769533329903448960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623479; b=P14yDHK8bCaXoPo65vPV1FV1Si6EqaDZNOSF8bS9dSihak3
    pK/LrwnWbYo1WW1hVwTBp0LSrgjK/QLVlF68qB1mFJRdd1h6iSVdD6qC9hZEUlku
    v3IMSpGPOP9FwlkuJ+IaYmJgmqT0utKRXO8IjS6RMittPsKYQC663EBXAiZF5Nyn
    wGJk0AJRIRK8aJAjLi99NERNZRM4wU/UHBJACXKQgRZHt77yhvbHlc+MMmOq0eF6
    3Cph/lxWvj9VKJ37NfSxNB0rLzvGjN9Wr07D6QDj/XC4QWjc57OaG32xAya/VlTY
    3ISJrB+ykqcAXBLvca6MO2deRaslxOQZdxZyrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623479; bh=yIuqHE+YDYf9rGnEde8je6nLOr
    q1e7mcfAP+Fwd8rGM=; b=vFCazHufVTBkK4lfT+CEMqdeiBj3ph9+46R5+CJF4P
    k4H+pOUU9OCQvvjZ+EwifssTt6M0vVDtVI/fD3R6/8Ffti84XtHXbxhcVC/e95kQ
    +2dzmr2DNgBZJQGOoIFfmG8UWDtk4Pu3Nl+zJuTs+6q0fi1Yn0dzLGUDOJV7pkY+
    4UrfFFmODKzWpOqOUcVog0Iorkmq5iR34Q+BAhMc1IjCjQel+WUzmdsFZ/X/wFz8
    rKRVU+KyUtLAlQ4GMctWq4HTa55zwayHQjgY2fw41RPSqBXX5xG8dRFu5We3Z1iW
    BFfQrJurq4d+d/mFh3qERE/z2IlBLndJMMlCS5W4dClA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeCUJKy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:10:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeCUJKu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:10:50 -0400
Date: Wed, 21 Mar 2018 10:10:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] random: convert to ->poll_mask
Message-ID: <20180321091047.GG14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-29-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:32AM +0100, Christoph Hellwig wrote:
> The big change is that random_read_wait and random_write_wait are merged
> into a single waitqueue that uses keyed wakeups.  Because wait_event_*
> doesn't know about that this will lead to occassional spurious wakeups
> in _random_read and add_hwgenerator_randomness, but wait_event_* is
> designed to handle these and were are not in a a hot path there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/char/random.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

