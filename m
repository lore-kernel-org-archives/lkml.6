Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6137C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87532218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548432382;
	bh=qZ87svk+Jt2tvcvB1Bc5Ocp/YHcnCScZfvJ8AKWSZxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkQPzZp6DzJNnhyVHuRW88sE3xwRSpuuLF+qh0f8QvtocVUoPYFkuw58kqyF/X5YI
	 H2n2lSsp0NUX07t2omdmOM/3punup0pWG/MSSgcJorXH03fzSeZ8ksKt31L22j55DW
	 xBfKcPVQ4hx/lFEoe0EBEGPbMkMpjmljLGV7DZYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAYQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfAYQGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:06:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A14218CD;
        Fri, 25 Jan 2019 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548432379;
        bh=qZ87svk+Jt2tvcvB1Bc5Ocp/YHcnCScZfvJ8AKWSZxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xS3ca+eZTSuILC+jiiWUsrPdvQygqKoSiQZx792mjSpHX5cLbJQhHLc56nBC957Qi
         NInhHi6ZF8f6YMjwjZCuo3Emquam+tB24jMnYpkj7IbZRbnoXLsQ5MYKNAawt0bnuI
         qZRobglKuZBF6k82qCo5nxJrEsxKwH30fghr4htU=
Date:   Fri, 25 Jan 2019 17:06:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
Message-ID: <20190125160617.GB14934@kroah.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <20190125073745.GD11891@kroah.com>
 <CAOesGMgJUeUMoRXZ98=J8bpfCuZOOMo5pwpVXZX-o-y1dAQsHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMgJUeUMoRXZ98=J8bpfCuZOOMo5pwpVXZX-o-y1dAQsHA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:33:23AM -0800, Olof Johansson wrote:
> On Thu, Jan 24, 2019 at 11:37 PM Greg Kroah-Hartman
> > As for what directory the code should live in, I suggested "misc" as
> > there was no other universal location, and I hate to see new subsystems
> > be created with only one driver, as that's pretty sad.  But it's just a
> > name/location, I have no dog in the fight, so I really don't care where
> > it ends up in the tree, just as long as it gets merged somewhere :)
> 
> I'm usually one to push back against new subsystems too, especially
> when I see a framework proposal with just one driver. In this case,
> given that we all know more vendors will come along, I think it makes
> sense to take the discussion and establish structure now. This should
> give some clarity to those who are out there that we haven't seen yet,
> and give them a chance to prepare for things such as the low-level
> userspace pieces mentioned above.
> 
> So I think setting this up now is the right thing to do, we know there
> will be more material here and having a common aggregation of it makes
> sense.

Ok, how about:
	drivers/deep_thought/

as a first proposal.

Let the bikeshedding begin!  :)

greg k-h
