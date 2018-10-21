Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22706ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC44120843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHYC7tIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC44120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJURG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeJURG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:06:58 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED75120843;
        Sun, 21 Oct 2018 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540112002;
        bh=eKCpRUlbOsYNp1tBm3RcOltn8uWM+b3PnkRDty4uu8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHYC7tIovepANi/Wzw7DphmY9BlIn2VH7Bo5RTYSbufwXqsfeMkCaFOIQK6IuKlBz
         OcwcGiJ0wPw1tipwdfUGNBoIcKwWF1Aq+86+0iTGue3cPB46zgHpLebdIzu/SfUYNN
         W4rrLlnwmG9lQ9NFDMXc+9UW+HFDDy9H5T6EzA+A=
Date:   Sun, 21 Oct 2018 10:53:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20181021085320.GA25337@kroah.com>
References: <20181020.154737.106692150032143674.davem@davemloft.net>
 <20181020.222645.1496129473806890473.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020.222645.1496129473806890473.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 10:26:45PM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Sat, 20 Oct 2018 15:47:37 -0700 (PDT)
> 
> > 
> > A few straggler bug fixes:
> > 
> > 1) Fix indexing of multi-pass dumps of ipv6 addresses, from David
> >    Ahern.
> > 
> > 2) Revert RCU locking change for bonding netpoll, causes worse problems
> >    than it solves.
> > 
> > 3) pskb_trim_rcsum_slow() doesn't handle odd trim offsets, resulting in
> >    erroneous bad hw checksum triggers with CHECKSUM_COMPLETE devices.
> >    From Dimitris Michailidis.
> > 
> > Please pull, thanks a lot!
> 
> Great, I appended one more bug fix to this pull request, a revert to
> some neighbour code changes that adjust notifications in a way that
> confuses some apps.

Now merged, thanks.

greg k-h
