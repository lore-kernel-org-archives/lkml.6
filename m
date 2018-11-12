Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C7AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A59E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmzw9NqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A59E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeKLKQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:16:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40917 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKLKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:16:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so6053734lji.7;
        Sun, 11 Nov 2018 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQBhj2GMBXVrTxAXiTBmsUy8r9ZshpIhGayLBpQCDaA=;
        b=Dmzw9NqAVU+ag6jD3OpZwMYFrJbO8HZ/jw2jPRZghOH5qlVc1f9r5G/BP4Mn7Z8MyB
         boHPIp+vJ5Rdp16d8I5ix3gSbO85zY04KUdOTeXjZI/wy5YfexLBohhBbhc+G2GK3EEN
         DXA/jxb2YLDPrTupiPjOMDAyxZDprYqCmE5VOdBuQS6MTuJMuB5RgXUfxGUFGv4pLyCT
         9CDhnAX5czlCMr+Kq9JB1qnKCg6mQRorJBPBT1fn8UqOulni4V6jmCjvsQvUPhcxmEI2
         bKJthNuHgipslkOzMmO3gnQaRvABLhgILwaPWw3ALXdQ+TLVZFzrLiOYIDEWNmUZVE1R
         KYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQBhj2GMBXVrTxAXiTBmsUy8r9ZshpIhGayLBpQCDaA=;
        b=oBYzn/tnNj1zxLe1cHZy1kz+OYhsya0ekQnapt46E5bGehzTyfsQTAuRzUw45OwK8v
         K3G1prNK4pSifzQotgUrfQKpjHN1XOXsV4yEZ2e3xov9IPY2xDNWrAgo1K6uU/fzbcfA
         pSGUsOuB0DKTfVrHywjFPAedRRoSl0DBRY/e/pVKFJWJ2sdwi61wMBUFONzJmdLCquyK
         F37d8QeStBuCiE6NBqsJ4ItwKXKP1z4QmjgoWfYcadE8wYBji2bbTulwMF8J5QXNuLNm
         mDCc80ghmq5UqKRGHeYhBOU+kdZaAiurfiDZ2jeHkGzNU1qUweDRfaoGKHvYhukPkLNd
         acGQ==
X-Gm-Message-State: AGRZ1gIdWUT2WrsLzfRhqa28YjYa5+JrHfYDZ5rJKGQvlxZyHafBpmy5
        2kCTyW+DMW8t5f4s23aWRW+4Aw/aQa4=
X-Google-Smtp-Source: AJdET5caLankBlcpL6FBdGO4dtUxZtOk8JoWFoZG0fH2EzZlt+tlUB9zsnFFtDG4PYqAazp1x9VldQ==
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr10318393ljb.48.1541982330753;
        Sun, 11 Nov 2018 16:25:30 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:f0d2:e35:c9b8:94be? (dtynxhyjt6kjdnwq4ww-y-3.rev.dnainternet.fi. [2001:14ba:8017:3300:f0d2:e35:c9b8:94be])
        by smtp.googlemail.com with ESMTPSA id m6-v6sm2830209ljh.16.2018.11.11.16.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 16:25:30 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <fb4139e2-53ae-0a02-df8d-2fe7c6d32194@gmail.com>
Date:   Mon, 12 Nov 2018 02:25:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 07/11/2018 0.07, Jacek Anaszewski wrote:
> Add common LED function definitions for use in Device Tree.
> The function names were extracted from existing dts files
> after eliminating oddities.

Is your intent here is to standardize the function definitions and to 
aid in that is to specify list of string defines?

Without a meaning what all of those mean it does complete the original goal.

In your list there are many things that could easily have multiple 
meanings for different audiences.

Some examples:

#define LED_FUNCTION_2G "2g"
- Does this mean that 2 metric grams has been detected in scale or 
cellular 2G connectivity?

#define LED_FUNCTION_ALL "all"
- This doesn't ring a bell to me what it could be in reality. All leds 
on doesn't sound right.

#define LED_FUNCTION_AUX "aux"
- There can be many things aux and multiple aux things in one device.

#define LED_FUNCTION_HD "hd"
- Is there a high definition video playing? Or audio? Or harddisk 
failure led?

You have already come up with long list of items. I am just wondering 
what is the logic in order to get to "common" list?

Can you just add custom items in device tree without being in the list?

Would it be better to start with a short simple list with meanings 
defined properly?

When do you then remove entries from the list? Let's say 3G networks are 
currently getting turned off world wide which kinda deprecates the term 
from definitions and probably should be then removed from the list (if 
it would be there).

Is there planned to be some auto connection from function to some other 
automated functionality? Or why wouldn't the label keyword be enough as 
it seems to be exactly the same thing? (without the common list -- which 
could be implemented for label too if seen as a good thing)

Thanks,
Vesa Jääskeläinen
