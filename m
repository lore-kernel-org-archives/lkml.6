Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585192146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsDniAuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585192146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDH2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeLDH2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:28:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E6220834;
        Tue,  4 Dec 2018 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543908516;
        bh=INJvMSa6sHkJKdw0qQZqN4OYGLvQiuQwF1fNpe7xD1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsDniAuNZA0LHbHDNHLS9OPvN8bxgV6iyCjm+mYKH9oodS/sUbkAj/1Z2Tf3vFFYz
         IWt3gOxS06aPaMCCQUyz+62H5T1aBYa4sMHCLRTM7ZMqxySG/UPWLp6cw1bWLm8QVt
         k+lrHsRJ+sQ5wi44978UR82uyltf8mik/SusItNE=
Date:   Tue, 4 Dec 2018 08:28:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Dave Chinner <david@fromorbit.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181204072833.GB25998@kroah.com>
References: <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <20181202232302.GT19305@dastard>
 <20181203092241.GC235790@sasha-vm>
 <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:22:46PM +0159, Thomas Backlund wrote:
> Den 2018-12-03 kl. 11:22, skrev Sasha Levin:
> 
> > 
> > This is a case where theory collides with the real world. Yes, our QA is
> > lacking, but we don't have the option of not doing the current process.
> > If we stop backporting until a future data where our QA problem is
> > solved we'll end up with what we had before: users stuck on ancient
> > kernels without a way to upgrade.
> > 
> 
> Sorry, but you seem to be living in a different "real world"...
> 
> People stay on "ancient kernels" that "just works" instead of updating
> to a newer one that "hopefully/maybe/... works"

That's not good as those "ancient kernels" really just are "kernels with
lots of known security bugs".

It's your systems, I can't tell you what to do, but I will tell you that
running older, unfixed kernels, is a known liability.

Good luck!

greg k-h
