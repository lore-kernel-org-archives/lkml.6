Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E27218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549481176;
	bh=GQAw4Gil6x0pLL207odqJVZGoRNvjnxgBfHvcEH3BEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ckkR8f9rH+cxZkZLs4fzHvzPYb+OTf/Rbunec7PuM2CIv36Ia/Kp9Cbqdvi9Z2IlX
	 12ELV2f6XlDRNtgos9aa+dfz29xCtFZgffHAPX/g300X2pB6k6msbew1Yr5amgESYb
	 GpunUlIrw4Iafqrp6ECpIi5Jtn/w1MBRJl9hHx98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfBFT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfBFT0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:26:14 -0500
Received: from localhost (unknown [131.107.174.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD432083B;
        Wed,  6 Feb 2019 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549481174;
        bh=GQAw4Gil6x0pLL207odqJVZGoRNvjnxgBfHvcEH3BEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUmF8qxIpkccO71U4/dvXp+D2JBBKUbA8xvLeI6tcmCLyW5JyPeAaa22P/DLQY10z
         ayGjXmS35YqwUIAzVchY+PzIfwskiLz6PLvhNps+Tma8gbnd93JuLNwWFqVs6BUWsk
         gmhKCd/jvMeT9TXmViW7oLZibwf4TsjsbfDxVqEI=
Date:   Wed, 6 Feb 2019 14:26:13 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: 4.14 "random: add a config option to trust the CPU's hwrng"
Message-ID: <20190206192613.GB4119@sasha-vm>
References: <b6532199f855e48fa53b8c3725a2eb93f949b32a.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b6532199f855e48fa53b8c3725a2eb93f949b32a.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:44:36AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
>Hi stable maintainers,
>
>Can you consider including these "random" patches in 4.14.y?
>
>These are very useful in fixing esp. first-bootup delays of VMs due to
>entropy starvation.
>
>
>commit 39a8883a2b989d1d21bd8dd99f5557f0c5e89694
>Author: Theodore Ts'o <tytso@mit.edu>
>Date:   Tue Jul 17 18:24:27 2018 -0400
>
>    random: add a config option to trust the CPU's hwrng
>
>commit 9b25436662d5fb4c66eb527ead53cab15f596ee0
>Author: Kees Cook <keescook@chromium.org>
>Date:   Mon Aug 27 14:51:54 2018 -0700
>
>    random: make CPU trust a boot parameter

This really looks like a new feature to me. The "old" behaviour of not
trusting RDRAND-like randomness was by-design rather than an oversight.

--
Thanks,
Sasha
