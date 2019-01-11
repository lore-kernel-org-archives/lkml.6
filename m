Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA90420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198220;
	bh=DILr1OjvuT0N0FnLKVKVc16rekM5XiRaZTRdLuhw9yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q4BVaZVsGqrkI26Hzq5fUQsiQYYVzKs20vZNfChaNexqQnCTSyQcQbTMrFHxMvllt
	 3bOojo1Qgsw/7w3tZI26sncLqIyHYcHT23M/sB1vsIdq1lJYT4wIfpUCUHr622MKmj
	 oHOVnfyZIlA4qXxxXa5ekfxjugyWOW1aJPthQf5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfAKJQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbfAKJQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:16:59 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6B020870;
        Fri, 11 Jan 2019 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547198218;
        bh=DILr1OjvuT0N0FnLKVKVc16rekM5XiRaZTRdLuhw9yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxuNd4Z3Ejynv+YS/8mc3CBcCu6AIJ2+efVaT44wnQgpB+XtjEcedRV8GRQdUmZvT
         w9WVX4O0jr4esjWEr/xjEKECA4uXTVG3wq6JuWBXsBy25pqBKAFehUkZuior/sTPad
         eqsUSUyczGqK2O7bMyLh6TzqhmwATXQlnhZTEMPY=
Date:   Fri, 11 Jan 2019 10:16:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: create node flag to request sender's security
 context
Message-ID: <20190111091655.GA16774@kroah.com>
References: <20190110182100.186199-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110182100.186199-1-tkjos@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:21:00AM -0800, Todd Kjos wrote:
> To allow servers to verify client identity, allow a node
> flag to be set that causes the sender's security context
> to be delivered with the transaction. The BR_TRANSACTION
> command is extended in BR_TRANSACTION_SEC_CTX to
> contain a pointer to the security context string.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c            | 106 ++++++++++++++++++++++------
>  include/uapi/linux/android/binder.h |  19 +++++
>  2 files changed, 102 insertions(+), 23 deletions(-)

Can you fix up the issue found by 0-day and resend?

thanks,

greg k-h
