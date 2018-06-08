Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 08coFtXlGVsWYgAAmS7hNA
	; Fri, 08 Jun 2018 02:11:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3868E6074D; Fri,  8 Jun 2018 02:11:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HxO0wWA/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A3E20601B4;
	Fri,  8 Jun 2018 02:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3E20601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeFHCL3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:11:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46616 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeFHCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:11:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id d2-v6so5624880pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5xUPg+YXEDk81n5mlokfnR16Ccj10o2P2CyqFGLkvB4=;
        b=HxO0wWA/XYlSmzmNNCrnksNnPBOAoGcAMm1zfusVfZ/fULYFejQ0gtWaDv38evgK7S
         2iIg0qRxwr4/QqFeZgeLKq97LFUCALJS82hsl8aXUKd4M/TyFNThQAGFpN+gYEr1foY2
         kU5Vjiv1DyapqiUc1VZQP+s9ZdGhEwsQwXtDX+hR25dtPWB5dNjCzR8M/v/Fr3IMzFkx
         WWQcPFM4sZHrFOZe+tsExP87QJgaGs73IYqN6si25nCaELTbfvUalBnxvOuiICggMWj0
         WU+Ckio3NldKBsTI/Dfq9n8wDFG+cSX7c1T1z9V4gnVDb3YwlbPhhO55DREeOP+i6Yfh
         iD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xUPg+YXEDk81n5mlokfnR16Ccj10o2P2CyqFGLkvB4=;
        b=nadCpNLbaZKAcdCeXPE1c7eWkiHJD/07QX2Oc2o0m+vloaRInDevHOXQe8JkTISjj6
         KNuz1P2WUf6VlUQ3HHeh/gQmk/XOYpxOJWbMozNlQgpu1EIU9irJ1Po/8RSa+Fp/sbtP
         vQhZErgjhPdEDXf64YoHEMWGQPrqdcT8z8seR2gJHV9XlQ00BmOBPOxjaRx7bnk/Vmuz
         p9WJgpfKjDvYnwtXSUzWoWn3e3+wH7gq4FZwZNOT/K2OVxZ550lE5kHgWMcqiWhM9VL4
         BQjRoacCZKhJTsMcYqvD6+xFePB8zufTaTPLbWwhZPzlZi7dF7+MJZS1FnfXGpFnNjQU
         yK7w==
X-Gm-Message-State: APt69E0K4ZqhsQXOzw96oYi26pErPBsqIPT1B5daG/mIBtRI3vn1zm8M
        5WYTqPSIuNZ3AXXz/WXsZaw0Yg==
X-Google-Smtp-Source: ADUXVKJQ5ith/xiTj/15G+DbiepXtLlDLW7NefmewKc5SHmOkl0be8gduETOylOESBOJRXqk6Bl6dQ==
X-Received: by 2002:a62:5d48:: with SMTP id r69-v6mr4010136pfb.84.1528423887110;
        Thu, 07 Jun 2018 19:11:27 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j23-v6sm1847761pfh.45.2018.06.07.19.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 19:11:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fR6s9-0006Pj-9N; Thu, 07 Jun 2018 20:11:25 -0600
Date: Thu, 7 Jun 2018 20:11:25 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] IB/mad: Use IDR instead of per-port list
Message-ID: <20180608021125.GB19611@ziepe.ca>
References: <20180607190832.GA24370@bombadil.infradead.org>
 <20180607222646.GX14597@mellanox.com>
 <20180607234926.GA8260@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607234926.GA8260@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:49:26PM -0700, Matthew Wilcox wrote:
> On Thu, Jun 07, 2018 at 04:26:46PM -0600, Jason Gunthorpe wrote:
> > On Thu, Jun 07, 2018 at 12:08:32PM -0700, Matthew Wilcox wrote:
> > > 
> > > Hans reports a bug where the mlx4 driver uses the MSB of the agent number
> > > to store slave number, meaning we can only use agent numbers up to 2^24.
> > > Fix this by using an IDR to assign the agent numbers and also look up the
> > > agent when a MSD packet is received.
> > > 
> > > I've changed the locking substantially, so this may well have a
> > > performance issue.  There are a few different possibilities for fixing
> > > that, including moving to an RCU-based lookup.
> > 
> > I do like this better than the last series..
> > 
> > This are is somewhat performance sensitive and it would be nice to
> > avoid this global lock.
> 
> OK, I wasn't sure whether it was worth it.
> 
> > What about using a read/write spinlock instead of the IDR internal
> > lock? Then all the per-port reading threads calling find_mad_agent can
> > run concurrently..
> 
> It'd be better to switch to RCU ... the IDR is RCU-safe, but the
> version/class/method or OUI match isn't.  Do you have any feeling on
> the relative frequency of the two types of "routing"?

I would say they are close to equally important, perhaps the
version/class/method is slightly more important.

> Actually, I think we can use the radix tree data structure for the
> version/class/method too ... that's going to take a little more work.

I was wondering about that as well, this code is very old so there
must be better data structure helpers these days.

Jason
