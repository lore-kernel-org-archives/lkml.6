Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2492123DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2492123DA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGCC2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:28:25 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:53592 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeGCC2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:28:23 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1faB35-00075d-GI; Tue, 03 Jul 2018 04:28:11 +0200
Date:   Tue, 3 Jul 2018 04:28:11 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel.h: Documentation for roundup() vs round_up()
Message-ID: <20180703022811.6v4dsqtcn5i6mt5i@angband.pl>
References: <20180703021654.GA42417@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703021654.GA42417@beast>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 07:16:54PM -0700, Kees Cook wrote:
> Things like commit 3619dec5103d ("dh key: fix rounding up KDF output
> length") expose the lack of explicit documentation for roundup() vs
> round_up(). At least we can try to document it better if anyone goes
> looking.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

> +/**
> + * round_up - round up to next specified power of 2
> + * @x: the value to round
> + * @y: multiple to round up to (must be a power of 2)
                                   ^^^^^^^^^^^^^^^^^^^^
This matches the description -- so far, good.
> + *
> + * Rounds @x up to next multiple of @y (which must be a power of 2).
> + * To perform arbitrary rounding up, use roundup() below.
> + */

> +/**
> + * roundup - round up to the next specified multiple
> + * @x: the value to up
> + * @y: multiple to round up to (must be a power of 2)
                                   ^^^^^^^^^^^^^^^^^^^^
But isn't this supposed to differ from the above?
> + *
> + * Rounds @x up to next multiple of @y. If @y will always be a power
> + * of 2, consider using the faster round_up().
> + *
> + * The `const' here prevents gcc-3.3 from calling __divdi3
> + */
>  #define roundup(x, y) (					\
>  {							\
>  	const typeof(y) __y = y;			\
>  	(((x) + (__y - 1)) / __y) * __y;		\
>  }							\


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven big-ass trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...
