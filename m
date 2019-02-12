Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33880C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C035F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549964881;
	bh=KGfDA30Md9i3+ZdnD2Il9rUsfH9AKkkqsZ9GNPgqEBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lNpAvJ1U3anYnx+c8QtXC6oUPkDZLT0xWLR1MWrOcKJCpJ79y6ZRTV6v+OwbB2LXA
	 ul/dsNZpwRE+C0Wf2IiOJgJC2703TjrObX/lRLUCeUzI/pD36Z8RjygQyPhUrVLfka
	 0le6UyKDyMJZitSyUGQyXQxZvJVsj2B+U0mssLdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfBLJr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfBLJr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:47:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328402082F;
        Tue, 12 Feb 2019 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549964877;
        bh=KGfDA30Md9i3+ZdnD2Il9rUsfH9AKkkqsZ9GNPgqEBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEQl9PeScNsXjEhSQssX0iVLzcMCp7LUALPS8tLb+3DL3apHat88slYdhU75+ENpe
         5Uwd8AO00tb3sTXuNsUxPbTbFFJLn8MXgmaqAZ5ntN0SRcosX8YlTJnJtFTft9GWcm
         aXJSN841iYsZG39mYqn5swTLRkLeE43WHs7oE4Nc=
Date:   Tue, 12 Feb 2019 10:47:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 018/352] ath9k: dynack: use authentication messages
 for late ack
Message-ID: <20190212094754.GA19627@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141847.541071852@linuxfoundation.org>
 <e3740a06-8735-eed3-b427-e924f3e185ae@ncentric.com>
 <20190211170252.GE21634@kroah.com>
 <b76468d1-13db-b4e6-beb1-097251f5627c@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76468d1-13db-b4e6-beb1-097251f5627c@ncentric.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:40:14AM +0100, Koen Vandeputte wrote:
> 
> On 11.02.19 18:02, Greg Kroah-Hartman wrote:
> > > 
> > > Dear Greg,
> > > 
> > > No idea if this is the proper location to report this or if I should inform
> > > stable@vger.. , but:
> > > 
> > > This backport alone is useless without backporting following 2 commits below
> > > also, unless the 2 wifi devices using dynack start off at very close
> > > distance.
> > > 
> > > Their commits messages indicate them as improvements, but they should be
> > > considered as fixes.
> > > 
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=0c60c490830a1a756c80f8de8d33d9c6359d4a36
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=9d3d65a91f027b8a9af5e63752d9b78cb10eb92d
> > > 
> > > 
> > > It's safe to add them to all stables involved (4.20, 4.19, 4.14, 4.9)
> > Thanks, that looks reasonable, now queued up.
> > 
> > greg k-h
> 
> 
> Hi Greg,
> 
> Just noticed the primary dynack patch also got merged into 4.4 stable rc
> 
> Could you also apply the 2 fixes above to 4.4?
> 
> 
> Checked older versions (< 4.4) .. and they are not required there.

The build breaks when the series in on 4.4, so I dropped the patches
from there, and 3.18.  If you want to send a backported series that
builds properly, I will be glad to queue that up.

thanks,

greg k-h
