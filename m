Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3CC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DABA2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujtPV/HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DABA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJ2Eoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 00:44:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50348 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2Eoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 00:44:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2-v6so2399124wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iqmQqZGWgQrBk/mpQOaiHVyzXaLu6jXiNLiuUSz52QI=;
        b=ujtPV/HKYcSIlTzSnSqA8rxdXylyTdg/XUuet4rgTf3+93+i21qFvKHogGO3nFlD6U
         NPWRe838oux4HMmZ280QRTKPCKaAA+dSYbj/zupXd6ddS2PIhwk/745XKnP8jjVr7E/G
         3gZBxinB5TxWXrQlTTqeDQIieZ5tg8AeRPxCtukiwFnz4ByswAC0ewOcNamdODHQ7TAX
         QbVMet+XVdRvo7xfmaJ/J3ryJn1HMheKay9KHNietWXapAAecxKvML/QtriA5XjIHPWl
         6INqrOj8qXMYwZDaX2se0YojI1IlGz8wGM6VsV5L6C4DS2SmeTE4NzyVDvApwP/fa7A7
         WuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iqmQqZGWgQrBk/mpQOaiHVyzXaLu6jXiNLiuUSz52QI=;
        b=ndHK3eUgRdZRoZDTIDN95Nr10X2jgyRzOEoFvCWfbHswvnINH1jdkSoegtbtJzzROW
         HiOm3Pt2u7oRGAbuut2FtY60shITJch/rLZYGpGU5wfqgzagnyVqxLI9jRan+cjUtizC
         nP4GXbjUD+GnhynxqcMaYmxhMPCtyEIslMo/Fm1DcKHsK4aiXtVVqEgjFSHBTUgnEAD2
         KzSxLq7KYTiMH7637tfC8rt3l3wOcmzb6SZSXdHIZs6ZzCcLzK6S774NdGSPjST7J8FK
         zVwEB6RE7a7YyLmo8IpOyYPD+6jmvQ18Z6RXH/BDhclNoC0MEYKcHVkO3Ra01NJgjE8L
         M7kA==
X-Gm-Message-State: AGRZ1gKY1yUjUvQH7vFHGWO6s38qQjtVCE/MQeH9gTQPMb3PJhoyZT9W
        ippTJm/mXNBKe30sjovmONs=
X-Google-Smtp-Source: AJdET5fYsStwxNnC7W3jNvaDY7bjrngWAgYCSi6+PJHn9M2a3wKK2DY8YueLZiKdwb37ZYCGiE2q7w==
X-Received: by 2002:a1c:c4cc:: with SMTP id u195-v6mr11486495wmf.120.1540756737600;
        Sun, 28 Oct 2018 12:58:57 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id l140-v6sm23110224wmb.24.2018.10.28.12.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 12:58:56 -0700 (PDT)
Subject: Re: Which SPDX Identifier for files without explicit GPL version
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrea.merello@gmail.com
References: <406c69c1-43fd-f821-b74b-a1399ed636e9@gmail.com>
 <20181028112728.GD8826@kroah.com>
 <f1aa3ce0-7e68-ce7e-e2a3-a978bcc36e03@gmail.com>
 <20181028141319.GA13215@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <1a796af6-4d83-c55a-c12b-145a8132d3d7@gmail.com>
Date:   Sun, 28 Oct 2018 20:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181028141319.GA13215@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/18 3:13 PM, Greg Kroah-Hartman wrote:
> On Sun, Oct 28, 2018 at 02:22:40PM +0100, Michael Straube wrote:
>> On 10/28/18 12:27 PM, Greg Kroah-Hartman wrote:
>>> On Sun, Oct 28, 2018 at 11:04:06AM +0100, Michael Straube wrote:
>>>> Hi,
>>>>
>>>> which GPL version should be used in SPDX Identifiers for files that
>>>> are GPL licensed but do not mention any version? It is not clear to
>>>> me after reading license-rules.rst.
>>>>
>>>> For example:
>>>>
>>>> /******************************************************************************
>>>>    * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
>>>>    *
>>>>    * This program is distributed in the hope that it will be useful, but WITHOUT
>>>>    * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>>    * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>>>    * more details.
>>>>    *
>>>>    * The full GNU General Public License is included in this distribution in the
>>>>    * file called LICENSE.
>>>
>>> Perhaps look up what version of the GPL that was originally contained in
>>> the tarball that this driver was bundled with?  I think that should be
>>> on their website somewhere...
>>>
>>> If not, it's v1, not a good thing, but all we have to go on.  Also, try
>>> emailing:
>>>
>>>>    * Contact Information:
>>>>    * wlanfae <wlanfae@realtek.com>
>>>
>>> That address :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Ah, there is a file 'license' in the root directory of this driver (rtl8192e)
>> that I overlooked. It contains GPLv2. So v2 applies to all files with the above
>> shortened boiler plate?
> 
> Yes.  So add a SPDX line to the file and delete the boiler plate text so
> we don't have this question again in the future.  Then delete that opy
> of the GPL so we don't have files we don't need :)
> 
> thanks,
> 
> greg k-h
> 

Alright, thanks. :)

There are two files left with no GPL version mentioned and no reference to
a file with the license text. I'm unsure how to handle the two files, so better
asking to get it right. Are they also covered by the license file in the root
directory?

/* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
  * Mostly extracted from the rtl8180-sa2400 driver for the
  * in-kernel generic ieee802.11 stack.
  *
  * Few lines might be stolen from other part of the rtllib
  * stack. Copyright who own it's copyright
  *
  * WPA code stolen from the ipw2200 driver.
  * Copyright who own it's copyright.
  *
  * released under the GPL
  */

/* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
  * Mostly extracted from the rtl8180-sa2400 driver for the
  * in-kernel generic ieee802.11 stack.
  *
  * Some pieces of code might be stolen from ipw2100 driver
  * copyright of who own it's copyright ;-)
  *
  * PS wx handler mostly stolen from hostap, copyright who
  * own it's copyright ;-)
  *
  * released under the GPL
  */

Perhaps you could say what GPL version to use in the SPDX line, Andrea?

Thanks,
Michael
