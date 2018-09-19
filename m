Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA092151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S89A9MGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA092151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbeISVvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:51:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36316 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbeISVvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:51:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so1764349lfe.3;
        Wed, 19 Sep 2018 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tW3lgWcCsvSQKvZT+KjDWgTvdJU4LVeRbHtdE0+ICiM=;
        b=S89A9MGP2coeXPGkzYVQ+uNJctTced4MQwb3FBySHJ3a0Iy4d5mkPFu0MnPYWKx1+0
         zNO4co3kWLgiLyBGr7yJQ2whxQBe+d43/BegmMsT2Y8+mYOSL3lTj816WAb8w0+q4olN
         n05gUrzrIvdlauXVclkEmsdk6kF8uexNldL3+bFFim7+3ssNYUhcrBaJNfJgTPGbqpZc
         fy9egYNEgRsY2bmjfutAg+JmPWUufxAXB0XItOQyBfpMC4opxchLjp7i7u+PoriBWWnC
         UeGmRVtw8z1Sh9EOTtqbib95ThtaziMoeJ5VuRF4EBfPOdjcld9mndyrRZA2H6PfbTwW
         YNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tW3lgWcCsvSQKvZT+KjDWgTvdJU4LVeRbHtdE0+ICiM=;
        b=UhenuDUe/U3WrZDwLrBi59N6P3NwxnLQuzMRvxgQ9PvdDSRLUmQ2qmDl0cczHH6SK6
         wSR+NDH2OllDAszDlu8L1VZJZq63w1Z/nglD7BI35Cjh9i8sQARpJU8aPqrN/RNzXTdE
         lC34YzDeF99eNLWMS36dhOlNvYZJQoz3zuJ702eujF8wePtXeE/KOwdcIVkBodT277Gp
         amMiAsQqeB05aJXgZp0YSZ7Q/M9VChjdpj13Z3P4PyoYZJd16HLbqIWAcloMG/nXFGkw
         TUv/irOfdHNxmv8oDmqkOTmnMynFXtUm4/CvSW7NrtTXfvNwE76MjGdJ6X+veDPhu/r8
         i17Q==
X-Gm-Message-State: APzg51BOOne/UjEoxGfG5vMDZGlLSCwUEZ8Qp2CwtkY9GQDEUBD01ZID
        HZLwLdlBPi5vufNpG6bRjCc=
X-Google-Smtp-Source: ANB0VdZPqgiKE7G8C4nwYG0BqMtaQU8WnMfYa9RNZqY51s4wCFrkH9pL0fUi7uQlcmv3H5ngfr2Tmg==
X-Received: by 2002:a19:1063:: with SMTP id f96-v6mr9323593lfi.88.1537373583617;
        Wed, 19 Sep 2018 09:13:03 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 16-v6sm970275lfs.84.2018.09.19.09.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 09:13:02 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id EAA6B460653; Wed, 19 Sep 2018 19:13:01 +0300 (MSK)
Date:   Wed, 19 Sep 2018 19:13:01 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, avagin@virtuozzo.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] BUG triggered in ptraceme
Message-ID: <20180919161301.GF17524@uranus.lan>
References: <20180919070737.GB17524@uranus.lan>
 <20180919071056.GC17524@uranus.lan>
 <CAG48ez0d0mO3yN10ApgJuwt9DTDj6x+j_wtjz6qM35nGtxnUdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0d0mO3yN10ApgJuwt9DTDj6x+j_wtjz6qM35nGtxnUdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:16:50PM +0200, Jann Horn wrote:
...
> >
> > Heh, actually not :) It is due to commit
> >
> > commit 1f8266ff58840d698a1e96d2274189de1bdf7969
> > Author: Jann Horn <jannh@google.com>
> > Date:   Thu Sep 13 18:12:09 2018 +0200
> >
> > which introduced might_sleep. Seems it is bad idea to send bug report
> > without having a cup of coffee at the morning :)
> 
> Yeah, I fixed one sleep-in-atomic bug and figured I'd throw a
> might_sleep() in there for good measure... sigh.
> I guess now I have to go through all the callers of
> begin_current_label_crit_section() to see what else looks wrong...
> 

Yes, I fear so. Need to check every caller just to be sure.

> apparmor_ptrace_traceme() is wrong, as reported...
> 
> apparmor_path_link() looks icky, but I'm not sure - from what I can
> tell, it's called with an i_rwsem held for writing, and that probably
> makes calling back into filesystem context from there a bad idea?
> OTOH, it's just the i_rwsem of a newly-created path, so I don't know
> whether that's actually an issue...
> 
> security_path_rename() is called with two i_rwsem's held, but again,
> I'm not sure whether that's a problem.

Lets wait for fs people opinions.
