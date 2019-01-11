Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A72177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547200769;
	bh=AZujvlrpFx70thDbpq618c25KqoHa12/iYnjylWNZ/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uTQL8GQ+fXGRM1Nn4LbznqHMXiWTOGzhB6QoobAjg+9XGMoPeOM/FZgY+Bt22f+Da
	 thv7OYredIXdnXkkLBEWsErL9C0Erc1yv9i3BqVG4D8rasY1E8hZ2gw2ebGVtquVCo
	 A6D+xHHNsBxBgmoHLJbs3QBUoQH7tn+5Sm7zHqcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfAKJ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfAKJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:59:28 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F178920872;
        Fri, 11 Jan 2019 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547200767;
        bh=AZujvlrpFx70thDbpq618c25KqoHa12/iYnjylWNZ/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQoK2t0e35R9rh9/eEYg698D4m4Sl5An4Gje81EdQapS7BJYssp3B34jPwQJVoF7v
         wElDfRD2843OrLlbirhZUuAqsLdMLi+BZykOxvs8iI+79B3SZfYQ5Wy3bVOQQPPdns
         QyVdQK5KHyf4LO8S/HGLjGaAEgyA+GMjuXjeWLbA=
Date:   Fri, 11 Jan 2019 10:59:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_loader: move firmware/ to
 drivers/base/firmware_loader/builtin/
Message-ID: <20190111095924.GA555@kroah.com>
References: <1547200321-17120-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547200321-17120-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 06:52:00PM +0900, Masahiro Yamada wrote:
> Currently, the 'firmware' directory only contains a single Makefile
> to embed extra firmware into the kernel.
> 
> Move it to the more relevant place.

So this moves any "build in" firmware to need to be placed in
drivers/base/firmare_loader/builtin/ instead of firmware/builtin/ ?  If
so, why?  That seems like a lot of extra work for people now.  And
burrying it down in the drivers/base/ directory is not obvious at all.

thanks,

greg k-h
