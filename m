Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643582146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011788;
	bh=x44jvinm/iPyI8L/0oRCEBzaQ2avcIpJ3kSCgZhyXkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PGXc4rDIIoi2qelxOp1tuQZHrQ+FFSLUwnJua6A6WtQdO7FcarK8cVGaNjEx1tEZZ
	 NEgyWBW8o0yKXOlhB1UJTN8U9gHT7B3XvaGrHqMC1TUgGY05KYxq9/0Im8/bp8Gswv
	 5VJ5fUe2hF3DjKqmL3XYgjh703CA6PGieU5nd8Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeL1PnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbeL1PnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:43:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55FD20879;
        Fri, 28 Dec 2018 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011786;
        bh=x44jvinm/iPyI8L/0oRCEBzaQ2avcIpJ3kSCgZhyXkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTKtLNwhdmroK3ID2/3Moy5cUERErJkWnxXaj3o/x2x18+6UafyhlrsCONRUa8L9U
         6WITNyAgrfdnbsusfZRPYJjDxoRZBLuCG60Y8dYusCE7FupCWGWqyE0kN4Hui0sUHD
         exnui77DBsrFfjXQPGB+RQZu6g/a+IpHFeCEH8m0=
Date:   Fri, 28 Dec 2018 16:43:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Driver core patches for 4.21-rc1
Message-ID: <20181228154303.GA24860@kroah.com>
References: <20181228153609.GA23789@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228153609.GA23789@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:36:09PM +0100, Greg KH wrote:
> The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:
> 
>   Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.21-rc1
> 
> for you to fetch changes up to 16df1456aa858a86f398dbc7d27649eb6662b0cc:
> 
>   mm, memory_hotplug: update a comment in unregister_memory() (2018-12-20 16:33:18 +0100)

There's a merge conflict in here as well, in drivers/base/platform.c.
The resolution should be pretty straightfoward, keep this line:
looking something like this:

diff --cc drivers/base/platform.c
index 0fb5f140f1b0,e1ba610482c0..000000000000
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@@ -447,7 -447,8 +447,7 @@@ void platform_device_del(struct platfor
  {
  	int i;
  
- 	if (pdev) {
+ 	if (!IS_ERR_OR_NULL(pdev)) {
 -		device_remove_properties(&pdev->dev);
  		device_del(&pdev->dev);
  
  		if (pdev->id_auto) {


thanks,

greg k-h
