Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12042C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C7B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="alJzuoNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C7B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeIFVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:41:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeIFVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:41:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so9937839ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5EDQFIJFeYvAOXHCmIUS43Joqis3b0ah/m0dUpGRgE=;
        b=alJzuoNtAyOVmZEBpNlsfxmtneOsZEHZJfgkDyhFBS60FivalJHQPf1QUzhf1kJ2nN
         tCNHre6moS5EsiSqQeiH2cgQb6xiqnFkexrrLaFQoJWC2NjD5ALIKG002shWKTUzrCmS
         a//10S6hlkGFcCv0diVG+LSDSkmVaf7z1fp4KU1V0dfGk5TO2xgFdFNWoAtUIfjhKoa3
         wldL2MiTAQ7lmf633OeFVNkXy65Rxg35yljhVOQ5Q1jjXCfY3QSnDM0EX1uMtSSZEYZw
         QmwylImjClycssbVYFBMsfD8kG0dQ1k/E7nmT91UW0RzKS0iaMMjBHfz/UZjre78IK6H
         /wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5EDQFIJFeYvAOXHCmIUS43Joqis3b0ah/m0dUpGRgE=;
        b=TasgX1zM5l93joPt2A5xw0n/6Ct5gl8PnMHGnZFDQipnUXQ//uKMvapO3b443XzLz9
         UJA6PYUC7ta5qnHPou6B7HJ0NQIT6QtDLvDkt7H4AxZ95kG6MzMCrMX01ngqrGXxVSdG
         Jqx1AljmZT0rBzOZfCorijccsYZJbcblfHgZkB+m+qm0ecRMeV7ir31LBBQ47xJ1MM4P
         yGOHvmr3GKSnkbOh1hVIYjx/svFcArIyqEH3aai2/UF2pkmZY+My6gybn2+GC4RJsnIR
         NJ7ybYU865Eh3qjgMRBN2DQG5imwpGhOY1J115w6JP1YEGkF00OaUrfJJ5O0wmzsZ+0e
         TtWA==
X-Gm-Message-State: APzg51ATapqzkBMftguOv79rTktl2T1U0p1WHCJi08lMd6TZmXqgqIn1
        sENkISsVk7nksqYZrm+3RqoYgQ==
X-Google-Smtp-Source: ANB0VdY41RSsm/8K1MMnATg0uG+xRPE0ql+62rihn1yscutztmcI9uFU2yn4vfZlJiQ3/cMlGI0m+g==
X-Received: by 2002:a2e:610a:: with SMTP id v10-v6mr2460496ljb.39.1536253503415;
        Thu, 06 Sep 2018 10:05:03 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 36-v6sm926071lja.65.2018.09.06.10.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:05:01 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:03:58 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "arm@kernel.org" <arm@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] memory: ti-aemif: fix a potential NULL-pointer
 dereference
Message-ID: <20180906170358.tfdw377lcffwztsm@localhost>
References: <20180906121219.23948-1-brgl@bgdev.pl>
 <b04c16ad-b57d-1635-8d0c-a96020e5aa76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04c16ad-b57d-1635-8d0c-a96020e5aa76@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:58:54AM -0700, Santosh Shilimkar wrote:
> Hi Arnd, Olof,
> 
> On 9/6/2018 5:12 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Platform data pointer may be NULL. We check it everywhere but in one
> > place. Fix it.
> > 
> > Fixes: 8af70cd2ca50 ("memory: aemif: add support for board files")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: stable@vger.kernel.org
> > ---
> >   drivers/memory/ti-aemif.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Will you be able to push this via drivers-soc fixes ?

Applied to fixes.


-Olof
