Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37BC222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550166657;
	bh=fz9GLtRieNevMSmqHd4JSbDJIUHSkA+6kBZiddKM/vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T/7S5eqU2Q97fhdjhj/Wceq4y8YogmLCDhz42OjNvVSiWUr/zeSlLTuKUpKlObxRF
	 6nQ8/0ujJR38FcG1AgWn5eIuEh4MsONi+9kpUkOe+0rrALXsgBGcAttTN11Sq62hmp
	 mgVmZ/U/HCmoH0UqdC3Iwyg1gDDFUiHbQBAUT4F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbfBNRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfBNRu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:50:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C711222DA;
        Thu, 14 Feb 2019 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550166655;
        bh=fz9GLtRieNevMSmqHd4JSbDJIUHSkA+6kBZiddKM/vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlSmNa/8tXSOofz54cShr69sie7XGSMx1VBrFxIH+FOfpVUzHCo9OtOdT0fsFxUXb
         BYa6M7h6SLnxtxBWS+/WB7rPb7KDGi24+TFzWIYcbFJOT6SnOR+trCVr3c9HP/QC7g
         3IAW00lm7M24Rcs8xv6ghx1rXS5r6I2LZcoXDcQM=
Date:   Thu, 14 Feb 2019 18:50:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging/android: use multiple futex wait queues
Message-ID: <20190214175053.GA11103@kroah.com>
References: <20190214173459.GA10737@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214173459.GA10737@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 06:34:59PM +0100, Hugo Lefeuvre wrote:
> Use multiple per-offset wait queues instead of one big wait queue per
> region.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>

Have you tested this?

Noticed any performance speedups or slow downs?

thanks,

greg k-h
