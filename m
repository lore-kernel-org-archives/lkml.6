Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5543EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A942098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Y4mocX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A942098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJKBro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKBro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:47:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8D72075B;
        Wed, 10 Oct 2018 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195864;
        bh=Ta5FjgYy9lJ+XRAA3FMtz1oKdLxGRvcj+hpen2w28yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/Y4mocX1wVHKBbALQixHwQBIvGhnk956eV9/8KZXqlIrv5dKC2uo6DoYnB2GYPf+
         3d6xGFrkmUyUigS0Bm7nJLRgYSyxI0alTFFnwjJUQIbHWhbLBsA5ZmzuOLX+AMDTmL
         1cjt5bufDHI4c1k2TUV9litA/SIhzWbcVv/RTPNw=
Date:   Wed, 10 Oct 2018 20:24:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, aszlig@nix.build, torvalds@linux-foundation.org,
        w@1wt.eu, Daniel Zatovic <daniel.zatovic@gmail.com>
Subject: Re: [PATCH v2 0/2] tty: erase buffers when the kernel is done with
 it.
Message-ID: <20181010182421.GA23517@kroah.com>
References: <20181004180614.25619-1-gregkh@linuxfoundation.org>
 <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 08:20:06PM +0200, Milan Broz wrote:
> On 04/10/2018 20:06, Greg Kroah-Hartman wrote:
> > azlig and Milan Broz reported that when the tty layer is done with a
> > buffer, the data can hang around in it for a very long time.  That
> > sometimes can "leak" to userspace under some conditions.
> > 
> > Because of this, just zero out the data after the tty layer is finished
> > with it, for buffers that we "think" should be zeroed out.
> > 
> > v2 - addressed some review comments on the 2/2 patch.
> 
> Hello Greg,
> 
> together with our intern we re-tested both patches and it fixes the reported problem,
> so, if it helps anything, you can add
> 
> Tested-by: Milan Broz <gmazyland@gmail.com>
> Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>
> 
> Do you plan to add this to linux-next?

Yes, I'll queue it up soon, thanks for testing!

greg k-h
