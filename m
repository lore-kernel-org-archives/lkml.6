Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91688C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B952086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViUr/oZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B952086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeH2Lpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:45:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45884 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeH2Lpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:45:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id r4-v6so3485867lff.12;
        Wed, 29 Aug 2018 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q4K+fl1L1VhnQfQ2kT1nipRGTe82sOgf2AkL3Hqd6fU=;
        b=ViUr/oZOAdBJkBUbmSnGNZ9N0h/trIGmObuChHoRVoRbdgbBmLzuPcssEtpM0lbJ5M
         z/8ZpMl/f9R+XG9pMZRjBlq9YFKwxzgfbgIPac/DC4mKeEYjsk/xt4rFC4TaypGBCRnH
         iBB+o+PD3lm78t5vcrKvGg4w1hWqsU4PdWMTFvWnxgyakzMBWyhbubmZ6bHhZh4MIsfg
         cP1Tuqh8GpuyuqMq11rxjAMsbapfr503OlHGFacEraDT0HM3pt8RYP0zjGJEm1SsmLU9
         b59muGIeSPoT7I1oZ+EUaQgO69SbewFsOlxuSfyLSUVr8OQnr2jeVFp7i1XoUptFF4iZ
         /sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4K+fl1L1VhnQfQ2kT1nipRGTe82sOgf2AkL3Hqd6fU=;
        b=VvWZ99OYFfDpIv36tAzJj+Ac2M7DuBsu3oEDEwqUsNi9/3S+/01G2X9PNZqxC+d3Ps
         iXAnpv7su6QbQgvgjl+vYwMNoWpm2sR7O4sv9v/75KYTf+gh4LbYr5E1zwZPQfeR8Bjq
         ZgBqEvvh9WduyYWPYEy2oa035f7W0CUx84YG2GXImLLlHlcJh5z6IyHfryE4HOru/eGK
         9vJVq/g/7NkXN4yi7RqPPzkSJ/6Njarao+FAxVb7sRuRVCjKKFNP3FDvgw0bJ8oc3gDP
         0OKTzKWJcpnNkIXQhccQ3WsJan6rkrvJSFF6x/6Nfwe7y7+D+kix3ZI54e8WGL4dpz77
         ISFQ==
X-Gm-Message-State: APzg51BFhFbSerAooelpE2Gp+3ded/F6IDUfG59Oz2WfbF7JUFkSNQG5
        565upU66F7MY403R8974YpM=
X-Google-Smtp-Source: ANB0VdadE5ENG9W84NtN610O+M0zQ7Ia1IcynekK/tfJEllrfPppWXNnEb2WbcTQJdG+/c3quh+Skw==
X-Received: by 2002:a19:730d:: with SMTP id o13-v6mr3380708lfc.130.1535529008313;
        Wed, 29 Aug 2018 00:50:08 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r1-v6sm582302ljr.81.2018.08.29.00.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 00:50:07 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuvEt-0007Yp-3n; Wed, 29 Aug 2018 09:50:07 +0200
Date:   Wed, 29 Aug 2018 09:50:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Message-ID: <20180829075007.GC28861@localhost>
References: <20180822090319.29167-1-johan@kernel.org>
 <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:32:03PM -0700, Stephen Boyd wrote:
> Quoting Johan Hovold (2018-08-22 02:03:19)
> > Fix child-node lookup which by using the wrong OF helper was searching
> > the whole tree depth-first, something which could end up matching an
> > unrelated node.
> > 
> > Also fix the related node-reference leaks.
> > 
> > Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> 
> Found by inspection? Or it's actively causing problems? I'm thinking
> it's the former so this can bake in clk-next for a while.

Right, through inspection. I fixed up most of these last year, but this
one managed to sneak in since then.

clk-next should be fine.

Thanks,
Johan
