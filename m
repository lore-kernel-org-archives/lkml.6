Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A04F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZRG9rll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIEWwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:52:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIEWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:52:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so8641624wre.10;
        Wed, 05 Sep 2018 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlTvQtmVMsSrKeQj5fQabj7Oqh7/mlRwJqlggnVQtpA=;
        b=iZRG9rllYezIWFRUy0n4WZcNAQ2xYLjJCM8WxEu0Ndx+GUfhnx9p+FC+b7PZ+CTcWn
         9aw+nDV7pjWl/wINXtC5XdLJj7oSvbEZbREFUFb25RL1cGPxnJtNbFycQGbYW+5YHe8Q
         OtFX4CxyzIjITFiZ8Ds96uW5XmjtlD21ZbnvlUJ0PumXjOOs8/9Meky4Fxo+N0CJSvJH
         khcRptsbKbgS1sdfGWzkUAPoJSUy6+X214qScTEmqPQV3nlBbq+5Gy/3aJw0C88cMJb4
         gLVMWJn9qFSWPceKq0GNr840RChgepZGHPvpKvL6d2/8b2wOMY+VbN1tNWTMv5YXM0F2
         2rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlTvQtmVMsSrKeQj5fQabj7Oqh7/mlRwJqlggnVQtpA=;
        b=GZTeQ22BW8yJJNz/pTN6ALH+Qohc9b6IBcrWCOKtQ4hBT4i/m53AI95sioxpBmG74R
         +pdNZxz3bn/9qt3VmlZZ0p+NOWFEy+0nrOdgk9hKsqbBh3fst9wK+WSxFrhNepyH/Va7
         rF0rAlIOQLeQDZhqIxkpykO0yOx1OrIHAcN6GFJl7Ib7yfUWf0oZ7zEh8mk3HUmoTyzv
         BMQvZ56Jq6TtUzNXDPXexFGlS6kXielqmCliq2/0e1PL7X16gxGfsHn4LkEAJhe1HX2U
         ZOoL3xKOInp60amNUYNwIPqkyZSVlnazjzi5q82Iz8+PL8UI6ZXZpR9yaK4XxIBW2KC+
         vwwA==
X-Gm-Message-State: APzg51AYtthhDw02RwoawHmX5f2f40cW76o09OwTdm8cO2PvdQAZhNIu
        DT1tVTuwQTnxlJs9yb/k9d4=
X-Google-Smtp-Source: ANB0VdYiklPWWEB9rPHlLgdFmkqhnXcTTDpGfzI03jovzu7zehDnua6PhkTnziHE69MzZjtzbOwjlQ==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr27356739wrm.213.1536171643430;
        Wed, 05 Sep 2018 11:20:43 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:b45a:4246:cb70:58f7])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3691332wre.15.2018.09.05.11.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:20:42 -0700 (PDT)
Date:   Wed, 5 Sep 2018 20:20:39 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Message-ID: <20180905182038.muv535vfugm72spk@ltop.local>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:33:11PM +0200, Miguel Ojeda wrote:
> Sparse knows about a few more attributes now, so we can remove
> the __CHECKER__ conditions from them (which, in turn, allow us
> to move some of them later on to compiler_attributes.h).
> 
>   * assume_aligned: since sparse's commit ffc860b ("sparse:
>     ignore __assume_aligned__ attribute"), included in 0.5.1
> 
>   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
>     to ignored attributes"), included in 0.5.0
> 
>   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
>     ignore hotpatch attribute"), included in 0.5.1
> 
>   * warning: since sparse's commit 977365d ("Avoid "attribute
>     'warning': unknown attribute" warning"), included in 0.4.2

Hi,

I hadn't noticed in the previous version but I see now that hotpatch
& assume_aligned is only available since sparse 0.5.1 which is only
13 months old. It would be great if everyone use a recent version
but I fear that a lot of people still use something less recent.
v0.5.0 should be OK, though, it's more than 5 years old.

Sorry for not having noticed this earlier.

-- Luc 
