Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB002083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB002083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIADAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:00:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:34024 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeIADAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:00:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5D8052B0;
        Fri, 31 Aug 2018 22:50:32 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:50:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: tidy up TOCs and refs to license-rules.rst
Message-ID: <20180831165015.1461bdc7@lwn.net>
In-Reply-To: <20180814114312.23201-1-markus.heiser@darmarit.de>
References: <20180814114312.23201-1-markus.heiser@darmarit.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:43:12 +0200
Markus Heiser <markus.heiser@darmarit.de> wrote:

> The documentation and TOCs are organized in a manner of a tree. Adding a TOC to
> the root, which refers to a file which is located in a subfolder forms a
> grid. Those TOCs are a bit confusing and thats why we get additional error
> messages while building partial documentation::
> 
>   $ make SPHINXDIRS=process htmldocs
>   ...
>   checking consistency... Documentation/process/license-rules.rst: \
>   WARNING: document isn't included in any toctree
> 
> To fix it, the *root-license-TOC* is replaced by a reference and the
> 'license-roles.txt' is added to the Documentation/process/index.rst TOC.
> 
> BTW: there was an old licences remark in Documentation/process/howto.rst which
> is also updated, mentioning SPDX and pointing to the license-rules.rst

So those are two separate changes and should really have been in two
different patches.  I guess we can let that slide just this
once...applied.

I do have to wonder if the licensing rules are *really* the most
important thing in our docs - the thing that readers should encounter
first, before anything else.  I think I'll revisit that at another time...

Thanks,

jon
