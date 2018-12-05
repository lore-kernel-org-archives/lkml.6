Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41553C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C752082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWtvwRHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C752082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeLEK5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLEK5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:57:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB9A2081B;
        Wed,  5 Dec 2018 10:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544007468;
        bh=iNlpqIfGWrh6FJrqfyQgWv9sDFfnmO8A1EAmLJseDzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWtvwRHSayMdCySHpHl+W0mTKrEt0RwBY3S/wWew8/NQGjPgor83oVSFWhgCIJZWP
         poewgOtcqEe01S24ziSE+8iqSUw6lvemNGo7sSY7QWMAONLWlycufvhBf+lZyhVURV
         kKXTUd+4i1050PVvczY/5KK/wQgL5dlNHfSmldD4=
Date:   Wed, 5 Dec 2018 11:57:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix sparse warnings on locking context
Message-ID: <20181205105746.GA16376@kroah.com>
References: <20181203202457.228972-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203202457.228972-1-tkjos@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:24:54PM -0800, Todd Kjos wrote:
> Add __acquire()/__release() annnotations to fix warnings
> in sparse context checking
> 
> There is one case where the warning was due to a lack of
> a "default:" case in a switch statement where a lock was
> being released in each of the cases, so the default
> case was added.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>

You sent out 4 patches here, as a series, but with no numbering so I
don't know what order to put them in :(

Can you resend them properly numbered so I have a chance to get it
right?

thanks,

greg k-h
