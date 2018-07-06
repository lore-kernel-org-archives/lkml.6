Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826120849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B826120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGFGIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:08:16 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:12289
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933395AbeGFFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:20 -0400
X-IronPort-AV: E=Sophos;i="5.51,314,1526335200"; 
   d="scan'208";a="272083389"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 07:49:18 +0200
Date:   Fri, 6 Jul 2018 07:49:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Joe Perches <joe@perches.com>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com, Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Israel Schlesinger <israels@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        baijiaju1990@gmail.com
Subject: Re: [PATCH] checkpatch: Add warnings for use of mdelay()
In-Reply-To: <20180705081953.pmvpmtzm273eb6yk@mwanda>
Message-ID: <alpine.DEB.2.20.1807060747280.3506@hadrien>
References: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org> <173cc189627e0d6618b535fcd1ce6a4c90ce2ad0.camel@perches.com> <20180705081953.pmvpmtzm273eb6yk@mwanda>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jul 2018, Dan Carpenter wrote:

> Neither Smatch nor Coccinelle do a good job tracking when you're in
> atomic context.  I've wanted to add this to Smatch but even then it
> would be to warn that "We're holding a spinlock so we can't sleep".
> It's trickier to say for sure when you're not holding a lock...

Jia-Ju Bai is working on this.  The tool is available on github.  It's
still being improved, though, so perhaps it's not yet ready for eg 0-day
inclusion.  He can give more details.

julia
