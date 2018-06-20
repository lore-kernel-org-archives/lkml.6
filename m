Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5480920846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nh6pKb+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5480920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeFTSVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:21:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbeFTSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0EvHrWHOsieAuHaCPAwk9ML5HAZ9ebKzFqVs2Q3GGDo=; b=nh6pKb+JW/0Yfz6ezSiRRES0KO
        pwkHmdgqj2Z+VCJhsIMKuuc3ehKyaRhawNUL8j5BZRMmqorVYlBTtSjjFVZYtC/g4s9EaksudZwcj
        iP05pE+YmKf6qx36Qv8JmDGkdEMmwHY3F1CX+xHAyBlNIsPrw73uLagOe9eER8U81oLSNMwJJA3yl
        RlhNAQzwhWhGzxw2o2yjeDfsemSpWy9KdBzGzUl49NAg/7YxDhPehtjxH7LSBAe1iS1ZDOc3I4B1T
        Qhp6mpXkrn+a/3HHQ8sdDw51uYUb+bYc5GbxxCT1slo4E6RkfWyJ+Domj3guEKfzPy7+nrdiOtFRB
        tcXcyn+w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVhjX-0001pn-7B; Wed, 20 Jun 2018 18:21:31 +0000
Subject: Re: [RFC v8 1/1] mconf: global i-search in menu prompts
To:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180620084217.8597-1-dirk@gouders.net>
 <20180620084217.8597-2-dirk@gouders.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f02cc7c6-d92e-24f3-b0ad-df9e6bf7630a@infradead.org>
Date:   Wed, 20 Jun 2018 11:21:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620084217.8597-2-dirk@gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/20/2018 01:42 AM, Dirk Gouders wrote:
> 
> Operation
> ---------
> The TAB key is reserved to toggle the focus between menu and bottons.
> Focus is on the buttons if one of the buttens (the active one) is
> hightlighted, otherwise it is on the menu.
> 
> When the focus is on the buttons, mconf operates as before with the
> exception of the TAB key.
> 
> When the focus is on the menu, mconf operates in i-search mode and the
> following input has special meaning:
> 
> * <\> (backslash) can be used to search for other occurences of an
>   already entered string.  On empty search strings, nothing happens.
> 
> * Any other printable character than backslash and '\n' is appended to
>   the current search string and a match is searched for.  If a match
>   is found, it is immediately navigated to.

About that paragraph above:  I tried to search for "fs-cache", as in:

config FSCACHE_DEBUG
	bool "Debug FS-Cache"

but i-search does not allow me to enter a '-' character.  Seems odd to me.


Still doing other testing...


> * BACKSPACE is used to remove the last character of the search string.
> 
> * DEL clears the search string.
> 
> * ENTER can be used to enter a submenu.
> 
> * ESC ESC exits the current isearch and clears the search string.
> 
> * Horizontal arrow keys still cycle between the buttons but also
>   switch focus to the buttons.
> 
> * Vertical arroy keys navigate the menu items.
> 
> At any time, at most one i-search is active and the navigation path to
> the current menu is displayed in the subtitle, the second line in the
> menu window.
> 
> Navigation example:
> 
> To navigate to options concerning NFS file systems, simply type 'n',
> 'f' and 's'.
> 
> Hint: use the 'z' key with focus on buttons to search for invisible
>       prompts.

-- 
~Randy
