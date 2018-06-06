Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dG2gLutuGFuaGQAAmS7hNA
	; Wed, 06 Jun 2018 23:31:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A418B6089E; Wed,  6 Jun 2018 23:31:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xebEWdXM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1674E601A8;
	Wed,  6 Jun 2018 23:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1674E601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeFFXbw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:31:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeFFXbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LVcMjLW0ET24TUBYEzWTisOKhGJa2yd0aKRSvK/P3/c=; b=xebEWdXMa7tSKfBhfRkzQ5SAqT
        Xoo9VpVoHxXkJ4mMIupGDQmQj08sNX/IpNLcdPZiDMxGqr/PsTuuYqRN8QDSPzS9XMEc2BV+cnocD
        bBaOpC7bUFNBl8T9T2uWf+JnScFzaDcg3ro3U2K1QMQuTBhSLVbk01mw8IlkhbCgw4Y0Mma+sBVfD
        SyjW57/5iEgDqGTgkpVTLfV8foPz/4EET8brSZrTr14/hwvLyBNb3dbpSARzRAzLnf52pfI7Cnrot
        +nQHeoyZ6G1g1Gc0SGRfPFjHSadx6InqKkAElQ/39QBiBTNiPLSujXlpmRRLuCL3asV+6xZZQnAwt
        AscYMEtA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQhu6-0001g4-Rz; Wed, 06 Jun 2018 23:31:49 +0000
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
To: Dirk Gouders <dirk@gouders.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180606215616.12817-1-dirk@gouders.net>
 <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
 <ghzi07v944.fsf@lena.gouders.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
Date: Wed, 6 Jun 2018 16:31:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ghzi07v944.fsf@lena.gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 03:32 PM, Dirk Gouders wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 06/06/2018 02:56 PM, Dirk Gouders wrote:
>>> Hello,
>>>
>>> being an Emacs user, I frequently find myself pressing CTRL-s in mconf
>>> to search for some menu entry, especially in large menus.
>>>
>>> I decided to implement a basic isearch in mconf and would like to hear
>>> if others find this functionality useful, as well.
>>>
>>> The new functionality is started with pressing CTRL-s followed by
>>> characters that form the search string.  To search for further
>>> occurences of an entered string, press CTRL-s instead of further
>>> characters.
>>>
>>> For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER
>>
>> Not being an emacs user, what is the "de" for above?
> 
> "de" (with my .config) causes a match for "Device Drivers" --
> no other menu entry matching the string "de" is befor that entry.
> 

Device Drivers is the first match for me also.

To get to the USB drivers, I have to enter:
	CTRL-s de ENTER ENTER CTRL-s usb ENTER ENTER

>>
>>> Pressing just CTRL-s subsequently results in line-by-line navigation
>>> through the menu (search for empty strings).
>>>
>>> The isearch is terminated by pressing either ESC ESC or ENTER.
>>>
>>> Because I expect that errors are found in the code and changes are requested, I
>>> completely left out the documentation part and will add it to V2
>>> should anyone find this functionality useful.
>>
>> Hm, it seems to take 2 entries of Ctrl-s to begin the search??
>> No, it takes 2 entries of Ctrl-s to display the "isearch:" prompt,
>> but entering one Ctrl-s + a string will display it also.
>>
>> Anyway, I am having trouble getting the USB drivers example to work.
> 
> Yes, I should have stated that this example explains what _I_ have to do to
> navigate to the USB device drivers.  Probably, "de" in your case matches
> some other menu entry and the navigation requires more or other input.
> 
> I'm sorry for causing confusion.

No problem.

Thanks.

> Dirk
> 
>>> Thanks,
>>>
>>> Dirk
>>>
>>> Dirk Gouders (1):
>>>   Emacs-like isearch for mconf.
>>>
>>>  scripts/kconfig/lxdialog/dialog.h  |   5 ++
>>>  scripts/kconfig/lxdialog/menubox.c | 140 ++++++++++++++++++++++++++++++++++++-
>>>  scripts/kconfig/lxdialog/util.c    |   1 +
>>>  3 files changed, 145 insertions(+), 1 deletion(-)
>>>
>>
>> thanks,


-- 
~Randy
