Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA012146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ghf2qNcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfAKKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:22:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40457 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:22:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so12633947edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPrExMqjX2aSg2yR/cKM5sDuT7CAwBh7xPK8cb41bao=;
        b=Ghf2qNccSpA7NEnN6SpJo1YEjgTFgUdEBCRA7jHQyPpNzGUzUC9988UGh8nCPz9P/3
         1mH1O21uQI8NldhNsSYLzE8H92KfJIDWk11xLL4uI7wEfG3IcGCb6ENMTLFeVx81PZ7l
         pDCVf1n8zkQn56zdOC8P5u0ew4pTcBT3tBmrlaL077/Fq852o5Go084lMq1YlCML/Zia
         X7MVCOv3ozbujDpOXi5Tanm6WxDQoJi1yK5tunmTX9baSkxDHdp69DzPdRZ/r9AOAlbn
         D47Q/E4Rl7b6psNY/FumqCQqmjLD/Cu0SUdge6Eo3pbNEZ9BBZVlvZSUVdFX0MhADMMY
         EOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPrExMqjX2aSg2yR/cKM5sDuT7CAwBh7xPK8cb41bao=;
        b=pmawLzwLMWzXs+FUBAny5cvP93AF9U9BDyimwTYbBSav+KvcG8bGEMN+iG4m5kN/os
         DcxxRI/CR9+dlN+fRHp7HSXQAaBi+u1U0pY6QtyO/TXOoyYKZQqjCJNiQo02yI4vqnUf
         gRdhFozD+ZSkQfMSVs1i5+sgGBmb2v6XHaQl//fOrNPXbZISoEy5LSZwg7Cm25O7KyjV
         Y9Sv68vuANOtx5EooUaOAe67k1hSwM1vmTu6FckvUnFCFpdR/rtPXGUTqIfFSCTEsntw
         zaTBcyClYlpmcRdTSQvMMWSioRWLtDG9brhVkxlmkq/XZ21WXPFxfOD/1/SoYh55FCnN
         DcQg==
X-Gm-Message-State: AJcUukdmfiYChMWETQugwi48FnPFpd25WH/afbD4p6sbhTD3zbpCnRrf
        2KodM7yNCdO93YvVTnNM+uLbrF2ojMz2Lg==
X-Google-Smtp-Source: ALg8bN67TOVnEU0oMn13ie4b+hH7Jk08ktufUBFz88c36nGxp2cJ/XIt4qgUzuOGlnh/DtJqAonuTQ==
X-Received: by 2002:a17:906:6d59:: with SMTP id a25-v6mr11394021ejt.54.1547202160422;
        Fri, 11 Jan 2019 02:22:40 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id m14sm3093750edc.27.2019.01.11.02.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 02:22:39 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:22:39 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/filesystems: add binderfs
Message-ID: <20190111102238.bpyyb6g4tmkm772h@brauner.io>
References: <20190110231309.12653-1-christian@brauner.io>
 <20190110164703.1dd6cee1@lwn.net>
 <20190110235641.nhuodos74i67jf64@brauner.io>
 <20190110170811.5d56f9cb@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110170811.5d56f9cb@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:08:11PM -0700, Jonathan Corbet wrote:
> On Fri, 11 Jan 2019 00:56:42 +0100
> Christian Brauner <christian@brauner.io> wrote:
> 
> > >  - Please consider doing this in RST and tying it into our documentation
> > >    tree.  It's *almost* RST now, so the effort required will be almost
> > >    zero.  
> > 
> > Oh sure. I simply didn't know. I was just going by the files under
> > Documentation/filesystems/. Is this a separate git tree? If so, where is
> > located? Or can I just place it as
> > Documentation/filesystems/binderfs.rst?
> 
> The latter - plus an entry in index.rst.  Look at, say, path-lookup.rst in
> that directory now.

Good. Thanks!

> 
> > >  - Is it worth putting the example program in the samples/ directory?  Is
> > >    it something that would ever make any sense to run in its current form?  
> > 
> > Hm, I mean I can write a small binary that illustrates mounting and
> > allocating binder devices in binderfs.
> 
> This was just a thought - I sure don't want to try to send you off on some
> sort of project if it won't be useful! :)

I mean it'll be useful and it's really not a lot of work to be honest.
It's just extending the program I put into the commit message for
binderfs itself. :)

Thanks!
Christian
