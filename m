Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FDBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C60208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYLkejN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C60208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeJPOTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbeJPOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:19:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C201208B3;
        Tue, 16 Oct 2018 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539671430;
        bh=Ge8s/Dq5YcJ/53G9YIBTAfEdxSrRs4heXdL2r3Q9N9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYLkejN+l865Gd1reee2iOEXE+1QDdD7DziAVe+8cBFLGhZD4bGXuvYu51KM0oeEM
         /8xLv33AI5RXIWTXdNaU7WZJZ79TIwLxGpNBUGuuePF176Gvf4c5el6IPCfTtATGGC
         eSdlxeV0RfYqZu2IV/j4fyy2uZIL61p1ocmW3/Z0=
Date:   Tue, 16 Oct 2018 08:30:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 07/15] platform: goldfish: pipe: Return status from
 "deinit" since "remove" does not do much
Message-ID: <20181016063028.GC882@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-7-rkir@google.com>
 <20181015183605.GB28454@kroah.com>
 <CAOGAQeqiWMseXPi6n2gkBHAWhsRdwDyMXpCFB1h2mEuQLJz-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeqiWMseXPi6n2gkBHAWhsRdwDyMXpCFB1h2mEuQLJz-mw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:04:47PM -0700, Roman Kiryanov wrote:
> > This function can not fail, why are you returning 0 always?  That
> > doesn't make sense.
> 
> remove in struct platform_driver requires returning something, we have
> to have "return" somewhere.

But this code always returns 0, you are changing the function return
value to int, but it can not fail.  I do not understand the need for
this change at all, sorry.

> I think we want to return closer to the place where we do something useful.

I do not understand this.

greg k-h
