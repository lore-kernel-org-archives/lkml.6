Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9890C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED9920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725576;
	bh=wQcJbbzDehn3t4lSTi/uSgaHCnpmLLsEu/tQlw29y4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YsfASATW1m5hwHhsIOTt2y4YsPN8nalVto+d2QWprzil2azWTU3BxXjidBX+A6h4M
	 2CWurxaKDXee5iQJ5cMendZjwtEEY8knUyMlBTIJ1WoaALKFaTWr3/0OoGIfg0MgAt
	 37hDZvFhK6V3D9tFKB0rdlvnEeJ7x2iSrrOHSHS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfAQLqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfAQLqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:46:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2088520657;
        Thu, 17 Jan 2019 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725573;
        bh=wQcJbbzDehn3t4lSTi/uSgaHCnpmLLsEu/tQlw29y4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvGqybcpSt/eLZpDFQ3LB28sbSVbKTWCL09vYwIx6xNsqsjdpy0dqpP2g9NfYzjly
         HfFui0KpZ5AA3/EV6ZII1/IkY9HoPc+sFQHVo9bWbGvkmpolwpKRgRIxAFblDLpPNt
         bOS1qv4T1NfpLuLjTdncy9NP4aPkAjrD8wPFcC0s=
Date:   Thu, 17 Jan 2019 12:46:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert O'Callahan <robert@ocallahan.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression in 32-bit-compat TIOCGPTPEER ioctl due to
 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
Message-ID: <20190117114610.GB2430@kroah.com>
References: <CAOp6jLa8rRw2ZQN9yWYZv_USrZw98D+U2rnk9V7M2EVY7O=VpQ@mail.gmail.com>
 <87won67580.fsf@xmission.com>
 <CAOp6jLaGei=ALRuRaQxtD2VK_vY_ViAupgcmdouuzgwUCjC0BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOp6jLaGei=ALRuRaQxtD2VK_vY_ViAupgcmdouuzgwUCjC0BQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:36:49AM +1300, Robert O'Callahan wrote:
> On Tue, Jan 15, 2019 at 8:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Can you confirm this fixes it for you?
> 
> Sorry --- I made a mistake. It looks like this is already fixed on
> master, by commit e21120383f2dce32312f63ffca145ff8a87d41f5 (though I
> don't think Al Viro knew he was fixing this bug). So, nothing to do
> here.

As you found a regression from 4.13 - 4.19, shouldn't we backport some
fix to the 4.14 and 4.19 kernels for this?

thanks,

greg k-h
