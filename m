Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nTH1HqMgG1siGgAAmS7hNA
	; Sat, 09 Jun 2018 00:59:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AEC3C607E7; Sat,  9 Jun 2018 00:59:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="It4wVb2M"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 33D88602FC;
	Sat,  9 Jun 2018 00:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33D88602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeFIA7k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:59:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeFIA7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+WqD372uH1apl7sTnyrF7NAMvyiLBmGXCcCVfCfZu1Q=; b=It4wVb2MsrKmyZ9ck69rxhBFG
        C9k7nIVX0pVmGRbytxNiOWAmTpEy5bZ2tJKJUY4MpEGPcDeKmggdg0jDwRCVnE4SyzHB0NUbGNhY3
        7vw+oRutyNoFtPdjBixU6SiMBUu1C8VWwET/2nm3dxJa3jMtINv90B93U8zW83DOo+tj1X0l4oL0u
        ++BSTi8rzu/v4VQQOxM3fqa4BGAl3in76+E2CMhx+IaXrEvM8Y+hHXbpTPyXvJ+fNRheIJ+ee75gM
        lqwyrhq1DFVuRdnqLHVN8nlouaCRJQY5gjqdrOE4FdqxiHKeKvIJ6CJY24wayDFcMlEKbWCI0k8ts
        gIpDhSdxA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRSE6-0004gs-91; Sat, 09 Jun 2018 00:59:30 +0000
Subject: Re: [RFC v4 1/1] i-search functionality for mconf
To: Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180608184606.5029-1-dirk@gouders.net>
 <20180608184606.5029-2-dirk@gouders.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6cd5ead5-c24e-d2e2-e87e-eb2c1f7b5672@infradead.org>
Date: Fri, 8 Jun 2018 17:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608184606.5029-2-dirk@gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 11:46 AM, Dirk Gouders wrote:
> This patch prototypes isearch functionality for mconf based on an idea of
> Sam Ravnborg:
> 
> * mconf now distinguishes if the focus is on the menu items or the
>   buttons below it.
> 
> * At startup focus is on the menu items and alphanumeric
>   characters or space entered are used to form a string that is
>   searched for.
> 
> * BACKSPACE is used to remove the last character of the search string.
> 
> * ENTER can be used to enter a submenu.
> 
> * Horizontal arrow keys put focus on the buttons with the known
>   behavior.
> 
> * The TAB key is now exclusively used to toggle the focus.
> 
> * Vertical arrow keys work anywhere.
> 
> * When the focus is on the buttons, all keys (e.g. hotkeys) work the
>   same as before this change.
> 
> * '\' can be used to search for other occurences of an already entered
>   string.
> 
> * To use y|n|m on an item, focus has to be on the buttons.
> 
> An example to navigate into the USB support menu under Device Drivers:
> 
>    1) de		# Navigates to the item "Device Drivers"
>    2) ENTER		# Enter the submenu
>    3) USB		# Navigate to the item "USB support"
>    4) ENTER		# Enter the submenu

Hi Dirk,

Much like Sam, I got locked in isearch mode.  The TAB key would not switch
into the buttons focus.  I had to kill it.


-- 
~Randy
