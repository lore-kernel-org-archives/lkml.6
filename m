Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AD1ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7228214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7228214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeIRWfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbeIRWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2A428830B;
        Tue, 18 Sep 2018 17:01:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AEC57DEE4;
        Tue, 18 Sep 2018 17:01:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180918161646.19105-20-Jason@zx2c4.com>
References: <20180918161646.19105-20-Jason@zx2c4.com> <20180918161646.19105-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH net-next v5 19/20] security/keys: rewrite big_key crypto to use Zinc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2825.1537290107.1@warthog.procyon.org.uk>
Date:   Tue, 18 Sep 2018 18:01:47 +0100
Message-ID: <2826.1537290107@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Sep 2018 17:01:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> A while back, I noticed that the crypto and crypto API usage in big_keys
> were entirely broken in multiple ways, so I rewrote it. Now, I'm
> rewriting it again, but this time using Zinc's ChaCha20Poly1305
> function.

warthog>git grep chacha20poly1305_decrypt net-next/master 
warthog1>

Where do I find this?

David
