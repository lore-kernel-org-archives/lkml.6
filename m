Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72165C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D120693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RMHpvysD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030372AbeFSRn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:43:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030330AbeFSRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NlJF3uWgWIYD55wUutUVRjnEPN8ufpH8hSRBrzKsFb8=; b=RMHpvysDLDON5aNRtfZrvdE2g
        McNrmmD/HmMU09aTumxJx6GrJSgzniYjVlZ3G0valbfxdkwt37+kO0RGNSsHI9utN3PVlakDMD/3n
        46DUDWzqP3Qo5N0NlCEN0NFnadXRfjyVMPJuJBHS9k8Hin7T/la868w3gacis/HfKsNEdaz4LDZNd
        MBo1TtibZbEBY96rfemg6sAW2M3h1A4ITFxHt0smOYfiGA75pzQsWpU0Ce4Lrmx6d4oMHz/krXKAv
        kcekZzlJHZ66bo8iUlUiueHr+ZC2OJ3eFuMw7DbvTeWMvxqKAJWgOK5Wka44z28nHR9jxkBFUZdB7
        po2az4LBA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVKfS-000550-Lu; Tue, 19 Jun 2018 17:43:46 +0000
Subject: Re: [RFC v7 1/1] mconf: global i-search in menu prompts
To:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180617121534.4809-1-dirk@gouders.net>
 <20180617121534.4809-2-dirk@gouders.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01450eac-3c65-efa1-8a9e-aaea98088bac@infradead.org>
Date:   Tue, 19 Jun 2018 10:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617121534.4809-2-dirk@gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 05:15 AM, Dirk Gouders wrote:

> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  scripts/kconfig/lxdialog/checklist.c |   2 +-
>  scripts/kconfig/lxdialog/dialog.h    |   3 +-
>  scripts/kconfig/lxdialog/inputbox.c  |   2 +-
>  scripts/kconfig/lxdialog/menubox.c   | 181 +++++++++++++++++++++---
>  scripts/kconfig/lxdialog/util.c      |  45 +++++-
>  scripts/kconfig/lxdialog/yesno.c     |   2 +-
>  scripts/kconfig/mconf.c              | 202 +++++++++++++++++++++++++--
>  7 files changed, 398 insertions(+), 39 deletions(-)

Hi Dirk,

A few typos below...


> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 5294ed159b98..e2e6fc973f6f 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -21,6 +21,12 @@
>  #include "lkc.h"
>  #include "lxdialog/dialog.h"
>  
> +extern int focus_on_buttons;
> +extern char isearch_str[];
> +static struct menu **flat_menu; /* serialized menu tree */
> +static int flat_menu_max = 10;
> +static int in_isearch;	      /* Ensure at most one instance of i-search is active */
> +
>  static const char mconf_readme[] =
>  "Overview\n"
>  "--------\n"
> @@ -36,20 +42,74 @@ static const char mconf_readme[] =
>  "while *, M or whitespace inside braces means to build in, build as\n"
>  "a module or to exclude the feature respectively.\n"
>  "\n"
> -"To change any of these features, highlight it with the cursor\n"
> -"keys and press <Y> to build it in, <M> to make it a module or\n"
> +"Operation modes\n"
> +"---------------\n"
> +"Menuconfig operates in two modes, depending on the focus that can be\n"
> +"either on the menu or the buttons below it. The focus is on the\n"
> +"buttons if one button (the selected one) is highlighted, otherwise it\n"
> +"is on the menu.\n"
> +"\n"
> +"To change any of the above features, it has to be navigated to (see\n"
> +"below) so that it is highlited, focus then has to be on the buttons\n"

                         highlighted,

> +"before you press <Y> to build it in, <M> to make it a module or\n"
>  "<N> to remove it.  You may also press the <Space Bar> to cycle\n"
>  "through the available options (i.e. Y->N->M->Y).\n"
>  "\n"
> +"Navigation\n"
> +"----------\n"
> +"The following keys work independent of the current focus:\n"

                            independently

> +"\n"
> +"o vertical arrow keys are used to navigate to menu items\n"
> +"\n"
> +"o horizontal arrow keys put the focus on the buttons and cycle\n"
> +"  between the buttons.\n"
> +"\n"
> +"o <PAGE UP> and <PAGE DOWN> scroll invisible items into view.\n"
> +"\n"
> +"o <ENTER> visits a submenu\n"
> +"  Submenus are designated by \"--->\", empty ones by \"----\".\n"
> +"\n"
> +"o <ESC><ESC> leaves a submenu or (in the main menu) exits menuconfig\n"
> +"  and clears the current i-search string."
> +"\n"
> +"o <TAB> is reserved to toggle the focus between menu and buttons\n"
> +"\n"
> +"When menuconfig starts, the focus is on the menu and i-search mode\n"
> +"is active.  I-search performs continuous cyclic searches for an entered\n"
> +"string in the prompt texts of the whole menu tree.\n"
> +"\n"
> +"Subsequent characters can be entered to build a search-string the\n"
> +"menu items are searched for and each time a character is added the\n"
> +"current string is searched for starting from the current position in\n"
> +"the menu tree.  If a match is found it is immediately navigated to.\n"
> +"\n"
> +"Keys with a special meaning are:\n"
> +"\n"
> +"o <BACKSPACE> removes the last character from the current search string\n"
> +"\n"
> +"o <DEL> clears the search string\n"
> +"\n"
> +"o <\\> (backslash) can be used to find further matches of a string\n"
> +"\n"
> +"When the focus is on the buttons the following keys can be used:\n"
> +"\n"
> +"o <x> can be used for exit identical to <ESC><ESC>\n"
> +"\n"
> +"o <y>, <n>, <m> or <SPACE> change the selected item\n"
> +"\n"
> +"o <+> and <-> keys navigate menu items identical to vertical arrow\n"
> +"  keys\n"
> +"\n"
> +"o <h> or <?> display help messages\n"
> +"\n"
> +"o <z> toggles the display of hidden options\n"

Ah, there it is!  Thanks.

> +"\n"
>  "Some additional keyboard hints:\n"
>  "\n"
>  "Menus\n"
>  "----------\n"
> -"o  Use the Up/Down arrow keys (cursor keys) to highlight the item you\n"
> -"   wish to change or the submenu you wish to select and press <Enter>.\n"
> -"   Submenus are designated by \"--->\", empty ones by \"----\".\n"
> -"\n"
> -"   Shortcut: Press the option's highlighted letter (hotkey).\n"
> +"o  Hotkeys (available with focus on buttons): Press the target option's\n"
> +"             highlighted letter (hotkey).\n"
>  "             Pressing a hotkey more than once will sequence\n"
>  "             through all visible items which use that hotkey.\n"
>  "\n"


thanks,
-- 
~Randy
