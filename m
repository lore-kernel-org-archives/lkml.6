Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6796021783
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545621299;
	bh=NT18uud4vPpXvXRj/ljTuCF+Z9tugP25r7m2kDp85Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q0nk3eg4QwD7dJx9G6Mg932yjM+BdBZV0Ku2y0qzHgY6HYcrF1G7b1+g34fVFp+sT
	 AAeLdcdVguw7uSx0kgfdEzS+k7Tsa0zZLywbu8JVyq3mMVkx39n5zcM1VTA6m9/lGZ
	 F7U+RokINNFOchLrPbZREonAhoKwDKTlDjaVionE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeLXDOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 22:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLXDOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 22:14:22 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D98821783;
        Mon, 24 Dec 2018 03:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545621261;
        bh=NT18uud4vPpXvXRj/ljTuCF+Z9tugP25r7m2kDp85Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A97abQu3Sh62ltfDiqrc+y70tPY6ngsVIpAwUZs0K/l6Tf4dEo5IxNdxfS2FxSSQc
         tHazavPYGotZFuB0hny8h7Wh+Ff6ftHNIpKrln+dPLbBzILQB1nYRG4oVmL5DQ4nn/
         aKoanLG8eZujCZ5SqaSB23eq5o6x2av94Y8bxNLY=
Date:   Sun, 23 Dec 2018 22:14:20 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH 1/1] x86/hyper-v: Fix 'set but not used' warnings
Message-ID: <20181224031420.GR86645@sasha-vm>
References: <1545437169-18069-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1545437169-18069-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:06:58AM +0000, Michael Kelley wrote:
>In these two cases, a value returned by rdmsr() or rdmsrl()
>is ignored. Indicate that ignoring the value is intentional, so
>that with the W=1 compilation option no warning is generated.
>
>Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Queued up, thank you.

--
Thanks,
Sasha
