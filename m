Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B8CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E880F2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198304;
	bh=K6kMvZB01NKiLOCkq1fK6WbXC08g4Mm45zKtI5lvSUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lT5UERIBCtKiHa70BnRBNOs/d0q8aeP+SULhQDuWA7PJBBrbpED6Ev3QttJZLsDKS
	 IVKQZZJ6SLsZb7N479Q9tvMUbHNZevLZXEmCbQQvdwkO/dumSD+MIfZDzARaFM+V3C
	 yp96IAbUxAGTr6EQ1tpgRyBtzX3eCK6Q/B+n0jOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfAKJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfAKJSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:18:22 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F80820872;
        Fri, 11 Jan 2019 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547198302;
        bh=K6kMvZB01NKiLOCkq1fK6WbXC08g4Mm45zKtI5lvSUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX1K90JopcSTjebTlG/2NywgDiU4mPnmknhkI42ckWSS3hm8msF2UALTuiDCh7LNg
         yOjEPP5gT0oOYQKa8HF4aM78NxK1igx5hyQaF+6Azv0+briALwRHI0XI13Qt1yJ2J4
         FIyibM1Hi7ZDotAFY6vAsR34lF1obE/xi2ePKPZM=
Date:   Fri, 11 Jan 2019 10:18:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com,
        dan.carpenter@oracle.com, joel@joelfernandes.org, maco@android.com,
        tkjos@google.com
Subject: Re: [PATCH v2 2/2] binderfs: reserve devices for initial mount
Message-ID: <20190111091818.GA17058@kroah.com>
References: <20190102113219.3716-1-christian@brauner.io>
 <20190102113219.3716-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102113219.3716-2-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 12:32:19PM +0100, Christian Brauner wrote:
> The binderfs instance in the initial ipc namespace will always have a
> reserve of 4 binder devices unless explicitly capped by specifying a lower
> value via the "max" mount option.
> This ensures when binder devices are removed (on accident or on purpose)
> they can always be recreated without risking that all minor numbers have
> already been used up.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> v2:
> - patch unchanged
> v1:
> - patch introduced
> v0:
> - patch not present
> ---
>  drivers/android/binderfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What did you make this patch against?  It doesn't apply cleanly so I
don't want to take it until we get everything synced up properly
together :(

I'll apply patch 1/2 now, can you rebase and resend this one?

thanks,

greg k-h
