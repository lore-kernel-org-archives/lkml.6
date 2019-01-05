Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38596C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36C20868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546698850;
	bh=2Yt3aLQvhCwyZRK7UGozQ6BWvDaMWB8O3gC0gVbqeCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kISsMmNNdvTkGx3LlETx50QR27pfP5uWZhuZ5E111wGf9jR2qerkzpXWVMtvIwgHH
	 C1g+Vh9vmiTT5tKlWiEW7crtoL9G2oVL4n0oGwIRcrSxShEb6Rm4Xsyf4FnrWOL9pp
	 Ri9GHQjA7rBRRDQHDE5T1CtMsI4n7bnzkqxHi394=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfAEOeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfAEOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 09:34:08 -0500
Received: from localhost (unknown [188.89.135.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C4C2070C;
        Sat,  5 Jan 2019 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546698848;
        bh=2Yt3aLQvhCwyZRK7UGozQ6BWvDaMWB8O3gC0gVbqeCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpo4GHdyljJFUZACWWb4YfVT7EBPWGTlPOnwW5cmlWcJoj23msWl4rqNaCnh9DGwZ
         TNwssq5yT9xCpsgYTUzjPwY+Wh2yISK2j0fmfJF00Ta8JQQJfa2zjIzWHBsGtnACQA
         IPwPxwqFDvTorUiIRPoVf+8wskWKHPfm6dyaa7us=
Date:   Sat, 5 Jan 2019 15:34:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: misc: goldfish_address_space: add a driver
Message-ID: <20190105143404.GB22044@kroah.com>
References: <20190104021311.38194-1-rkir@google.com>
 <20190105085429.GB13941@kroah.com>
 <CAOGAQeoOTVMzufOvXf+f6SDJYfCWj7unU8oWExfq3WSj55o7CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeoOTVMzufOvXf+f6SDJYfCWj7unU8oWExfq3WSj55o7CQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 01:43:55AM -0800, Roman Kiryanov wrote:
> > Why isn't this in drivers/platform/goldfish/ ?
> 
> I was not sure where to put, but this driver is not a platform one, it
> is a pci one.

You are controlling a "platform" device, the goldfish platform.  What
makes this different from any of the other goldfish platform drivers in
that directory other than you are triggering off of a virtual pci
device?

thanks,

greg k-h
