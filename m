Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA92C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A3E20818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="cMOyS7Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBDWHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:07:01 -0500
Received: from tomli.me ([153.92.126.73]:47502 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfBDWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:07:01 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 7cf5e88a;
        Mon, 4 Feb 2019 22:06:58 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b75:4650)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Feb 2019 22:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=m4XIWugY4pGr1Q6Xf78MAuSQYItIOVhtGyJ8P3u6fNo=; b=cMOyS7Jmi0T+PK/eEpV6vl1MXDimmm3F/qZgk7GLnVpEWpFA6o4Eac/mXnrRtkhC+960jkCf3LV1G7b1hYzTXmPg7+M51B9bU6298TvAq57Lw8ypJfPYFFgxwWzMFXf0s9Tql1DSz/ZlEwgKFW38kN6lp2yHp7cOFBTs8OL6SeP9dsKhGv9S55biST6cpKqI+OCYtOs6yDJ5BK23aC8Ct4liZyfoiswXFWlT4EYckkcYsy6KDDJ0Bh+FWrOHN+dtR9+f+Qm0qabvtO68BEBtfFe4w1mB+rUIIDF/vBqxiD9fp3nhEf6NXttqhxXQC9cqWVWFTxi39//N7UQdZg0eEw==
Date:   Tue, 5 Feb 2019 06:06:50 +0800
From:   Tom Li <tomli@tomli.me>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/
 cleanups.
Message-ID: <20190204220650.GA24673@localhost.localdomain>
References: <20190202061648.30374-1-tomli@tomli.me>
 <20190204092618.GM3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204092618.GM3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since you care about this driver, considered converting it to a drm
> display driver? You can still have all the acceleration and stuff, the
> fbdev compat mode in drm is rather flexible.
> -Daniel

Yes, I know fbdev is now in maintenance-only mode, reimplementing it
on top of DRM is on my roadmap, including rewriting a saner version
of the modesetting code. The current version is beyond repair. I'll
start working on it once I managed to purchase the hardware for testing.

But currently my objectively is to have something usable during the
transitional period. The major user of the chipset was Yeeloong 8089D
laptop - a choice for many non-x86 and MIPS hobbyists for experimentation.
Getting the current version of the patch merged would solve the immediate
usability issues, and then trying to get some platform drivers merged.
And after completing the preliminary upstreaming process, since then,
can start working on a DRM version of the driver, and possibly eventually
remove the fbdev version of sm712fb entirely. 

The 2D acceleration implementation is strictly no more than 200 lines,
the vast majority of the code insertions are comments and documentation
changes ranting about the known issues of the driver/hardware, nothing
non-trivial is added and I think the changeset is manageable and would
not be a burden for the fbdev maintainers, and I can grarantee that I will
not add any other new features to this driver.

Cheers,
Tom Li
