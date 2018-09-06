Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76897C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABCD2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABCD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeIFW4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:56:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34394 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeIFW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:56:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so5657585pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hr6P5TygTHl/oHPHtePFA77lLt4zl7jMvYUPCT4B3nw=;
        b=Hs/mtw7vbb64NFZEgHi5QKcqRh+PsZXXk0Tk/WH/tq2ddjsCSsv+1VSeU2o/XaLjUX
         8ekz7PhTlGQQuYO+WEffn1tVr9rkUtnxfz6X/TdZ9/tLgxNFdLGkE15P/MRhvHbJbSra
         xd89tpHlbOfuOiKNylp0qhRX8Ffl5vmB3fKH9/9nSpu4U8m+hDJvec9+QmqBvRoJ8aS/
         kk6BsA4Hg/HKTIkbM4Bnb5+84RmeRsHLJijLThKYrid6NSqGBPfDUUelkXAy7hCHkFw8
         Wx7oiV5kWyPdObnrGtJUfF6AjvFwnpUIXXiknU6nSH+aenUpa4f7W1EIpC661msQ/BvH
         wsXQ==
X-Gm-Message-State: APzg51BGis1O6ExM0EjtJHuGv5MyKK4qXQFATgInJd9t568mbkWPV4ge
        la8KT94l440cANoisita6FaJXQ==
X-Google-Smtp-Source: ANB0VdZN75wUKBAdl/x5558iqLdQqh/1Ko4uFOxuOu11xwYfatys+PgZ6lk+k2g3aBydwXp1W+e6XQ==
X-Received: by 2002:a63:481:: with SMTP id 123-v6mr4208747pge.129.1536257960299;
        Thu, 06 Sep 2018 11:19:20 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id v8-v6sm7401061pff.120.2018.09.06.11.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:19:19 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:19:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <moritz.fischer.private@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] fpga: bridge: add devm_fpga_bridge_create
Message-ID: <20180906181918.GA20419@archbook>
References: <20180904212237.3078-1-atull@kernel.org>
 <20180904212237.3078-4-atull@kernel.org>
 <CAJYdmeO0RegP4q1tVow1U0=Zc42GEHMuqsHsvHvMqp89zZ6Wpw@mail.gmail.com>
 <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, Sep 05, 2018 at 10:38:53AM -0500, Alan Tull wrote:
> > > - * fpga_bridge_unregister - unregister and free a fpga bridge
> > > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > > + * fpga_bridge_unregister - unregister a FPGA bridge
> > > + *
> > > + * @bridge: FPGA bridge struct
> > > + *
> > > + * This function is intended for use in a FPGA bridge driver's remove function.
> > > + * If the bridge was created with devm_fpga_bridge_create(), the bridge struct
> > > + * will be automatically freed.  If the bridge was created with
> > > + * fpga_bridge_create(), the caller is responsible for freeing the bridge with
> > > + * fpga_bridge_free().
> >
> > I find the formulation somewhat confusing, since it could be
> > interpreted as if you
> > used the devm_() functions you don't have to call unregister().
> 
> Yes I'm being too verbose and it's making things muddled.  How about
> if I take out the part that starts with "If bridge was created..."?
> That just leaves "This function is intended for use in a FPGA bridge
> driver's remove function."

Sounds good.

Moritz
