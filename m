Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B402320866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547620639;
	bh=8UotO4s9VENwI57eiv8B6JGyML7bIU6RQFM8MEfhBm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDjfOOvNqslGNsEb8bv4RjpO5TCZ/yzWHfhyk76yXRlp3BYewkSOHqaPprMIFRx9V
	 3XoU0xi4LYHGiaCfMa/++cfq+cCienp7zClXt8ogAdXGmKUTG1zcp3TxQX2TuerUWX
	 zQ7WAmvbJS1xizJ9ur6obtg+g+ijUTku4/JecZ9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbfAPGhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730938AbfAPGhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:37:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54CC20840;
        Wed, 16 Jan 2019 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547620636;
        bh=8UotO4s9VENwI57eiv8B6JGyML7bIU6RQFM8MEfhBm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXbh9sMywI8JzHFIac27OU9h4BbsotQ8hX+d40WpTtMJ8UttQVlskYdOanTPceZ8R
         Ua/ykTszXa0tlBdf7jGgYPo3Ai9gxAxHe0+uXpog8bXo5jcmLMSYb+M9bkxwjNjLj2
         rI9CuXvgdJ54Ltr8tBFwzKsPosHncUBDK50KX8cc=
Date:   Wed, 16 Jan 2019 07:37:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Shilovskiy <pshilov@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: Re: [PATCH 4.20 14/57] CIFS: Do not hide EINTR after sending network
 packets
Message-ID: <20190116063714.GA24920@kroah.com>
References: <20190115154910.734892368@linuxfoundation.org>
 <20190115154911.514830122@linuxfoundation.org>
 <DM5PR21MB01406D74FDA02D9311CDF4B4B6810@DM5PR21MB0140.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01406D74FDA02D9311CDF4B4B6810@DM5PR21MB0140.namprd21.prod.outlook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:22:38PM +0000, Pavel Shilovskiy wrote:
> Hi Greg,
> 
> I am wondering if it is possible to include exact stable kernel
> version (e.g. 4.20.3 in this case) in the email. This would help to
> quickly understand which kernel version should be installed in order
> to get the fix.

Given that this is not in a released kernel yet, it's hard to give you a
final version :)

We have had times when a stable release happens while a -rc is out for
review due to special circumstances, so you couldn't always rely on my
email for this, as well as the fact that sometimes we drop patches from
-rc releases before they are in a real release, so such an email would
lie and confuse people.

Just watch the kernel releases, and use git to see what commit is
in what release, it's not that difficult.  Especially as you are going
to want to track this across multiple stable releases, so any guess I
might provide here isn't going to help you out much.

greg k-h
