Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1evJL7D7GlvgfgAAmS7hNA
	; Fri, 08 Jun 2018 21:57:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B241F607E7; Fri,  8 Jun 2018 21:57:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 12F04607DC;
	Fri,  8 Jun 2018 21:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12F04607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeFHV5B (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:57:01 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39477 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeFHV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:56:59 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5F54420054;
        Fri,  8 Jun 2018 23:56:56 +0200 (CEST)
Date: Fri, 8 Jun 2018 23:56:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dirk Gouders <dirk@gouders.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC v4 0/1] i-search functionality for mconf
Message-ID: <20180608215655.GB28473@ravnborg.org>
References: <20180608184606.5029-1-dirk@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608184606.5029-1-dirk@gouders.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=hvHml8rP7Vaw8gOLeoUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dirk.

On Fri, Jun 08, 2018 at 08:46:05PM +0200, Dirk Gouders wrote:
> Hello,
> 
> this version is a prototype of the idea, Sam suggested -- I hope I
> undestood it correctly.
> 
> This is a remarkable change to mconf in it's behavior; mainly it now
> differentiates two focuses and operates differently, depending on the
> focus.  When the focus is on the menu, mconf is in i-search mode, for
> a detailed description see 1/1.
> 
> As stated earlier, this is just a prototype, documentation is missing
> and the code is not ready for a real commit.

When trying this out it started to work as envisioned.
But somehw I manage to get stuck in the menus and cannot navigate to
the buttons.

Consider to remove the old short-cut for the menus.
(Most/all the first_alph thingy in menubox.c)
That will avoid two confliting navigations principles and likely
make the code simpler to read.

I am not sure, but maybe you can get rid of all the hotkey
support in print_item with this change too.

	Sam
