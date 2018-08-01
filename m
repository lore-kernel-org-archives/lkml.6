Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35740C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5AD20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5AD20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbeHAPiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:38:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:40106 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389226AbeHAPiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:38:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 285D5AB5;
        Wed,  1 Aug 2018 13:52:15 +0000 (UTC)
Date:   Wed, 1 Aug 2018 07:52:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 03/13] docs: net: Add filter to index toctree
Message-ID: <20180801075212.6e42fa0c@lwn.net>
In-Reply-To: <20180801050908.29970-4-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
        <20180801050908.29970-4-me@tobin.cc>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Aug 2018 15:08:58 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> filter.rst was just created (from filter.txt).  We should include it in
> the networking docs toctree.
> 
> Add filter to Documentation/networking/index.rst toctree.

So...the minorest of nits just to prove that I actually looked at
this...:)  Adding it to the toctree at this point is going to make the
docs build messy (OK, even messier than it already is) because the RST
conversion hasn't really been done yet.  I'd do this at the end of the
series, just in case somebody, somewhere, is crazy enough to try to
bisect a docs build.

Something that's a bit more relevant, perhaps: this document is a bit of
a mishmash.  It starts by talking about how to use cBPF for socket
filters, then includes a long discussion about the features of eBPF
which, as I understand it, is still not accessible to user space for
socket filters. That latter part certainly merits being in its own file
where people will actually find it?  And if it were me, I would move that
file into the core API guide, since it will be relevant beyond networking.

Thanks,

jon
