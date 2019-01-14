Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD6B2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bjNM4n5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfANS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:56:17 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45935 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfANS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:56:16 -0500
Received: by mail-pf1-f182.google.com with SMTP id g62so13340pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IX+dhyoUTqOpDLszzjf/ieQT97h5YR/fB1FZJT8KF+g=;
        b=bjNM4n5JQJjcBkQEP9H0ifXHNY9R+GwXkEQxPVrXB5Mun3iUrvB0NFllXtxcA1Uvn0
         MrdsTTXjQpEuct5EvMhN/lRgg+YahDgqEklRyoRTlQkPg9TmChVZRiretxzYTBGHZsDG
         8Hpt/I20ZY/QFL0kMN+2O+bLsXVTzKCx1kCDbP61lUDlL1O+25/40EyK78xtZYOPUGrH
         M1ZfMHKqVVrM3BynPJDjm8DlDbuQ2/pPA1hI7naYLlMtxDjLYILJpFR6CgJAil17WARx
         HpCvl8gXG/ic6/06+Vrk/3QVTJ0Cy1nFwpB8RRLqqsnrJtrY7/AawcGpAEggWshUucd7
         Yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IX+dhyoUTqOpDLszzjf/ieQT97h5YR/fB1FZJT8KF+g=;
        b=E7vujU1yWkoN4suJS1r3xXPXoKtMp+RtLPht5fXARSxATphESDeBop0qnP+XIZozJR
         AGk21bf2iI/aP7Ec0Eh73mrP1IL4jX/n8qnfXXrbibMx6oagOJfVwnvi2VrXcWi0LV0m
         k1k+Ct4sqP/jpN9q/ToImlTVIebm4F3O0GBf3ekguFW095OM7MSmBa4NbcPY82wJpdMP
         Gi9tq1sRE+7aBQgfp6ND6DJtzYdvNZUOaUc6tDsydG9+heqrTJEd/Hwz0Hzbcdhdt7ec
         XvQ6NnIF6WpWB4VWFcE5KNIV5SZkK2Bq9H7pnLjNf5jAghdAoBvctpwKes2YvggkfPAj
         IuLA==
X-Gm-Message-State: AJcUukcV1t+xtIHHTCuhrsygUQLfd0uLqO8BFlzLBSrtYNctL4RE6ylx
        +FTxdrxeDBkve+sDOYGcB8z2tMHMVqY=
X-Google-Smtp-Source: ALg8bN5Kpi2F/1XfU4wfPnYfrnu5GsC6PTXaB+IQkqeJ+6bvj6sUNa741hTnW9/6qIPBzPJmZjp2Qw==
X-Received: by 2002:a63:3204:: with SMTP id y4mr24104960pgy.41.1547492175765;
        Mon, 14 Jan 2019 10:56:15 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m3sm1432736pgl.69.2019.01.14.10.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:56:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gj7PB-0007vR-Vj; Mon, 14 Jan 2019 11:56:13 -0700
Date:   Mon, 14 Jan 2019 11:56:13 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <JOELN@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/3] docs-rst: infiniband: Convert user verbs doc to rst
Message-ID: <20190114185613.GF22910@ziepe.ca>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
 <1547456451-7102-2-git-send-email-joeln@il.ibm.com>
 <20190114165621.GD22910@ziepe.ca>
 <20190114103421.7fef97c0@lwn.net>
 <OFE572E930.5960E029-ONC2258382.00673730-C2258382.0067A91D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE572E930.5960E029-ONC2258382.00673730-C2258382.0067A91D@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:52:14PM +0200, Joel Nider wrote:
> > > Jonathan/linux-doc: Can you Ack at least the build system parts of
> > > this please? I can take it through the rdma tree, unless you prefer
> > > otherwise?
> > 
> > Can I make a request?  This appears to be user-oriented documentation;  can
> > we please place it into the userspace-api manual, rather than keeping it
> > in its own silo?
> 
> I knew someone was going to ask me to do that :-)
> I agree that userspace stuff should all be together, but I guess for 
> historical reasons this one stayed in the infiniband section. So if Jason 
> is ok with moving the doc, I'll take a look in the morning to see how best 
> to work that into the patchset.

I don't mind

Jason
