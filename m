Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D4FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6CA20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6CA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbeHAKMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:12:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388600AbeHAKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:12:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF7BA40241C0;
        Wed,  1 Aug 2018 08:28:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5377215670D;
        Wed,  1 Aug 2018 08:28:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180801073251.9808-1-yuehaibing@huawei.com>
References: <20180801073251.9808-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dhowells@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next] rxrpc: remove redundant variables 'xcall','sp' and 'did_discard'
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15080.1533112094.1@warthog.procyon.org.uk>
Date:   Wed, 01 Aug 2018 09:28:14 +0100
Message-ID: <15081.1533112094@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 08:28:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 08:28:15 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

>  		while (*pp) {
>  			parent = *pp;
> -			xcall = rb_entry(parent, struct rxrpc_call, sock_node);
>  			if (user_call_ID < call->user_call_ID)
>  				pp = &(*pp)->rb_left;
>  			else if (user_call_ID > call->user_call_ID)

No, this is an actual bug.  The if-conditions should be using xcall-> not
call->.

> -		sp = rxrpc_skb(skb);

Yeah, that's fine.

> -	did_discard = true;

Hmmm...  It looks like I intended something with this, but I don't remember
what now.  I think it can be removed.

David
