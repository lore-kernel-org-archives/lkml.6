Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB66C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71C22081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544384433;
	bh=rXkESkATq3ArhWI5oSj34Vjf172eyN034mZrie4x80A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B4y2c2vbQoNuBpQc3uR/JPoi62FettXvuwIE8uZGZMAhxmXCnjLrsn0LMSHmb8ZrG
	 Xz4xxKEx06/vuZQSDhVXPtQ9xc2bUPqth8wD9hqNFeLkxlhyDqSxBpZfzyqxOycfke
	 fZt74P73c4TQuEDuUITzhBjGFol2ZDasjNEwScDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71C22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeLITkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeLITkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:40:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC402064D;
        Sun,  9 Dec 2018 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544384431;
        bh=rXkESkATq3ArhWI5oSj34Vjf172eyN034mZrie4x80A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzq0oRsq0LyTGegUS8lCbNGGPOn3DPvdGPsSXYDPtui5nowIN4w8uBfoOHu8/GnXg
         ZpH0wNsIGDr30S8C+NlyvQYoGK2+d9SywEY9F5jb5+841pwIS7C+m/Nbu8YaGwO5e0
         ixdMmR0BleivpPvEW89vM1uQs61mwR3edngk2bEA=
Date:   Sun, 9 Dec 2018 20:40:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Jespersen <laumann.thomas@gmail.com>, gaoxiang25@huawei.com,
        yuchao0@huawei.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: erofs: Add braces to do-while statements
Message-ID: <20181209194029.GA31163@kroah.com>
References: <20181209155900.10164-1-laumann.thomas@gmail.com>
 <20181209162007.GA22432@kroah.com>
 <f741ac1808f05f2efe6532491e8b1eb6ac74e260.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f741ac1808f05f2efe6532491e8b1eb6ac74e260.camel@perches.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 09:27:01AM -0800, Joe Perches wrote:
> On Sun, 2018-12-09 at 17:20 +0100, Greg KH wrote:
> > On Sun, Dec 09, 2018 at 04:59:00PM +0100, Thomas Jespersen wrote:
> > > This fixes warning reported by sparse (with -Wsparse-all).
> > 
> > Why is sparse warning about this?
> 
> Probably because it's the kernel preferred style
> to use single statement
> 
> 	do {
> 		<foo>;
> 	} while (<bar>);
> 
> over
> 
> by about a 20:1 ratio.

Sparse is spitting out coding style complaints now?

