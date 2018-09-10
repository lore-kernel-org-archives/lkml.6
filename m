Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BF8204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BF8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeIJRrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:47:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35473 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeIJRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:47:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so39868779oic.2;
        Mon, 10 Sep 2018 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLd10tAtSenj+3JrhO+DdIM7wk3fp9//kd6MtfTlc4s=;
        b=S7ReW0zgMVdyD2xm9QvSK3mX8e/Bt+lAdZrOlgiwSi/Gidn4umHc42o9+wLqgyFzf3
         EAf0FRAy+fsdiF04pq+qoU+lT7M3xVtCoLX5Z3nSfTOtqBmCp0tKlaDfiuBA3KZVFHTF
         sHfRUHZp3NryFKqXdwhXEL1G7a9kJe3kYiSq7r3bYMPhjwQ65ue3nqcCyvJ8ccIi9SJr
         ivZE7R8hqsRyptS6QqcSoeFdsydTREBZs5NE+4n5gbzsgzd6+gWI2GOydN+gMOcl3dEi
         tWXiGqj6K40CsTVQvBlMS05iAqqyBV5mn0TXCAb5fPZx8k4kGhrJyaAELEK/A9zAU/em
         S+mg==
X-Gm-Message-State: APzg51B5RXdvPjCxwbSO6XgUk01ajTd8gEqgbYHjLpK72wPfz6VXygVX
        NycZi0vT8rrgFOwd+LzvLA==
X-Google-Smtp-Source: ANB0VdabnV45UJTtOv8+KS4ztm7SdcatUDqj7pC9twlpDLQJBi9g0sBIBQAp6ny6nizqeALDqStX0Q==
X-Received: by 2002:aca:2311:: with SMTP id e17-v6mr20423677oie.47.1536584001782;
        Mon, 10 Sep 2018 05:53:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f144-v6sm29004108oib.39.2018.09.10.05.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 05:53:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 07:53:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Message-ID: <20180910125320.GA17028@bogus>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 07:04:25PM +0200, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
> > 
> > > A long shot, but something to consider, is that I failed to cover the
> > > cases of dynamic devicetree updates (removing nodes that contain a
> > > phandle) in ways other than overlays.  Michael Ellerman has reported
> > > such a problem for powerpc/mobility with of_detach_node().  A patch to
> > > fix that is one of the tasks I need to complete.
> > 
> > The only thing I can think of is booting via the BootX bootloader on
> > those ancient macs results in a DT with no phandles. I didn't see an
> > obvious reason why that would cause that patch to break though.
> 
> Guys, we still don't have a fix for this one on its way upstream...
> 
> My test patch just creates phandle properties for all nodes, that was
> not intended as a fix, more a way to check if the problem was related
> to the lack of phandles.
> 
> I don't actually know why the new code causes things to fail when
> phandles are absent. This needs to be looked at.
> 
> I'm travelling at the moment and generally caught up with other things,
> I haven't had a chance to dig, so just a heads up. I don't intend to
> submit my patch since it's just a band aid. We need to figure out what
> the actual problem is.

Can you try this patch (w/o Ben's patch). I think the problem is if 
there are no phandles, then roundup_pow_of_two is passed 0 which is 
documented as undefined result.

Though, if a DT has no properties with phandles, then why are we doing a 
lookup in the first place?


8<----------------------------------------------------------------------

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9095b8290150..74eaedd5b860 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	if (!phandles)
+		goto out;
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 
