Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1786296-1520003183-2-18193945810156750214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520003183; b=FyamTKy3IwEEOmdmxS2x2lb8LB26GmdrPBLQyzGI6XLqaWu
    PWDVVLTttHKMCGwLXaQM6mw8lCCDpT11tV+zRBupmIMMQASPLjYe3vSQgdfNOORO
    n+tDJbPDFW29vyzIn6HIZAPVVeCuo74UMpy5osq+Hvk7bT4SjGDv0TXgxTsDYwhb
    kMVN2RTU+Z5DmrW3/rW9MDFglYHvtK+Hqq6/CLqpURLpgSC821AwBqDJ153jHFZ9
    s2SbY1PqnF0HxYushHBvLd3KZGCy3nPk9xULOyE9cwNYnUTrIyIZjpE+Bi/RKIA7
    TaZL9nq5uZ98qmVFKMl2IEAOYb4fzZTubOAu4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520003183; bh=f2cSA/37QQqeVGyD5obYNJFILrdfjmcykZ+olnigPhY=; b=f
    xZ3iDXyKCIupA3MQsMcIAQ4h5xZKWdTw+Z7uo1eehSkWQ6hFGKDvJfOwQ9PLwtrt
    l7cylSVR2NW8vFQQjUzIvVUjCQ/J/3HLdfxFqWRXI1Oua86M84/yk8gi22utybPX
    UHVom0v/lrdYePzJ9AHNlGV3NzDaw3Zi7vMBJDRc9yF5DD0O25vHSl2e3qVh9tJ8
    pMh2qO0dXpnyThDgiSYmw7SWEA7V73uo2mNxhbH2iSqS8Xa3hDZM6hTNtSlxUnFQ
    fZV0gZzqYA0Q2nlCdoTe/xAtQZZayL2AvLOybDMAXbkS6UUgt73l5EXCb+pXoQPR
    SdVKV4FDE7ZJhhOBmfxhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423689AbeCBPF5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 10:05:57 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423587AbeCBPF4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Mar 2018 10:05:56 -0500
Date: Fri, 02 Mar 2018 10:05:54 -0500 (EST)
Message-Id: <20180302.100554.633342004233205400.davem@davemloft.net>
To: colin.king@canonical.com
Cc: johannes.berg@intel.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/usb/kalmia: use ARRAY_SIZE for various array
 sizing calculations
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180302134239.31599-1-colin.king@canonical.com>
References: <20180302134239.31599-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin King <colin.king@canonical.com>
Date: Fri,  2 Mar 2018 13:42:39 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Use the ARRAY_SIZE macro on a couple of arrays to determine
> size of the arrays. Also fix up alignment to clean up a checkpatch
> warning. Improvement suggested by Coccinelle.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
