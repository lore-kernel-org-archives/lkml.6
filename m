Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA76C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968382174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968382174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeI1NhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:37:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeI1NhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:37:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so4844294ljb.3;
        Fri, 28 Sep 2018 00:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cW2dZM23GkKjeo+Poi01rT+5Ggz6QDfM613pJNXu5nc=;
        b=EArAti6F51BWtgbbue1on0Ntsmh9WXkv0chzvnx5xnxuRkrg5WB/pKmliAiyVd8wfS
         5uszJX7acKLTwMYmM55YiIPuNmC3Ap+UYgw60aVqgDMfY44rOytHg/h+94zQY6AXrK2/
         TmnLMcCS3ZYdIHaaQLDiG1Dq80m5dM5wmocOm7uAuhLTLUDITK51cJiYNud54pl30yd5
         TpZn+0jLNa/jS+nms5WWQB4BLPOjVfX1qt8Va2ALnAO/ZPHlxcMk9gPiEd+LFxUQ6SCx
         IQk7IXcXVsyNfzsMCYH9SGBszBPOqmAdRgUF3wf9rnJd03Or92RIwql57Ke8mTbfjCc0
         KY+w==
X-Gm-Message-State: ABuFfoiV0RydWkWu+V1yrKv6FtH6+1PG5SmNM+zH2gm5WK6FmStoTl8J
        zXccjEcaYyw3uNiPcHvU31M=
X-Google-Smtp-Source: ACcGV631eTOV0/ajCK+yloyMQCjRwVuZ05nopXSYEKMyLIBVAPmoLSf/aFP03llMsdoXozTsEyjEFQ==
X-Received: by 2002:a2e:3e0d:: with SMTP id l13-v6mr9874559lja.151.1538118880578;
        Fri, 28 Sep 2018 00:14:40 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x78-v6sm875476lfa.33.2018.09.28.00.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 00:14:39 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:14:37 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, sboyd@kernel.org,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180928071437.GB9389@localhost.localdomain>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
 <20180921181217.GI20825@sirena.org.uk>
 <20180921185258.GC4358@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921185258.GC4358@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:52:58AM -0700, Lee Jones wrote:
> On Fri, 21 Sep 2018, Mark Brown wrote:
> 
> > On Fri, Sep 21, 2018 at 11:02:41AM -0700, Lee Jones wrote:
> > > On Fri, 21 Sep 2018, Mark Brown wrote:
> > 
> > > > This looks OK to me - Lee, the patch is almost entirely a regulator one,
> > > > are you OK with me applying it?
> > 
> > > The diff in rohm-bd718x7.h does not look significant.
> > 
> > > You can apply it so long as you provide me with a PR in order to avoid
> > > any potential merge conflicts.  Especially as Linus is out for this
> > > release.
> > 
> > Great, thanks.  There's also the MFD DT bindings and another patch later
> > on with Acked-for-MFD tags on them, should I convert the tags to acks,
> > apply those as well and include them in the pull request?
> 
> Please.

I was just wondering if I could do something to help get this patch
series applied? Mark, have you had the time to take a look on pickable
ranges addition yet? Should I do some rebasing/resending? Are you giving
me a nudge if I can do something?

Br,
	Matti Vaittinen
