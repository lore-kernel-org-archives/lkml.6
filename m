Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5AFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB9A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeHQBB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:01:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33913 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHQBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:01:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so2729597plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9AkNs0FkR1w/3GFu1Vzzpy+TZydMmyeI+LasrmjPfc=;
        b=NTAvmeUMdwX+hrmkJIVD7wsYEHC3Rr44BFhu7aDbXGtA8ujJVr6xscVP0crPt12n7o
         ZTGZo0ZD5YiWmRZITwxsnZ26SV3KnSZG0XztlIGJzr/iwi5lFUd7lf5H4B8o0/N7+72f
         CKO6GDQcGdiFJkfq2gNs9eCOpb5CiDhCwPCM9ut7M+jHIjLxH6XKzNunbJxsQRzhMPIK
         r/9+HTO+7AtPgdtvkD6iDeeWYiLG/msBvxEqnW3D8V72v6BFr35yhAfO4TTS2CoqKmsR
         wUz3fXXclEzOyDtaT/8YNuoGB7heBIot1Dft3VzRlU2Y4L59Xr4EwNsIrCcOFnakshhG
         7amQ==
X-Gm-Message-State: AOUpUlEYpWRqKTDSYA+oy7ujOM3UM3bvKEOAGUTScxZAPnplBtVTb6bZ
        yhYnZBwoIs2ksyR0LzLwtTtW3A==
X-Google-Smtp-Source: AA+uWPyM2x8smU9jQhf9OiEfn6L5xXsAcMYK7UVzKCsT8H7kcaAf4qdBD1YQQOBH4S15pd0QzzzNRQ==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr30294114plb.172.1534456837215;
        Thu, 16 Aug 2018 15:00:37 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id 64-v6sm358841pfi.89.2018.08.16.15.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 15:00:36 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:00:34 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Message-ID: <20180816220034.GA4431@archbook>
References: <20180815220958.3606-1-atull@kernel.org>
 <20180816185952.GA3932@archbook>
 <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
 <1841468.1pWPcT6Du7@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1841468.1pWPcT6Du7@harkonnen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Federico,

On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:
> Hi,
> 
> On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> > On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > > Hi Alan,
> > 
> > Hi Moritz,
> > 
> > > comments inline. While I see how this is useful, I have the
> > > suspicion that from the moment this gets merged vendor kernels
> > > will just default to use this ...
> > 
> > Yeah, I have that suspicion as well.  That's probably why I sat on
> > this and didn't upstream it for 2 years.  But on the other hand, I
> > keep hearing of lots of cases of people implementing this
> > independently anyway.  At least if it is debugfs, it makes it clear
> > that it's not intended for production use.
> 
> I'm one of those guys who implemented this independently.

We all have in one way or another ;) Most people on ARM run an out of tree
patch using devicetree overlays these days I hope rather than /dev/mem
and UIO ... or other vender solutions...
> 
> @Mortiz
> I do not see how this can be a bad thing (from what you wrote I guess you 
> prefer another interface). Which interface to use depends on the use case.
> If you have this suspicion it's, I guess, because such interface it is 
> extremely easy to use.

What happens to a kernel driver doing MMIO with devices while you reload
the entire FPGA from userland?
> 
> @Alan
> DebugFS can be a first step, but I would go for a normal device in /dev at 
> some point. I do not see why this should not be used in production

I'm not against having a userland interface to reprogram the FPGA, the 
Intel DFL code is a good example of a sensible one, doing so in a safe
manner.

Ideally we'll get around to have a more generic interface, as we get
time to work on it.

- Moritz
