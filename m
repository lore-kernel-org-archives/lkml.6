Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933052AbeBULOy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:14:54 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36958 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbeBULOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:14:51 -0500
X-Google-Smtp-Source: AH8x224poZDiVcRNJ6XbIJWxPkzdFM237p12W5PPciqcX+o8mZX72h5A+D7ETL6bhjAXCP2BKQDgZw==
Date: Wed, 21 Feb 2018 12:14:48 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: clean-up reverse dependency help implementation
Message-ID: <20180221111447.ki7v66azmfgch5om@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <1519114728-1084-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519114728-1084-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

> This commit splits out the special E_OR handling ('-' instead of '||')
> into a dedicated helper expr_print_revdev().

> Restore the original expr_print() prior to commit 1ccb27143360
> ("kconfig: make "Selected by:" and "Implied by:" readable").

> This makes sense because:

>   - We need to chop those expressions only when printing the reverse
>     dependency, and only when E_OR is encountered

>   - Otherwise, it should be printed as before, so fall back to
>     expr_print()

> This also improves the behavior; for a single line, it was previously
> displayed in the same line as "Selected by", like this:

>   Selected by: A [=n] && B [=n]

> This will be displayed in a new line, consistently:

>   Selected by:
>   - A [=n] && B [=n]

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---

<snip>

>  	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
>  	if (sym->rev_dep.expr) {
> -		str_append(r, _("  Selected by: "));
> +		str_append(r, _("  Selected by: \n"));
                                       ^
I'd remove unnecessary whitespace here ^.

		str_append(r, _("  Selected by:\n"));
>  		expr_gstr_print_revdep(sym->rev_dep.expr, r);
> -		str_append(r, "\n");
>  	}

>  	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
>  	if (sym->implied.expr) {
> -		str_append(r, _("  Implied by: "));
> +		str_append(r, _("  Implied by: \n"));
The same here.

>  		expr_gstr_print_revdep(sym->implied.expr, r);
> -		str_append(r, "\n");
>  	}

>  	str_append(r, "\n\n");


Kind regards,
Petr
