Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7104C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66311214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3mlrN7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66311214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeKLM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeKLM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:27:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A91DB20871;
        Mon, 12 Nov 2018 02:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541990190;
        bh=wVU/hd9Wkr+YpJDYbmIzHf60E5NiLEHdR6posnaJIRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3mlrN7vhOoCEa//UJiojqzShE1gQgsHNt/vTuTIE81MuKPGEZdZfcJCt668MfOiS
         8E9g71QKFzrabt6Rv2nLimXPuekhXAiYNNaJvn3N2ALF1c3VZYm58gisxHLf3EXDR9
         JLuDjVAowBJp1BqqlpQx0GgBhTifbuIfC4CxLmRs=
Date:   Sun, 11 Nov 2018 18:36:30 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181112023630.GA20359@kroah.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 09:24:40PM -0500, Carlos O'Donell wrote:
> On 11/10/18 2:20 PM, Greg KH wrote:
> > Also, what about the basic work of making sure our uapi header files can
> > actually be used untouched by a libc?  That isn't the case these days as
> > the bionic maintainers like to keep reminding me.  That might be a good
> > thing to do _before_ trying to add new things like syscall wrappers.
> I agree completely. There are many steps in the checklist to writing
> a new syscall, heck we should probably have a checklist!

We should have a checklist.  That's a great idea.  Now to find someone
to write it... :)

I'll try to make it to the plumbers talk, but I think there's a
competing one I am supposed to be at at the same time.

greg k-h
