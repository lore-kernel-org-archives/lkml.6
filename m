Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DAFECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81A2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE81A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeITM65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:58:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeITM65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:58:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB397D6E;
        Thu, 20 Sep 2018 07:16:55 +0000 (UTC)
Date:   Thu, 20 Sep 2018 09:16:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] kgdboc: Fix warning with module build
Message-ID: <20180920071652.GA12843@kroah.com>
References: <20180919131208.07aa9c6b@canb.auug.org.au>
 <20180920015901.4639-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920015901.4639-1-labbott@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 06:59:01PM -0700, Laura Abbott wrote:
> 
> After 2dd453168643 ("kgdboc: Fix restrict error"), kgdboc_option_setup is
> now only used when built in, resulting in a warning when compiled as a
> module:
> 
> drivers/tty/serial/kgdboc.c:134:12: warning: 'kgdboc_option_setup' defined but not used [-Wunused-function]
>  static int kgdboc_option_setup(char *opt)
>             ^~~~~~~~~~~~~~~~~~~
> 
> Move the function under the appropriate ifdef for builtin only.
> 
> Fixes: 2dd453168643 ("kgdboc: Fix restrict error")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/tty/serial/kgdboc.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)

You forgot a reported-by: tag :(

I'll go fix it up, thanks for the patch resolving this.

greg k-h
