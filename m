Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C687C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65855218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfADR2F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:28:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfADR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:28:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB6FF2D7FF;
        Fri,  4 Jan 2019 17:28:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 435EA101F97D;
        Fri,  4 Jan 2019 17:28:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190103171659.GA208343@gmail.com>
References: <20190103171659.GA208343@gmail.com> <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: Bug report: unaligned access with ext4 encryption
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17390.1546622882.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 04 Jan 2019 17:28:02 +0000
Message-ID: <17391.1546622882@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 04 Jan 2019 17:28:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> Hi Aaro, thanks for the bug report!  I think you're on the right track; it makes
> much more sense to have the keyrings subsystem store the payload with better
> alignment, than to work around the 2-byte alignment in fscrypt.
> 
> But how about '__aligned(__alignof__(u64))' instead?  4 bytes may not be enough.
> 
> David, what do you think?

Does that even work?

Might be better to just insert 6 bytes of padding with a comment, but yes I
agree that it's probably better to align it to at least machine word size.

David
