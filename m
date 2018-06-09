Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6/x/F4OGG1uXSgAAmS7hNA
	; Sat, 09 Jun 2018 07:49:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44CEB607A4; Sat,  9 Jun 2018 07:49:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="gOpkyI9p"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3C544605A2;
	Sat,  9 Jun 2018 07:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C544605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeFIHtT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:49:19 -0400
Received: from services.gouders.net ([141.101.32.176]:46112 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeFIHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:49:17 -0400
Received: from localhost (ltea-047-066-004-082.pools.arcor-ip.net [47.66.4.82])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w597eTQh006010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Jun 2018 09:40:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528530030; bh=6EuxRHhsRDd+latK7IjAnTp99PB0cDF0juX3KXWpsjs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=gOpkyI9pU9Byf92w/dnJHbjZkdYwp0gUvF1DuBLFofkt+GkvyVvTzETt1wIyLxwJM
         HRoCqhQNzggolOQ/p/UD61S9YliLAT7fpHnTZlJQmtyEccjGG57UwJpRtCNbemeNnG
         MLjwJA2S4qGmagcgjYB+KVYv7GgrytBnBnb1ydQ0=
From: Dirk Gouders <dirk@gouders.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC v4 0/1] i-search functionality for mconf
In-Reply-To: <20180608215655.GB28473@ravnborg.org> (Sam Ravnborg's message of
        "Fri, 8 Jun 2018 23:56:55 +0200")
References: <20180608184606.5029-1-dirk@gouders.net>
        <20180608215655.GB28473@ravnborg.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Sat, 09 Jun 2018 09:40:27 +0200
Message-ID: <ghlgbo5rx0.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> Hi Dirk.
>
> On Fri, Jun 08, 2018 at 08:46:05PM +0200, Dirk Gouders wrote:
>> Hello,
>> 
>> this version is a prototype of the idea, Sam suggested -- I hope I
>> undestood it correctly.
>> 
>> This is a remarkable change to mconf in it's behavior; mainly it now
>> differentiates two focuses and operates differently, depending on the
>> focus.  When the focus is on the menu, mconf is in i-search mode, for
>> a detailed description see 1/1.
>> 
>> As stated earlier, this is just a prototype, documentation is missing
>> and the code is not ready for a real commit.
>
> When trying this out it started to work as envisioned.
> But somehw I manage to get stuck in the menus and cannot navigate to
> the buttons.
>
> Consider to remove the old short-cut for the menus.
> (Most/all the first_alph thingy in menubox.c)
> That will avoid two confliting navigations principles and likely
> make the code simpler to read.
>
> I am not sure, but maybe you can get rid of all the hotkey
> support in print_item with this change too.

Hi Sam,

thank you (and also to Randy) for having a look at it.

Next, I will prepare a patch, more thorougly tested,
documentation included and with hotkey support removed.

You are right, trying to support two navigation principles makes
everything too complex and I was too eager to keep as much of today's
functionality as possible.

Dirk
