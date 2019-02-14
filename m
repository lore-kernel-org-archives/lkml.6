Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9D222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550137331;
	bh=3y3cokQQMIouqGIaVg2qeuXpZAD3dMQo0WkuCPlzX0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jx0+WtbqMtNpm3YPFU08nJS1X3C1DvqHj4YLKv50FiqnR+dNaL7fVh8UJFgaRdqrP
	 kJsXaYs5GToOe028sRUDwJ/qL2VdVM+SK0OeuttUkfhbTkNAKqP3K4ZVayLE1rWpSD
	 aNX2Cc/pyaR1Q0hpxTHN0ry6S8ZqUZ5hJomfZkoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392762AbfBNJmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfBNJmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:42:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E283222A4;
        Thu, 14 Feb 2019 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550137329;
        bh=3y3cokQQMIouqGIaVg2qeuXpZAD3dMQo0WkuCPlzX0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=070Y2BjLfDaEe+eK3vshODuDxRgEKb2z7LwQFFpW4DdE1B7geG7g75wUBfKam1V7p
         cmpVBtiusERBSC+EJhmF/sYuSXtf6GWGymtuMUPIT6Nwuz0N2QCZ/PxIfrelrFkjjH
         oate21sgBlVokrm5SwtaUIvHuzIlLYgZCTPdUYOQ=
Date:   Thu, 14 Feb 2019 10:42:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cyril Chemparathy <cyrilc@xilinx.com>
Subject: Re: [PATCH 1/1] staging: android: ion: Add the GPL exception for
 syscalls
Message-ID: <20190214094206.GB10895@kroah.com>
References: <1550102506-24731-1-git-send-email-hyun.kwon@xilinx.com>
 <1550102506-24731-2-git-send-email-hyun.kwon@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550102506-24731-2-git-send-email-hyun.kwon@xilinx.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:01:46PM -0800, Hyun Kwon wrote:
> Add "WITH Linux-syscall-note" to the license to not put GPL
> restrictions on user space programs using this header.
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> ---
>  drivers/staging/android/uapi/ion.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
> index 5d70098..46c93fc 100644
> --- a/drivers/staging/android/uapi/ion.h
> +++ b/drivers/staging/android/uapi/ion.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * drivers/staging/android/uapi/ion.h
>   *
> -- 
> 2.7.4
> 

Yes, that is the correct thing to do, let me go queue this up.

thanks,

greg k-h
