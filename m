Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EZI9LeplGFtLPwAAmS7hNA
	; Wed, 06 Jun 2018 22:53:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A7C7C608BA; Wed,  6 Jun 2018 22:53:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43D8F601C3;
	Wed,  6 Jun 2018 22:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43D8F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeFFWx0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:53:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:42706 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752800AbeFFWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:53:22 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w56Mr03w025534;
        Wed, 6 Jun 2018 17:53:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w56Mr08K025533;
        Wed, 6 Jun 2018 17:53:00 -0500
Date: Wed, 6 Jun 2018 17:52:59 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Dirk Gouders <dirk@gouders.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] Emacs-like isearch for mconf.
Message-ID: <20180606225259.GY17342@gate.crashing.org>
References: <20180606215855.12889-1-dirk@gouders.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606215855.12889-1-dirk@gouders.net>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:58:55PM +0200, Dirk Gouders wrote:
> @@ -332,6 +332,7 @@ int init_dialog(const char *backtitle)
>  
>  	keypad(stdscr, TRUE);
>  	cbreak();
> +	raw();			/* Enable CTRL-sequences*/

Is that a good idea?  You probably should mention it in the patch
description, either way.


Segher
