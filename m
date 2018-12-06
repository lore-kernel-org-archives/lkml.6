Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1845620989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107862;
	bh=N75n1h3v0iCrZSE09uORZlm9XyQ1tVR9WrWQ+8anmWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfovA36uXR198YCZqmEydpd7BL30DpD75dZ5VFCtWCnRfIA/r3LiVWBEdYrrHFCOe
	 hBu73DsovL0m/R0zPj1IWcoDXiu5Uopgnot9QLFEQ+tR4hzSVmHiEuk20/WWl3P+YT
	 4G/KHdqkR/abLJk5v9zViiRwi20ZGjRXxXxGyhNE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbeLFOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbeLFOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:50:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E4320878;
        Thu,  6 Dec 2018 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107859;
        bh=N75n1h3v0iCrZSE09uORZlm9XyQ1tVR9WrWQ+8anmWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pr0foo6k6T5/H70pOVM9qAlJXWGi6Y+8+Ue+LaJeCr6kk8GpHPdiSFI8eqL+vSPRT
         fI7uz5syvDBJkyTZMxUM3yiSQbZMb2lDSAR/RBYzFXQQBgNHUReyNIS7gudIi1P+1S
         f+Eqvx1NWhmaqK8HT+VlkYP01aMQgeOIEWxfMQz0=
Date:   Thu, 6 Dec 2018 15:44:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] binder: fix sparse warnings on locking context
Message-ID: <20181206144408.GA24078@kroah.com>
References: <20181205231926.45928-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205231926.45928-1-tkjos@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:19:24PM -0800, Todd Kjos wrote:
> Add __acquire()/__release() annnotations to fix warnings
> in sparse context checking
> 
> There is one case where the warning was due to a lack of
> a "default:" case in a switch statement where a lock was
> being released in each of the cases, so the default
> case was added.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
> v2: no change, just resubmitted as #1 of 3 patches instead of by itself

I've already applied this one, right?

thanks,

greg k-h
