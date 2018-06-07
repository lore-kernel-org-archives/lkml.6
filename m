Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vGVfO5aSGFtVKAAAmS7hNA
	; Thu, 07 Jun 2018 02:04:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CBC036089E; Thu,  7 Jun 2018 02:04:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pDVSTU6g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BB197601C3;
	Thu,  7 Jun 2018 02:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB197601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeFGCDb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:03:31 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17111 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbeFGCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:03:24 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5723IjN019354;
        Thu, 7 Jun 2018 11:03:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5723IjN019354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528336999;
        bh=pHaLTQcxRXY6lY44zxRe9h1HGHhdA6InhKaCw8a2dpQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pDVSTU6gdVdp+SVMpXMdcLQgvuqyzU8FCYSNjkGSUUphUA95CfR1770rDvIPryVWU
         gJyy9U2YZ1CYmj7XXgX96petEYa1Qk6gDQkbN03Rvy+EDuFeuK3aMcr4odXPf36HcZ
         /WKbXkl/cMJRKStcXl/kVp0Ij73/M6mPu0tGCXDPL2OoQZ1hSVKct1Zs4uGWwdN+8+
         JTxZxz/dm1WQqPlUL9MzPJdiZUdOBTU4TYHUedEVR9uhs+si+7EKvAzQceK4pmcSgy
         U9Ta4jr4jxQbnMVZuCt9H/CJppVimjVCYrWiC2uP3m/DXm9B3YyUE5KbmdrKilqjNR
         F0ZFX4drXqnuw==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id c23-v6so5419714uan.3;
        Wed, 06 Jun 2018 19:03:18 -0700 (PDT)
X-Gm-Message-State: APt69E2xMW5KqUpajrT6/YB1GKincwRQhcdFAPLOliL+P0y/P0yAkfyp
        bpFHWDaH9kJ+ktoYWkI1Aom/E3Cc096dzj8w7cE=
X-Google-Smtp-Source: ADUXVKJwLQUkAeLI5Zj+Dioj+AAlYZE4fjOuaUW9l1gGX3o9v+n1t+rkNKN+67NuWhGzfFY5IZquvPZ08iZzn+D8S/Y=
X-Received: by 2002:a9f:3d6b:: with SMTP id m43-v6mr3761528uai.17.1528336997765;
 Wed, 06 Jun 2018 19:03:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 19:02:37 -0700 (PDT)
In-Reply-To: <ghr2ljv5c9.fsf@lena.gouders.net>
References: <20180606215616.12817-1-dirk@gouders.net> <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
 <ghzi07v944.fsf@lena.gouders.net> <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
 <ghr2ljv5c9.fsf@lena.gouders.net>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Jun 2018 11:02:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
Message-ID: <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
To: Dirk Gouders <dirk@gouders.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-07 8:54 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> Randy Dunlap <rdunlap@infradead.org> writes:
>
>> On 06/06/2018 03:32 PM, Dirk Gouders wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>> On 06/06/2018 02:56 PM, Dirk Gouders wrote:
>>>>> Hello,
>>>>>
>>>>> being an Emacs user, I frequently find myself pressing CTRL-s in mconf
>>>>> to search for some menu entry, especially in large menus.


I use Emacs, but I have never typed Ctrl-s in menuconfig.

Is it important to use the same key pattern as in Emacs?

You intercepted Ctrl-*

Currently, Ctrl-C terminates the program,
but this patch makes it no-op.



>>>>> I decided to implement a basic isearch in mconf and would like to hear
>>>>> if others find this functionality useful, as well.
>>>>>
>>>>> The new functionality is started with pressing CTRL-s followed by
>>>>> characters that form the search string.  To search for further
>>>>> occurences of an entered string, press CTRL-s instead of further
>>>>> characters.
>>>>>
>>>>> For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER
>>>>
>>>> Not being an emacs user, what is the "de" for above?
>>>
>>> "de" (with my .config) causes a match for "Device Drivers" --
>>> no other menu entry matching the string "de" is befor that entry.
>>>
>>
>> Device Drivers is the first match for me also.
>>
>> To get to the USB drivers, I have to enter:
>>       CTRL-s de ENTER ENTER CTRL-s usb ENTER ENTER
>
> Yes, I left out the second CTRL-s, thank you!
>
> Oh well, I shouldn't have sent this late at night, then I would probably
> have explained the needed input as:
>
>      1) CTRL-s  // start isearch
>      2) de      // substring that matches "Device Drivers"
>      3) ENTER   // quit isearch
>      4) ENTER   // enter Device Drivers menu
>      5) CTRL-s  // start isearch
>      6) usb     // navigate to USB support
>      7) ENTER   // quit isearch
>      8) ENTER   // enter USB support menu


Hmm.

I tried this, but I was a bit annoyed.


I wonder if this could be more user-friendly.

For example, I want KEY_UP/DOWN/LEFT/RIGHT
to quit the search mode without pressing ENTER.




> Again, I'm really sorry for the confusion.
>
> Dirk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




You in



-- 
Best Regards
Masahiro Yamada
