Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C53C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0120877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="c4lLUlUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcksX0L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIYXFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:05:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51803 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbeIYXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:05:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C203321F86;
        Tue, 25 Sep 2018 12:57:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Sep 2018 12:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8rZvYDqjX7ZuJ8AqIiMqBxG8N4s/Z6KgMCuI7P6V6Tk=; b=c4lLUlUC
        2p5Dtv+9faewEzVVXgAfJbVGx/I1dq/ffGLp/fyRHCiNqsq1ZqhP7FnPbRIrUsJU
        xJtIxIzYAHhgnCuM2+aSwA2Ysf5qFAwimxuH7U6S23aPqhK2KJgIMcicBUf+kw60
        ijhSVLwT8JN8TY9E7SXmJk+dgCQWVg12toup9Qsf1Y/0MHdQF4fiPmRUcYohw8Nw
        w3AGl6Mp4rmkyNtm/uNlXh4lPA8qYoGCo64FlpUfBCODgTAABOzBoiXBxxBjpZHi
        rD0JfUF1tf2/aL3CFUa5mS1FyFUR+8yCyn5Rn1+eawZrI2NzRDGvSpB9cVSu3HrI
        oO+dHtDhdbWpJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8rZvYDqjX7ZuJ8AqIiMqBxG8N4s/Z
        6KgMCuI7P6V6Tk=; b=FcksX0L/vOvbw42VNW0Fc8+TWHQteqkydD9MlUEOJSOU3
        oKZ3KK/QHXogTo9EA1weY+VzzrvkzboJCTK4MzJz1WO4bSqr8MjTMp8i6rodJwcQ
        3MoG/q7E9h2glGB4QsmCHA3zrdHJqUX+Cen7uQ/ilV3zespwRzUlFoxAOYC93n0R
        Cm6tkn5PqNZPkn0SKyi7XTt/oLWwrCPKPuuAZjYcpgWtA2bI4ZXtGzd147C0Xw5G
        mXYgZjLpizj8LZ3ISm+9RFwQBNBCaliNfxRNpWys7gIaTiJa9cb1BCUy/9dGOlXL
        iVMQzLeqUHNSdqJqlD7S4vBKSuCOm2HeWjDcVw2EQ==
X-ME-Proxy: <xmx:-2iqW1jCYE058GiYbljd0cMUidJ_86RNx-3iFCDG68wH8Lre8bBUFA>
    <xmx:-2iqWyRDaJdhfRTclIFZ3yqHcQNOqrkPVl4rlhwHf-g7gLlGxJoxCg>
    <xmx:-2iqW5Bzh_alD9pNlxLM_s7xGxqh72OezjuH7tamHNasVBdxvuRUgg>
    <xmx:-2iqWxk5Cblhpbbk8j0nygF6RUWG_DWkjYmIz-A-YAn2F-_HFISbkQ>
    <xmx:-2iqW3cew7NtCw9wTGvp9pUCoPeWe0oG_qV-0D5sENMLvOeJL1qfdg>
    <xmx:-2iqW47yqvXRNXMbtGpT0KOCN0RilFyfMCJcnO6g7i64IKGZg0KBhg>
X-ME-Sender: <xms:-2iqW7eBF7PpNytWPanqT6RWoBdpYuJ0JSJYvSaTfZCYl7qH_tw-zQ>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06218E467D;
        Tue, 25 Sep 2018 12:57:30 -0400 (EDT)
Date:   Tue, 25 Sep 2018 18:57:29 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.19-rc5
Message-ID: <20180925165729.GA16781@kroah.com>
References: <1537889692.5951.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537889692.5951.2.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:34:52AM -0700, James Bottomley wrote:
> Nine obvious bug fixes mostly in individual drivers.  The target fix is
> of particular importance because it's CVE related.
> 
> The patch is available here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Now pulled, thanks.

greg k-h
