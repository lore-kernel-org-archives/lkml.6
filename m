Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cuOvG750GFt5RQAAmS7hNA
	; Wed, 06 Jun 2018 23:56:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F3FA607DC; Wed,  6 Jun 2018 23:56:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="IQQpQ+Q5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 33459601D2;
	Wed,  6 Jun 2018 23:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33459601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeFFX4z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:56:55 -0400
Received: from services.gouders.net ([141.101.32.176]:52537 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbeFFX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:56:54 -0400
Received: from localhost (ltea-047-066-034-138.pools.arcor-ip.net [47.66.34.138])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w56NsVsV005802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 01:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528329272; bh=TAcyOn6nPDFBx6xHKwNhi34xLtituCXMG1sLUXMK0xw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=IQQpQ+Q5LRxXg9odh2JNHTiGtV+0rDND93u8yVawYreUJSseJ2h7Y/wwcO3gTaPDk
         hnRDhIl/DKjB8rIu1gEALvtz12kABa++0/at884aZoMU5BcjtioyyBiPjut8iMRZG6
         aS9t5SO7ZfpLyOCJBguqVwI6VW06PXn6PSiiyKLY=
From: Dirk Gouders <dirk@gouders.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
In-Reply-To: <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org> (Randy
        Dunlap's message of "Wed, 6 Jun 2018 16:31:44 -0700")
References: <20180606215616.12817-1-dirk@gouders.net>
        <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
        <ghzi07v944.fsf@lena.gouders.net>
        <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Thu, 07 Jun 2018 01:54:30 +0200
Message-ID: <ghr2ljv5c9.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 06/06/2018 03:32 PM, Dirk Gouders wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> On 06/06/2018 02:56 PM, Dirk Gouders wrote:
>>>> Hello,
>>>>
>>>> being an Emacs user, I frequently find myself pressing CTRL-s in mconf
>>>> to search for some menu entry, especially in large menus.
>>>>
>>>> I decided to implement a basic isearch in mconf and would like to hear
>>>> if others find this functionality useful, as well.
>>>>
>>>> The new functionality is started with pressing CTRL-s followed by
>>>> characters that form the search string.  To search for further
>>>> occurences of an entered string, press CTRL-s instead of further
>>>> characters.
>>>>
>>>> For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER
>>>
>>> Not being an emacs user, what is the "de" for above?
>> 
>> "de" (with my .config) causes a match for "Device Drivers" --
>> no other menu entry matching the string "de" is befor that entry.
>> 
>
> Device Drivers is the first match for me also.
>
> To get to the USB drivers, I have to enter:
> 	CTRL-s de ENTER ENTER CTRL-s usb ENTER ENTER

Yes, I left out the second CTRL-s, thank you!

Oh well, I shouldn't have sent this late at night, then I would probably
have explained the needed input as:

     1) CTRL-s  // start isearch
     2) de      // substring that matches "Device Drivers"
     3) ENTER   // quit isearch
     4) ENTER   // enter Device Drivers menu
     5) CTRL-s  // start isearch
     6) usb     // navigate to USB support
     7) ENTER   // quit isearch
     8) ENTER   // enter USB support menu

Again, I'm really sorry for the confusion.

Dirk
