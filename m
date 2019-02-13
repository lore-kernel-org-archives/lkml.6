Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2C222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550049488;
	bh=OBwtMif6U+gAaRqAxV3AgL7zafK6ORpn+3ToEs1jewg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iyNb66JBXOSEa0AEhWLzMMEZX13p+KxJUuz8Pqy0emauw7hg84M7XoHRqvF5KJPHp
	 uPVhv3hlQz4lZ7RL0m/fxlT6IsEWYsukLFWov2AX1CEfKjn2Q+2NI4am5iee8vhJc8
	 5SvOMX0AIUs0GkuguA/PeRdQN9HKuRL4lZjSoWPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfBMJSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfBMJSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:18:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286E8222BE;
        Wed, 13 Feb 2019 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550049485;
        bh=OBwtMif6U+gAaRqAxV3AgL7zafK6ORpn+3ToEs1jewg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJBR3p8UeaFYq4Y9hKmUYhWwNBpI/rhmNsqsWY5DyLtM70GEH2zsy934/UJrWt0UQ
         YlRgwty3vJMnXJEYcGPMOCe90hxSs6XnD2eriPsByXASy9gNMWSFhdXkTRVXQc8CVi
         P6OKqoUYaAOb5ywdBMwvzWG5uev3p2PZSm37lpAE=
Date:   Wed, 13 Feb 2019 10:18:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Steve French <smfrench@gmail.com>, Sasha Levin <sashal@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190213091803.GA2308@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein wrote:
> I think the main difference between these review announcements
> and true CI is what kind of guaranty you get for a release candidate
> from NOT getting a test failure response, which is one of the main
> reasons that where holding back xfs stable fixes for so long.

That's not true, I know to wait for some responses before doing a
release of these kernels.

> Best effort testing in timely manner is good, but a good way to
> improve confidence in stable kernel releases is a publicly
> available list of tests that the release went through.

We have that, you aren't noticing them...

> Do you have any such list of tests that you *know* are being run,
> that you (or Sasha) run yourself or that you actively wait on an
> ACK from a group before a release?

Yes, look at the responses to those messages from Guenter, Shuah, Jon,
kernel.ci, Red Hat testing, the Linaro testing teams, and a few other
testers that come and go over time.  Those list out all of the tests
that are being run, and the results of those tests.

I also get a number of private responses from different build systems
from companies that don't want to post in public, which is fine, I
understand the issues involved with that.

I would argue that the stable releases are better tested than Linus's
releases for that reason alone :)

thanks,

greg k-h
