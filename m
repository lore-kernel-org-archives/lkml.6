Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PpeCLt9gGFt8QAAAmS7hNA
	; Wed, 06 Jun 2018 22:35:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7002D60861; Wed,  6 Jun 2018 22:35:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="IgZNqoDS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 822F96063F;
	Wed,  6 Jun 2018 22:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 822F96063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeFFWfm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:35:42 -0400
Received: from services.gouders.net ([141.101.32.176]:47069 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeFFWfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:35:40 -0400
Received: from localhost (ltea-047-066-034-138.pools.arcor-ip.net [47.66.34.138])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w56MX1As005080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 00:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528324382; bh=4i4VjLWmi2ccN+YngtsbPAxDcRfyPZqXUUaNM6ScMek=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=IgZNqoDSuwwB3EEhVbRQ4l/mJLxOHsv/0YqCXpgPN5v6FBlXKW9fJVlFwYtj+0rsy
         pGi9ykFfIU4YwnqqX4p+VVwzGgngfbmXdxnxyaW/X+g0RpVX/9XMQ6uPw0Q55jzprz
         wO0D1pFrVqrDOOvNJWPLywvhV17bRTKiRHerehNs=
From: Dirk Gouders <dirk@gouders.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
In-Reply-To: <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org> (Randy
        Dunlap's message of "Wed, 6 Jun 2018 15:24:06 -0700")
References: <20180606215616.12817-1-dirk@gouders.net>
        <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Thu, 07 Jun 2018 00:32:59 +0200
Message-ID: <ghzi07v944.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 06/06/2018 02:56 PM, Dirk Gouders wrote:
>> Hello,
>> 
>> being an Emacs user, I frequently find myself pressing CTRL-s in mconf
>> to search for some menu entry, especially in large menus.
>> 
>> I decided to implement a basic isearch in mconf and would like to hear
>> if others find this functionality useful, as well.
>> 
>> The new functionality is started with pressing CTRL-s followed by
>> characters that form the search string.  To search for further
>> occurences of an entered string, press CTRL-s instead of further
>> characters.
>> 
>> For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER
>
> Not being an emacs user, what is the "de" for above?

"de" (with my .config) causes a match for "Device Drivers" --
no other menu entry matching the string "de" is befor that entry.

>
>> Pressing just CTRL-s subsequently results in line-by-line navigation
>> through the menu (search for empty strings).
>> 
>> The isearch is terminated by pressing either ESC ESC or ENTER.
>> 
>> Because I expect that errors are found in the code and changes are requested, I
>> completely left out the documentation part and will add it to V2
>> should anyone find this functionality useful.
>
> Hm, it seems to take 2 entries of Ctrl-s to begin the search??
> No, it takes 2 entries of Ctrl-s to display the "isearch:" prompt,
> but entering one Ctrl-s + a string will display it also.
>
> Anyway, I am having trouble getting the USB drivers example to work.

Yes, I should have stated that this example explains what _I_ have to do to
navigate to the USB device drivers.  Probably, "de" in your case matches
some other menu entry and the navigation requires more or other input.

I'm sorry for causing confusion.

Dirk

>> Thanks,
>> 
>> Dirk
>> 
>> Dirk Gouders (1):
>>   Emacs-like isearch for mconf.
>> 
>>  scripts/kconfig/lxdialog/dialog.h  |   5 ++
>>  scripts/kconfig/lxdialog/menubox.c | 140 ++++++++++++++++++++++++++++++++++++-
>>  scripts/kconfig/lxdialog/util.c    |   1 +
>>  3 files changed, 145 insertions(+), 1 deletion(-)
>> 
>
> thanks,
