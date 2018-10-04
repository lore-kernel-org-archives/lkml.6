Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99404C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5323720652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5323720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJDXzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:55:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeJDXzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA17D30E5F8D;
        Thu,  4 Oct 2018 16:54:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6F7D60191;
        Thu,  4 Oct 2018 16:54:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com>
References: <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com> <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
To:     David Ahern <dsahern@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in and out of a UDP socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25667.1538672073.1@warthog.procyon.org.uk>
Date:   Thu, 04 Oct 2018 17:54:33 +0100
Message-ID: <25668.1538672073@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 04 Oct 2018 16:54:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Ahern <dsahern@gmail.com> wrote:

> These do not add any real value. You are only dumping the skb address,

Not in and of themselves, no - but in combination with tracepoints elsewhere,
where you can use the skb address as a key to follow the lifetime of a
particular skb.

> and you can get the same effect with a probe on the function and dumping
> the value of the register with the skb argument.

Installing a probe requires various preconditions, including your kernel not
being locked down and having the source around AIUI.

Anyway, I've no especially strong feelings about this patch - it's been useful
for me and it might be useful to others.

David
