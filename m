Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEBBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA572083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nj2aEaoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBKWyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:54:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfBKWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:54:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so266641pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nnjv+ROc7ciGZ5xFxjkSbI/QboRe6hPG4YjtEvpy/NE=;
        b=nj2aEaoW6CV4dj7N/6ZjXb/iKW8uostTzcE2RJ7/dU28IxKQM0gsJiKq5yyLrtJccq
         tFHOlbx+DBFlEIqVzzEoZ3BpR0DS4D6JClryC8gcvfeXkmnAzc6trASgatfSpRtzBPKx
         XHVwh/d+DXn6bWJekIyggMOq43FhS2oa6VyKjcsi5dvSUU6VEdJ5ASrlnT8Tmikftc5b
         uQX4mGpcXUmDnN1OqLRNLFvtepie6LyvV5ACs+iePwcnbMdDi68KDl3mHdpGNMh4VNUj
         NoVYrB4vF+v9jVKRtPTgAFLZxm55YNqmGmKwpvTZsmD/99r5AYCgAPzRpYq23mlwAQXa
         UZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nnjv+ROc7ciGZ5xFxjkSbI/QboRe6hPG4YjtEvpy/NE=;
        b=hlqM0lAi7xW9QlKDsr8Y1oTRFL53V6grjTKnnwFBHwqkeRVjQn09kGTZ+AaI6vQBxr
         ohBMg1zPd6uvLgZ4caCuzhR77WX+iFH9o4liXhH7sF8pR+fSxyKjV6paYa/JUiXsFPLx
         jIKj4CT7FgjmIzddluVzWWS1ZlkrDazP9lj7TaXPc134dBFe0oGQpcDpLrMsL2WQ7orh
         dHvtkri96ISUl95fPGVSUlXyF024tJuniiofaR0XNGSYq8yt/fjTF3sf7uiwwqBhkT/B
         NkfxsXDGVoOsOLaN9CL4C744vtfpOTK/H/9Xd3uwgmvJb9o2//MzyW2qpfaORm7DU0f6
         MC+w==
X-Gm-Message-State: AHQUAuableu9m7lQ0guO87sgOrhtvMZny//oat4rdRKNnuTOfXXhEPxU
        2yy865vaZp27jCNnCLIQGquSAQ==
X-Google-Smtp-Source: AHgI3Iay4O9bB9n/pGpyk1kN1tV8bWoIAGTYBHJeUZ6apBJpCJJ/V04jDSGkM/rSMYCK63GYv00hlg==
X-Received: by 2002:a63:4658:: with SMTP id v24mr635737pgk.114.1549925689039;
        Mon, 11 Feb 2019 14:54:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t3sm2392772pga.31.2019.02.11.14.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:54:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtKTP-0003RY-Pa; Mon, 11 Feb 2019 15:54:47 -0700
Date:   Mon, 11 Feb 2019 15:54:47 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190211225447.GN24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> Hi,
> 
> This series converts users that account pinned pages with locked_vm to
> account with pinned_vm instead, pinned_vm being the correct counter to
> use.  It's based on a similar patch I posted recently[0].
> 
> The patches are based on rdma/for-next to build on Davidlohr Bueso's
> recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
> sense for these to be routed the same way, despite lack of rdma content?

Oy.. I'd be willing to accumulate a branch with acks to send to Linus
*separately* from RDMA to Linus, but this is very abnormal.

Better to wait a few weeks for -rc1 and send patches through the
subsystem trees.

> All five of these places, and probably some of Davidlohr's conversions,
> probably want to be collapsed into a common helper in the core mm for
> accounting pinned pages.  I tried, and there are several details that
> likely need discussion, so this can be done as a follow-on.

I've wondered the same..

Jason
