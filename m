Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC25C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5582184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550453796;
	bh=0GxfKPj4pEmfC3cXYWHjeK7KcnZGhnQZKBn15z/Rj58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aS5eg+oKbwZ3qywzG7s5yQcHe9d5jR0Twadyxd1ckFHV0Wkvq+ikEISIhIJ4p6zNp
	 OREfk9P52WJcZnH3RJ8jzJcAnr01QAHjQf8y2pcQGNSCxsDP//v0PhBJtHFpHU76ZB
	 aD4EKTeoMCVaW1ZLaEf3cxlhDJWnBlcT4YHSeQ4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfBRBgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfBRBge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:36:34 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35472184E;
        Mon, 18 Feb 2019 01:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550453793;
        bh=0GxfKPj4pEmfC3cXYWHjeK7KcnZGhnQZKBn15z/Rj58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gltCXkcyaUmfoJBO5YT2N2/7/GWd1EhzJG03FpsXY7eM4iwuWkDxqQLxl57HZ10X
         yRNy2lTrqKQ4WJLtZbcUGfYqfTz/ihKzyp18El/b9eoT3MOhzgqK3gPoijHSY9hbNG
         DzJLwdHIGaesKuPn/Pm/zpX4oEc3zpN9E5xdnm38=
Date:   Sun, 17 Feb 2019 20:36:32 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Rustad <mrustad@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [RFC PATCH 4.4] Documentation/network: reword kernel version
 reference
Message-ID: <20190218013632.GQ10616@sasha-vm>
References: <20190215161955.12119.77812.stgit@mdr-mbp.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215161955.12119.77812.stgit@mdr-mbp.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:19:55AM -0800, Mark Rustad wrote:
>It seemed odd to say "since 4.17" in a 4.4 kernel. Consider
>rewording the reference to indicate where in the stable series
>it was introduced as well as where it originated.
>
>Signed-off-by: Mark Rustad <mrustad@gmail.com>
>
>---
>
>Does this brief elaboration add useful information? It seems to
>me that someone using a particular series of stable kernels would
>find this information to be helpful or at least potentially less
>confusing to a non-developer.
>---
> Documentation/networking/ip-sysctl.txt |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
>index 7c229f59016f..2fb35658d151 100644
>--- a/Documentation/networking/ip-sysctl.txt
>+++ b/Documentation/networking/ip-sysctl.txt
>@@ -116,7 +116,7 @@ ipfrag_high_thresh - LONG INTEGER
> 	Maximum memory used to reassemble IP fragments.
>
> ipfrag_low_thresh - LONG INTEGER
>-	(Obsolete since linux-4.17)
>+	(Obsolete since linux-4.4.174, backported from linux-4.17)
> 	Maximum memory used to reassemble IP fragments before the kernel
> 	begins to remove incomplete fragment queues to free up resources.
> 	The kernel still accepts new fragments for defragmentation.

Admittingly the stabke kernel rules do not allow documentation fixes,
but I can see how this can be confusing, and the fact that someone
actually hit it, wrote a patch and submitted it makes me want to ignore
that rule.

Queued, thank you!

--
Thanks,
Sasha
