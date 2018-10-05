Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCAFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C69520834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C69520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeJENoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbeJENoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AFA2A4D29;
        Fri,  5 Oct 2018 06:46:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6071969FAF;
        Fri,  5 Oct 2018 06:46:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181005020316.7cqlcfkedhamwhtt@ast-mbp.dhcp.thefacebook.com>
References: <20181005020316.7cqlcfkedhamwhtt@ast-mbp.dhcp.thefacebook.com> <20181004171925.6neebizw4xmpjhv6@ast-mbp.dhcp.thefacebook.com> <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com> <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk> <25668.1538672073@warthog.procyon.org.uk> <5213.1538695482@warthog.procyon.org.uk>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     dhowells@redhat.com, David Ahern <dsahern@gmail.com>,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in and out of a UDP socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9723.1538722010.1@warthog.procyon.org.uk>
Date:   Fri, 05 Oct 2018 07:46:50 +0100
Message-ID: <9724.1538722010@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 05 Oct 2018 06:46:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> - kprobes at the top of the function don't use traps and they've been
> optimized over the years to have very low overhead

To quote kprobes.txt:

	How Does a Kprobe Work?
	-----------------------

	When a kprobe is registered, Kprobes makes a copy of the probed
	instruction and replaces the first byte(s) of the probed instruction
	with a breakpoint instruction (e.g., int3 on i386 and x86_64).

Perhaps the docs need updating.

However, for my purposes, tracepoints are easier.

Anyway, as I said, I don't feel that strongly about the patch.  It was useful
for me, and I thought it might be useful for other people.

David
