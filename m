Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gGxBIxE6GlulIAAAmS7hNA
	; Fri, 08 Jun 2018 08:12:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1A17B607DC; Fri,  8 Jun 2018 08:12:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="LpvZ9E1Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 756F3606FA;
	Fri,  8 Jun 2018 08:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 756F3606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHIMd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:12:33 -0400
Received: from services.gouders.net ([141.101.32.176]:58619 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeFHIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:12:30 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w587uvBx026232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 09:56:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528444618; bh=rn4WsR5p6eKW1oS8cXf9fIT7GR+JGxv0x9IWwASqmis=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=LpvZ9E1QbtbTUXcpRGcBYytxoGZPPoMk6cfv7+7wrUORvQvd1jGaj8sg2IEJ+BixK
         wMkplxZQ80M54YKj2eqMZMdyclli+bWKMXtN30G7sLVHlaJKg9DZlH1hI+l8tYO3GK
         Lg6f6HYTxJKwkn7SSjFOOS1RNax1CcHRmJywarY4=
From: Dirk Gouders <dirk@gouders.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
In-Reply-To: <20180607163208.GA26914@ravnborg.org> (Sam Ravnborg's message of
        "Thu, 7 Jun 2018 18:32:08 +0200")
References: <20180606215616.12817-1-dirk@gouders.net>
        <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
        <ghzi07v944.fsf@lena.gouders.net>
        <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
        <ghr2ljv5c9.fsf@lena.gouders.net>
        <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
        <ghmuw7uoku.fsf@lena.gouders.net>
        <20180607163208.GA26914@ravnborg.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Fri, 08 Jun 2018 09:56:50 +0200
Message-ID: <gha7s5socd.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

>> 
>> I'd say it's not important to start isearch with CTRL-s, I am just so
>> used to it.  So, I am open for suggestions.
>
> Today we have first or one of the first letters as shortcut to menus.
> How about considering everything typed as search inputs.
> Search is then stopped by ESC, arrow keys and maybe more.
>
> Search is only possible when a menu is selected, not with focus on the buttons.
>
> This will break the habits of people used to the shortcut variant,
> but then we have the more flexible i-search variant.
>
> Idea?

Sounds very interesting, I will see if I can prepare a prototype so that
users can test it an see if they feel that would be an improvement for
them.  In mconf, a focus on the buttons would be conceptually new
and I am anticipating I am not yet realizing all of the consequences.

One situation, I am still thinking about how to handle it (without a
dedicated search key):

* The user types a string and then doesn't want to enter further string
  characters but find further occurences of the already entered string.

  (In my imagination, TAB is reserved to change focus to the buttons,
   ENTER is reserved to stop searching -- and enter a submenu, depending
   on the item.)

Dirk
